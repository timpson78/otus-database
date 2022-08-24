CREATE DATABASE myotusdb;
CREATE USER  IF NOT EXISTS  'otususer'@'%' IDENTIFIED BY 'otususer';
GRANT ALL PRIVILEGES ON myotusdb.* TO 'otususer'@'%';
USE myotusdb;
CREATE TABLE manufacturer(
	id serial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	address varchar(200),
	phone varchar(11),
	CONSTRAINT manufacturer_pkey PRIMARY KEY (id),
	CONSTRAINT manufacturer_name_unique UNIQUE (name)
);
CREATE INDEX idx_manufacturer_name ON manufacturer  (name);


CREATE TABLE item_category(
	id serial NOT NULL,
	parent_id int8,
	name varchar(50) NOT NULL,
	description varchar(200),
	CONSTRAINT category_pkey PRIMARY KEY (id),
	CONSTRAINT category_name_unique UNIQUE (name)
);
CREATE INDEX idx_item_category_name ON item_category  (name);


CREATE TABLE supplier(
	id serial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	address varchar(200),
	phone varchar(11),
	CONSTRAINT supplier_pkey PRIMARY KEY (id),
	CONSTRAINT supplier_name_unique UNIQUE (name)
);
CREATE INDEX idx_supplier_name ON supplier  (name);


CREATE TABLE customer(
	id serial NOT NULL,
	fio varchar(50) NOT NULL,
	registration_date timestamp,
	phone varchar(11),
	CONSTRAINT customer_pkey PRIMARY KEY (id),
	CONSTRAINT customer_fio_unique UNIQUE (fio)
);
CREATE INDEX idx_customer_fio ON customer  (fio);


CREATE TABLE purchases(
	id serial NOT NULL,
	customer_id int8 NOT NULL,
	number varchar(50) NOT NULL,
    date timestamp NOT NULL,
	status varchar(20),
	CONSTRAINT purchases_pkey PRIMARY KEY (id),
	CONSTRAINT purchases_number_unique UNIQUE (number)
);
CREATE INDEX idx_purchases_number ON purchases  (number);
CREATE INDEX idx_purchases_customer_id ON purchases  (customer_id);


CREATE TABLE item_modifications(
	id serial NOT NULL,
	item_id int8 NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	CONSTRAINT modifications_pkey PRIMARY KEY (id),
	CONSTRAINT modifications_name_unique UNIQUE (name)
);
CREATE INDEX idx_item_modifications_name ON item_modifications  (name);
CREATE INDEX idx_item_modifications_item_id ON item_modifications  (item_id);


CREATE TABLE purchase_items(
	item_modification_id int8 NOT NULL,
	purchase_id int8 NOT NULL
);
CREATE INDEX idx_purchase_items_purchase_id ON purchase_items  (purchase_id);

CREATE TABLE items(
	id serial NOT NULL,
	category_id int8 NOT NULL,
	supplier_id int8 NOT NULL,
	manufactory_id int8 NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	stock_balance int8 NOT NUll default 0,
	CONSTRAINT items_pkey PRIMARY KEY (id),
	CONSTRAINT items_name_unique UNIQUE (name)
);
CREATE INDEX idx_items_name ON items  (name);
CREATE INDEX idx_items_composite_key ON items  (category_id, supplier_id, manufactory_id);


CREATE TABLE items_modifications(
	id serial NOT NULL,
	item_id int8 NOT NULL,
	category_id int8 NOT NULL,
	supplier_id int8 NOT NULL,
	manufactory_id int8 NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	part_number varchar(20) NOT NUll,
	CONSTRAINT items_modifications_pkey PRIMARY KEY (id),
	CONSTRAINT items_modifications_name_unique UNIQUE (name, item_id)
);
CREATE INDEX idx_items_modifications_name ON items_modifications  (name);
CREATE INDEX idx_items_modifications_part_number ON items_modifications  (part_number);
CREATE INDEX idx_items_modifications_item_id ON items_modifications  (item_id);
CREATE INDEX idx_items_modifications_composite_key ON items_modifications  (category_id, supplier_id, manufactory_id);



CREATE TABLE price(
	id serial NOT NULL,
	item_modification_id int8 NOT NULL,
	currency_id int8 NOT NULL,
	price numeric NOT NULL,
	discount bigint NOT NULL default 0,
	CONSTRAINT price_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_price_price ON price  (price);
CREATE INDEX idx_price_complex_key ON price  (currency_id,item_modification_id);

CREATE TABLE currency(
	id serial NOT NULL,
	name varchar(10) NOT NULL,
	CONSTRAINT currency_pkey PRIMARY KEY (id)
);
