CREATE UNIQUE INDEX items_pkey ON public.items USING btree (id)
CREATE INDEX idx_items_name ON public.items USING btree (name)

--- Добавление поля tsvector и обновление значений из description

ALTER TABLE public.items ADD description_fulltext tsvector NULL;
UPDATE eshop.items   SET description_fulltext = to_tsvector(description);

--- создание полнотекстового индекса на основе функции to_tsvector

CREATE INDEX idx_items_fulltext2 ON eshop.items USING gin(to_tsvector('russian','description'));

--- создание полнотекстового индекса gin

CREATE INDEX idx_items_fulltext ON eshop.items USING gin (description_fulltext);

---- индекс по функции

CREATE INDEX idx_manufactory_name_lower ON eshop.manufacturer  (lower(name));

--- составной индекс


CREATE INDEX idx_passangername_bookref_complex ON bookings.tickets  (book_ref, passenger_name);
