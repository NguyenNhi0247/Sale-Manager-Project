-- Table: public.author_books

-- DROP TABLE public.author_books;

CREATE TABLE public.author_books
(
    id integer NOT NULL DEFAULT nextval('author_books_id_seq'::regclass),
    author_id integer NOT NULL,
    book_id integer NOT NULL,
    CONSTRAINT author_books_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.author_books
    OWNER to postgres;

-- Index: ab_idx

-- DROP INDEX public.ab_idx;

CREATE UNIQUE INDEX ab_idx
    ON public.author_books USING btree
    (author_id, book_id)
    TABLESPACE pg_default;

-- Index: author_idx

-- DROP INDEX public.author_idx;

CREATE INDEX author_idx
    ON public.author_books USING btree
    (author_id)
    TABLESPACE pg_default;

-- Index: book_idx

-- DROP INDEX public.book_idx;

CREATE INDEX book_idx
    ON public.author_books USING btree
    (book_id)
    TABLESPACE pg_default;
