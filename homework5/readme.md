**Домашнее задание 5**

0.  Добавлены исходные данные 
1.  Запрос поиска товаров (ноутбуков) у которых раземер монитора 13 или 17

    SELECT * FROM items i WHERE i.name  similar to '1(3|7)%';
    
    Многие примеры не получились с регулярными выражениями, хотелось бы найти хорошие примеры более сложных запросов
    
2.  Запросы с LEFT и INNER JOIN:
    Поиск товаров со справочниками
    SELECT i.name as item, i.stock_balance as balance, ic.name as category, m.name as manufacturer, s.name as supplier  FROM items i 
           LEFT JOIN item_category ic on i.category_id = ic.id 
           LEFT JOIN manufacturer m on i.manufactory_id = m.id
           LEFT JOIN supplier s on i.supplier_id = s.id;
    
    Такой же запрос только с inner join на моих исходных данных не меняет результат выборки т.к. в таблице items нет данных которые не связаны со справочниками
           
    SELECT i.name as item, i.stock_balance as balance, ic.name as category, m.name as manufacturer, s.name as supplier  FROM items i 
               INNER JOIN item_category ic on i.category_id = ic.id 
               INNER JOIN manufacturer m on i.manufactory_id = m.id
               INNER JOIN supplier s on i.supplier_id = s.id;
               
    Но при добавлении записи в таблицу с товарами с айдишниками справочнков, которых нет:
    
    INSERT INTO eshop.items
    (category_id, supplier_id, manufactory_id, name, description, stock_balance)
    values (45, 67, 78,  'Запись товара с айдишниками которых нет в справочнике', ' Описание ', 123421);
           
    то результат  между inner и left join отличается на одну запись - при inner join новая запись не попадает т.к. 
    при inner join в выборку попадают записи, которые пересекаются в двух таблицах одновременно 

3.  Добавление записи в таблицу, с возвратом id добавленной записи

    INSERT INTO eshop.items (category_id, supplier_id, manufactory_id, name, description, stock_balance) values (2, 4, 3,  'Новая запись', ' Описание ', 123) RETURNING id;

4. Обновление данных на основе  созданной таблицы:
   
   SELECT * into eshop.new_items FROM items i WHERE i.id in (1,3,5);
   
   Обновление имени новой таблицы на описание из другой таблицы:
   
   UPDATE eshop.new_items as ni SET name = i.description   FROM eshop.items as  i    WHERE i.id = ni.id;

5. Пример удаление из новой таблицы используя USING

   DELETE FROM eshop.new_items ni USING eshop.items i WHERE ni .id = i.id AND ni.id > 3 RETURNING ni.id;                            