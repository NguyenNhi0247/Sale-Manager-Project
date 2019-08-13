-- Table: public.categories

-- DROP TABLE public.categories;

CREATE TABLE public.categories
(
    id integer NOT NULL DEFAULT nextval('categories_id_seq'::regclass),
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categories_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.categories
    OWNER to postgres;