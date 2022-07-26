**Домашнее задание 6**

1.  Создан индекс btree по id
    CREATE UNIQUE INDEX items_pkey ON public.items USING btree (id)
    
    Результаты работы explain показывают, что при операциях сравнения btree индекс использует Index Scan 

    explain (costs, verbose, format json)   select * from items where id >2 and id < 7
2. [
  {
    "Plan": {
      "Node Type": "Index Scan",
      "Parallel Aware": false,
      "Scan Direction": "Forward",
      "Index Name": "items_pkey",
      "Relation Name": "items",
      "Schema": "public",
      "Alias": "items",
      "Startup Cost": 0.14,
      "Total Cost": 2.36,
      "Plan Rows": 1,
      "Plan Width": 572,
      "Output": ["id", "category_id", "supplier_id", "manufactory_id", "name", "description", "stock_balance"],
      "Index Cond": "((items.id > 2) AND (items.id < 7))"
    }
  }
]

3. Использовать индекс для полнотекстового поиска на моих данных так и не получилось
    
    Рассмотрел два варианта
    3.1.  Создал новое поле description_fulltext типа tsvector и заполнил данными с description
    
    ALTER TABLE public.items ADD description_fulltext tsvector NULL;
    UPDATE eshop.items   SET description_fulltext = to_tsvector(description);
    
    analyze eshop.items;
    vacuum eshop.items
    
    Даллее запускаю запрос:
    
    select * from eshop.items where  description_fulltext  @@ plainto_tsquery('russian', 'radeon')    
    или     
    select * from eshop.items where  description_fulltext  @@ plainto_tsquery('radeon')
    или 
    select description_fulltext from eshop.items where  description_fulltext  @@ plainto_tsquery('radeon')
    
    получаю выборку из двух записей
    
    НО explain показывает что индекс не используется
     
    explain (costs, verbose, format json) 
    select * from eshop.items where  description_fulltext  @@ plainto_tsquery('radeon')
    
    [
      {
        "Plan": {
          "Node Type": "Seq Scan",
          "Parallel Aware": false,
          "Relation Name": "items",
          "Schema": "eshop",
          "Alias": "items",
          "Startup Cost": 0.00,
          "Total Cost": 3.36,
          "Plan Rows": 2,
          "Plan Width": 264,
          "Output": ["id", "category_id", "supplier_id", "manufactory_id", "name", "description", "stock_balance", "description_fulltext"],
          "Filter": "(items.description_fulltext @@ plainto_tsquery('radeon'::text))"
        }
      }
    ]
    
    3.2. Создал индекс для  текстового поля description на основе функции to_tsvector
  
    CREATE INDEX idx_items_fulltext2 ON eshop.items USING gin(to_tsvector('russian', description));
    analyze eshop.items;
    vacuum eshop.items
  
    Анализ запроса по  description  показвает что индекс не используется
  
    explain (costs, verbose, format json)
    select * from eshop.items where  to_tsvector('russian', description)  @@ plainto_tsquery('russian', 'оперативная')
  
      [
        {
          "Plan": {
            "Node Type": "Seq Scan",
            "Parallel Aware": false,
            "Relation Name": "items",
            "Schema": "eshop",
            "Alias": "items",
            "Startup Cost": 0.00,
            "Total Cost": 3.36,
            "Plan Rows": 2,
            "Plan Width": 264,
            "Output": ["id", "category_id", "supplier_id", "manufactory_id", "name", "description", "stock_balance", "description_fulltext"],
            "Filter": "(to_tsvector('russian'::regconfig, (items.description)::text) @@ '''оперативн'''::tsquery)"
          }
        }
      ]

4. Индексы на функцию

  Предположим у нас справочник поставщиков заполняется автоматически и записи все с заглавной буквы
  
  тогда имеет смысл создать индекс по функции lower()
  
  CREATE INDEX idx_manufactory_name_lower ON eshop.manufactory (lower(name));
  
  select * from eshop.manufacturer m where lower(m.name) = 'производитель1'   
  
  --- и опять не задействован индекс... предполагаю, что  у меня в базе мало данных и поэтому планировщик выбирает  
  --- последовательное сканирование вместо сканирование индекса
  
  проверил работу на БД bookings - все работает:
  
  CREATE INDEX idx_passanger_name_lower ON bookings.tickets  (lower(passenger_name));
  
  explain (costs, verbose, format json)
  select * from bookings.tickets where lower(passenger_name) = lower('TATYANA KUZNECOVA') 
 
  
  [
    {
      "Plan": {
        "Node Type": "Bitmap Heap Scan",
        "Parallel Aware": false,
        "Relation Name": "tickets",
        "Schema": "bookings",
        "Alias": "tickets",
        "Startup Cost": 23.44,
        "Total Cost": 1725.20,
        "Plan Rows": 1834,
        "Plan Width": 104,
        "Output": ["ticket_no", "book_ref", "passenger_id", "passenger_name", "contact_data"],
        "Recheck Cond": "(lower(tickets.passenger_name) = 'tatyana kuznecova'::text)",
        "Plans": [
          {
            "Node Type": "Bitmap Index Scan",
            "Parent Relationship": "Outer",
            "Parallel Aware": false,
            "Index Name": "idx_passanger_name_lower",
            "Startup Cost": 0.00,
            "Total Cost": 22.98,
            "Plan Rows": 1834,
            "Plan Width": 0,
            "Index Cond": "(lower(tickets.passenger_name) = 'tatyana kuznecova'::text)"
          }
        ]
      }
    }
  ]
    
5. Составной индекс

  Создал составной индекс на базе демо версии БД bookings
  
  CREATE INDEX idx_passangername_bookref_complex ON bookings.tickets  (book_ref, passenger_name);
  analyze bookings.tickets
  
  Анализ показывает эффективность использования индекса
  explain (costs, verbose, format json)
  select * from bookings.tickets where passenger_name = 'TATYANA KUZNECOVA' and book_ref = '00D64E'
  
  [
    {
      "Plan": {
        "Node Type": "Index Scan",
        "Parallel Aware": false,
        "Scan Direction": "Forward",
        "Index Name": "idx_passangername_bookref_complex",
        "Relation Name": "tickets",
        "Schema": "bookings",
        "Alias": "tickets",
        "Startup Cost": 0.42,
        "Total Cost": 2.64,
        "Plan Rows": 1,
        "Plan Width": 104,
        "Output": ["ticket_no", "book_ref", "passenger_id", "passenger_name", "contact_data"],
        "Index Cond": "((tickets.book_ref = '00D64E'::bpchar) AND (tickets.passenger_name = 'TATYANA KUZNECOVA'::text))"
      }
    }
  ]
    
    
      
    