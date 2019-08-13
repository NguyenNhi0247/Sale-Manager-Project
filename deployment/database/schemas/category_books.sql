-- Table: public.category_books

-- DROP TABLE public.category_books;

CREATE TABLE public.category_books
(
    id integer NOT NULL DEFAULT nextval('category_books_id_seq'::regclass),
    category_id integer NOT NULL,
    book_id integer NOT NULL,
    CONSTRAINT category_books_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.category_books
    OWNER to postgres;