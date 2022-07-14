create role admin_eshop_role;
create database otus_eshop owner admin_eshop_role;
create  user eshop_user  with password 'eshop_user';
grant usage, create on SCHEMA eshop TO admin_eshop_role;
grant all privileges on database otus_eshop TO admin_eshop_role;
grant select, insert, update, delete on all tables in schema eshop TO admin_eshop_role;
grant admin_eshop_role to eshop_user;

create schema eshop;

create tablespace indexs_tbs owner  admin_eshop_role location '/data/index_tbs';
create tablespace tables_tbs owner admin_eshop_role location '/data/table_tbs';

set search_path to eshop;

CREATE TABLE eshop.manufacturer(
	id serial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	address varchar(200),
	phone varchar(11),
	CONSTRAINT manufacturer_pkey PRIMARY KEY (id),
	CONSTRAINT manufacturer_name_unique UNIQUE (name)
) tablespace tables_tbs;
CREATE INDEX idx_manufacturer_name ON eshop.manufacturer USING btree (name) tablespace indexs_tbs;

CREATE TABLE eshop.item_category(
	id serial NOT NULL,
	parent_id int8,
	name varchar(50) NOT NULL,
	description varchar(200),
	CONSTRAINT category_pkey PRIMARY KEY (id),
	CONSTRAINT category_name_unique UNIQUE (name)
) tablespace tables_tbs;
CREATE INDEX idx_item_category_name ON eshop.item_category USING btree (name) tablespace indexs_tbs;

CREATE TABLE eshop.supplier(
	id serial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	address varchar(200),
	phone varchar(11),
	CONSTRAINT supplier_pkey PRIMARY KEY (id),
	CONSTRAINT supplier_name_unique UNIQUE (name)
) tablespace tables_tbs;
CREATE INDEX idx_supplier_name ON eshop.supplier USING btree (name) tablespace indexs_tbs;

CREATE TABLE eshop.customer(
	id serial NOT NULL,
	fio varchar(50) NOT NULL,
	registration_date timestamp,
	phone varchar(11),
	CONSTRAINT customer_pkey PRIMARY KEY (id),
	CONSTRAINT customer_fio_unique UNIQUE (fio)
) tablespace tables_tbs;
CREATE INDEX idx_customer_fio ON eshop.customer USING btree (fio) tablespace indexs_tbs;

CREATE TABLE eshop.purchases(
	id serial NOT NULL,
	customer_id int8 NOT NULL,
	number varchar(50) NOT NULL,
    date timestamp NOT NULL,
	status varchar(20),
	CONSTRAINT purchases_pkey PRIMARY KEY (id),
	CONSTRAINT purchases_number_unique UNIQUE (number)
) tablespace tables_tbs;
CREATE INDEX idx_purchases_number ON eshop.purchases USING btree (number) tablespace indexs_tbs;
CREATE INDEX idx_purchases_customer_id ON eshop.purchases USING btree (customer_id) tablespace indexs_tbs;

CREATE TABLE eshop.item_modifications(
	id serial NOT NULL,
	item_id int8 NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	CONSTRAINT modifications_pkey PRIMARY KEY (id),
	CONSTRAINT modifications_name_unique UNIQUE (name)
) tablespace tables_tbs;
CREATE INDEX idx_item_modifications_name ON eshop.item_modifications USING btree (name) tablespace indexs_tbs;
CREATE INDEX idx_item_modifications_item_id ON eshop.item_modifications USING btree (item_id) tablespace indexs_tbs;

CREATE TABLE eshop.purchase_items(
	item_modification_id int8 NOT NULL,
	purchase_id int8 NOT NULL
) tablespace tables_tbs;
CREATE INDEX idx_purchase_items_purchase_id ON eshop.purchase_items USING btree (purchase_id) tablespace indexs_tbs;


CREATE TABLE eshop.items(
	id serial NOT NULL,
	category_id int8 NOT NULL,
	supplier_id int8 NOT NULL,
	manufactory_id int8 NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	stock_balance int8 NOT NUll default 0,
	CONSTRAINT items_pkey PRIMARY KEY (id),
	CONSTRAINT items_name_unique UNIQUE (name)
) tablespace tables_tbs;
CREATE INDEX idx_items_name ON eshop.items USING btree (name) tablespace indexs_tbs;
CREATE INDEX idx_items_composite_key ON eshop.items USING btree (category_id, supplier_id, manufactory_id) tablespace indexs_tbs;

CREATE TABLE eshop.items_modifications(
	id serial NOT NULL,
	item_id int8 NOT NULL,
	category_id int8 NOT NULL,
	supplier_id int8 NOT NULL,
	manufactory_id int8 NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	part_number varchar(20) NOT NUll,
	CONSTRAINT items_modifications_pkey PRIMARY KEY (id),
	CONSTRAINT items_modifications_name_unique UNIQUE (name)
) tablespace tables_tbs;
CREATE INDEX idx_items_modifications_name ON eshop.items_modifications USING btree (name) tablespace indexs_tbs;
CREATE INDEX idx_items_modifications_part_number ON eshop.items_modifications USING btree (part_number) tablespace indexs_tbs;
CREATE INDEX idx_items_modifications_item_id ON eshop.items_modifications USING btree (item_id) tablespace indexs_tbs;
CREATE INDEX idx_items_modifications_composite_key ON eshop.items_modifications USING btree (category_id, supplier_id, manufactory_id) tablespace indexs_tbs;


CREATE TABLE eshop.price(
	id serial NOT NULL,
	item_modification_id int8 NOT NULL,
	currency_id int8 NOT NULL,
	price bigint NOT NULL,
	discount bigint NOT NULL default 0,
	CONSTRAINT price_pkey PRIMARY KEY (id)
) tablespace tables_tbs;
CREATE INDEX idx_price_price ON eshop.price USING btree (price) tablespace indexs_tbs;
CREATE INDEX idx_price_complex_key ON eshop.price USING btree (currency_id,item_modification_id) tablespace indexs_tbs;

CREATE TABLE eshop.currency(
	id serial NOT NULL,
	name varchar(10) NOT NULL,
	CONSTRAINT currency_pkey PRIMARY KEY (id)
) tablespace tables_tbs;
