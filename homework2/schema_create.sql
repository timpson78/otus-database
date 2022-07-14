CREATE TABLE public.manufacturer(
	id serial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	address varchar(200),
	phone varchar(11),
	CONSTRAINT manufacturer_pkey PRIMARY KEY (id),
	CONSTRAINT manufacturer_name_unique UNIQUE (name)
);
CREATE INDEX idx_manufacturer_name ON manufacturer USING btree (name);


CREATE TABLE public.item_category(
	id serial NOT NULL,
	parent_id int8,
	name varchar(50) NOT NULL,
	description varchar(200),
	CONSTRAINT category_pkey PRIMARY KEY (id),
	CONSTRAINT category_name_unique UNIQUE (name)
);
CREATE INDEX idx_item_category_name ON item_category USING btree (name);


CREATE TABLE public.supplier(
	id serial NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	address varchar(200),
	phone varchar(11),
	CONSTRAINT supplier_pkey PRIMARY KEY (id),
	CONSTRAINT supplier_name_unique UNIQUE (name)
);
CREATE INDEX idx_supplier_name ON supplier USING btree (name);


CREATE TABLE public.customer(
	id serial NOT NULL,
	fio varchar(50) NOT NULL,
	registration_date timestamp,
	phone varchar(11),
	CONSTRAINT customer_pkey PRIMARY KEY (id),
	CONSTRAINT customer_fio_unique UNIQUE (fio)
);
CREATE INDEX idx_customer_fio ON customer USING btree (fio);


CREATE TABLE public.purchases(
	id serial NOT NULL,
	customer_id int8 NOT NULL,
	number varchar(50) NOT NULL,
    date timestamp NOT NULL,
	status varchar(20),
	CONSTRAINT purchases_pkey PRIMARY KEY (id),
	CONSTRAINT purchases_number_unique UNIQUE (number)
);
CREATE INDEX idx_purchases_number ON purchases USING btree (number);
CREATE INDEX idx_purchases_customer_id ON purchases USING btree (customer_id);


CREATE TABLE public.item_modifications(
	id serial NOT NULL,
	item_id int8 NOT NULL,
	name varchar(50) NOT NULL,
	description varchar(200),
	CONSTRAINT modifications_pkey PRIMARY KEY (id),
	CONSTRAINT modifications_name_unique UNIQUE (name)
);
CREATE INDEX idx_item_modifications_name ON item_modifications USING btree (name);
CREATE INDEX idx_item_modifications_item_id ON item_modifications USING btree (item_id);


CREATE TABLE public.purchase_items(
	item_modification_id int8 NOT NULL,
	purchase_id int8 NOT NULL
);
CREATE INDEX idx_purchase_items_purchase_id ON purchase_items USING btree (purchase_id);

CREATE TABLE public.items(
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
CREATE INDEX idx_items_name ON items USING btree (name);
CREATE INDEX idx_items_composite_key ON items USING btree (category_id, supplier_id, manufactory_id);


CREATE TABLE public.items_modifications(
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
);
CREATE INDEX idx_items_modifications_name ON items_modifications USING btree (name);
CREATE INDEX idx_items_modifications_part_number ON items_modifications USING btree (part_number);
CREATE INDEX idx_items_modifications_item_id ON items_modifications USING btree (item_id);
CREATE INDEX idx_items_modifications_composite_key ON items_modifications USING btree (category_id, supplier_id, manufactory_id);



CREATE TABLE public.price(
	id serial NOT NULL,
	item_modification_id int8 NOT NULL,
	currency_id int8 NOT NULL,
	price bigint NOT NULL,
	discount bigint NOT NULL default 0,
	CONSTRAINT price_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_price_price ON price USING btree (price);
CREATE INDEX idx_price_complex_key ON price USING btree (currency_id,item_modification_id);

CREATE TABLE public.currency(
	id serial NOT NULL,
	name varchar(10) NOT NULL,
	CONSTRAINT currency_pkey PRIMARY KEY (id)
);
