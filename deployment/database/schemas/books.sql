-- Table: public.books

-- DROP TABLE public.books;

CREATE TABLE public.books
(
    id integer NOT NULL DEFAULT nextval('books_id_seq'::regclass),
    title character varying(500) COLLATE pg_catalog."default" NOT NULL,
    sub_title character varying(2000) COLLATE pg_catalog."default",
    thumbnails character varying(1000)[] COLLATE pg_catalog."default",
    description character varying(10000) COLLATE pg_catalog."default",
    long_description character varying(50000) COLLATE pg_catalog."default",
    price double precision NOT NULL,
    total_rating_point integer,
    total_rated integer,
    total_purchased integer,
    publisher character varying(500) COLLATE pg_catalog."default",
    published_at timestamp without time zone,
    published_place character varying(500) COLLATE pg_catalog."default",
    pagination character varying(100) COLLATE pg_catalog."default",
    ebook_formats json,
    authors character varying(200)[] COLLATE pg_catalog."default",
    categories character varying(200)[] COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    is_deleted boolean,
    deleted_at timestamp without time zone,
    CONSTRAINT books_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.books
    OWNER to postgres;

-- Index: title_idx

-- DROP INDEX public.title_idx;

CREATE INDEX title_idx
    ON public.books USING btree
    (title COLLATE pg_catalog."default" text_pattern_ops)
    TABLESPACE pg_default;