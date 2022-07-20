
-- Поставщики
INSERT INTO eshop.supplier
(id, name, description, address, phone)
values (1, 'Поставщик1', 'Описание поставщика 1','Адрес поставщика 1', '9183432344' );

INSERT INTO eshop.supplier
(id, name, description, address, phone)
values (2, 'Поставщик2', 'Описание поставщика 2','Адрес поставщика 2', '9293245555' );

INSERT INTO eshop.supplier
(id, name, description, address, phone)
values (3, 'Поставщик3', 'Описание поставщика 3','Адрес поставщика 3', '9291111111' );

INSERT INTO eshop.supplier
(id, name, description, address, phone)
values (4, 'Поставщик4', 'Описание поставщика 4','Адрес поставщика 4', '9292222222' );

INSERT INTO eshop.supplier
(id, name, description, address, phone)
values (5, 'Поставщик5', 'Описание поставщика 5','Адрес поставщика 5', '92921112233' );


-- Покупатели
INSERT INTO eshop.customer
(id, fio, registration_date,  phone)
values (1, 'ФИО Покупатель1', CURRENT_DATE, '9293398887' );

INSERT INTO eshop.customer
(id, fio, registration_date,  phone)
values (2, 'ФИО Покупатель2', localtimestamp, '9187774433' );

INSERT INTO eshop.customer
(id, fio, registration_date,  phone)
values (3, 'ФИО Покупатель3', '2021-02-14 18:15:40.452', '91874445' );

-- Валюта
INSERT INTO eshop.currency
(id, name)
values (1, 'RUB');

INSERT INTO eshop.currency
(id, name)
values (2, 'USD');

-- Производители

INSERT INTO eshop.manufacturer
(id, name, description, address, phone)
values (1, 'Производитель1', 'Описание производителя 1', 'Адрес производителя 1', '9188887766');

INSERT INTO eshop.manufacturer
(id, name, description, address, phone)
values (2, 'Производитель2', 'Описание производителя 2', 'Адрес производителя 2', '9291112233');

INSERT INTO eshop.manufacturer
(id,name, description, address, phone)
values (3, 'Производитель3', 'Описание производителя 3', 'Адрес производителя 3', '9291412233');

INSERT INTO eshop.manufacturer
(id, name, description, address, phone)
values (4, 'Производитель4', 'Описание производителя 4', 'Адрес производителя 4', '9294323545');

-- Категории

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (1, null, 'Компьютерная техника', 'Здесь описание каегории Компьютерная техника');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (2, null, 'Бытовая техника', 'Здесь описание каегории Бытовая техника');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (3, null, 'Смартфоны', 'Здесь описание каегории Смартфоны');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (4, 1, 'Ноутбуки', 'Здесь описание каегории Ноутбуки');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (5, 1, 'Моноблоки', 'Здесь описание каегории Моноблоки');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (6, 1, 'Комплектующие', 'Здесь описание каегории Комплектующие');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (7, 3, 'Материнские платы', 'Здесь описание каегории Материнские платы');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (8, 3, 'Оперативная память', 'Здесь описание каегории Оперативная память');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (9, 3, 'Жесткие диски', 'Здесь описание каегории Жесткие диски');

INSERT INTO eshop.item_category
(id, parent_id, name, description)
values (10, 3, 'Флеш накопители', 'Здесь описание каегории Флеш накопители');

--- Товары

INSERT INTO eshop.items
(id, category_id, supplier_id, manufactory_id, name, description, stock_balance)
values (1, 4, 1, 1,  '13.3" Ноутбук Irbis NB77', ' Описание ноутбука ', 2);

INSERT INTO eshop.items
(id, category_id, supplier_id, manufactory_id, name, description, stock_balance)
values (2, 4, 1, 1,  '11.6" Ноутбук ASUS Laptop 11 E210MA-GJ151T', ' Описание ноутбука ', 5);

