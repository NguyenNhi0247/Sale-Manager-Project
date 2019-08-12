-- Table: public.authors

-- DROP TABLE public.authors;

CREATE TABLE public.authors
(
    id integer NOT NULL DEFAULT nextval('authors_id_seq'::regclass),
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT authors_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.authors
    OWNER to postgres;

-- Index: name_idx

-- DROP INDEX public.name_idx;

CREATE INDEX name_idx
    ON public.authors USING btree
    (name COLLATE pg_catalog."default" text_pattern_ops)
    TABLESPACE pg_default;