INSERT INTO eshop.items
(id, category_id, supplier_id, manufactory_id, name, description, stock_balance)
values (3, 4, 1, 1,  '17.3" Ноутбук Lenovo Ideapad 3 17ITL6', ' Описание ноутбука ', 7);
---
INSERT INTO eshop.items
(id, category_id, supplier_id, manufactory_id, name, description, stock_balance)
values (4, 8, 2, 3,  'Оперативная память AMD Radeon R5', 'Описание оперативной памяти', 7);

INSERT INTO eshop.items
(id, category_id, supplier_id, manufactory_id, name, description, stock_balance)
values (5, 8, 2, 3,  'Оперативная память AMD Radeon R6', 'Описание оперативной памяти', 4);
---

INSERT INTO eshop.items
(id, category_id, supplier_id, manufactory_id, name, description, stock_balance)
values (6, 3, 2, 3,  '5" Смартфон DEXP A350', 'Описание сфмартфона', 4);

INSERT INTO eshop.items
(id, category_id, supplier_id, manufactory_id, name, description, stock_balance)
values (7, 3, 2, 3,  '3.97" Смартфон BQ 4030G Nice Mini', 'Описание сфмартфона', 4);

--- Модификации товаров и цена

INSERT INTO eshop.item_modifications
(id, item_id, name, description)
values (1, 1, '16ГБ черный', '');

INSERT INTO eshop.price
(item_modification_id, currency_id, price, discount  )
values (1, 1, 25999.44, 1200);

INSERT INTO eshop.item_modifications
(id, item_id, name, description)
values (2, 1, '32ГБ белый', '');

INSERT INTO eshop.price
(item_modification_id, currency_id, price, discount  )
values (2, 1, 27999.44, 1400);

INSERT INTO eshop.item_modifications
(id, item_id, name, description)
values (3, 2, '8ГБ зеленый', '');

INSERT INTO eshop.price
(item_modification_id, currency_id, price, discount  )
values (3, 1, 44569.44, 100);

INSERT INTO eshop.item_modifications
(id, item_id, name, description)
values (5, 2, '32ГБ белый', '');

INSERT INTO eshop.price
(item_modification_id, currency_id, price, discount  )
values (5, 1, 164569.44, 300);

INSERT INTO eshop.item_modifications
(id, item_id, name, description)
values (6, 3, '128ГБ серый', '');

INSERT INTO eshop.price
(item_modification_id, currency_id, price, discount  )
values (6, 1, 1234569.44, 400);

INSERT INTO eshop.item_modifications
(id, item_id, name, description)
values (7, 4, '128ГБ', '');

INSERT INTO eshop.price
(item_modification_id, currency_id, price, discount  )
values (7, 1, 2200.44, 50);

INSERT INTO eshop.item_modifications
(id, item_id, name, description)
values (8, 4, '16ГБ', '');

INSERT INTO eshop.price
(item_modification_id, currency_id, price, discount  )
values (8, 1, 1200.44, 50);

--- регулярное выражение

select * from items i where i.name  similar to '1(3|7)%';

--- LEFT JOIN  and INNER JOIN

select i.name as item, i.stock_balance as balance, ic.name as category, m.name as manufacturer, s.name as supplier  from items i
           left join item_category ic on i.category_id = ic.id
           left join manufacturer m on i.manufactory_id = m.id
           left join supplier s on i.supplier_id = s.id;

select i.name as item, i.stock_balance as balance, ic.name as category, m.name as manufacturer, s.name as supplier  from items i
           inner join item_category ic on i.category_id = ic.id
           inner join manufacturer m on i.manufactory_id = m.id
           inner join supplier s on i.supplier_id = s.id;

--- Добавление запсиси с возратом id

INSERT INTO eshop.items (category_id, supplier_id, manufactory_id, name, description, stock_balance) values (2, 4, 3,  'Новая запись', ' Описание ', 123) returning id;

--- Пример UPDATE FROM

select * into eshop.new_items from items i where i.id in (1,3,5);

UPDATE eshop.new_items as ni    SET name = i.description    FROM eshop.items as  i    WHERE i.id = ni.id;

--- Пример удаление из новой таблицы используя USING

DELETE FROM eshop.new_items ni USING eshop.items i WHERE ni .id = i.id AND ni.id > 3 RETURNING ni.id;

