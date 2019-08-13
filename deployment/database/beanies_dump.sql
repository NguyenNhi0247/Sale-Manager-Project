--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4 (Debian 11.4-1.pgdg90+1)
-- Dumped by pg_dump version 11.3

-- Started on 2019-08-09 04:57:37 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 16630)
-- Name: author_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author_books (
    id serial NOT NULL PRIMARY KEY,
    author_id integer NOT NULL,
    book_id integer NOT NULL
);


ALTER TABLE public.author_books OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16628)
-- Name: author_books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

-- CREATE SEQUENCE public.author_books_id_seq
--     AS integer
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


ALTER TABLE public.author_books_id_seq OWNER TO postgres;

--
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 198
-- Name: author_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.author_books_id_seq OWNED BY public.author_books.id;


--
-- TOC entry 201 (class 1259 OID 16646)
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id serial NOT NULL PRIMARY KEY,
    name character varying(500) NOT NULL
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16644)
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

-- CREATE SEQUENCE public.authors_id_seq
--     AS integer
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


ALTER TABLE public.authors_id_seq OWNER TO postgres;

--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 200
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- TOC entry 197 (class 1259 OID 16603)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id serial NOT NULL PRIMARY KEY,
    title character varying(500) NOT NULL,
    sub_title character varying(2000),
    thumbnails character varying(1000)[],
    description character varying(10000),
    long_description character varying(50000),
    price double precision NOT NULL,
    total_rating_point integer,
    total_rated integer,
    total_purchased integer,
    publisher character varying(500),
    published_at timestamp without time zone,
    published_place character varying(500),
    pagination character varying(100),
    ebook_formats json,
    authors character varying(200)[],
    categories character varying(200)[],
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    is_deleted boolean,
    deleted_at timestamp without time zone
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16601)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

-- CREATE SEQUENCE public.books_id_seq
--     AS integer
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 196
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 203 (class 1259 OID 16654)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id serial NOT NULL PRIMARY KEY,
    name character varying(500) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16652)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

-- CREATE SEQUENCE public.categories_id_seq
--     AS integer
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 202
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 205 (class 1259 OID 16662)
-- Name: category_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_books (
    id serial NOT NULL PRIMARY KEY,
    category_id integer NOT NULL,
    book_id integer NOT NULL
);


ALTER TABLE public.category_books OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16660)
-- Name: category_books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

-- CREATE SEQUENCE public.category_books_id_seq
--     AS integer
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1;


ALTER TABLE public.category_books_id_seq OWNER TO postgres;

--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 204
-- Name: category_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_books_id_seq OWNED BY public.category_books.id;


--
-- TOC entry 2766 (class 2604 OID 16633)
-- Name: author_books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_books ALTER COLUMN id SET DEFAULT nextval('public.author_books_id_seq'::regclass);


--
-- TOC entry 2767 (class 2604 OID 16649)
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- TOC entry 2765 (class 2604 OID 16606)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 2768 (class 2604 OID 16657)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 2769 (class 2604 OID 16665)
-- Name: category_books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_books ALTER COLUMN id SET DEFAULT nextval('public.category_books_id_seq'::regclass);


--
-- TOC entry 2909 (class 0 OID 16630)
-- Dependencies: 199
-- Data for Name: author_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.author_books VALUES (2, 2, 2);
INSERT INTO public.author_books VALUES (3, 3, 3);
INSERT INTO public.author_books VALUES (4, 4, 5);
INSERT INTO public.author_books VALUES (5, 5, 5);
INSERT INTO public.author_books VALUES (6, 6, 5);
INSERT INTO public.author_books VALUES (7, 7, 8);
INSERT INTO public.author_books VALUES (8, 8, 9);
INSERT INTO public.author_books VALUES (9, 9, 10);
INSERT INTO public.author_books VALUES (10, 10, 12);
INSERT INTO public.author_books VALUES (11, 11, 13);
INSERT INTO public.author_books VALUES (12, 12, 15);
INSERT INTO public.author_books VALUES (13, 13, 16);
INSERT INTO public.author_books VALUES (14, 14, 17);
INSERT INTO public.author_books VALUES (15, 15, 18);
INSERT INTO public.author_books VALUES (16, 16, 19);
INSERT INTO public.author_books VALUES (17, 17, 21);
INSERT INTO public.author_books VALUES (18, 18, 22);
INSERT INTO public.author_books VALUES (19, 19, 23);
INSERT INTO public.author_books VALUES (20, 20, 23);
INSERT INTO public.author_books VALUES (21, 21, 23);
INSERT INTO public.author_books VALUES (22, 22, 23);
INSERT INTO public.author_books VALUES (23, 23, 23);
INSERT INTO public.author_books VALUES (24, 24, 23);
INSERT INTO public.author_books VALUES (25, 25, 23);
INSERT INTO public.author_books VALUES (26, 26, 24);
INSERT INTO public.author_books VALUES (27, 27, 25);
INSERT INTO public.author_books VALUES (28, 28, 25);
INSERT INTO public.author_books VALUES (29, 29, 25);
INSERT INTO public.author_books VALUES (30, 30, 25);
INSERT INTO public.author_books VALUES (31, 31, 25);
INSERT INTO public.author_books VALUES (32, 32, 25);
INSERT INTO public.author_books VALUES (33, 33, 25);
INSERT INTO public.author_books VALUES (34, 34, 25);
INSERT INTO public.author_books VALUES (35, 35, 25);
INSERT INTO public.author_books VALUES (36, 36, 25);
INSERT INTO public.author_books VALUES (37, 37, 25);
INSERT INTO public.author_books VALUES (38, 38, 25);
INSERT INTO public.author_books VALUES (39, 39, 25);
INSERT INTO public.author_books VALUES (40, 40, 33);
INSERT INTO public.author_books VALUES (41, 41, 33);
INSERT INTO public.author_books VALUES (42, 42, 33);
INSERT INTO public.author_books VALUES (43, 43, 26);
INSERT INTO public.author_books VALUES (44, 44, 26);
INSERT INTO public.author_books VALUES (45, 45, 26);
INSERT INTO public.author_books VALUES (46, 46, 26);
INSERT INTO public.author_books VALUES (47, 47, 26);
INSERT INTO public.author_books VALUES (48, 48, 27);
INSERT INTO public.author_books VALUES (49, 49, 28);
INSERT INTO public.author_books VALUES (50, 50, 29);
INSERT INTO public.author_books VALUES (51, 51, 32);
INSERT INTO public.author_books VALUES (52, 52, 32);
INSERT INTO public.author_books VALUES (53, 53, 32);
INSERT INTO public.author_books VALUES (54, 54, 32);
INSERT INTO public.author_books VALUES (55, 55, 32);
INSERT INTO public.author_books VALUES (56, 56, 32);
INSERT INTO public.author_books VALUES (57, 57, 32);
INSERT INTO public.author_books VALUES (58, 58, 32);
INSERT INTO public.author_books VALUES (59, 59, 34);
INSERT INTO public.author_books VALUES (60, 60, 35);
INSERT INTO public.author_books VALUES (61, 61, 36);
INSERT INTO public.author_books VALUES (62, 62, 36);
INSERT INTO public.author_books VALUES (63, 63, 36);
INSERT INTO public.author_books VALUES (64, 64, 37);
INSERT INTO public.author_books VALUES (65, 65, 38);
INSERT INTO public.author_books VALUES (66, 66, 39);
INSERT INTO public.author_books VALUES (67, 67, 40);
INSERT INTO public.author_books VALUES (68, 68, 43);
INSERT INTO public.author_books VALUES (69, 69, 45);
INSERT INTO public.author_books VALUES (70, 70, 46);
INSERT INTO public.author_books VALUES (71, 71, 47);
INSERT INTO public.author_books VALUES (72, 72, 48);
INSERT INTO public.author_books VALUES (73, 73, 49);
INSERT INTO public.author_books VALUES (74, 74, 50);
INSERT INTO public.author_books VALUES (75, 75, 51);
INSERT INTO public.author_books VALUES (76, 76, 52);
INSERT INTO public.author_books VALUES (77, 77, 53);
INSERT INTO public.author_books VALUES (78, 78, 54);
INSERT INTO public.author_books VALUES (79, 79, 55);
INSERT INTO public.author_books VALUES (80, 80, 56);
INSERT INTO public.author_books VALUES (81, 81, 57);
INSERT INTO public.author_books VALUES (82, 82, 57);
INSERT INTO public.author_books VALUES (83, 83, 57);
INSERT INTO public.author_books VALUES (84, 84, 57);
INSERT INTO public.author_books VALUES (85, 85, 58);
INSERT INTO public.author_books VALUES (86, 86, 59);
INSERT INTO public.author_books VALUES (87, 87, 60);
INSERT INTO public.author_books VALUES (88, 88, 62);
INSERT INTO public.author_books VALUES (89, 89, 62);
INSERT INTO public.author_books VALUES (90, 90, 62);
INSERT INTO public.author_books VALUES (91, 91, 62);
INSERT INTO public.author_books VALUES (92, 92, 62);
INSERT INTO public.author_books VALUES (93, 93, 63);
INSERT INTO public.author_books VALUES (94, 94, 65);
INSERT INTO public.author_books VALUES (95, 95, 66);
INSERT INTO public.author_books VALUES (96, 96, 66);
INSERT INTO public.author_books VALUES (97, 97, 67);
INSERT INTO public.author_books VALUES (98, 98, 68);
INSERT INTO public.author_books VALUES (99, 99, 69);
INSERT INTO public.author_books VALUES (100, 100, 69);
INSERT INTO public.author_books VALUES (101, 101, 69);
INSERT INTO public.author_books VALUES (102, 102, 71);
INSERT INTO public.author_books VALUES (103, 103, 71);
INSERT INTO public.author_books VALUES (104, 104, 71);
INSERT INTO public.author_books VALUES (105, 105, 72);
INSERT INTO public.author_books VALUES (106, 106, 73);
INSERT INTO public.author_books VALUES (107, 107, 73);
INSERT INTO public.author_books VALUES (108, 108, 74);
INSERT INTO public.author_books VALUES (109, 109, 75);
INSERT INTO public.author_books VALUES (110, 110, 76);
INSERT INTO public.author_books VALUES (111, 111, 78);
INSERT INTO public.author_books VALUES (112, 112, 79);
INSERT INTO public.author_books VALUES (113, 113, 81);
INSERT INTO public.author_books VALUES (114, 114, 82);
INSERT INTO public.author_books VALUES (115, 115, 83);
INSERT INTO public.author_books VALUES (116, 116, 85);
INSERT INTO public.author_books VALUES (117, 117, 86);
INSERT INTO public.author_books VALUES (118, 118, 87);
INSERT INTO public.author_books VALUES (119, 119, 88);
INSERT INTO public.author_books VALUES (120, 120, 89);
INSERT INTO public.author_books VALUES (121, 121, 90);
INSERT INTO public.author_books VALUES (122, 122, 91);
INSERT INTO public.author_books VALUES (123, 123, 92);
INSERT INTO public.author_books VALUES (124, 124, 93);
INSERT INTO public.author_books VALUES (125, 125, 94);
INSERT INTO public.author_books VALUES (126, 126, 95);
INSERT INTO public.author_books VALUES (127, 127, 96);
INSERT INTO public.author_books VALUES (128, 128, 97);
INSERT INTO public.author_books VALUES (129, 129, 98);
INSERT INTO public.author_books VALUES (130, 130, 99);
INSERT INTO public.author_books VALUES (131, 131, 100);
INSERT INTO public.author_books VALUES (132, 132, 101);


--
-- TOC entry 2911 (class 0 OID 16646)
-- Dependencies: 201
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authors VALUES (2, 'Francis de Sales');
INSERT INTO public.authors VALUES (3, 'Plato');
INSERT INTO public.authors VALUES (4, 'Francis MacDonald Cornford');
INSERT INTO public.authors VALUES (5, 'Arnold Hermann');
INSERT INTO public.authors VALUES (6, 'Sylvana Chrysakopoulou');
INSERT INTO public.authors VALUES (7, 'Stendhal');
INSERT INTO public.authors VALUES (8, 'Otto Apelt');
INSERT INTO public.authors VALUES (9, 'Richard von Krafft-Ebing');
INSERT INTO public.authors VALUES (10, 'Jonathan Edwards');
INSERT INTO public.authors VALUES (11, 'Carpenter, Edward');
INSERT INTO public.authors VALUES (12, 'Vātsyāyana');
INSERT INTO public.authors VALUES (13, 'Emanuel Swedenborg');
INSERT INTO public.authors VALUES (14, 'Frederick William Faber');
INSERT INTO public.authors VALUES (15, 'United States. Congress. House. Committee on National Security. Military Personnel Subcommittee.');
INSERT INTO public.authors VALUES (16, 'John Ruskin');
INSERT INTO public.authors VALUES (17, 'Benvenuto Cellini');
INSERT INTO public.authors VALUES (18, 'Giorgio Vasari');
INSERT INTO public.authors VALUES (19, 'Rembrandt Harmenszoon van Rijn');
INSERT INTO public.authors VALUES (20, 'Holm Bevers');
INSERT INTO public.authors VALUES (21, 'Rembrandt');
INSERT INTO public.authors VALUES (22, 'Gary Schwartz');
INSERT INTO public.authors VALUES (23, 'Ludwig Munz');
INSERT INTO public.authors VALUES (24, 'Bob Haak');
INSERT INTO public.authors VALUES (25, 'Christopher Brown');
INSERT INTO public.authors VALUES (26, 'Honoré de Balzac');
INSERT INTO public.authors VALUES (27, 'Edvard Munch');
INSERT INTO public.authors VALUES (28, 'Christoph Asendorf');
INSERT INTO public.authors VALUES (29, 'Marian Bisanz-Prakken');
INSERT INTO public.authors VALUES (30, 'Albrecht Schröder');
INSERT INTO public.authors VALUES (31, 'Albertina Wien');
INSERT INTO public.authors VALUES (32, 'Dieter Buchhart');
INSERT INTO public.authors VALUES (33, 'Antonia Hoerschelmann');
INSERT INTO public.authors VALUES (34, 'Frank Hoifodt');
INSERT INTO public.authors VALUES (35, 'Iris Müller-Westermann');
INSERT INTO public.authors VALUES (36, 'Gerd Woll');
INSERT INTO public.authors VALUES (37, 'Arne Eggum');
INSERT INTO public.authors VALUES (38, 'Reinhold Heller');
INSERT INTO public.authors VALUES (39, 'Carla Lathe');
INSERT INTO public.authors VALUES (40, 'John Leonard Greenberg');
INSERT INTO public.authors VALUES (41, 'Peter Huber');
INSERT INTO public.authors VALUES (42, 'Dieter Borchmeyer');
INSERT INTO public.authors VALUES (43, 'John James Audubon');
INSERT INTO public.authors VALUES (44, 'RH Value Publishing');
INSERT INTO public.authors VALUES (45, 'Cyril Walker');
INSERT INTO public.authors VALUES (46, 'Roger Tory Peterson Institute');
INSERT INTO public.authors VALUES (47, 'Virginia Marie Peterson');
INSERT INTO public.authors VALUES (48, 'Rainer Maria Rilke');
INSERT INTO public.authors VALUES (49, 'Francisco Goya');
INSERT INTO public.authors VALUES (50, 'Michelangelo Buonarroti');
INSERT INTO public.authors VALUES (51, 'Paul Cézanne');
INSERT INTO public.authors VALUES (52, 'Paul Cézanne');
INSERT INTO public.authors VALUES (53, 'Federico Teresa Zandomeneghi');
INSERT INTO public.authors VALUES (54, 'Anna Barskaya');
INSERT INTO public.authors VALUES (55, 'Eugenia Georgievskaya');
INSERT INTO public.authors VALUES (56, 'Francoise Cachin');
INSERT INTO public.authors VALUES (57, 'Isabelle Cahn');
INSERT INTO public.authors VALUES (58, 'Walter Feilchenfeldt');
INSERT INTO public.authors VALUES (59, 'Tolstoy');
INSERT INTO public.authors VALUES (60, 'Jean Piaget');
INSERT INTO public.authors VALUES (61, 'Gerhard Richter');
INSERT INTO public.authors VALUES (62, 'Andreas Hapkemeyer');
INSERT INTO public.authors VALUES (63, 'Peter Weiermar');
INSERT INTO public.authors VALUES (64, 'James McNeill Whistler');
INSERT INTO public.authors VALUES (65, 'Holbrook Jackson');
INSERT INTO public.authors VALUES (66, 'Benedetto Croce');
INSERT INTO public.authors VALUES (67, 'William Morris');
INSERT INTO public.authors VALUES (68, 'Jacques Maritain');
INSERT INTO public.authors VALUES (69, 'Ernest Francisco Fenollosa');
INSERT INTO public.authors VALUES (70, 'Salomon, Louis Rev.');
INSERT INTO public.authors VALUES (71, 'Arthur Schopenhauer');
INSERT INTO public.authors VALUES (72, 'E. V. Lucas');
INSERT INTO public.authors VALUES (73, 'Charles Baudelaire');
INSERT INTO public.authors VALUES (74, 'Wilhelm Worringer');
INSERT INTO public.authors VALUES (75, 'Henry David Thoreau');
INSERT INTO public.authors VALUES (76, 'Walt Whitman');
INSERT INTO public.authors VALUES (77, 'James Boswell');
INSERT INTO public.authors VALUES (78, 'John Keats');
INSERT INTO public.authors VALUES (79, 'Joseph Conrad');
INSERT INTO public.authors VALUES (80, 'Mark Twain');
INSERT INTO public.authors VALUES (81, 'Saint Ignatius of Loyola');
INSERT INTO public.authors VALUES (82, 'Aloysio R.P Bellecio');
INSERT INTO public.authors VALUES (83, 'Ignatius.');
INSERT INTO public.authors VALUES (84, 'William, S.J. Reiser');
INSERT INTO public.authors VALUES (85, 'Bernardin de Saint-Pierre');
INSERT INTO public.authors VALUES (86, 'Marco Polo');
INSERT INTO public.authors VALUES (87, 'Benjamin Constant');
INSERT INTO public.authors VALUES (88, 'Max Ernst');
INSERT INTO public.authors VALUES (89, 'Werner Spies');
INSERT INTO public.authors VALUES (90, 'Fabrice Hergott');
INSERT INTO public.authors VALUES (91, 'Doris Krystof');
INSERT INTO public.authors VALUES (92, 'Günter Metken');
INSERT INTO public.authors VALUES (93, 'Xenophon');
INSERT INTO public.authors VALUES (94, 'Cornelius Nepos');
INSERT INTO public.authors VALUES (95, 'Jacobus de Voragine');
INSERT INTO public.authors VALUES (96, 'William Caxton');
INSERT INTO public.authors VALUES (97, 'Samuel Pepys');
INSERT INTO public.authors VALUES (98, 'William Shakespeare');
INSERT INTO public.authors VALUES (99, 'Johann Wolfgang von Goethe');
INSERT INTO public.authors VALUES (100, 'Johann Peter Eckermann');
INSERT INTO public.authors VALUES (101, 'Otto Schönberger');
INSERT INTO public.authors VALUES (102, 'Marcus Junianus Justinus');
INSERT INTO public.authors VALUES (103, 'Justin');
INSERT INTO public.authors VALUES (104, 'Waldemar Heckel');
INSERT INTO public.authors VALUES (105, 'Samuel Johnson');
INSERT INTO public.authors VALUES (106, 'François-René de Chateaubriand');
INSERT INTO public.authors VALUES (107, 'Jean-Paul Clément');
INSERT INTO public.authors VALUES (108, 'Washington Irving');
INSERT INTO public.authors VALUES (109, 'Alexander Chalmers');
INSERT INTO public.authors VALUES (110, 'P. Cornelius Tacitus');
INSERT INTO public.authors VALUES (111, 'Quintus Curtius Rufus');
INSERT INTO public.authors VALUES (112, 'John Bunyan');
INSERT INTO public.authors VALUES (113, 'D. H. Lawrence');
INSERT INTO public.authors VALUES (114, 'Diodorus Siculus');
INSERT INTO public.authors VALUES (115, 'Jean-Jacques Rousseau');
INSERT INTO public.authors VALUES (116, 'Alfred Marshall');
INSERT INTO public.authors VALUES (117, 'Andrew Carnegie');
INSERT INTO public.authors VALUES (118, 'Thorstein Veblen');
INSERT INTO public.authors VALUES (119, 'Alonzo Delano');
INSERT INTO public.authors VALUES (120, 'John D. Rockefeller');
INSERT INTO public.authors VALUES (121, 'Walter Colton');
INSERT INTO public.authors VALUES (122, 'David Rohrer Leeper');
INSERT INTO public.authors VALUES (123, 'Louis Dembitz Brandeis');
INSERT INTO public.authors VALUES (124, 'Waldo Pondray Warren');
INSERT INTO public.authors VALUES (125, 'M. Clare');
INSERT INTO public.authors VALUES (126, 'Charles Dickens');
INSERT INTO public.authors VALUES (127, 'Helen Bannerman');
INSERT INTO public.authors VALUES (128, 'Lucy Maud Montgomery');
INSERT INTO public.authors VALUES (129, 'George Bernard Shaw');
INSERT INTO public.authors VALUES (130, 'Charles Lamb');
INSERT INTO public.authors VALUES (131, 'Horace Bushnell');
INSERT INTO public.authors VALUES (132, 'Richard Jefferies');


--
-- TOC entry 2907 (class 0 OID 16603)
-- Dependencies: 197
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books VALUES (2, 'Introduction to a devout life', 'from the French of St. Francis de Sales ... to which is prefixed an abstract of his life.', '{http://covers.openlibrary.org/b/olid/OL16574453M-L.jpg}', 'Please update me!', 'Please update me, too!', 181000, NULL, NULL, NULL, 'F. Pustet & co.', '1900-01-01 00:00:00', 'Ratisbon, New York [etc.]', 'xxi, 367 p.', '[{"type":"txt","file_path":"_data/txt/OL16574453M.txt","file_size":577420},{"type":"epub","file_path":"_data/epub/OL16574453M.epub","file_size":1400070},{"type":"pdf","file_path":"_data/pdf/OL16574453M.pdf","file_size":23575267}]', '{"Francis de Sales"}', '{"Accessible book",Bible,"Catholic Church","Catholic authors","Christian life","Devotional exercises","Devotional literature","Early works to 1800",God,Love,Maxims,Meditations,Mystics,Méditations,"Prayers and devotions","Religious aspects of Love",Spanish,"Spiritual life","Worship and love"}', '2019-08-09 04:53:48.681679', '2019-08-09 04:53:48.681679', NULL, NULL);
INSERT INTO public.books VALUES (3, 'The Phaedrus of Plato.', NULL, '{http://covers.openlibrary.org/b/olid/OL14034129M-L.jpg}', 'Please update me!', 'Please update me, too!', 227000, NULL, NULL, NULL, 'Whittaker', '1868-01-01 00:00:00', 'London', 'xxviii, 203 p.', '[{"type":"epub","file_path":"_data/epub/OL14034129M.epub","file_size":2852635},{"type":"pdf","file_path":"_data/pdf/OL14034129M.pdf","file_size":18594118},{"type":"txt","file_path":"_data/txt/OL14034129M.txt","file_size":881495}]', '{Plato}', '{Rhetoric,Love,"Ancient Philosophy","Accessible book",Love.,Soul,"Ancient Rhetoric",Great_books_of_the_western_world,"Early works to 1800",Open_syllabus_project,"Protected DAISY","Theory of Knowledge","In library",Inspiration,Kommentar}', '2019-08-09 04:53:48.709883', '2019-08-09 04:53:48.709883', NULL, NULL);
INSERT INTO public.books VALUES (4, 'Meno', NULL, '{http://covers.openlibrary.org/b/olid/OL23319049M-L.jpg}', 'Please update me!', 'Please update me, too!', 187000, NULL, NULL, NULL, 'Clarendon Press', '1887-01-01 00:00:00', 'Oxford', '2 parts in 1 vol.', '[{"type":"epub","file_path":"_data/epub/OL23319049M.epub","file_size":1737269},{"type":"txt","file_path":"_data/txt/OL23319049M.txt","file_size":271292},{"type":"pdf","file_path":"_data/pdf/OL23319049M.pdf","file_size":6220399}]', '{Plato}', '{Virtue,"Early works to 1800","Ancient Philosophy",Philosophy,"Idea (Philosophy)","Classic Literature",Fiction,Vertus,Love,"Meno (Plato)",Social,PHILOSOPHY,"Ethics & Moral Philosophy"}', '2019-08-09 04:53:48.711032', '2019-08-09 04:53:48.711032', NULL, NULL);
INSERT INTO public.books VALUES (5, 'The Parmenides of Plato', NULL, '{http://covers.openlibrary.org/b/olid/OL24180407M-L.jpg}', 'Please update me!', 'Please update me, too!', 79000, NULL, NULL, NULL, 'J. Maclehose', '1894-01-01 00:00:00', 'Glasgow', '1 v. (various paging):', '[{"type":"txt","file_path":"_data/txt/OL24180407M.txt","file_size":1189897},{"type":"epub","file_path":"_data/epub/OL24180407M.epub","file_size":2924158},{"type":"pdf","file_path":"_data/pdf/OL24180407M.pdf","file_size":13874656}]', '{Plato,"Francis MacDonald Cornford","Arnold Hermann","Sylvana Chrysakopoulou"}', '{Great_books_of_the_western_world,Knowledge,"Translating into Latin",Periodicals,Fiction,"Voyages and travels",Philosophy,"One (The One in philosophy)","Idea (Philosophy)","Classic Literature","Pictorial works","Ancient Philosophy",Open_syllabus_project,Pleasure,"Language and languages",Ontology,"Greek language",Travelers,"Early works to 1800","Theory of Knowledge",Dialectic,Reasoning,Geography,Love,"Western philosophy","Ancient Greek & Roman philosophy","History & Surveys - Ancient & Classical",Metaphysics,"Philosophy / Western"}', '2019-08-09 04:53:48.711922', '2019-08-09 04:53:48.711922', NULL, NULL);
INSERT INTO public.books VALUES (6, 'The Gorgias of Plato', NULL, '{http://covers.openlibrary.org/b/olid/OL14010062M-L.jpg}', 'Please update me!', 'Please update me, too!', 21000, NULL, NULL, NULL, 'J. Munroe', '1856-01-01 00:00:00', 'Boston', 'lv, 242 p. ;', '[{"type":"txt","file_path":"_data/txt/OL14010062M.txt","file_size":520946},{"type":"pdf","file_path":"_data/pdf/OL14010062M.pdf","file_size":13807765},{"type":"epub","file_path":"_data/epub/OL14010062M.epub","file_size":1521973}]', '{Plato}', '{"In library","Ancient Philosophy","Accessible book",Great_books_of_the_western_world,"Early works to 1800",Open_syllabus_project,"Political science","Protected DAISY",Ethics,"Classic Literature",Love,"Greek language materials"}', '2019-08-09 04:53:48.712917', '2019-08-09 04:53:48.712917', NULL, NULL);
INSERT INTO public.books VALUES (7, 'Charmides, Laches, Lysis.', 'Ex recognitione Caroli Friderici Hermanni.', '{http://covers.openlibrary.org/b/olid/OL24196010M-L.jpg}', 'Please update me!', 'Please update me, too!', 218000, NULL, NULL, NULL, 'B.G. Teubneri', '1881-01-01 00:00:00', 'Lipsiae', '88p.', '[{"type":"txt","file_path":"_data/txt/OL24196010M.txt","file_size":272829},{"type":"epub","file_path":"_data/epub/OL24196010M.epub","file_size":641517},{"type":"pdf","file_path":"_data/pdf/OL24196010M.pdf","file_size":4960369}]', '{Plato}', '{Greek,"Accessible book",Philosophy,Great_books_of_the_western_world,Love}', '2019-08-09 04:53:48.714124', '2019-08-09 04:53:48.714124', NULL, NULL);
INSERT INTO public.books VALUES (8, 'De l''amour', NULL, '{http://covers.openlibrary.org/b/olid/OL14003141M-L.jpg}', 'Please update me!', 'Please update me, too!', 45000, NULL, NULL, NULL, 'Calmann Lévy', '1891-01-01 00:00:00', 'Paris', '371p.', '[{"type":"txt","file_path":"_data/txt/OL14003141M.txt","file_size":692620},{"type":"epub","file_path":"_data/epub/OL14003141M.epub","file_size":2737681},{"type":"pdf","file_path":"_data/pdf/OL14003141M.pdf","file_size":16606546}]', '{Stendhal}', '{"Accessible book",Amour,"French language",Love,Slideshow}', '2019-08-09 04:53:48.715137', '2019-08-09 04:53:48.715137', NULL, NULL);
INSERT INTO public.books VALUES (9, 'The Sophistes and Politicus of Plato', NULL, '{http://covers.openlibrary.org/b/olid/OL6902887M-L.jpg}', 'Please update me!', 'Please update me, too!', 160000, NULL, NULL, NULL, 'Clarendon press', '1867-01-01 00:00:00', 'Oxford', '2 p. l., [7]-9, xc p., 1 l., 192, lix, 191 p.', '[{"type":"txt","file_path":"_data/txt/OL6902887M.txt","file_size":1315012},{"type":"pdf","file_path":"_data/pdf/OL6902887M.pdf","file_size":19240452},{"type":"epub","file_path":"_data/epub/OL6902887M.epub","file_size":9211634}]', '{Plato,"Otto Apelt"}', '{"Sophists (Greek philosophy)","Early works to 1800",Ontology,Methodology,"Meaning (Philosophy)","Ancient Logic",Statesmen,"Classic Literature",Fiction,"Indians of South America",Costume,"Description and travel",Love}', '2019-08-09 04:53:48.716072', '2019-08-09 04:53:48.716072', NULL, NULL);
INSERT INTO public.books VALUES (10, 'Psychopathia Sexualis', 'with especial reference to the antipathic sexual instinct, a medico-forensic study', '{http://covers.openlibrary.org/b/olid/OL7199919M-L.jpg}', 'Please update me!', 'Please update me, too!', 156000, NULL, NULL, NULL, 'Rebman', '1900-01-01 00:00:00', 'New York', 'xiii, 617 p.  port.', '[{"type":"txt","file_path":"_data/txt/OL7199919M.txt","file_size":1289785},{"type":"pdf","file_path":"_data/pdf/OL7199919M.pdf","file_size":34606286},{"type":"txt","file_path":"_data/txt/OL7199919M.txt","file_size":1289785},{"type":"pdf","file_path":"_data/pdf/OL7199919M.pdf","file_size":34606286}]', '{"Richard von Krafft-Ebing"}', '{Paraphilias,"Accessible book","Case studies","Criminal psychology",Homosexualité,Love,"Perversion sexuelle","Psychology, pathological","Sex (Psychology)","Sex Disorders","Sexual behavior","Sexual deviation","Sexual perversion","Sexualité (Psychologie)","Sex Behavior"}', '2019-08-09 04:53:48.717115', '2019-08-09 04:53:48.717115', NULL, NULL);
INSERT INTO public.books VALUES (11, 'Crito', 'een dialoog van Plato', '{http://covers.openlibrary.org/b/olid/OL13988906M-L.jpg}', 'Please update me!', 'Please update me, too!', 440000, NULL, NULL, NULL, 'J.B. Wolters', '1846-01-01 00:00:00', 'Te Groningen', '70 p.', '[{"type":"txt","file_path":"_data/txt/OL13988906M.txt","file_size":112905},{"type":"pdf","file_path":"_data/pdf/OL13988906M.pdf","file_size":2860147},{"type":"epub","file_path":"_data/epub/OL13988906M.epub","file_size":675231}]', '{Plato}', '{Philosophy,Law,Obedience,"Accessible book",Open_syllabus_project,Love}', '2019-08-09 04:53:48.723599', '2019-08-09 04:53:48.723599', NULL, NULL);
INSERT INTO public.books VALUES (12, 'Treatise concerning the religious affections ...', NULL, '{http://covers.openlibrary.org/b/olid/OL14046055M-L.jpg}', 'Please update me!', 'Please update me, too!', 154000, NULL, NULL, NULL, 'James Crissy', '1821-01-01 00:00:00', 'Philadelphia', '432 p. ;', '[{"type":"txt","file_path":"_data/txt/OL14046055M.txt","file_size":1081908},{"type":"epub","file_path":"_data/epub/OL14046055M.epub","file_size":1930762},{"type":"pdf","file_path":"_data/pdf/OL14046055M.pdf","file_size":26628492}]', '{"Jonathan Edwards"}', '{"Affections (Religious)",Christianity,"Congregational churches","Controversial literature","Early works to 1800","Early works to 1850",Emotions,Love,"Religious aspects","Religious aspects of Emotions","Religious aspects of Love","Christian life",Puritans}', '2019-08-09 04:53:48.730743', '2019-08-09 04:53:48.730743', NULL, NULL);
INSERT INTO public.books VALUES (13, 'Love''s coming of age', 'a series of papers on the relations of the sexes', '{http://covers.openlibrary.org/b/olid/OL6537509M-L.jpg}', 'Please update me!', 'Please update me, too!', 291000, NULL, NULL, NULL, 'M. Kennerley', '1911-01-01 00:00:00', 'New York', '199 p.', '[{"type":"txt","file_path":"_data/txt/OL6537509M.txt","file_size":230481},{"type":"epub","file_path":"_data/epub/OL6537509M.epub","file_size":3226637},{"type":"pdf","file_path":"_data/pdf/OL6537509M.pdf","file_size":7353759}]', '{"Carpenter, Edward"}', '{"Accessible book",Love,Marriage,"Secual ethics",Sex,"Sexual ethics"}', '2019-08-09 04:53:48.737746', '2019-08-09 04:53:48.737746', NULL, NULL);
INSERT INTO public.books VALUES (14, 'The Euthydemus of Plato', NULL, '{http://covers.openlibrary.org/b/olid/OL5289524M-L.jpg}', 'Please update me!', 'Please update me, too!', 182000, NULL, NULL, NULL, 'Arno Press', '1973-01-01 00:00:00', 'New York', '51, [47], 81 p.', '[{"type":"epub","file_path":"_data/epub/OL5289524M.epub","file_size":678574},{"type":"txt","file_path":"_data/txt/OL5289524M.txt","file_size":522031},{"type":"pdf","file_path":"_data/pdf/OL5289524M.pdf","file_size":7650171}]', '{Plato}', '{"Early works to 1800",Logic,Methodology,"Classic Literature",Fiction,Love}', '2019-08-09 04:53:48.744114', '2019-08-09 04:53:48.744114', NULL, NULL);
INSERT INTO public.books VALUES (15, 'The Kama sutra of Vatsyayana', NULL, '{http://covers.openlibrary.org/b/olid/OL7021277M-L.jpg}', 'Please update me!', 'Please update me, too!', 229000, NULL, NULL, NULL, 'Printed for the Society of the Friends of India', '1883-01-01 00:00:00', 'Benares', 'xxi, 175 p., [8] leaves of plates :', '[{"type":"txt","file_path":"_data/txt/OL7021277M.txt","file_size":346934},{"type":"pdf","file_path":"_data/pdf/OL7021277M.pdf","file_size":8723405},{"type":"epub","file_path":"_data/epub/OL7021277M.epub","file_size":12223883}]', '{Vātsyāyana}', '{"Sex customs",Love,"Sexual intercourse",Sex,"Accessible book"}', '2019-08-09 04:53:48.745033', '2019-08-09 04:53:48.745033', NULL, NULL);
INSERT INTO public.books VALUES (16, 'The divine Providence.', NULL, '{http://covers.openlibrary.org/b/olid/OL176876M-L.jpg}', 'Please update me!', 'Please update me, too!', 108000, NULL, NULL, NULL, 'Dent', '1913-01-01 00:00:00', 'London', 'xvii, [1] 319 p.', '[{"type":"epub","file_path":"_data/epub/OL176876M.epub","file_size":1206216},{"type":"txt","file_path":"_data/txt/OL176876M.txt","file_size":822147},{"type":"pdf","file_path":"_data/pdf/OL176876M.pdf","file_size":15226295}]', '{"Emanuel Swedenborg"}', '{"Accessible book",Christianity,"God (Christianity)",Love,"Providence and government of God",Wisdom,"New Jerusalem Church"}', '2019-08-09 04:53:48.746417', '2019-08-09 04:53:48.746417', NULL, NULL);
INSERT INTO public.books VALUES (17, 'Le cr©Øeateur et la cr©Øeature, ou, Les merveilles de l''amour divin', NULL, '{http://covers.openlibrary.org/b/olid/OL7212610M-L.jpg}', 'Please update me!', 'Please update me, too!', 334000, NULL, NULL, NULL, 'Ambroise Bray', '1866-01-01 00:00:00', 'Paris', '426 p. ;', '[{"type":"txt","file_path":"_data/txt/OL7212610M.txt","file_size":916752},{"type":"epub","file_path":"_data/epub/OL7212610M.epub","file_size":2416100},{"type":"pdf","file_path":"_data/pdf/OL7212610M.pdf","file_size":25704699}]', '{"Frederick William Faber"}', '{"Catholic Church",Charity,"Doctrinal and controversial works",Doctrines,God,Love,Salvation,"Worship and love","Worship and love.","God (Christianity)",Meditations,"Love (Theology)","Spiritual life"}', '2019-08-09 04:53:48.747996', '2019-08-09 04:53:48.747996', NULL, NULL);
INSERT INTO public.books VALUES (18, 'The presidential determination of "full faith cooperation" by Vietnam on POW/MIA matters', 'hearing before the Military Personnel Subcommittee of the Committee on National Security, House of Representatives, One Hundred Fourth Congress, second session, hearing held June 19, 1996.', '{http://covers.openlibrary.org/b/olid/OL283452M-L.jpg}', 'Please update me!', 'Please update me, too!', 191000, NULL, NULL, NULL, 'U.S. G.P.O.', '1997-01-01 00:00:00', 'Washington', 'iv, 793 p. :', '[{"type":"txt","file_path":"_data/txt/OL283452M.txt","file_size":1782093},{"type":"epub","file_path":"_data/epub/OL283452M.epub","file_size":2230818},{"type":"pdf","file_path":"_data/pdf/OL283452M.pdf","file_size":35639743}]', '{"United States. Congress. House. Committee on National Security. Military Personnel Subcommittee."}', '{"Vietnamese Conflict, 1961-1975","Foreign relations","North Vietnamese Prisoners and prisons",Vietnam,"Missing in action","Accessible book"}', '2019-08-09 04:53:48.749808', '2019-08-09 04:53:48.749808', NULL, NULL);
INSERT INTO public.books VALUES (19, 'Sesame and lilies', 'three lectures', '{http://covers.openlibrary.org/b/olid/OL24197200M-L.jpg}', 'Please update me!', 'Please update me, too!', 265000, NULL, NULL, NULL, 'Lovell', '1885-01-01 00:00:00', 'New York', '133 p. ;', '[{"type":"txt","file_path":"_data/txt/OL24197200M.txt","file_size":1822924},{"type":"epub","file_path":"_data/epub/OL24197200M.epub","file_size":16416176},{"type":"pdf","file_path":"_data/pdf/OL24197200M.pdf","file_size":54001031}]', '{"John Ruskin"}', '{"Books and reading","Conduct of life",Women,"Social problems",Art,"Decorative arts","Education of women",Femininity,"Sex role",Masculinity,Economics,"Greek Mythology","Early works to 1900",Education,"Accessible book","Early works to 1800"}', '2019-08-09 04:53:48.750665', '2019-08-09 04:53:48.750665', NULL, NULL);
INSERT INTO public.books VALUES (20, 'The stones of Venice ...', NULL, '{http://covers.openlibrary.org/b/olid/OL22894444M-L.jpg}', 'Please update me!', 'Please update me, too!', 217000, NULL, NULL, NULL, 'D. Estes & Co.', '1911-01-01 00:00:00', 'Boston', '3 v.', '[{"type":"txt","file_path":"_data/txt/OL22894444M.txt","file_size":929093},{"type":"pdf","file_path":"_data/pdf/OL22894444M.pdf","file_size":32943752},{"type":"epub","file_path":"_data/epub/OL22894444M.epub","file_size":19760831}]', '{"John Ruskin"}', '{Venice,"Byzantine Architecture",Art,Description,"Accessible book",Philosophy,"Gothic Architecture","Description and travel",Architecture,"Protected DAISY","Architecture and society","In library",Details}', '2019-08-09 04:53:48.751636', '2019-08-09 04:53:48.751636', NULL, NULL);
INSERT INTO public.books VALUES (21, 'Memoirs of Benvenuto Cellini', 'a Florentine artist', '{http://covers.openlibrary.org/b/olid/OL7131293M-L.jpg}', 'Please update me!', 'Please update me, too!', 406000, NULL, NULL, NULL, 'G. Bell & sons', '1889-01-01 00:00:00', 'London', '[v]-viii, [1]-504 p. :', '[{"type":"txt","file_path":"_data/txt/OL7131293M.txt","file_size":1317698},{"type":"epub","file_path":"_data/epub/OL7131293M.epub","file_size":2656890},{"type":"pdf","file_path":"_data/pdf/OL7131293M.pdf","file_size":27628231},{"type":"epub","file_path":"_data/epub/OL7131293M.epub","file_size":2656890},{"type":"txt","file_path":"_data/txt/OL7131293M.txt","file_size":1317698},{"type":"pdf","file_path":"_data/pdf/OL7131293M.pdf","file_size":27628231}]', '{"Benvenuto Cellini"}', '{"Accessible book",Art,Autobiography,Biography,"Early works to 1800",Sculptors,"Protected DAISY","In library",Goldsmiths}', '2019-08-09 04:53:48.752386', '2019-08-09 04:53:48.752386', NULL, NULL);
INSERT INTO public.books VALUES (22, 'Lives of the most eminent painters, sculptors, and architects', 'translated from the Italian of Giorgio Vasari.  With notes and illus., chiefly selected from various commentators by Mrs. Jonathan Foster.', '{http://covers.openlibrary.org/b/olid/OL7131711M-L.jpg}', 'Please update me!', 'Please update me, too!', 355000, NULL, NULL, NULL, 'H.G. Bohn', '1850-01-01 00:00:00', 'London', '5 v. ', '[{"type":"txt","file_path":"_data/txt/OL7131711M.txt","file_size":1453555},{"type":"pdf","file_path":"_data/pdf/OL7131711M.pdf","file_size":35887815},{"type":"txt","file_path":"_data/txt/OL7131711M.txt","file_size":1453555},{"type":"pdf","file_path":"_data/pdf/OL7131711M.pdf","file_size":35887815}]', '{"Giorgio Vasari"}', '{History,Artists,Biography,"Italian Artists",Art,"Italian Art","Renaissance Art","Medieval Artists",Painters,"Gothic Art",Italy,Portraits,Architects,"Italian Painters",Sculptors,Artistas,Biografía,"Arte renacentista","Medieval Art","Arte italiano","Accessible book","In library","Protected DAISY"}', '2019-08-09 04:53:48.753237', '2019-08-09 04:53:48.753237', NULL, NULL);
INSERT INTO public.books VALUES (23, 'The complete etchings of Rembrandt', NULL, '{http://covers.openlibrary.org/b/olid/OL6352703M-L.jpg}', 'Please update me!', 'Please update me, too!', 206000, NULL, NULL, NULL, 'Arden Book Company', '1937-01-01 00:00:00', 'New York', '3 p. l., ix-xv p., 1 l., [218] p. of illus.', '[{"type":"txt","file_path":"_data/txt/OL6352703M.txt","file_size":50475},{"type":"pdf","file_path":"_data/pdf/OL6352703M.pdf","file_size":35367918},{"type":"epub","file_path":"_data/epub/OL6352703M.epub","file_size":139902199}]', '{"Rembrandt Harmenszoon van Rijn","Holm Bevers",Rembrandt,"Gary Schwartz","Ludwig Munz","Bob Haak","Christopher Brown"}', '{"In library",Etching,"Dutch Painting","Accessible book","Dutch Art","Vejle kunstmuseum","Art collections","Staatliche Kunstsammlungen Dresden. Kupferstich-Kabinett","Staatliche Kunstsammlungen Dresden","Staatliche Museen zu Berlin--Preussischer Kulturbesitz",Catalogs,"Musée du Petit Palais (Paris, France). Collection Dutuit","Criticism and interpretation","Rembrandt Hermans-zoon van Rijn, 1606-1669","Staatliche Museen zu Berlin--Preussischer Kulturbesitz. Kupferstichkabinett--Sammlung der Zeichnungen und Druckgraphik","Themes, motives",Bible,"Musée du Louvre. Cabinet des dessins","Private collections",Self-portraits,"Musée du Louvre",Expertising,Drawing,Art,Exhibitions,"Gosudarstvennyĭ muzeĭ izobrazitelʹnykh iskusstv imeni A.S. Pushkina",Nativity,"Musée du Petit Palais (Paris, France)","Dutch Etching","Drawing & drawings","Individual artists","Art & Art Instruction",Netherlands,"Art / Individual Artist","Individual Artist","Baroque art","Prints & printmaking","Rembrandt Harmenszoon van Rijn",Printmaking,"Rembrandt Harmenszoon van Rijn,","Art / Fine Arts",1606-1669,"Painting & paintings","Individual Painters And Their Work","Graphic Arts - General"}', '2019-08-09 04:53:48.759434', '2019-08-09 04:53:48.759434', NULL, NULL);
INSERT INTO public.books VALUES (24, 'Lost illusions', NULL, '{http://covers.openlibrary.org/b/olid/OL24155493M-L.jpg}', 'Please update me!', 'Please update me, too!', 28000, NULL, NULL, NULL, 'Privately printed for members of the Society of English Bibliophilists', '1901-01-01 00:00:00', 'London', 'x, 354 p., [4] leaves of plates :', '[{"type":"txt","file_path":"_data/txt/OL24155493M.txt","file_size":750683},{"type":"pdf","file_path":"_data/pdf/OL24155493M.pdf","file_size":9060947},{"type":"epub","file_path":"_data/epub/OL24155493M.epub","file_size":1771428},{"type":"txt","file_path":"_data/txt/OL24155493M.txt","file_size":750683},{"type":"epub","file_path":"_data/epub/OL24155493M.epub","file_size":1771428},{"type":"pdf","file_path":"_data/pdf/OL24155493M.pdf","file_size":9060947}]', '{"Honoré de Balzac"}', '{"Social life and customs","Translations into Chinese","Accessible book","In library",Fiction,"Translations from French","Protected DAISY","Chinese fiction",Manuscripts,"French fiction",Literature,"French literature",Art,Sculpture,Aesthetics,Musicians,Composers,"Russian Novelists",Biography,Artists}', '2019-08-09 04:53:48.765913', '2019-08-09 04:53:48.765913', NULL, NULL);
INSERT INTO public.books VALUES (25, 'Edvard Munch', NULL, '{http://covers.openlibrary.org/b/olid/OL5953823M-L.jpg}', 'Please update me!', 'Please update me, too!', 198000, NULL, NULL, NULL, 'Solomon R. Guggenheim Museum', '1965-01-01 00:00:00', 'New York', '103 p. :', '[{"type":"txt","file_path":"_data/txt/OL5953823M.txt","file_size":119347},{"type":"pdf","file_path":"_data/pdf/OL5953823M.pdf","file_size":9492865},{"type":"epub","file_path":"_data/epub/OL5953823M.epub","file_size":395701667},{"type":"txt","file_path":"_data/txt/OL5953823M.txt","file_size":119347},{"type":"epub","file_path":"_data/epub/OL5953823M.epub","file_size":25715724},{"type":"pdf","file_path":"_data/pdf/OL5953823M.pdf","file_size":9492865}]', '{"Edvard Munch","Christoph Asendorf","Marian Bisanz-Prakken","Albrecht Schröder","Albertina Wien","Dieter Buchhart","Antonia Hoerschelmann","Frank Hoifodt","Iris Müller-Westermann","Gerd Woll","Arne Eggum","Reinhold Heller","Carla Lathe"}', '{Art,"Art collections",Biography,Catalogs,"Catalogues raisonnés","Criticism and interpretation",Exhibitions,"Friends and associates","Hamburger Kunsthalle","Modern Painting","Munch-museet (Oslo, Norway)","Museum Folkwang Essen","Nasjonalgalleriet (Norway)",Norway,"Norway. Nasjonalgalleriet","Norwegian Art","Norwegian Drawing","Norwegian Engraving","Norwegian Lithography","Norwegian Painting",Painters,Prints,"Private collections","Symbolism in art","Themes, motives","Wood-engraving, Norwegian","Working class in art","OUR Brockhaus selection","Bildende Kunst","Pictorial Norwegian wit and humor","Biography: general","Exhibition catalogues and specific collections","Individual artists","Individual Artist","Art & Art Instruction",Essays,"History - Modern (Late 19th Century to 1945)","Art / General","Munch, Edvard,","Exhibition Catalogs","Graphic Arts","Graphic Arts - General",1863-1944}', '2019-08-09 04:53:48.772662', '2019-08-09 04:53:48.772662', NULL, NULL);
INSERT INTO public.books VALUES (33, 'Sämtliche Werke.', 'Ergänzungsband: Goethe als Persönlichkeit [Berichte und Briefe von Zeitgenossen gesammelt von Heinz Amelung.', '{http://covers.openlibrary.org/b/olid/OL23332776M-L.jpg}', 'Please update me!', 'Please update me, too!', 428000, NULL, NULL, NULL, 'G. Müller', '1914-01-01 00:00:00', 'München', NULL, '[{"type":"epub","file_path":"_data/epub/OL23332776M.epub","file_size":1573594},{"type":"txt","file_path":"_data/txt/OL23332776M.txt","file_size":863681},{"type":"pdf","file_path":"_data/pdf/OL23332776M.pdf","file_size":23858805}]', '{"John Leonard Greenberg","Peter Huber","Dieter Borchmeyer"}', '{"Translations into English",Knowledge,Science,"German Authors",Biography,Art,Philosophy,Literature,"German Aesthetics",Quotations,"History and criticism","German National characteristics",Characters,"English Translations",Travel,"German Maxims","Men in literature",Aesthetics,Music,"German Erotic poetry","Music in literature",Men,Calendars,"Literary calendars","Women in literature","Translations into Catalan",Women,"Accessible book"}', '2019-08-09 04:53:48.802549', '2019-08-09 04:53:48.802549', NULL, NULL);
INSERT INTO public.books VALUES (26, 'The birds of America', NULL, '{http://covers.openlibrary.org/b/olid/OL6904996M-L.jpg}', 'Please update me!', 'Please update me, too!', 467000, NULL, NULL, NULL, 'J.J. Audubon', '1840-01-01 00:00:00', 'New York', '7 v.', '[{"type":"txt","file_path":"_data/txt/OL6904996M.txt","file_size":890290},{"type":"pdf","file_path":"_data/pdf/OL6904996M.pdf","file_size":36253665},{"type":"txt","file_path":"_data/txt/OL6904996M.txt","file_size":890290},{"type":"pdf","file_path":"_data/pdf/OL6904996M.pdf","file_size":36253665}]', '{"John James Audubon","RH Value Publishing","Cyril Walker","Roger Tory Peterson Institute","Virginia Marie Peterson"}', '{"American Watercolor painting","Birds in art",Classification,"Birds in art.","Accessible book","Protected DAISY","In library","Miniature books",Ornithologists,Specimens,Artists,"Ornithological illustration","Geographical distribution","Juvenile literature",Birds,Biography,"Pictorial works","Sale Adult - Art & Art Instruction",Nature/Ecology,"Techniques - Painting - Specific Subjects","Individual Artist","Art / General","Sale Books","North America","Birds, including cage birds","Drawing & drawings","Birds & Birdwatching - General","Art & Art Instruction",Art,"Techniques - Printmaking"}', '2019-08-09 04:53:48.779988', '2019-08-09 04:53:48.779988', NULL, NULL);
INSERT INTO public.books VALUES (27, 'Auguste Rodin', NULL, '{http://covers.openlibrary.org/b/olid/OL6619165M-L.jpg}', 'Please update me!', 'Please update me, too!', 447000, NULL, NULL, NULL, 'Sunwise turn inc.', '1919-01-01 00:00:00', 'New York', '4 p. l., 13-80 p., l l.', '[{"type":"pdf","file_path":"_data/pdf/OL6619165M.pdf","file_size":1185429},{"type":"epub","file_path":"_data/epub/OL6619165M.epub","file_size":965382},{"type":"txt","file_path":"_data/txt/OL6619165M.txt","file_size":97892},{"type":"pdf","file_path":"_data/pdf/OL6619165M.pdf","file_size":1185429},{"type":"txt","file_path":"_data/txt/OL6619165M.txt","file_size":97892},{"type":"epub","file_path":"_data/epub/OL6619165M.epub","file_size":965382}]', '{"Rainer Maria Rilke"}', '{Correspondence,"German Authors",Art,Knowledge,History,"Art and literature","French Authors",Painters,"Cats in art","Art in literature",Biography,"Accessible book","Correspondence (Rilke, Rainer Maria)",Briefsammlung,"OUR Brockhaus selection","Literatur in verwandten Sprachen Deutsche Literatur","Criticism and interpretation"}', '2019-08-09 04:53:48.781404', '2019-08-09 04:53:48.781404', NULL, NULL);
INSERT INTO public.books VALUES (28, 'Goya', NULL, '{http://covers.openlibrary.org/b/olid/OL18081427M-L.jpg}', 'Please update me!', 'Please update me, too!', 387000, NULL, NULL, NULL, 'Éditions Hypérion', '2019-08-09 04:53:48.785178', 'Paris', '47 p.', '[{"type":"pdf","file_path":"_data/pdf/OL18081427M.pdf","file_size":2272210},{"type":"txt","file_path":"_data/txt/OL18081427M.txt","file_size":12410},{"type":"txt","file_path":"_data/txt/OL18081427M.txt","file_size":12410},{"type":"pdf","file_path":"_data/pdf/OL18081427M.pdf","file_size":2272210}]', '{"Francisco Goya"}', '{"Catalogues raisonnés",Correspondence,"In library",Catalogs,Exhibitions,"Museo del Prado","Critique et interprétation","Accessible book",Artists,"Criticism and interpretation",Romanticism,Painters,"Modernism (Art)","Art collections","Spanish Painting","Private collections","Protected DAISY",Art,"Spanish Prints",Biography}', '2019-08-09 04:53:48.785173', '2019-08-09 04:53:48.785173', NULL, NULL);
INSERT INTO public.books VALUES (29, 'Michelangelo', 'a record of his life as told in his own letters and papers', '{http://covers.openlibrary.org/b/olid/OL13531647M-L.jpg}', 'Please update me!', 'Please update me, too!', 108000, NULL, NULL, NULL, 'Constable & Co. ltd.', '1913-01-01 00:00:00', 'London', 'xiv, 335 p. :', '[{"type":"pdf","file_path":"_data/pdf/OL13531647M.pdf","file_size":20647751},{"type":"txt","file_path":"_data/txt/OL13531647M.txt","file_size":526818},{"type":"epub","file_path":"_data/epub/OL13531647M.epub","file_size":7442177}]', '{"Michelangelo Buonarroti"}', '{Art,"Artistic Anatomy",Artists,"Artists'' preparatory studies",Autographs,Bibliography,Biography,"Cappella Sistina (Vatican Palace, Vatican City)","Casa Buonarroti (Florence, Italy)",Catalogs,Chronology,Exhibitions,Manuscripts,"Miniature books","Notebooks, sketchbooks","Renaissance Art","San Lorenzo (Church : Florence, Italy)","San Lorenzo (Church : Florence, Italy). Sagrestia nuova","Sistine Chapel (Vatican Palace, Vatican City)","Vatican. Capella paolina",Vatican,Painters}', '2019-08-09 04:53:48.792191', '2019-08-09 04:53:48.792191', NULL, NULL);
INSERT INTO public.books VALUES (30, 'The crown of wild olive', 'four lectures on work, traffic, war, and the future of England', '{http://covers.openlibrary.org/b/olid/OL6775051M-L.jpg}', 'Please update me!', 'Please update me, too!', 170000, NULL, NULL, NULL, 'W. B. Conkey company', '1900-01-01 00:00:00', 'Chicago', '240 p.', '[{"type":"pdf","file_path":"_data/pdf/OL6775051M.pdf","file_size":16442268},{"type":"txt","file_path":"_data/txt/OL6775051M.txt","file_size":305779},{"type":"txt","file_path":"_data/txt/OL6775051M.txt","file_size":305779},{"type":"pdf","file_path":"_data/pdf/OL6775051M.pdf","file_size":16442268}]', '{"John Ruskin"}', '{Architecture,Work,War,History,"Politics and government",Art,"Greek Mythology",Industry,Economics,"Art and war","Environmental aspects","Working class","Accessible book",Sculpture,"History. [from old catalog]","Art et guerre","Aspect de l''environnement",Industrie}', '2019-08-09 04:53:48.793323', '2019-08-09 04:53:48.793323', NULL, NULL);
INSERT INTO public.books VALUES (31, '"Unto this last"', 'four essays on the first principles of political economy.', '{http://covers.openlibrary.org/b/olid/OL6576588M-L.jpg}', 'Please update me!', 'Please update me, too!', 395000, NULL, NULL, NULL, 'J. Wiley & son', '1866-01-01 00:00:00', 'New York', 'xiv p., 1 l., [17]-138 p.', '[{"type":"pdf","file_path":"_data/pdf/OL6576588M.pdf","file_size":6220598},{"type":"txt","file_path":"_data/txt/OL6576588M.txt","file_size":195096},{"type":"epub","file_path":"_data/epub/OL6576588M.epub","file_size":2322056}]', '{"John Ruskin"}', '{Economics,"Social security",Art,Wealth,"Welfare state",Training,Pensions,Youth}', '2019-08-09 04:53:48.794306', '2019-08-09 04:53:48.794306', NULL, NULL);
INSERT INTO public.books VALUES (32, 'Cézanne', NULL, '{http://covers.openlibrary.org/b/olid/OL14050598M-L.jpg}', 'Please update me!', 'Please update me, too!', 201000, NULL, NULL, NULL, 'Éditions Hypérion', '1963-01-01 00:00:00', 'Paris', '41 p.', '[{"type":"pdf","file_path":"_data/pdf/OL14050598M.pdf","file_size":3790249},{"type":"txt","file_path":"_data/txt/OL14050598M.txt","file_size":12959},{"type":"epub","file_path":"_data/epub/OL14050598M.epub","file_size":18712717}]', '{"Paul Cézanne","Paul Cézanne","Federico Teresa Zandomeneghi","Anna Barskaya","Eugenia Georgievskaya","Francoise Cachin","Isabelle Cahn","Walter Feilchenfeldt"}', '{Exhibitions,"Musée de l''Orangerie","Post-impressionism (Art)","French Painting",Interviews,"French Drawing","Accessible book","Protected DAISY","In library",Impressionism,"Individual artists","Painting & paintings",Post-Impressionism,"Individual Artist",Art,"Art & Art Instruction","Exhibition catalogues and specific collections","Museum, historic sites, gallery & art guides","Collections, Catalogs, Exhibitions - General","Exhibition Catalogs","History - General","Câezanne, Paul,","Art / Individual Artist","Cezanne, Paul",1839-1906,Catalogs,"Cezanne, Paul,"}', '2019-08-09 04:53:48.795254', '2019-08-09 04:53:48.795254', NULL, NULL);
INSERT INTO public.books VALUES (34, 'The Kingdom of God Is Within You', 'Christianity Not as a Mystic Religion but as a New Theory of Life', '{http://covers.openlibrary.org/b/olid/OL25358735M-L.jpg}', 'Please update me!', 'Please update me, too!', 367000, NULL, NULL, NULL, 'Cassell Publishing Co.', '1894-01-01 00:00:00', 'New York', NULL, '[{"type":"pdf","file_path":"_data/pdf/OL25358735M.pdf","file_size":1033798},{"type":"txt","file_path":"_data/txt/OL25358735M.txt","file_size":725104},{"type":"epub","file_path":"_data/epub/OL25358735M.epub","file_size":612749}]', '{Tolstoy}', '{Art,"Art and morals",Christianity,"Church history","Controversial literature","Essence, genius, nature","Evil, Non-resistance to","Evil, Non-resistance to.","Kingdom of God",Nonviolence,Religion,"Religious aspects","Religious aspects of Nonviolence","Religious aspects of Resistance to government","Religious aspects of War","Resistance to Government",War,"Christian anarchism","Protected DAISY"}', '2019-08-09 04:53:48.809021', '2019-08-09 04:53:48.809021', NULL, NULL);
INSERT INTO public.books VALUES (35, 'The child''s conception of the world.', NULL, '{http://covers.openlibrary.org/b/olid/OL23627514M-L.jpg}', 'Please update me!', 'Please update me, too!', 451000, NULL, NULL, NULL, 'Routledge & K. Paul', '1929-01-01 00:00:00', 'London', 'ix, 379 p.', '[{"type":"txt","file_path":"_data/txt/OL23627514M.txt","file_size":867094},{"type":"pdf","file_path":"_data/pdf/OL23627514M.pdf","file_size":18127090},{"type":"epub","file_path":"_data/epub/OL23627514M.epub","file_size":13939312}]', '{"Jean Piaget"}', '{Congresses,"Child psychology","Imagery (Psychology) in children","Drawing ability in children","Child development","Earth in art",Art,"Space perception in children","Earth in art.","Child study","Protected DAISY","In library"}', '2019-08-09 04:53:48.815568', '2019-08-09 04:53:48.815568', NULL, NULL);
INSERT INTO public.books VALUES (36, 'Gerhard Richter', 'Eight Gray', '{http://covers.openlibrary.org/b/olid/OL8230100M-L.jpg}', 'Please update me!', 'Please update me, too!', 89000, NULL, NULL, NULL, 'Guggenheim Museum', '2019-08-09 04:53:48.821809', NULL, NULL, '[{"type":"pdf","file_path":"_data/pdf/OL8230100M.pdf","file_size":6131653},{"type":"txt","file_path":"_data/txt/OL8230100M.txt","file_size":102653},{"type":"epub","file_path":"_data/epub/OL8230100M.epub","file_size":24465317}]', '{"Gerhard Richter","Andreas Hapkemeyer","Peter Weiermar"}', '{Exhibitions,Interviews,"Rote Armee Fraktion",Philosophy,Artists,"In art",Art,"Art (Drawing and Painting)","Baader-Meinhof gang in art","Baader-Meinhof gang","Rote Armee Fraktion in art","History of art & design styles: from c 1900 -","Individual artists","Painting & paintings"}', '2019-08-09 04:53:48.821802', '2019-08-09 04:53:48.821802', NULL, NULL);
INSERT INTO public.books VALUES (37, 'The gentle art of making enemies', 'as pleasingly exemplified in many instances, wherein the serious ones of this earth, carefully exasperated, have been prettily spurred on to unseemliness and indiscretion, while overcome by an undue sense of right.', '{http://covers.openlibrary.org/b/olid/OL6530865M-L.jpg}', 'Please update me!', 'Please update me, too!', 256000, NULL, NULL, NULL, 'W. Heinemann', '1909-01-01 00:00:00', 'London', '8 prelim. leaves, 340 p.', '[{"type":"epub","file_path":"_data/epub/OL6530865M.epub","file_size":2201740},{"type":"pdf","file_path":"_data/pdf/OL6530865M.pdf","file_size":14034505},{"type":"txt","file_path":"_data/txt/OL6530865M.txt","file_size":315234}]', '{"James McNeill Whistler"}', '{Correspondence,Painters,"Criticism and interpretation","Art criticism","Accessible book",Art,"Protected DAISY",Biography,Artists}', '2019-08-09 04:53:48.822785', '2019-08-09 04:53:48.822785', NULL, NULL);
INSERT INTO public.books VALUES (38, 'The eighteen nineties', 'a review of art and ideas at the close of the nineteenth century', '{http://covers.openlibrary.org/b/olid/OL23347429M-L.jpg}', 'Please update me!', 'Please update me, too!', 317000, NULL, NULL, NULL, 'A.A. Knopf', '1922-01-01 00:00:00', 'New York', '304 p.', '[{"type":"epub","file_path":"_data/epub/OL23347429M.epub","file_size":12528604},{"type":"pdf","file_path":"_data/pdf/OL23347429M.pdf","file_size":19161489},{"type":"txt","file_path":"_data/txt/OL23347429M.txt","file_size":636910}]', '{"Holbrook Jackson"}', '{"English literature","History and criticism","Intellectual life",Art,"Arts and society","British Arts","Victorian Arts","Edwardian Arts","British Art","English Arts","Accessible book"}', '2019-08-09 04:53:48.82396', '2019-08-09 04:53:48.82396', NULL, NULL);
INSERT INTO public.books VALUES (39, 'Aesthetic as science of expression and general linguistic', NULL, '{http://covers.openlibrary.org/b/olid/OL14653168M-L.jpg}', 'Please update me!', 'Please update me, too!', 171000, NULL, NULL, NULL, 'Macmillan and co., limited', '1922-01-01 00:00:00', 'London', 'xxx p., 1 l., 503 p.', '[{"type":"epub","file_path":"_data/epub/OL14653168M.epub","file_size":801823},{"type":"txt","file_path":"_data/txt/OL14653168M.txt","file_size":1127804},{"type":"pdf","file_path":"_data/pdf/OL14653168M.pdf","file_size":22205527}]', '{"Benedetto Croce"}', '{Aesthetics,"Language and languages",Philosophy,Historiography,Art,"Protected DAISY"}', '2019-08-09 04:53:48.824913', '2019-08-09 04:53:48.824913', NULL, NULL);
INSERT INTO public.books VALUES (40, 'Hopes and fears for art.', NULL, '{http://covers.openlibrary.org/b/olid/OL23305303M-L.jpg}', 'Please update me!', 'Please update me, too!', 305000, NULL, NULL, NULL, 'Longmans', '1908-01-01 00:00:00', 'London', '217 p.', '[{"type":"epub","file_path":"_data/epub/OL23305303M.epub","file_size":3067687},{"type":"pdf","file_path":"_data/pdf/OL23305303M.pdf","file_size":10571617},{"type":"txt","file_path":"_data/txt/OL23305303M.txt","file_size":331483}]', '{"William Morris"}', '{"Arts and crafts movement",Art,"Accessible book"}', '2019-08-09 04:53:48.825956', '2019-08-09 04:53:48.825956', NULL, NULL);
INSERT INTO public.books VALUES (41, 'St. Mark''s rest.', 'The history of Venice, written for the help of the few travellers who still care for her monuments.', '{http://covers.openlibrary.org/b/olid/OL24251787M-L.jpg}', 'Please update me!', 'Please update me, too!', 326000, NULL, NULL, NULL, 'G. Allen', '1884-01-01 00:00:00', 'Orpington [Eng.]', 'x, 160 p.', '[{"type":"epub","file_path":"_data/epub/OL24251787M.epub","file_size":799823},{"type":"pdf","file_path":"_data/pdf/OL24251787M.pdf","file_size":11258122},{"type":"txt","file_path":"_data/txt/OL24251787M.txt","file_size":375022}]', '{"John Ruskin"}', '{Art,History,"Italian Art",Perspective,"Accessible book",Histoire}', '2019-08-09 04:53:48.826909', '2019-08-09 04:53:48.826909', NULL, NULL);
INSERT INTO public.books VALUES (42, 'Val d''Arno', 'ten lectures on the Tuscan art directly antecedent to the Florentine year of victories; given before the University of Oxford in Michaelmas term, 1873', '{http://covers.openlibrary.org/b/olid/OL17967874M-L.jpg}', 'Please update me!', 'Please update me, too!', 33000, NULL, NULL, NULL, 'C. E. Merrill & Co.; 1891.', '1891-01-01 00:00:00', 'New York', 'xiv p., 1 l., 256 p.', '[{"type":"txt","file_path":"_data/txt/OL17967874M.txt","file_size":315990},{"type":"pdf","file_path":"_data/pdf/OL17967874M.pdf","file_size":13731418},{"type":"epub","file_path":"_data/epub/OL17967874M.epub","file_size":7071808}]', '{"John Ruskin"}', '{Art,Botany,"Accessible book","Italian Art"}', '2019-08-09 04:53:48.828274', '2019-08-09 04:53:48.828274', NULL, NULL);
INSERT INTO public.books VALUES (43, 'Art et scolastique.', NULL, '{http://covers.openlibrary.org/b/olid/OL13995004M-L.jpg}', 'Please update me!', 'Please update me, too!', 390000, NULL, NULL, NULL, 'Librairie de l''Art Catholique', '1920-01-01 00:00:00', 'Paris', '188 p.', '[{"type":"txt","file_path":"_data/txt/OL13995004M.txt","file_size":245580},{"type":"pdf","file_path":"_data/pdf/OL13995004M.pdf","file_size":6408433},{"type":"epub","file_path":"_data/epub/OL13995004M.epub","file_size":15370351}]', '{"Jacques Maritain"}', '{"Accessible book",Aesthetics,Art,History,Philosophy,Poetry,Scholasticism}', '2019-08-09 04:53:48.829462', '2019-08-09 04:53:48.829462', NULL, NULL);
INSERT INTO public.books VALUES (44, '"Ten O''clock."', NULL, '{http://covers.openlibrary.org/b/olid/OL23454968M-L.jpg}', 'Please update me!', 'Please update me, too!', 414000, NULL, NULL, NULL, NULL, '1888-01-01 00:00:00', NULL, NULL, '[{"type":"pdf","file_path":"_data/pdf/OL23454968M.pdf","file_size":706964},{"type":"txt","file_path":"_data/txt/OL23454968M.txt","file_size":33091},{"type":"epub","file_path":"_data/epub/OL23454968M.epub","file_size":101247}]', '{"James McNeill Whistler"}', '{Art,"Accessible book"}', '2019-08-09 04:53:48.830459', '2019-08-09 04:53:48.830459', NULL, NULL);
INSERT INTO public.books VALUES (45, 'Epochs of Chinese & Japanese art', 'an outline history of East Asiatic design.', '{http://covers.openlibrary.org/b/olid/OL22879593M-L.jpg}', 'Please update me!', 'Please update me, too!', 23000, NULL, NULL, NULL, 'Frederick A. Stokes company', '1912-01-01 00:00:00', 'New York', '2 v.', '[{"type":"txt","file_path":"_data/txt/OL22879593M.txt","file_size":561897},{"type":"pdf","file_path":"_data/pdf/OL22879593M.pdf","file_size":24071387},{"type":"epub","file_path":"_data/epub/OL22879593M.epub","file_size":66545342}]', '{"Ernest Francisco Fenollosa"}', '{History,Art,"Chinese Art","Japanese Art","Asian Art","Accessible book"}', '2019-08-09 04:53:48.837382', '2019-08-09 04:53:48.837382', NULL, NULL);
INSERT INTO public.books VALUES (46, 'Apollo', 'an illustrated manual of the history of art throughout the ages', '{http://covers.openlibrary.org/b/olid/OL22848861M-L.jpg}', 'Please update me!', 'Please update me, too!', 453000, NULL, NULL, NULL, 'C. Scribner''s Sons', '1908-01-01 00:00:00', 'New York', 'xvi, 350 p.', '[{"type":"txt","file_path":"_data/txt/OL22848861M.txt","file_size":703243},{"type":"epub","file_path":"_data/epub/OL22848861M.epub","file_size":59773588},{"type":"pdf","file_path":"_data/pdf/OL22848861M.pdf","file_size":28015656}]', '{"Salomon, Louis Rev."}', '{History,Art,Bibliography,Architecture}', '2019-08-09 04:53:48.847476', '2019-08-09 04:53:48.847476', NULL, NULL);
INSERT INTO public.books VALUES (47, 'Religion: a dialogue', 'and other essays', '{http://covers.openlibrary.org/b/olid/OL24182061M-L.jpg}', 'Please update me!', 'Please update me, too!', 167000, NULL, NULL, NULL, 'G. Allen & Unwin', '1915-01-01 00:00:00', 'London', '140 p.', '[{"type":"pdf","file_path":"_data/pdf/OL24182061M.pdf","file_size":3281126},{"type":"epub","file_path":"_data/epub/OL24182061M.epub","file_size":474213},{"type":"txt","file_path":"_data/txt/OL24182061M.txt","file_size":208555}]', '{"Arthur Schopenhauer"}', '{Philosophy,Pessimism,Literature,"Conduct of life",Religion,Maxims,Esthétique,"Morale pratique","Study and teaching (Higher)","Art and literature",Intelligence,"Addresses, essays, lectures",Métaphysique,Art,Philosophie,"Accessible book"}', '2019-08-09 04:53:48.853966', '2019-08-09 04:53:48.853966', NULL, NULL);
INSERT INTO public.books VALUES (48, 'A wanderer in London', NULL, '{http://covers.openlibrary.org/b/olid/OL22138841M-L.jpg}', 'Please update me!', 'Please update me, too!', 498000, NULL, NULL, NULL, 'Methuen', '1909-01-01 00:00:00', 'London', 'x, 305 p., [52] leaves of plates (inc. front.) :', '[{"type":"epub","file_path":"_data/epub/OL22138841M.epub","file_size":1187010},{"type":"txt","file_path":"_data/txt/OL22138841M.txt","file_size":727064},{"type":"pdf","file_path":"_data/pdf/OL22138841M.pdf","file_size":16045320}]', '{"E. V. Lucas"}', '{"Description and travel",Art,"Accessible book","English Art",Description}', '2019-08-09 04:53:48.860549', '2019-08-09 04:53:48.860549', NULL, NULL);
INSERT INTO public.books VALUES (49, 'L'' art romantique', NULL, '{http://covers.openlibrary.org/b/olid/OL24136255M-L.jpg}', 'Please update me!', 'Please update me, too!', 24000, NULL, NULL, NULL, 'L. Conard', '1922-01-01 00:00:00', 'Paris', '599 p. --', '[{"type":"txt","file_path":"_data/txt/OL24136255M.txt","file_size":1015101},{"type":"epub","file_path":"_data/epub/OL24136255M.epub","file_size":6217694},{"type":"pdf","file_path":"_data/pdf/OL24136255M.pdf","file_size":24646191}]', '{"Charles Baudelaire"}', '{"History and criticism","French literature",Art,"Painting, French",Romanticism,"Art criticism",History,"Art, Modern",Arts,"Criticism and interpretation","Fantasy literature, American","Addresses, essays, lectures","French Painting","American Fantasy literature","Modern Art"}', '2019-08-09 04:53:48.861812', '2019-08-09 04:53:48.861812', NULL, NULL);
INSERT INTO public.books VALUES (50, 'Abstraktion und Einfühlung', 'ein Beitrag zur Stilpsychologie', '{http://covers.openlibrary.org/b/olid/OL13991475M-L.jpg}', 'Please update me!', 'Please update me, too!', 339000, NULL, NULL, NULL, 'Piper', '1921-01-01 00:00:00', 'München', 'xi, 179 p.', '[{"type":"txt","file_path":"_data/txt/OL13991475M.txt","file_size":266109},{"type":"pdf","file_path":"_data/pdf/OL13991475M.pdf","file_size":7382126},{"type":"epub","file_path":"_data/epub/OL13991475M.epub","file_size":2350984}]', '{"Wilhelm Worringer"}', '{Art,Philosophy,Aesthetics,"Abstract Art",Psychology,"Accessible book"}', '2019-08-09 04:53:48.86298', '2019-08-09 04:53:48.86298', NULL, NULL);
INSERT INTO public.books VALUES (51, 'Thoreau''s Walden', NULL, '{http://covers.openlibrary.org/b/olid/OL16297782M-L.jpg}', 'Please update me!', 'Please update me, too!', 173000, NULL, NULL, NULL, 'Longmans, Green, and co.', '1910-01-01 00:00:00', 'New York [etc.]', 'xx, 283 p. incl. front. (map)', '[{"type":"txt","file_path":"_data/txt/OL16297782M.txt","file_size":676697},{"type":"epub","file_path":"_data/epub/OL16297782M.epub","file_size":2370800},{"type":"pdf","file_path":"_data/pdf/OL16297782M.pdf","file_size":16364607}]', '{"Henry David Thoreau"}', '{Biography,"Homes and haunts","American Authors","Social life and customs",Solitude,"Natural history","Wilderness areas","Civil disobedience","Resistance to Government","Comic books, strips","Juvenile literature","Translations into Chinese",Philosophy,"Walden Woods",Massachusetts,"English essays",Indexes,1817-1862,"Wildnerness areas","Classic Literature",Fiction,Essays,Nonfiction,Open_syllabus_project,Homes,"American authors","Manners and customs"}', '2019-08-09 04:53:48.864175', '2019-08-09 04:53:48.864175', NULL, NULL);
INSERT INTO public.books VALUES (52, 'Leaves of Grass', NULL, '{http://covers.openlibrary.org/b/olid/OL6392386M-L.jpg}', 'Please update me!', 'Please update me, too!', 137000, NULL, NULL, NULL, 'D. McKay', '1900-01-01 00:00:00', 'Philadelphia', 'xi, 11-526 p.', '[{"type":"txt","file_path":"_data/txt/OL6392386M.txt","file_size":911000},{"type":"pdf","file_path":"_data/pdf/OL6392386M.pdf","file_size":30703102},{"type":"epub","file_path":"_data/epub/OL6392386M.epub","file_size":77196941}]', '{"Walt Whitman"}', '{"United States Civil War, 1861-1865","Translations into Chinese","Gay poets",Presidents,Poetry,"American Poets",Fiction,"English poetry","American poetry",Mysticism,"Classic Literature",Biography,History,"American Epic poetry"}', '2019-08-09 04:53:48.865446', '2019-08-09 04:53:48.865446', NULL, NULL);
INSERT INTO public.books VALUES (53, 'The life of Samuel Johnson, LL.D.', 'with his correspondence and conversations', '{http://covers.openlibrary.org/b/olid/OL7215332M-L.jpg}', 'Please update me!', 'Please update me, too!', 381000, NULL, NULL, NULL, 'George Routledge & Sons', '1872-01-01 00:00:00', 'New York', 'xii, 580 p.', '[{"type":"txt","file_path":"_data/txt/OL7215332M.txt","file_size":3408751},{"type":"epub","file_path":"_data/epub/OL7215332M.epub","file_size":5071884},{"type":"pdf","file_path":"_data/pdf/OL7215332M.pdf","file_size":60788665}]', '{"James Boswell"}', '{Biography,"Description and travel","English Authors","Early works to 1800",Interviews,Lexicographers,"KDescr. & trav","Intellectual life",Critics,Intellectuals,"Protected DAISY","In library","Johnson, Samuel, 1709-1784","Authors, English"}', '2019-08-09 04:53:48.86702', '2019-08-09 04:53:48.86702', NULL, NULL);
INSERT INTO public.books VALUES (54, 'The poetical works of John Keats.', NULL, '{http://covers.openlibrary.org/b/olid/OL22890046M-L.jpg}', 'Please update me!', 'Please update me, too!', 329000, NULL, NULL, NULL, 'R. Worthington', '1800-01-01 00:00:00', 'New York', 'v, [1], [7]-340 p.', '[{"type":"pdf","file_path":"_data/pdf/OL22890046M.pdf","file_size":14855297},{"type":"txt","file_path":"_data/txt/OL22890046M.txt","file_size":483896},{"type":"epub","file_path":"_data/epub/OL22890046M.epub","file_size":5189808}]', '{"John Keats"}', '{"English poetry",Correspondence,"English Poets",Manuscripts,"Criticism and interpretation",Facsimiles,Biography,"Accessible book","Protected DAISY",Poetry,"In library"}', '2019-08-09 04:53:48.868011', '2019-08-09 04:53:48.868011', NULL, NULL);
INSERT INTO public.books VALUES (55, 'Lord Jim', 'a tale of the sea', '{http://covers.openlibrary.org/b/olid/OL24771495M-L.jpg}', 'Please update me!', 'Please update me, too!', 299000, NULL, NULL, NULL, 'W.J. Gage', '1900-01-01 00:00:00', 'Toronto', '5 microfiches (239 fr.).', '[{"type":"epub","file_path":"_data/epub/OL24771495M.epub","file_size":1225195},{"type":"txt","file_path":"_data/txt/OL24771495M.txt","file_size":754729},{"type":"pdf","file_path":"_data/pdf/OL24771495M.pdf","file_size":22788491}]', '{"Joseph Conrad"}', '{Fiction,British,Officers,"Merchant marine",Atonement,Cowardice,"Fiction in English",Travel,Indonesia,"Seafaring life","Conrad, Joseph, 1857-1924. Lord Jim","English Psychological fiction","English Adventure stories","In literature",Literature,"Classic Literature","NOVELAS INGLESAS","LITERARY CRITICISM / European / English, Irish, Scottish, Welsh",Biography,"Criticism and interpretation"}', '2019-08-09 04:53:48.869035', '2019-08-09 04:53:48.869035', NULL, NULL);
INSERT INTO public.books VALUES (56, 'The writings of Mark Twain', 'author''s national edition.', '{http://covers.openlibrary.org/b/olid/OL7167436M-L.jpg}', 'Please update me!', 'Please update me, too!', 60000, NULL, NULL, NULL, 'P.F. Collier]', '1920-01-01 00:00:00', '[New York', NULL, '[{"type":"txt","file_path":"_data/txt/OL7167436M.txt","file_size":845526},{"type":"pdf","file_path":"_data/pdf/OL7167436M.pdf","file_size":20263408},{"type":"epub","file_path":"_data/epub/OL7167436M.epub","file_size":12096636}]', '{"Mark Twain"}', '{"19th century","American Authors",Biography,Business,"Christian Science","Description and travel","Homes and haunts","Intellectual life",Journeys,"Law and politics","Mines and mineral resources",Travel,"Voyages around the world","West (U.S.)","Sexual ethics for teenagers","Sex instruction for youth","Sexual ethics","Protected DAISY","Controversial literature",Fiction,"In library"}', '2019-08-09 04:53:48.869919', '2019-08-09 04:53:48.869919', NULL, NULL);
INSERT INTO public.books VALUES (57, 'Exercitia spiritualia', 'S. P. Ignatii De Loyola', '{http://covers.openlibrary.org/b/olid/OL25921916M-L.jpg}', 'Please update me!', 'Please update me, too!', 165000, NULL, NULL, NULL, 'Avgvstae Tavrinorvm', '1835-01-01 00:00:00', NULL, NULL, '[{"type":"txt","file_path":"_data/txt/OL25921916M.txt","file_size":772738},{"type":"pdf","file_path":"_data/pdf/OL25921916M.pdf","file_size":17517415},{"type":"epub","file_path":"_data/epub/OL25921916M.epub","file_size":31303394}]', '{"Saint Ignatius of Loyola","Aloysio R.P Bellecio",Ignatius.,"William, S.J. Reiser"}', '{"Spiritual exercises",Meditations,"Spiritual retreats","Catholic Church",Meditation,Biography,"Early works to 1800","Christian saints",Jesuits,"Spiritual life","Devotional calendars","Christian life","Devotional exercises","Spiritual direction",Spirituality,History,"Prayers and devotions",French,"Spiritual excercises",Sources,"Pastoral letters and charges","Accessible book","Protected DAISY","In library","Ignatius,","Christianity - Catholicism","Religion - Classic Works",Religion,"Inspirational - Catholic","Christian Life - General","Christian Life - Inspirational - Catholic",1491-1556.,"Of Loyola, Saint,","Christianity - Catholic",1491-1556,"Exercitia spiritualia"}', '2019-08-09 04:53:48.876016', '2019-08-09 04:53:48.876016', NULL, NULL);
INSERT INTO public.books VALUES (58, 'Paul and Virginia', NULL, '{http://covers.openlibrary.org/b/olid/OL24188166M-L.jpg}', 'Please update me!', 'Please update me, too!', 28000, NULL, NULL, NULL, 'G. Routledge and Sons', '1888-01-01 00:00:00', 'London', 'xxvii, 208 p., [12] leaves of plates :', '[{"type":"txt","file_path":"_data/txt/OL24188166M.txt","file_size":295889},{"type":"pdf","file_path":"_data/pdf/OL24188166M.pdf","file_size":14571280},{"type":"epub","file_path":"_data/epub/OL24188166M.epub","file_size":20334081}]', '{"Bernardin de Saint-Pierre"}', '{Botany,Fiction,"Mauritius in fiction",Readers,"French language","Translations into Arabic","Arabic literature","French literature","Translations from French",Imprints,"Classic Literature","Brothers and sisters",Biography,History}', '2019-08-09 04:53:48.882614', '2019-08-09 04:53:48.882614', NULL, NULL);
INSERT INTO public.books VALUES (59, 'The bookof Ser Marco Polo, the Venetian', 'concerning the kingdoms and marvels of the East', '{http://covers.openlibrary.org/b/olid/OL21776234M-L.jpg}', 'Please update me!', 'Please update me, too!', 398000, NULL, NULL, NULL, 'J. Murray', '1903-01-01 00:00:00', 'London', '2 v :', '[{"type":"txt","file_path":"_data/txt/OL21776234M.txt","file_size":1931910},{"type":"epub","file_path":"_data/epub/OL21776234M.epub","file_size":40144296},{"type":"pdf","file_path":"_data/pdf/OL21776234M.pdf","file_size":55563349}]', '{"Marco Polo"}', '{"Description and travel","Voyages and travels",History,Mongols,"Early works to 1800","Chinese Inscriptions",Travel,"Early maps",Travelers,Biography,Bibliography,"Biblioteca civica (Padua, Italy)","Illumination of books and manuscripts",Mongals,"Pre-Linnean works","Descriptions et voyages","Natural history",Specimens,Voyages,Journeys,Italians,Asie,"Accessible book","Protected DAISY","In library","Medieval Travel","Miniature books","Fairy tales","Medieval Illumination of books and manuscripts"}', '2019-08-09 04:53:48.889197', '2019-08-09 04:53:48.889197', NULL, NULL);
INSERT INTO public.books VALUES (60, 'Adolphe', NULL, '{http://covers.openlibrary.org/b/olid/OL24149326M-L.jpg}', 'Please update me!', 'Please update me, too!', 123000, NULL, NULL, NULL, 'A. Quantin', '1878-01-01 00:00:00', 'Paris', '228 p. :', '[{"type":"txt","file_path":"_data/txt/OL24149326M.txt","file_size":266570},{"type":"pdf","file_path":"_data/pdf/OL24149326M.pdf","file_size":11405723},{"type":"epub","file_path":"_data/epub/OL24149326M.epub","file_size":4591461}]', '{"Benjamin Constant"}', '{Fiction,"Social life and customs",Theater,"Commitment (Psychology)","French fiction","Translations into English","French literature","Planche, Gustave, 1808-1857","Swiss Novelists","Childhood and youth",Biography,"Classic Literature",Literature,"Literatura Francesa"}', '2019-08-09 04:53:48.895549', '2019-08-09 04:53:48.895549', NULL, NULL);
INSERT INTO public.books VALUES (61, 'The auto-biography of Goethe.', 'Truth and poetry: from my own life.', '{http://covers.openlibrary.org/b/olid/OL23279698M-L.jpg}', 'Please update me!', 'Please update me, too!', 415000, NULL, NULL, NULL, 'H. G. Bohn', '1848-01-01 00:00:00', 'London', '2 v.', '[{"type":"txt","file_path":"_data/txt/OL23279698M.txt","file_size":1305650},{"type":"epub","file_path":"_data/epub/OL23279698M.epub","file_size":1533087},{"type":"pdf","file_path":"_data/pdf/OL23279698M.pdf","file_size":35231168}]', '{"John Leonard Greenberg"}', '{Plants,"German Poets","Effect of chemicals on","German Authors","Description and travel",Travel,"Translations into English","Botanical chemistry","In library","Accessible book",Bibliography,"German language","Childhood and youth",Biography}', '2019-08-09 04:53:48.896552', '2019-08-09 04:53:48.896552', NULL, NULL);
INSERT INTO public.books VALUES (62, 'Max Ernst', 'a retrospective.', '{http://covers.openlibrary.org/b/olid/OL5063689M-L.jpg}', 'Please update me!', 'Please update me, too!', 151000, NULL, NULL, NULL, 'Solomon R. Guggenheim Museum', '1975-01-01 00:00:00', 'New York', '271 p. :', '[{"type":"pdf","file_path":"_data/pdf/OL5063689M.pdf","file_size":16902351},{"type":"txt","file_path":"_data/txt/OL5063689M.txt","file_size":263832},{"type":"epub","file_path":"_data/epub/OL5063689M.epub","file_size":74380719}]', '{"Max Ernst","Werner Spies","Fabrice Hergott","Doris Krystof","Günter Metken"}', '{"In library","Friends and associates","Kreissparkasse Köln (Germany)",Dadaism,"Art collections","Drawing, German",Catalogs,"Deutsche Lufthansa (1951- )","Themes, motives","Sprengel Museum Hannover","Private collections",Drawing,Prints,Art,Exhibitions,Portraits,Rubbing,"Capricorn Trust",Surrealism,Biography,Artists,"German Drawing","German Painting"}', '2019-08-09 04:53:48.897519', '2019-08-09 04:53:48.897519', NULL, NULL);
INSERT INTO public.books VALUES (63, 'Memorabilia', 'edited on the basis of the Breitenbach-Mücke ed. by Josiah Renick Smith.', '{http://covers.openlibrary.org/b/olid/OL23318736M-L.jpg}', 'Please update me!', 'Please update me, too!', 50000, NULL, NULL, NULL, 'Ginn', '1903-01-01 00:00:00', 'Boston', '270p.', '[{"type":"txt","file_path":"_data/txt/OL23318736M.txt","file_size":703191},{"type":"epub","file_path":"_data/epub/OL23318736M.epub","file_size":2571382},{"type":"pdf","file_path":"_data/pdf/OL23318736M.pdf","file_size":15579663}]', '{Xenophon}', '{"Accessible book","Ancient Philosophers",Biography,"Early works to 1800","Trials, litigation"}', '2019-08-09 04:53:48.89849', '2019-08-09 04:53:48.89849', NULL, NULL);
INSERT INTO public.books VALUES (64, 'Goethes werke', 'illustrirt von ersten deutschen Künstlern', '{http://covers.openlibrary.org/b/olid/OL24361402M-L.jpg}', 'Please update me!', 'Please update me, too!', 305000, NULL, NULL, NULL, 'Deutsche verlagsanstalt, vorm. E. Hallberger', '1882-01-01 00:00:00', 'Stuttgart', '5 v.  illus., port.', '[{"type":"txt","file_path":"_data/txt/OL24361402M.txt","file_size":1982037},{"type":"pdf","file_path":"_data/pdf/OL24361402M.pdf","file_size":70623189},{"type":"epub","file_path":"_data/epub/OL24361402M.epub","file_size":108321661}]', '{"John Leonard Greenberg"}', '{"Translations into English",Knowledge,Science,"German Authors",Biography,Philosophy,Art,Literature,"German Aesthetics","History and criticism","German National characteristics",Characters,Quotations,"English Translations",Readers,Travel,"German Maxims","Men in literature",Aesthetics,Music,"German Erotic poetry","Music in literature","German language",Calendars,Men,"Literary calendars","Women in literature","Translations into Catalan",Women,"Accessible book"}', '2019-08-09 04:53:48.899484', '2019-08-09 04:53:48.899484', NULL, NULL);
INSERT INTO public.books VALUES (65, 'Vitae excellentium imperatorum', 'cum versione Anglicâ, in quâ verbum de verbo, quantum fieri potuit, redditus; notis quoquè Anglicis, [et] indice locupletissimo; or, Lives of the excellent commanders', '{http://covers.openlibrary.org/b/olid/OL23357020M-L.jpg}', 'Please update me!', 'Please update me, too!', 176000, NULL, NULL, NULL, 'Rivington', '1790-01-01 00:00:00', 'London', '280 p.', '[{"type":"epub","file_path":"_data/epub/OL23357020M.epub","file_size":2541087},{"type":"txt","file_path":"_data/txt/OL23357020M.txt","file_size":659666},{"type":"pdf","file_path":"_data/pdf/OL23357020M.pdf","file_size":19546504}]', '{"Cornelius Nepos"}', '{"Accessible book",Biography,"Classical biography","Early works to 1800",Emperors,Generals,History,"Latin language",Readers,Bibliography,"Latin language materials"}', '2019-08-09 04:53:48.900728', '2019-08-09 04:53:48.900728', NULL, NULL);
INSERT INTO public.books VALUES (66, 'The Golden Legend, Or, Lives Of The Saints', 'Volume 2', '{http://covers.openlibrary.org/b/olid/OL25910245M-L.jpg}', 'Please update me!', 'Please update me, too!', 126000, NULL, NULL, NULL, 'J.M. Dent and Co.', '1900-01-01 00:00:00', 'London', NULL, '[{"type":"pdf","file_path":"_data/pdf/OL25910245M.pdf","file_size":6621908},{"type":"txt","file_path":"_data/txt/OL25910245M.txt","file_size":511432},{"type":"epub","file_path":"_data/epub/OL25910245M.epub","file_size":53088006}]', '{"Jacobus de Voragine","William Caxton"}', '{"Christian saints","Early works to 1800",Biography,Legends,Saints,"Translations into English","Christian literature, Latin (Medieval and modern)",Heiligen,"French Christian literature","Catholic Church",History,"Christian women saints",Incunabula,Liturgy,Bible,Martyrologies,Specimens,"Church calendar",Texts,Cult,Calendar,"Accessible book"}', '2019-08-09 04:53:48.901803', '2019-08-09 04:53:48.901803', NULL, NULL);
INSERT INTO public.books VALUES (67, 'Diary and correspondence of Samuel Pepys, F.R.S.', 'secretary to the Admiralty in the reign of Charles II and James II', '{http://covers.openlibrary.org/b/olid/OL7026452M-L.jpg}', 'Please update me!', 'Please update me, too!', 88000, NULL, NULL, NULL, 'C. T. Brainard', '1880-01-01 00:00:00', 'Boston', '4 v. :', '[{"type":"txt","file_path":"_data/txt/OL7026452M.txt","file_size":1089045},{"type":"epub","file_path":"_data/epub/OL7026452M.epub","file_size":5873496},{"type":"pdf","file_path":"_data/pdf/OL7026452M.pdf","file_size":28688822}]', '{"Samuel Pepys"}', '{"Accessible book",Biography,"Cabinet officers",Diaries,Diarists,"English Authors","English drama","Great Britain",History,"History and criticism","Social life and customs",Sources,Statesmen,Theater,"Social conditions",Agriculture,Periodicals,"Plant diseases",Open_syllabus_project,Tagebuch,"Social Environment","Manners and customs","Social Conditions"}', '2019-08-09 04:53:48.902993', '2019-08-09 04:53:48.902993', NULL, NULL);
INSERT INTO public.books VALUES (68, 'The works of William Shakespeare', NULL, '{http://covers.openlibrary.org/b/olid/OL24155589M-L.jpg}', 'Please update me!', 'Please update me, too!', 61000, NULL, NULL, NULL, 'Macmillan and co.', '1863-01-01 00:00:00', 'Cambridge and London', '9 v.', '[{"type":"epub","file_path":"_data/epub/OL24155589M.epub","file_size":1035478},{"type":"txt","file_path":"_data/txt/OL24155589M.txt","file_size":1250140},{"type":"pdf","file_path":"_data/pdf/OL24155589M.pdf","file_size":17296262}]', '{"William Shakespeare"}', '{Drama,Bibliography,"Outlines, syllabi",Sources,Generals,Language,Study,Dictionaries,Illustrations,"Folios. 1623",History,Folios,Goths,Concordances,Glossaries,"Titus Andronicus (Legendary character)","English Manuscripts",Heroes,"English Paleography",Biography,"Accessible book","English language","Glossaries, vocabularies",Facsimiles}', '2019-08-09 04:53:48.90466', '2019-08-09 04:53:48.90466', NULL, NULL);
INSERT INTO public.books VALUES (69, 'Gespräche', NULL, '{http://covers.openlibrary.org/b/olid/OL23418096M-L.jpg}', 'Please update me!', 'Please update me, too!', 22000, NULL, NULL, NULL, 'Ehlermann', '1900-01-01 00:00:00', 'Leipzig', '208 p.  pl., port.', '[{"type":"txt","file_path":"_data/txt/OL23418096M.txt","file_size":462716},{"type":"pdf","file_path":"_data/pdf/OL23418096M.pdf","file_size":10341540},{"type":"epub","file_path":"_data/epub/OL23418096M.epub","file_size":7038277}]', '{"Johann Wolfgang von Goethe","Johann Peter Eckermann","Otto Schönberger"}', '{Biography,"German Authors","Accessible book"}', '2019-08-09 04:53:48.910932', '2019-08-09 04:53:48.910932', NULL, NULL);
INSERT INTO public.books VALUES (70, 'Italiänische Reise', 'Aufsätze und Aussprüche über bildende Kunst, mit Einleitung und Bericht über dessen Kunststudien und Kunstübungen', '{http://covers.openlibrary.org/b/olid/OL23418231M-L.jpg}', 'Please update me!', 'Please update me, too!', 403000, NULL, NULL, NULL, 'Cotta', '1862-01-01 00:00:00', 'Stuttgart', '2 vol.', '[{"type":"epub","file_path":"_data/epub/OL23418231M.epub","file_size":2386626},{"type":"txt","file_path":"_data/txt/OL23418231M.txt","file_size":1527942},{"type":"pdf","file_path":"_data/pdf/OL23418231M.pdf","file_size":35942731}]', '{"John Leonard Greenberg"}', '{Correspondence,"In library","German Authors","Description and travel",Diaries,Journeys,Travel,Views,"Early works to 1800","German language","Accessible book",Biography}', '2019-08-09 04:53:48.917171', '2019-08-09 04:53:48.917171', NULL, NULL);
INSERT INTO public.books VALUES (71, 'Thabridgemente of the Histories of Trogus Pompeius', NULL, '{http://covers.openlibrary.org/b/olid/OL13446520M-L.jpg}', 'Please update me!', 'Please update me, too!', 406000, NULL, NULL, NULL, 'By Thomas Marshe.', '1570-01-01 00:00:00', 'Imprinted at London', '[13], 200 [i.e. 179] leaves ;', '[{"type":"txt","file_path":"_data/txt/OL13446520M.txt","file_size":786637},{"type":"epub","file_path":"_data/epub/OL13446520M.epub","file_size":5304566},{"type":"pdf","file_path":"_data/pdf/OL13446520M.pdf","file_size":63492891}]', '{"Marcus Junianus Justinus",Justin,"Waldemar Heckel"}', '{"Ancient History",History,Macedonia,"Early works to 1800",Emperors,Biography,"Kings and rulers",Generals,"Latin American literature","Medieval and modern Latin literature","Accessible book"}', '2019-08-09 04:53:48.923991', '2019-08-09 04:53:48.923991', NULL, NULL);
INSERT INTO public.books VALUES (72, 'The lives of the most eminent English poets', 'with critical observations on their works', '{http://covers.openlibrary.org/b/olid/OL7100475M-L.jpg}', 'Please update me!', 'Please update me, too!', 63000, NULL, NULL, NULL, 'George Walker', '1821-01-01 00:00:00', 'London', '3 v.', '[{"type":"epub","file_path":"_data/epub/OL7100475M.epub","file_size":1169792},{"type":"txt","file_path":"_data/txt/OL7100475M.txt","file_size":707801},{"type":"pdf","file_path":"_data/pdf/OL7100475M.pdf","file_size":22420044}]', '{"Samuel Johnson"}', '{"History and criticism","English poetry","English Poets",Biography,"Early works to 1800","Accessible book"}', '2019-08-09 04:53:48.930937', '2019-08-09 04:53:48.930937', NULL, NULL);
INSERT INTO public.books VALUES (73, 'Mémoires d''outre-tombe.', NULL, '{http://covers.openlibrary.org/b/olid/OL24191906M-L.jpg}', 'Please update me!', 'Please update me, too!', 476000, NULL, NULL, NULL, 'Garnier Frères', '1840-01-01 00:00:00', 'Paris', NULL, '[{"type":"txt","file_path":"_data/txt/OL24191906M.txt","file_size":922603},{"type":"epub","file_path":"_data/epub/OL24191906M.epub","file_size":4816827},{"type":"pdf","file_path":"_data/pdf/OL24191906M.pdf","file_size":32110708}]', '{"François-René de Chateaubriand","Jean-Paul Clément"}', '{"Accessible book",Biography,Christianity,Contemporaries,France,"French Authors","French literature",God,History,"History and criticism","Homes and haunts","Kings and rulers","Pictorial works","Political and social views","Politics and government",Soul,Statesmen,Travel,"Voyages and travels"}', '2019-08-09 04:53:48.931977', '2019-08-09 04:53:48.931977', NULL, NULL);
INSERT INTO public.books VALUES (74, 'Life of George Washington.', NULL, '{http://covers.openlibrary.org/b/olid/OL7103031M-L.jpg}', 'Please update me!', 'Please update me, too!', 382000, NULL, NULL, NULL, 'G. P. Putnam', '1860-01-01 00:00:00', 'New York', '5 v. :', '[{"type":"epub","file_path":"_data/epub/OL7103031M.epub","file_size":2258022},{"type":"txt","file_path":"_data/txt/OL7103031M.txt","file_size":863626},{"type":"pdf","file_path":"_data/pdf/OL7103031M.pdf","file_size":22033674}]', '{"Washington Irving"}', '{"Politics and government",Campaigns,"In library",Generals,Presidents,"Accessible book","United States",Sources,Biography,"Protected DAISY","United States. Continental Army",History}', '2019-08-09 04:53:48.932771', '2019-08-09 04:53:48.932771', NULL, NULL);
INSERT INTO public.books VALUES (75, 'The general biographical dictionary', 'containing an historical account of the lives and writings of the most eminent persons in every nation; particularly the British and Irish; from the earliest to the present time.', '{http://covers.openlibrary.org/b/olid/OL22880883M-L.jpg}', 'Please update me!', 'Please update me, too!', 298000, NULL, NULL, NULL, 'J. Nichols and Son [etc., etc.]', '1812-01-01 00:00:00', 'London', '32 v.', '[{"type":"txt","file_path":"_data/txt/OL22880883M.txt","file_size":1245135},{"type":"epub","file_path":"_data/epub/OL22880883M.epub","file_size":2034380},{"type":"pdf","file_path":"_data/pdf/OL22880883M.pdf","file_size":32924096}]', '{"Alexander Chalmers"}', '{"Accessible book",Dictionaries,Biography}', '2019-08-09 04:53:48.93373', '2019-08-09 04:53:48.93373', NULL, NULL);
INSERT INTO public.books VALUES (76, 'Germania', NULL, '{http://covers.openlibrary.org/b/olid/OL23301406M-L.jpg}', 'Please update me!', 'Please update me, too!', 347000, NULL, NULL, NULL, 'Macmillan', '1916-01-01 00:00:00', 'New York', 'xxiii, 139 p.  map.', '[{"type":"txt","file_path":"_data/txt/OL23301406M.txt","file_size":323036},{"type":"pdf","file_path":"_data/pdf/OL23301406M.pdf","file_size":7594811},{"type":"epub","file_path":"_data/epub/OL23301406M.epub","file_size":2019502}]', '{"P. Cornelius Tacitus"}', '{"Accessible book",Biography,"Description and travel","Early works to 1800","Germanic Law","Germanic Mythology","Germanic antiquities","Germanic peoples","Historical geography",History,Romans,Statesmen,"Criticism and interpretation",Open_syllabus_project}', '2019-08-09 04:53:48.934934', '2019-08-09 04:53:48.934934', NULL, NULL);
INSERT INTO public.books VALUES (77, 'Oliver Goldsmith', 'a biography', '{http://covers.openlibrary.org/b/olid/OL13439319M-L.jpg}', 'Please update me!', 'Please update me, too!', 314000, NULL, NULL, NULL, 'Macmillan', '1903-01-01 00:00:00', 'New York', 'xx, 303 p. :', '[{"type":"epub","file_path":"_data/epub/OL13439319M.epub","file_size":1142392},{"type":"txt","file_path":"_data/txt/OL13439319M.txt","file_size":701576},{"type":"pdf","file_path":"_data/pdf/OL13439319M.pdf","file_size":16655923}]', '{"Washington Irving"}', '{"American Poets",Biography,"English Authors","Irish authors","Irish Authors"}', '2019-08-09 04:53:48.93592', '2019-08-09 04:53:48.93592', NULL, NULL);
INSERT INTO public.books VALUES (78, 'Alexander in India', 'a portion of the history', '{http://covers.openlibrary.org/b/olid/OL23270792M-L.jpg}', 'Please update me!', 'Please update me, too!', 477000, NULL, NULL, NULL, 'Univ. Press', '1889-01-01 00:00:00', 'Cambridge', '204 p.', '[{"type":"txt","file_path":"_data/txt/OL23270792M.txt","file_size":490022},{"type":"epub","file_path":"_data/epub/OL23270792M.epub","file_size":758106},{"type":"pdf","file_path":"_data/pdf/OL23270792M.pdf","file_size":9294750}]', '{"Quintus Curtius Rufus"}', '{Biography,"Early works to 1800","Kings and rulers",History,Generals,Readers,"Latin language","Latin American literature",Travel,"Medieval and modern Latin literature","Ancient Kings and rulers","Accessible book","Alexander, the Great, 356-323 B.C. -- Early works to 1800"}', '2019-08-09 04:53:48.936949', '2019-08-09 04:53:48.936949', NULL, NULL);
INSERT INTO public.books VALUES (79, 'Grace abounding to the chief of sinners', NULL, '{http://covers.openlibrary.org/b/olid/OL17791340M-L.jpg}', 'Please update me!', 'Please update me, too!', 123000, NULL, NULL, NULL, 'Cassell', '1899-01-01 00:00:00', 'London', '192 p. ;', '[{"type":"txt","file_path":"_data/txt/OL17791340M.txt","file_size":327843},{"type":"epub","file_path":"_data/epub/OL17791340M.epub","file_size":1208030},{"type":"pdf","file_path":"_data/pdf/OL17791340M.pdf","file_size":10484276}]', '{"John Bunyan"}', '{Biography,"Grace (Theology)","Christian biography","English Authors",Puritans,"Early works to 1800",Portraits,"Spiritual life",Redemption,"Christian life",Fiction,Purtians,"Christian pilgrims and pilgrimages","Accessible book"}', '2019-08-09 04:53:48.937975', '2019-08-09 04:53:48.937975', NULL, NULL);
INSERT INTO public.books VALUES (80, 'The mirror of the sea', NULL, '{http://covers.openlibrary.org/b/olid/OL6975955M-L.jpg}', 'Please update me!', 'Please update me, too!', 336000, NULL, NULL, NULL, 'Harper & Brothers', '1906-01-01 00:00:00', 'New York', '3 p. l., 328, [1] p.', '[{"type":"txt","file_path":"_data/txt/OL6975955M.txt","file_size":359826},{"type":"epub","file_path":"_data/epub/OL6975955M.epub","file_size":996853},{"type":"pdf","file_path":"_data/pdf/OL6975955M.pdf","file_size":5552781}]', '{"Joseph Conrad"}', '{"English Novelists","Open Library Staff Picks",Travel,"Seafaring life",Fiction,"Classic Literature",Biography,Journeys}', '2019-08-09 04:53:48.93896', '2019-08-09 04:53:48.93896', NULL, NULL);
INSERT INTO public.books VALUES (81, 'New poems.', NULL, '{http://covers.openlibrary.org/b/olid/OL13520585M-L.jpg}', 'Please update me!', 'Please update me, too!', 40000, NULL, NULL, NULL, 'M. Secker', '1919-01-01 00:00:00', 'London', '64 p.', '[{"type":"txt","file_path":"_data/txt/OL13520585M.txt","file_size":44311},{"type":"epub","file_path":"_data/epub/OL13520585M.epub","file_size":1216951},{"type":"pdf","file_path":"_data/pdf/OL13520585M.pdf","file_size":2186411}]', '{"D. H. Lawrence"}', '{"Children''s poetry, English","English poetry",Correspondence,Biography,"English Authors","Poetic works"}', '2019-08-09 04:53:48.945361', '2019-08-09 04:53:48.945361', NULL, NULL);
INSERT INTO public.books VALUES (82, 'Histoire universelle de Diodore de Sicile', NULL, '{http://covers.openlibrary.org/b/olid/OL6445686M-L.jpg}', 'Please update me!', 'Please update me, too!', 83000, NULL, NULL, NULL, 'De Bure l''aîné', '1737-01-01 00:00:00', 'Paris', '7 v. ;', '[{"type":"txt","file_path":"_data/txt/OL6445686M.txt","file_size":647338},{"type":"epub","file_path":"_data/epub/OL6445686M.epub","file_size":3221141},{"type":"pdf","file_path":"_data/pdf/OL6445686M.pdf","file_size":29043996}]', '{"Diodorus Siculus"}', '{"Ancient History",History,"Early works to 1800","World history","Kings and rulers","Slave insurrections","Germanic peoples",Biography,"Accessible book"}', '2019-08-09 04:53:48.951578', '2019-08-09 04:53:48.951578', NULL, NULL);
INSERT INTO public.books VALUES (83, 'Les confessions', NULL, '{http://covers.openlibrary.org/b/olid/OL24234560M-L.jpg}', 'Please update me!', 'Please update me, too!', 173000, NULL, NULL, NULL, '[s.n.]', '1782-01-01 00:00:00', 'A Geneve', '2 v.', '[{"type":"txt","file_path":"_data/txt/OL24234560M.txt","file_size":511809},{"type":"epub","file_path":"_data/epub/OL24234560M.epub","file_size":4399493},{"type":"pdf","file_path":"_data/pdf/OL24234560M.pdf","file_size":24131950}]', '{"Jean-Jacques Rousseau"}', '{"French Authors",Biography,Correspondence,"Critique et interprétation","Childhood and youth","Jacques, 1712-1778. Les confessions","Jean Rousseau","Rousseau, Jean Jacques, 1712-1778","Accessible book"}', '2019-08-09 04:53:48.957889', '2019-08-09 04:53:48.957889', NULL, NULL);
INSERT INTO public.books VALUES (84, 'Knickerbocker''s History of New York', NULL, '{http://covers.openlibrary.org/b/olid/OL19350974M-L.jpg}', 'Please update me!', 'Please update me, too!', 117000, NULL, NULL, NULL, 'Cassell', '1891-01-01 00:00:00', 'London', '2 v.', '[{"type":"epub","file_path":"_data/epub/OL19350974M.epub","file_size":1304556},{"type":"txt","file_path":"_data/txt/OL19350974M.txt","file_size":388153},{"type":"pdf","file_path":"_data/pdf/OL19350974M.pdf","file_size":9512714}]', '{"Washington Irving"}', '{"Dutch Americans","Social life and customs",Literature,Fiction,"City and town life","Historical Fiction","New York (State)","Classic Literature","Juvenile literature",Biography,History}', '2019-08-09 04:53:48.964125', '2019-08-09 04:53:48.964125', NULL, NULL);
INSERT INTO public.books VALUES (85, 'Industry and trade', 'a study of industrial technique and business organization ; and of their influence on the conditions of various classes and nations', '{http://covers.openlibrary.org/b/olid/OL18677878M-L.jpg}', 'Please update me!', 'Please update me, too!', 273000, NULL, NULL, NULL, 'Macmillan', '1997-01-01 00:00:00', 'London', '10 microfiches (472 fr.)', '[{"type":"txt","file_path":"_data/txt/OL18677878M.txt","file_size":2423780},{"type":"epub","file_path":"_data/epub/OL18677878M.epub","file_size":6476268},{"type":"pdf","file_path":"_data/pdf/OL18677878M.pdf","file_size":56758686}]', '{"Alfred Marshall"}', '{"Accessible book",Business,Commerce,"Economic conditions","Economic history","Industrial Trusts",Industries,Industry,Industrie,Affaires}', '2019-08-09 04:53:48.965071', '2019-08-09 04:53:48.965071', NULL, NULL);
INSERT INTO public.books VALUES (86, 'The empire of business', NULL, '{http://covers.openlibrary.org/b/olid/OL24183440M-L.jpg}', 'Please update me!', 'Please update me, too!', 61000, NULL, NULL, NULL, 'Doubleday, Page & Co.', '1902-01-01 00:00:00', 'New York', 'ix, 345 p. :', '[{"type":"txt","file_path":"_data/txt/OL24183440M.txt","file_size":448651},{"type":"epub","file_path":"_data/epub/OL24183440M.epub","file_size":1579721},{"type":"pdf","file_path":"_data/pdf/OL24183440M.pdf","file_size":7436770}]', '{"Andrew Carnegie"}', '{Business,"Economic conditions",Wealth,"Success in business",Success,"Accessible book",Succès,Richesse,Affaires,"Conditions économiques"}', '2019-08-09 04:53:48.966055', '2019-08-09 04:53:48.966055', NULL, NULL);
INSERT INTO public.books VALUES (87, 'The theory of business enterprise', NULL, '{http://covers.openlibrary.org/b/olid/OL6944789M-L.jpg}', 'Please update me!', 'Please update me, too!', 159000, NULL, NULL, NULL, 'C. Scribner''s Sons', '1904-01-01 00:00:00', 'New York', 'vii, 400 p.', '[{"type":"txt","file_path":"_data/txt/OL6944789M.txt","file_size":644401},{"type":"epub","file_path":"_data/epub/OL6944789M.epub","file_size":1128268},{"type":"pdf","file_path":"_data/pdf/OL6944789M.pdf","file_size":24273745}]', '{"Thorstein Veblen"}', '{Business,Capital,Capitalism,"Accessible book"}', '2019-08-09 04:53:48.966995', '2019-08-09 04:53:48.966995', NULL, NULL);
INSERT INTO public.books VALUES (88, 'Life on the plains and among the diggings', 'being scenes and adventures of an overland journey to California: with particular incidents of the route, mistakes and sufferings of the emigrants, the Indian tribes, the present and future of the great West.', '{http://covers.openlibrary.org/b/olid/OL22885359M-L.jpg}', 'Please update me!', 'Please update me, too!', 253000, NULL, NULL, NULL, 'C.M. Saxton', '1859-01-01 00:00:00', 'New York', 'xi, [13]-384 p.', '[{"type":"epub","file_path":"_data/epub/OL22885359M.epub","file_size":3090856},{"type":"txt","file_path":"_data/txt/OL22885359M.txt","file_size":674663},{"type":"pdf","file_path":"_data/pdf/OL22885359M.pdf","file_size":17490202}]', '{"Alonzo Delano"}', '{"Accessible book",Business,"Description and travel","Frontier and pioneer life","Gold discoveries","Indians of North America","Mines and mineral resources","Overland journeys to the Pacific","Real estate development",Travel,Urbanization}', '2019-08-09 04:53:48.968321', '2019-08-09 04:53:48.968321', NULL, NULL);
INSERT INTO public.books VALUES (89, 'Random reminiscences of men and events', NULL, '{http://covers.openlibrary.org/b/olid/OL17480496M-L.jpg}', 'Please update me!', 'Please update me, too!', 103000, NULL, NULL, NULL, 'McClelland & Goodchild', '1994-01-01 00:00:00', 'Toronto', '3 microfiches (110 fr.)', '[{"type":"txt","file_path":"_data/txt/OL17480496M.txt","file_size":222262},{"type":"pdf","file_path":"_data/pdf/OL17480496M.pdf","file_size":6990484},{"type":"epub","file_path":"_data/epub/OL17480496M.epub","file_size":635490}]', '{"John D. Rockefeller"}', '{"Standard Oil Company",Charity,"Capitalists and financiers",Business,"Accessible book","Capitalistes et financiers",Charité}', '2019-08-09 04:53:48.969351', '2019-08-09 04:53:48.969351', NULL, NULL);
INSERT INTO public.books VALUES (90, 'Three years in California [1846-1849]', NULL, '{http://covers.openlibrary.org/b/olid/OL13489400M-L.jpg}', 'Please update me!', 'Please update me, too!', 151000, NULL, NULL, NULL, 'H. W. Derby & co.', '1850-01-01 00:00:00', 'Cincinnati, Ohio', '456 p. :', '[{"type":"txt","file_path":"_data/txt/OL13489400M.txt","file_size":676891},{"type":"epub","file_path":"_data/epub/OL13489400M.epub","file_size":5455058},{"type":"pdf","file_path":"_data/pdf/OL13489400M.pdf","file_size":19379410}]', '{"Walter Colton"}', '{"Accessible book",Business,Correspondence,"Description and travel","Gold discoveries",History,"Law and politics","Mines and mineral resources",Sources,"Zamorano 80","American History","History. [from old catalog]","Gold discoveries. [from old catalog]"}', '2019-08-09 04:53:48.970497', '2019-08-09 04:53:48.970497', NULL, NULL);
INSERT INTO public.books VALUES (91, 'The argonauts of ''forty-nine', 'some recollections of the plains and the diggings', '{http://covers.openlibrary.org/b/olid/OL271158M-L.jpg}', 'Please update me!', 'Please update me, too!', 102000, NULL, NULL, NULL, 'J.B. Stoll & company, printers', '1894-01-01 00:00:00', 'South Bend. Ind', '146, xvi p.', '[{"type":"txt","file_path":"_data/txt/OL271158M.txt","file_size":223610},{"type":"pdf","file_path":"_data/pdf/OL271158M.pdf","file_size":11964690},{"type":"epub","file_path":"_data/epub/OL271158M.epub","file_size":20103192}]', '{"David Rohrer Leeper"}', '{"Gold discoveries","Ethnic groups",Business,"Accessible book"}', '2019-08-09 04:53:48.971617', '2019-08-09 04:53:48.971617', NULL, NULL);
INSERT INTO public.books VALUES (92, 'Business: a profession.', NULL, '{http://covers.openlibrary.org/b/olid/OL5629854M-L.jpg}', 'Please update me!', 'Please update me, too!', 178000, NULL, NULL, NULL, 'A. M. Kelley', '1971-01-01 00:00:00', 'New York', 'lvi, 327 p.', '[{"type":"epub","file_path":"_data/epub/OL5629854M.epub","file_size":414686},{"type":"txt","file_path":"_data/txt/OL5629854M.txt","file_size":478457},{"type":"pdf","file_path":"_data/pdf/OL5629854M.pdf","file_size":20338470}]', '{"Louis Dembitz Brandeis"}', '{"Economic conditions",Business,"Accessible book"}', '2019-08-09 04:53:48.972565', '2019-08-09 04:53:48.972565', NULL, NULL);
INSERT INTO public.books VALUES (93, 'Thoughts on business', NULL, '{http://covers.openlibrary.org/b/olid/OL7147399M-L.jpg}', 'Please update me!', 'Please update me, too!', 396000, NULL, NULL, NULL, 'Forbes & company', '1907-01-01 00:00:00', 'Chicago', '237 p.', '[{"type":"txt","file_path":"_data/txt/OL7147399M.txt","file_size":281875},{"type":"epub","file_path":"_data/epub/OL7147399M.epub","file_size":842665},{"type":"pdf","file_path":"_data/pdf/OL7147399M.pdf","file_size":8987466}]', '{"Waldo Pondray Warren"}', '{Business,Success,"Accessible book"}', '2019-08-09 04:53:48.979021', '2019-08-09 04:53:48.979021', NULL, NULL);
INSERT INTO public.books VALUES (94, 'Youth''s introduction to trade and business ...', NULL, '{http://covers.openlibrary.org/b/olid/OL22897074M-L.jpg}', 'Please update me!', 'Please update me, too!', 86000, NULL, NULL, NULL, 'Printed for G. Keith', '1769-01-01 00:00:00', 'London', 'viii, 192 p.', '[{"type":"pdf","file_path":"_data/pdf/OL22897074M.pdf","file_size":10165143},{"type":"txt","file_path":"_data/txt/OL22897074M.txt","file_size":314949},{"type":"epub","file_path":"_data/epub/OL22897074M.epub","file_size":2348531}]', '{"M. Clare"}', '{"Accessible book",Business,"Handbooks, manuals"}', '2019-08-09 04:53:48.985333', '2019-08-09 04:53:48.985333', NULL, NULL);
INSERT INTO public.books VALUES (95, 'American notes for general circulation', 'and Pictures from Italy.', '{http://covers.openlibrary.org/b/olid/OL24197495M-L.jpg}', 'Please update me!', 'Please update me, too!', 327000, NULL, NULL, NULL, 'Charles Scribner''s Sons', '1911-01-01 00:00:00', 'New York', '517 p.', '[{"type":"txt","file_path":"_data/txt/OL24197495M.txt","file_size":1037065},{"type":"epub","file_path":"_data/epub/OL24197495M.epub","file_size":5168475},{"type":"pdf","file_path":"_data/pdf/OL24197495M.pdf","file_size":25420443}]', '{"Charles Dickens"}', '{"Social life and customs",Travel,"Description and travel",History,"Juvenile literature",Quotations,Humor,"Early works to 1800","Quotations, maxims",Fiction,"English Quotations","English Christmas stories","English Novelists",Children,Biography,Nonfiction,"Biography & Autobiography","Classic Literature","Descriptions et voyages"}', '2019-08-09 04:53:48.991676', '2019-08-09 04:53:48.991676', NULL, NULL);
INSERT INTO public.books VALUES (96, 'The story of Little Black Sambo', NULL, '{http://covers.openlibrary.org/b/olid/OL6659739M-L.jpg}', 'Please update me!', 'Please update me, too!', 440000, NULL, NULL, NULL, 'Frederick A. Stokes company', '1923-01-01 00:00:00', 'New York', '[ii]-iv, [1], 56 p.', '[{"type":"epub","file_path":"_data/epub/OL6659739M.epub","file_size":8007},{"type":"txt","file_path":"_data/txt/OL6659739M.txt","file_size":8448},{"type":"pdf","file_path":"_data/pdf/OL6659739M.pdf","file_size":2578781}]', '{"Helen Bannerman"}', '{Children,"Sambo (Fictitious character)","In library","Toy and movable books",Blacks,Tigers,"Accessible book","Protected DAISY",India,Jungles,Fiction,Boys,"Clothing and dress","Juvenile fiction",Specimens,Dogs,"Pictorial works"}', '2019-08-09 04:53:48.998197', '2019-08-09 04:53:48.998197', NULL, NULL);
INSERT INTO public.books VALUES (97, 'Rainbow valley.', 'Frontispiece by M.L. Kirk.', '{http://covers.openlibrary.org/b/olid/OL7177217M-L.jpg}', 'Please update me!', 'Please update me, too!', 123000, NULL, NULL, NULL, 'A.L. Burt', '1919-01-01 00:00:00', 'New York', '341p.', '[{"type":"txt","file_path":"_data/txt/OL7177217M.txt","file_size":460626},{"type":"epub","file_path":"_data/epub/OL7177217M.epub","file_size":1702263},{"type":"pdf","file_path":"_data/pdf/OL7177217M.pdf","file_size":11331234}]', '{"Lucy Maud Montgomery"}', '{"Juvenile fiction","Brothers and sisters",Family,Fiction,"Family life","Accessible book","Canadian fiction (English), CIHM","Roman canadien-anglais, ICMH",Orphans,"Protected DAISY","In library","Anne Shirley (Fictitious character)",Friendship,Children}', '2019-08-09 04:53:49.001074', '2019-08-09 04:53:49.001074', NULL, NULL);
INSERT INTO public.books VALUES (98, 'Misalliance', 'The dark lady of the Sonnets, and Fanny''s first play.', '{http://covers.openlibrary.org/b/olid/OL7021009M-L.jpg}', 'Please update me!', 'Please update me, too!', 332000, NULL, NULL, NULL, 'Brentano''s', '1914-01-01 00:00:00', 'New York', 'cxxvi, 245 p.,', '[{"type":"txt","file_path":"_data/txt/OL7021009M.txt","file_size":657271},{"type":"epub","file_path":"_data/epub/OL7021009M.epub","file_size":1715995},{"type":"pdf","file_path":"_data/pdf/OL7021009M.pdf","file_size":16528964}]', '{"George Bernard Shaw"}', '{Drama,Parenting,"Man-woman relationships",Courtship,Education,Children}', '2019-08-09 04:53:49.002283', '2019-08-09 04:53:49.002283', NULL, NULL);
INSERT INTO public.books VALUES (99, 'Tales from Shakspeare', 'designed for the use of young persons', '{http://covers.openlibrary.org/b/olid/OL24140324M-L.jpg}', 'Please update me!', 'Please update me, too!', 23000, NULL, NULL, NULL, 'Baldwin and Cradock', '1831-01-01 00:00:00', 'London', 'vi, 376 p. :', '[{"type":"txt","file_path":"_data/txt/OL24140324M.txt","file_size":590207},{"type":"epub","file_path":"_data/epub/OL24140324M.epub","file_size":6915872},{"type":"pdf","file_path":"_data/pdf/OL24140324M.pdf","file_size":21154733}]', '{"Charles Lamb"}', '{Adaptations,"Stories, plots","Accessible book","Protected DAISY","In library","Conduct of life","Children''s literature, English","Children''s stories, English","Juvenile fiction","Juvenile literature",Children}', '2019-08-09 04:53:49.003272', '2019-08-09 04:53:49.003272', NULL, NULL);
INSERT INTO public.books VALUES (100, 'Christian nurture', NULL, '{http://covers.openlibrary.org/b/olid/OL24185879M-L.jpg}', 'Please update me!', 'Please update me, too!', 225000, NULL, NULL, NULL, 'Scribner', '1866-01-01 00:00:00', 'New York', '407 p.', '[{"type":"epub","file_path":"_data/epub/OL24185879M.epub","file_size":414377},{"type":"txt","file_path":"_data/txt/OL24185879M.txt","file_size":642630},{"type":"pdf","file_path":"_data/pdf/OL24185879M.pdf","file_size":8511533}]', '{"Horace Bushnell"}', '{"Religious life",Children,"Religious education","Christian education of children","Christian education","Infant baptism","Accessible book","Christliche Erziehung"}', '2019-08-09 04:53:49.004499', '2019-08-09 04:53:49.004499', NULL, NULL);
INSERT INTO public.books VALUES (101, 'Bevis', 'the story of a boy', '{http://covers.openlibrary.org/b/olid/OL23666131M-L.jpg}', 'Please update me!', 'Please update me, too!', 178000, NULL, NULL, NULL, 'Sampson Low, Marston, Searle, Rivington', '1882-01-01 00:00:00', 'London', '3 v. ;', '[{"type":"txt","file_path":"_data/txt/OL23666131M.txt","file_size":345705},{"type":"epub","file_path":"_data/epub/OL23666131M.epub","file_size":4792015},{"type":"pdf","file_path":"_data/pdf/OL23666131M.pdf","file_size":13639276}]', '{"Richard Jefferies"}', '{Boys,Children,Fiction}', '2019-08-09 04:53:49.005518', '2019-08-09 04:53:49.005518', NULL, NULL);


--
-- TOC entry 2913 (class 0 OID 16654)
-- Dependencies: 203
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (2, 'Accessible book');
INSERT INTO public.categories VALUES (3, 'Bible');
INSERT INTO public.categories VALUES (4, 'Catholic Church');
INSERT INTO public.categories VALUES (5, 'Catholic authors');
INSERT INTO public.categories VALUES (6, 'Christian life');
INSERT INTO public.categories VALUES (7, 'Devotional exercises');
INSERT INTO public.categories VALUES (8, 'Devotional literature');
INSERT INTO public.categories VALUES (9, 'Early works to 1800');
INSERT INTO public.categories VALUES (10, 'God');
INSERT INTO public.categories VALUES (11, 'Love');
INSERT INTO public.categories VALUES (12, 'Maxims');
INSERT INTO public.categories VALUES (13, 'Meditations');
INSERT INTO public.categories VALUES (14, 'Mystics');
INSERT INTO public.categories VALUES (15, 'Méditations');
INSERT INTO public.categories VALUES (16, 'Prayers and devotions');
INSERT INTO public.categories VALUES (17, 'Religious aspects of Love');
INSERT INTO public.categories VALUES (18, 'Spanish');
INSERT INTO public.categories VALUES (19, 'Spiritual life');
INSERT INTO public.categories VALUES (20, 'Worship and love');
INSERT INTO public.categories VALUES (21, 'Rhetoric');
INSERT INTO public.categories VALUES (22, 'Ancient Philosophy');
INSERT INTO public.categories VALUES (23, 'Love.');
INSERT INTO public.categories VALUES (24, 'Soul');
INSERT INTO public.categories VALUES (25, 'Ancient Rhetoric');
INSERT INTO public.categories VALUES (26, 'Great_books_of_the_western_world');
INSERT INTO public.categories VALUES (27, 'Open_syllabus_project');
INSERT INTO public.categories VALUES (28, 'Protected DAISY');
INSERT INTO public.categories VALUES (29, 'Theory of Knowledge');
INSERT INTO public.categories VALUES (30, 'In library');
INSERT INTO public.categories VALUES (31, 'Inspiration');
INSERT INTO public.categories VALUES (32, 'Kommentar');
INSERT INTO public.categories VALUES (33, 'Virtue');
INSERT INTO public.categories VALUES (34, 'Philosophy');
INSERT INTO public.categories VALUES (35, 'Idea (Philosophy)');
INSERT INTO public.categories VALUES (36, 'Classic Literature');
INSERT INTO public.categories VALUES (37, 'Fiction');
INSERT INTO public.categories VALUES (38, 'Vertus');
INSERT INTO public.categories VALUES (39, 'Meno (Plato)');
INSERT INTO public.categories VALUES (40, 'Social');
INSERT INTO public.categories VALUES (41, 'PHILOSOPHY');
INSERT INTO public.categories VALUES (42, 'Ethics & Moral Philosophy');
INSERT INTO public.categories VALUES (43, 'Knowledge');
INSERT INTO public.categories VALUES (44, 'Translating into Latin');
INSERT INTO public.categories VALUES (45, 'Periodicals');
INSERT INTO public.categories VALUES (46, 'Voyages and travels');
INSERT INTO public.categories VALUES (47, 'One (The One in philosophy)');
INSERT INTO public.categories VALUES (48, 'Pictorial works');
INSERT INTO public.categories VALUES (49, 'Pleasure');
INSERT INTO public.categories VALUES (50, 'Language and languages');
INSERT INTO public.categories VALUES (51, 'Ontology');
INSERT INTO public.categories VALUES (52, 'Greek language');
INSERT INTO public.categories VALUES (53, 'Travelers');
INSERT INTO public.categories VALUES (54, 'Dialectic');
INSERT INTO public.categories VALUES (55, 'Reasoning');
INSERT INTO public.categories VALUES (56, 'Geography');
INSERT INTO public.categories VALUES (57, 'Western philosophy');
INSERT INTO public.categories VALUES (58, 'Ancient Greek & Roman philosophy');
INSERT INTO public.categories VALUES (59, 'History & Surveys - Ancient & Classical');
INSERT INTO public.categories VALUES (60, 'Metaphysics');
INSERT INTO public.categories VALUES (61, 'Philosophy / Western');
INSERT INTO public.categories VALUES (62, 'Political science');
INSERT INTO public.categories VALUES (63, 'Ethics');
INSERT INTO public.categories VALUES (64, 'Greek language materials');
INSERT INTO public.categories VALUES (65, 'Greek');
INSERT INTO public.categories VALUES (66, 'Amour');
INSERT INTO public.categories VALUES (67, 'French language');
INSERT INTO public.categories VALUES (68, 'Slideshow');
INSERT INTO public.categories VALUES (69, 'Sophists (Greek philosophy)');
INSERT INTO public.categories VALUES (70, 'Methodology');
INSERT INTO public.categories VALUES (71, 'Meaning (Philosophy)');
INSERT INTO public.categories VALUES (72, 'Ancient Logic');
INSERT INTO public.categories VALUES (73, 'Statesmen');
INSERT INTO public.categories VALUES (74, 'Indians of South America');
INSERT INTO public.categories VALUES (75, 'Costume');
INSERT INTO public.categories VALUES (76, 'Description and travel');
INSERT INTO public.categories VALUES (77, 'Paraphilias');
INSERT INTO public.categories VALUES (78, 'Case studies');
INSERT INTO public.categories VALUES (79, 'Criminal psychology');
INSERT INTO public.categories VALUES (80, 'Homosexualité');
INSERT INTO public.categories VALUES (81, 'Perversion sexuelle');
INSERT INTO public.categories VALUES (82, 'Psychology, pathological');
INSERT INTO public.categories VALUES (83, 'Sex (Psychology)');
INSERT INTO public.categories VALUES (84, 'Sex Disorders');
INSERT INTO public.categories VALUES (85, 'Sexual behavior');
INSERT INTO public.categories VALUES (86, 'Sexual deviation');
INSERT INTO public.categories VALUES (87, 'Sexual perversion');
INSERT INTO public.categories VALUES (88, 'Sexualité (Psychologie)');
INSERT INTO public.categories VALUES (89, 'Sex Behavior');
INSERT INTO public.categories VALUES (90, 'Law');
INSERT INTO public.categories VALUES (91, 'Obedience');
INSERT INTO public.categories VALUES (92, 'Affections (Religious)');
INSERT INTO public.categories VALUES (93, 'Christianity');
INSERT INTO public.categories VALUES (94, 'Congregational churches');
INSERT INTO public.categories VALUES (95, 'Controversial literature');
INSERT INTO public.categories VALUES (96, 'Early works to 1850');
INSERT INTO public.categories VALUES (97, 'Emotions');
INSERT INTO public.categories VALUES (98, 'Religious aspects');
INSERT INTO public.categories VALUES (99, 'Religious aspects of Emotions');
INSERT INTO public.categories VALUES (100, 'Puritans');
INSERT INTO public.categories VALUES (101, 'Marriage');
INSERT INTO public.categories VALUES (102, 'Secual ethics');
INSERT INTO public.categories VALUES (103, 'Sex');
INSERT INTO public.categories VALUES (104, 'Sexual ethics');
INSERT INTO public.categories VALUES (105, 'Logic');
INSERT INTO public.categories VALUES (106, 'Sex customs');
INSERT INTO public.categories VALUES (107, 'Sexual intercourse');
INSERT INTO public.categories VALUES (108, 'God (Christianity)');
INSERT INTO public.categories VALUES (109, 'Providence and government of God');
INSERT INTO public.categories VALUES (110, 'Wisdom');
INSERT INTO public.categories VALUES (111, 'New Jerusalem Church');
INSERT INTO public.categories VALUES (112, 'Charity');
INSERT INTO public.categories VALUES (113, 'Doctrinal and controversial works');
INSERT INTO public.categories VALUES (114, 'Doctrines');
INSERT INTO public.categories VALUES (115, 'Salvation');
INSERT INTO public.categories VALUES (116, 'Worship and love.');
INSERT INTO public.categories VALUES (117, 'Love (Theology)');
INSERT INTO public.categories VALUES (118, 'Vietnamese Conflict, 1961-1975');
INSERT INTO public.categories VALUES (119, 'Foreign relations');
INSERT INTO public.categories VALUES (120, 'North Vietnamese Prisoners and prisons');
INSERT INTO public.categories VALUES (121, 'Vietnam');
INSERT INTO public.categories VALUES (122, 'Missing in action');
INSERT INTO public.categories VALUES (123, 'Books and reading');
INSERT INTO public.categories VALUES (124, 'Conduct of life');
INSERT INTO public.categories VALUES (125, 'Women');
INSERT INTO public.categories VALUES (126, 'Social problems');
INSERT INTO public.categories VALUES (127, 'Art');
INSERT INTO public.categories VALUES (128, 'Decorative arts');
INSERT INTO public.categories VALUES (129, 'Education of women');
INSERT INTO public.categories VALUES (130, 'Femininity');
INSERT INTO public.categories VALUES (131, 'Sex role');
INSERT INTO public.categories VALUES (132, 'Masculinity');
INSERT INTO public.categories VALUES (133, 'Economics');
INSERT INTO public.categories VALUES (134, 'Greek Mythology');
INSERT INTO public.categories VALUES (135, 'Early works to 1900');
INSERT INTO public.categories VALUES (136, 'Education');
INSERT INTO public.categories VALUES (137, 'Venice');
INSERT INTO public.categories VALUES (138, 'Byzantine Architecture');
INSERT INTO public.categories VALUES (139, 'Description');
INSERT INTO public.categories VALUES (140, 'Gothic Architecture');
INSERT INTO public.categories VALUES (141, 'Architecture');
INSERT INTO public.categories VALUES (142, 'Architecture and society');
INSERT INTO public.categories VALUES (143, 'Details');
INSERT INTO public.categories VALUES (144, 'Autobiography');
INSERT INTO public.categories VALUES (145, 'Biography');
INSERT INTO public.categories VALUES (146, 'Sculptors');
INSERT INTO public.categories VALUES (147, 'Goldsmiths');
INSERT INTO public.categories VALUES (148, 'History');
INSERT INTO public.categories VALUES (149, 'Artists');
INSERT INTO public.categories VALUES (150, 'Italian Artists');
INSERT INTO public.categories VALUES (151, 'Italian Art');
INSERT INTO public.categories VALUES (152, 'Renaissance Art');
INSERT INTO public.categories VALUES (153, 'Medieval Artists');
INSERT INTO public.categories VALUES (154, 'Painters');
INSERT INTO public.categories VALUES (155, 'Gothic Art');
INSERT INTO public.categories VALUES (156, 'Italy');
INSERT INTO public.categories VALUES (157, 'Portraits');
INSERT INTO public.categories VALUES (158, 'Architects');
INSERT INTO public.categories VALUES (159, 'Italian Painters');
INSERT INTO public.categories VALUES (160, 'Artistas');
INSERT INTO public.categories VALUES (161, 'Biografía');
INSERT INTO public.categories VALUES (162, 'Arte renacentista');
INSERT INTO public.categories VALUES (163, 'Medieval Art');
INSERT INTO public.categories VALUES (164, 'Arte italiano');
INSERT INTO public.categories VALUES (165, 'Etching');
INSERT INTO public.categories VALUES (166, 'Dutch Painting');
INSERT INTO public.categories VALUES (167, 'Dutch Art');
INSERT INTO public.categories VALUES (168, 'Vejle kunstmuseum');
INSERT INTO public.categories VALUES (169, 'Art collections');
INSERT INTO public.categories VALUES (170, 'Staatliche Kunstsammlungen Dresden. Kupferstich-Kabinett');
INSERT INTO public.categories VALUES (171, 'Staatliche Kunstsammlungen Dresden');
INSERT INTO public.categories VALUES (172, 'Staatliche Museen zu Berlin--Preussischer Kulturbesitz');
INSERT INTO public.categories VALUES (173, 'Catalogs');
INSERT INTO public.categories VALUES (174, 'Musée du Petit Palais (Paris, France). Collection Dutuit');
INSERT INTO public.categories VALUES (175, 'Criticism and interpretation');
INSERT INTO public.categories VALUES (176, 'Rembrandt Hermans-zoon van Rijn, 1606-1669');
INSERT INTO public.categories VALUES (177, 'Staatliche Museen zu Berlin--Preussischer Kulturbesitz. Kupferstichkabinett--Sammlung der Zeichnungen und Druckgraphik');
INSERT INTO public.categories VALUES (178, 'Themes, motives');
INSERT INTO public.categories VALUES (179, 'Musée du Louvre. Cabinet des dessins');
INSERT INTO public.categories VALUES (180, 'Private collections');
INSERT INTO public.categories VALUES (181, 'Self-portraits');
INSERT INTO public.categories VALUES (182, 'Musée du Louvre');
INSERT INTO public.categories VALUES (183, 'Expertising');
INSERT INTO public.categories VALUES (184, 'Drawing');
INSERT INTO public.categories VALUES (185, 'Exhibitions');
INSERT INTO public.categories VALUES (186, 'Gosudarstvennyĭ muzeĭ izobrazitelʹnykh iskusstv imeni A.S. Pushkina');
INSERT INTO public.categories VALUES (187, 'Nativity');
INSERT INTO public.categories VALUES (188, 'Musée du Petit Palais (Paris, France)');
INSERT INTO public.categories VALUES (189, 'Dutch Etching');
INSERT INTO public.categories VALUES (190, 'Drawing & drawings');
INSERT INTO public.categories VALUES (191, 'Individual artists');
INSERT INTO public.categories VALUES (192, 'Art & Art Instruction');
INSERT INTO public.categories VALUES (193, 'Netherlands');
INSERT INTO public.categories VALUES (194, 'Art / Individual Artist');
INSERT INTO public.categories VALUES (195, 'Individual Artist');
INSERT INTO public.categories VALUES (196, 'Baroque art');
INSERT INTO public.categories VALUES (197, 'Prints & printmaking');
INSERT INTO public.categories VALUES (198, 'Rembrandt Harmenszoon van Rijn');
INSERT INTO public.categories VALUES (199, 'Printmaking');
INSERT INTO public.categories VALUES (200, 'Rembrandt Harmenszoon van Rijn,');
INSERT INTO public.categories VALUES (201, 'Art / Fine Arts');
INSERT INTO public.categories VALUES (202, '1606-1669');
INSERT INTO public.categories VALUES (203, 'Painting & paintings');
INSERT INTO public.categories VALUES (204, 'Individual Painters And Their Work');
INSERT INTO public.categories VALUES (205, 'Graphic Arts - General');
INSERT INTO public.categories VALUES (206, 'Social life and customs');
INSERT INTO public.categories VALUES (207, 'Translations into Chinese');
INSERT INTO public.categories VALUES (208, 'Translations from French');
INSERT INTO public.categories VALUES (209, 'Chinese fiction');
INSERT INTO public.categories VALUES (210, 'Manuscripts');
INSERT INTO public.categories VALUES (211, 'French fiction');
INSERT INTO public.categories VALUES (212, 'Literature');
INSERT INTO public.categories VALUES (213, 'French literature');
INSERT INTO public.categories VALUES (214, 'Sculpture');
INSERT INTO public.categories VALUES (215, 'Aesthetics');
INSERT INTO public.categories VALUES (216, 'Musicians');
INSERT INTO public.categories VALUES (217, 'Composers');
INSERT INTO public.categories VALUES (218, 'Russian Novelists');
INSERT INTO public.categories VALUES (219, 'Catalogues raisonnés');
INSERT INTO public.categories VALUES (220, 'Friends and associates');
INSERT INTO public.categories VALUES (221, 'Hamburger Kunsthalle');
INSERT INTO public.categories VALUES (222, 'Modern Painting');
INSERT INTO public.categories VALUES (223, 'Munch-museet (Oslo, Norway)');
INSERT INTO public.categories VALUES (224, 'Museum Folkwang Essen');
INSERT INTO public.categories VALUES (225, 'Nasjonalgalleriet (Norway)');
INSERT INTO public.categories VALUES (226, 'Norway');
INSERT INTO public.categories VALUES (227, 'Norway. Nasjonalgalleriet');
INSERT INTO public.categories VALUES (228, 'Norwegian Art');
INSERT INTO public.categories VALUES (229, 'Norwegian Drawing');
INSERT INTO public.categories VALUES (230, 'Norwegian Engraving');
INSERT INTO public.categories VALUES (231, 'Norwegian Lithography');
INSERT INTO public.categories VALUES (232, 'Norwegian Painting');
INSERT INTO public.categories VALUES (233, 'Prints');
INSERT INTO public.categories VALUES (234, 'Symbolism in art');
INSERT INTO public.categories VALUES (235, 'Wood-engraving, Norwegian');
INSERT INTO public.categories VALUES (236, 'Working class in art');
INSERT INTO public.categories VALUES (237, 'OUR Brockhaus selection');
INSERT INTO public.categories VALUES (238, 'Bildende Kunst');
INSERT INTO public.categories VALUES (239, 'Pictorial Norwegian wit and humor');
INSERT INTO public.categories VALUES (240, 'Biography: general');
INSERT INTO public.categories VALUES (241, 'Exhibition catalogues and specific collections');
INSERT INTO public.categories VALUES (242, 'Essays');
INSERT INTO public.categories VALUES (243, 'History - Modern (Late 19th Century to 1945)');
INSERT INTO public.categories VALUES (244, 'Art / General');
INSERT INTO public.categories VALUES (245, 'Munch, Edvard,');
INSERT INTO public.categories VALUES (246, 'Exhibition Catalogs');
INSERT INTO public.categories VALUES (247, 'Graphic Arts');
INSERT INTO public.categories VALUES (248, '1863-1944');
INSERT INTO public.categories VALUES (249, 'Translations into English');
INSERT INTO public.categories VALUES (250, 'Science');
INSERT INTO public.categories VALUES (251, 'German Authors');
INSERT INTO public.categories VALUES (252, 'German Aesthetics');
INSERT INTO public.categories VALUES (253, 'Quotations');
INSERT INTO public.categories VALUES (254, 'History and criticism');
INSERT INTO public.categories VALUES (255, 'German National characteristics');
INSERT INTO public.categories VALUES (256, 'Characters');
INSERT INTO public.categories VALUES (257, 'English Translations');
INSERT INTO public.categories VALUES (258, 'Travel');
INSERT INTO public.categories VALUES (259, 'German Maxims');
INSERT INTO public.categories VALUES (260, 'Men in literature');
INSERT INTO public.categories VALUES (261, 'Music');
INSERT INTO public.categories VALUES (262, 'German Erotic poetry');
INSERT INTO public.categories VALUES (263, 'Music in literature');
INSERT INTO public.categories VALUES (264, 'Men');
INSERT INTO public.categories VALUES (265, 'Calendars');
INSERT INTO public.categories VALUES (266, 'Literary calendars');
INSERT INTO public.categories VALUES (267, 'Women in literature');
INSERT INTO public.categories VALUES (268, 'Translations into Catalan');
INSERT INTO public.categories VALUES (269, 'American Watercolor painting');
INSERT INTO public.categories VALUES (270, 'Birds in art');
INSERT INTO public.categories VALUES (271, 'Classification');
INSERT INTO public.categories VALUES (272, 'Birds in art.');
INSERT INTO public.categories VALUES (273, 'Miniature books');
INSERT INTO public.categories VALUES (274, 'Ornithologists');
INSERT INTO public.categories VALUES (275, 'Specimens');
INSERT INTO public.categories VALUES (276, 'Ornithological illustration');
INSERT INTO public.categories VALUES (277, 'Geographical distribution');
INSERT INTO public.categories VALUES (278, 'Juvenile literature');
INSERT INTO public.categories VALUES (279, 'Birds');
INSERT INTO public.categories VALUES (280, 'Sale Adult - Art & Art Instruction');
INSERT INTO public.categories VALUES (281, 'Nature/Ecology');
INSERT INTO public.categories VALUES (282, 'Techniques - Painting - Specific Subjects');
INSERT INTO public.categories VALUES (283, 'Sale Books');
INSERT INTO public.categories VALUES (284, 'North America');
INSERT INTO public.categories VALUES (285, 'Birds, including cage birds');
INSERT INTO public.categories VALUES (286, 'Birds & Birdwatching - General');
INSERT INTO public.categories VALUES (287, 'Techniques - Printmaking');
INSERT INTO public.categories VALUES (288, 'Correspondence');
INSERT INTO public.categories VALUES (289, 'Art and literature');
INSERT INTO public.categories VALUES (290, 'French Authors');
INSERT INTO public.categories VALUES (291, 'Cats in art');
INSERT INTO public.categories VALUES (292, 'Art in literature');
INSERT INTO public.categories VALUES (293, 'Correspondence (Rilke, Rainer Maria)');
INSERT INTO public.categories VALUES (294, 'Briefsammlung');
INSERT INTO public.categories VALUES (295, 'Literatur in verwandten Sprachen Deutsche Literatur');
INSERT INTO public.categories VALUES (296, 'Museo del Prado');
INSERT INTO public.categories VALUES (297, 'Critique et interprétation');
INSERT INTO public.categories VALUES (298, 'Romanticism');
INSERT INTO public.categories VALUES (299, 'Modernism (Art)');
INSERT INTO public.categories VALUES (300, 'Spanish Painting');
INSERT INTO public.categories VALUES (301, 'Spanish Prints');
INSERT INTO public.categories VALUES (302, 'Artistic Anatomy');
INSERT INTO public.categories VALUES (303, 'Artists'' preparatory studies');
INSERT INTO public.categories VALUES (304, 'Autographs');
INSERT INTO public.categories VALUES (305, 'Bibliography');
INSERT INTO public.categories VALUES (306, 'Cappella Sistina (Vatican Palace, Vatican City)');
INSERT INTO public.categories VALUES (307, 'Casa Buonarroti (Florence, Italy)');
INSERT INTO public.categories VALUES (308, 'Chronology');
INSERT INTO public.categories VALUES (309, 'Notebooks, sketchbooks');
INSERT INTO public.categories VALUES (310, 'San Lorenzo (Church : Florence, Italy)');
INSERT INTO public.categories VALUES (311, 'San Lorenzo (Church : Florence, Italy). Sagrestia nuova');
INSERT INTO public.categories VALUES (312, 'Sistine Chapel (Vatican Palace, Vatican City)');
INSERT INTO public.categories VALUES (313, 'Vatican. Capella paolina');
INSERT INTO public.categories VALUES (314, 'Vatican');
INSERT INTO public.categories VALUES (315, 'Work');
INSERT INTO public.categories VALUES (316, 'War');
INSERT INTO public.categories VALUES (317, 'Politics and government');
INSERT INTO public.categories VALUES (318, 'Industry');
INSERT INTO public.categories VALUES (319, 'Art and war');
INSERT INTO public.categories VALUES (320, 'Environmental aspects');
INSERT INTO public.categories VALUES (321, 'Working class');
INSERT INTO public.categories VALUES (322, 'History. [from old catalog]');
INSERT INTO public.categories VALUES (323, 'Art et guerre');
INSERT INTO public.categories VALUES (324, 'Aspect de l''environnement');
INSERT INTO public.categories VALUES (325, 'Industrie');
INSERT INTO public.categories VALUES (326, 'Social security');
INSERT INTO public.categories VALUES (327, 'Wealth');
INSERT INTO public.categories VALUES (328, 'Welfare state');
INSERT INTO public.categories VALUES (329, 'Training');
INSERT INTO public.categories VALUES (330, 'Pensions');
INSERT INTO public.categories VALUES (331, 'Youth');
INSERT INTO public.categories VALUES (332, 'Musée de l''Orangerie');
INSERT INTO public.categories VALUES (333, 'Post-impressionism (Art)');
INSERT INTO public.categories VALUES (334, 'French Painting');
INSERT INTO public.categories VALUES (335, 'Interviews');
INSERT INTO public.categories VALUES (336, 'French Drawing');
INSERT INTO public.categories VALUES (337, 'Impressionism');
INSERT INTO public.categories VALUES (338, 'Post-Impressionism');
INSERT INTO public.categories VALUES (339, 'Museum, historic sites, gallery & art guides');
INSERT INTO public.categories VALUES (340, 'Collections, Catalogs, Exhibitions - General');
INSERT INTO public.categories VALUES (341, 'History - General');
INSERT INTO public.categories VALUES (342, 'Câezanne, Paul,');
INSERT INTO public.categories VALUES (343, 'Cezanne, Paul');
INSERT INTO public.categories VALUES (344, '1839-1906');
INSERT INTO public.categories VALUES (345, 'Cezanne, Paul,');
INSERT INTO public.categories VALUES (346, 'Art and morals');
INSERT INTO public.categories VALUES (347, 'Church history');
INSERT INTO public.categories VALUES (348, 'Essence, genius, nature');
INSERT INTO public.categories VALUES (349, 'Evil, Non-resistance to');
INSERT INTO public.categories VALUES (350, 'Evil, Non-resistance to.');
INSERT INTO public.categories VALUES (351, 'Kingdom of God');
INSERT INTO public.categories VALUES (352, 'Nonviolence');
INSERT INTO public.categories VALUES (353, 'Religion');
INSERT INTO public.categories VALUES (354, 'Religious aspects of Nonviolence');
INSERT INTO public.categories VALUES (355, 'Religious aspects of Resistance to government');
INSERT INTO public.categories VALUES (356, 'Religious aspects of War');
INSERT INTO public.categories VALUES (357, 'Resistance to Government');
INSERT INTO public.categories VALUES (358, 'Christian anarchism');
INSERT INTO public.categories VALUES (359, 'Congresses');
INSERT INTO public.categories VALUES (360, 'Child psychology');
INSERT INTO public.categories VALUES (361, 'Imagery (Psychology) in children');
INSERT INTO public.categories VALUES (362, 'Drawing ability in children');
INSERT INTO public.categories VALUES (363, 'Child development');
INSERT INTO public.categories VALUES (364, 'Earth in art');
INSERT INTO public.categories VALUES (365, 'Space perception in children');
INSERT INTO public.categories VALUES (366, 'Earth in art.');
INSERT INTO public.categories VALUES (367, 'Child study');
INSERT INTO public.categories VALUES (368, 'Rote Armee Fraktion');
INSERT INTO public.categories VALUES (369, 'In art');
INSERT INTO public.categories VALUES (370, 'Art (Drawing and Painting)');
INSERT INTO public.categories VALUES (371, 'Baader-Meinhof gang in art');
INSERT INTO public.categories VALUES (372, 'Baader-Meinhof gang');
INSERT INTO public.categories VALUES (373, 'Rote Armee Fraktion in art');
INSERT INTO public.categories VALUES (374, 'History of art & design styles: from c 1900 -');
INSERT INTO public.categories VALUES (375, 'Art criticism');
INSERT INTO public.categories VALUES (376, 'English literature');
INSERT INTO public.categories VALUES (377, 'Intellectual life');
INSERT INTO public.categories VALUES (378, 'Arts and society');
INSERT INTO public.categories VALUES (379, 'British Arts');
INSERT INTO public.categories VALUES (380, 'Victorian Arts');
INSERT INTO public.categories VALUES (381, 'Edwardian Arts');
INSERT INTO public.categories VALUES (382, 'British Art');
INSERT INTO public.categories VALUES (383, 'English Arts');
INSERT INTO public.categories VALUES (384, 'Historiography');
INSERT INTO public.categories VALUES (385, 'Arts and crafts movement');
INSERT INTO public.categories VALUES (386, 'Perspective');
INSERT INTO public.categories VALUES (387, 'Histoire');
INSERT INTO public.categories VALUES (388, 'Botany');
INSERT INTO public.categories VALUES (389, 'Poetry');
INSERT INTO public.categories VALUES (390, 'Scholasticism');
INSERT INTO public.categories VALUES (391, 'Chinese Art');
INSERT INTO public.categories VALUES (392, 'Japanese Art');
INSERT INTO public.categories VALUES (393, 'Asian Art');
INSERT INTO public.categories VALUES (394, 'Pessimism');
INSERT INTO public.categories VALUES (395, 'Esthétique');
INSERT INTO public.categories VALUES (396, 'Morale pratique');
INSERT INTO public.categories VALUES (397, 'Study and teaching (Higher)');
INSERT INTO public.categories VALUES (398, 'Intelligence');
INSERT INTO public.categories VALUES (399, 'Addresses, essays, lectures');
INSERT INTO public.categories VALUES (400, 'Métaphysique');
INSERT INTO public.categories VALUES (401, 'Philosophie');
INSERT INTO public.categories VALUES (402, 'English Art');
INSERT INTO public.categories VALUES (403, 'Painting, French');
INSERT INTO public.categories VALUES (404, 'Art, Modern');
INSERT INTO public.categories VALUES (405, 'Arts');
INSERT INTO public.categories VALUES (406, 'Fantasy literature, American');
INSERT INTO public.categories VALUES (407, 'American Fantasy literature');
INSERT INTO public.categories VALUES (408, 'Modern Art');
INSERT INTO public.categories VALUES (409, 'Abstract Art');
INSERT INTO public.categories VALUES (410, 'Psychology');
INSERT INTO public.categories VALUES (411, 'Homes and haunts');
INSERT INTO public.categories VALUES (412, 'American Authors');
INSERT INTO public.categories VALUES (413, 'Solitude');
INSERT INTO public.categories VALUES (414, 'Natural history');
INSERT INTO public.categories VALUES (415, 'Wilderness areas');
INSERT INTO public.categories VALUES (416, 'Civil disobedience');
INSERT INTO public.categories VALUES (417, 'Comic books, strips');
INSERT INTO public.categories VALUES (418, 'Walden Woods');
INSERT INTO public.categories VALUES (419, 'Massachusetts');
INSERT INTO public.categories VALUES (420, 'English essays');
INSERT INTO public.categories VALUES (421, 'Indexes');
INSERT INTO public.categories VALUES (422, '1817-1862');
INSERT INTO public.categories VALUES (423, 'Wildnerness areas');
INSERT INTO public.categories VALUES (424, 'Nonfiction');
INSERT INTO public.categories VALUES (425, 'Homes');
INSERT INTO public.categories VALUES (426, 'American authors');
INSERT INTO public.categories VALUES (427, 'Manners and customs');
INSERT INTO public.categories VALUES (428, 'United States Civil War, 1861-1865');
INSERT INTO public.categories VALUES (429, 'Gay poets');
INSERT INTO public.categories VALUES (430, 'Presidents');
INSERT INTO public.categories VALUES (431, 'American Poets');
INSERT INTO public.categories VALUES (432, 'English poetry');
INSERT INTO public.categories VALUES (433, 'American poetry');
INSERT INTO public.categories VALUES (434, 'Mysticism');
INSERT INTO public.categories VALUES (435, 'American Epic poetry');
INSERT INTO public.categories VALUES (436, 'English Authors');
INSERT INTO public.categories VALUES (437, 'Lexicographers');
INSERT INTO public.categories VALUES (438, 'KDescr. & trav');
INSERT INTO public.categories VALUES (439, 'Critics');
INSERT INTO public.categories VALUES (440, 'Intellectuals');
INSERT INTO public.categories VALUES (441, 'Johnson, Samuel, 1709-1784');
INSERT INTO public.categories VALUES (442, 'Authors, English');
INSERT INTO public.categories VALUES (443, 'English Poets');
INSERT INTO public.categories VALUES (444, 'Facsimiles');
INSERT INTO public.categories VALUES (445, 'British');
INSERT INTO public.categories VALUES (446, 'Officers');
INSERT INTO public.categories VALUES (447, 'Merchant marine');
INSERT INTO public.categories VALUES (448, 'Atonement');
INSERT INTO public.categories VALUES (449, 'Cowardice');
INSERT INTO public.categories VALUES (450, 'Fiction in English');
INSERT INTO public.categories VALUES (451, 'Indonesia');
INSERT INTO public.categories VALUES (452, 'Seafaring life');
INSERT INTO public.categories VALUES (453, 'Conrad, Joseph, 1857-1924. Lord Jim');
INSERT INTO public.categories VALUES (454, 'English Psychological fiction');
INSERT INTO public.categories VALUES (455, 'English Adventure stories');
INSERT INTO public.categories VALUES (456, 'In literature');
INSERT INTO public.categories VALUES (457, 'NOVELAS INGLESAS');
INSERT INTO public.categories VALUES (458, 'LITERARY CRITICISM / European / English, Irish, Scottish, Welsh');
INSERT INTO public.categories VALUES (459, '19th century');
INSERT INTO public.categories VALUES (460, 'Business');
INSERT INTO public.categories VALUES (461, 'Christian Science');
INSERT INTO public.categories VALUES (462, 'Journeys');
INSERT INTO public.categories VALUES (463, 'Law and politics');
INSERT INTO public.categories VALUES (464, 'Mines and mineral resources');
INSERT INTO public.categories VALUES (465, 'Voyages around the world');
INSERT INTO public.categories VALUES (466, 'West (U.S.)');
INSERT INTO public.categories VALUES (467, 'Sexual ethics for teenagers');
INSERT INTO public.categories VALUES (468, 'Sex instruction for youth');
INSERT INTO public.categories VALUES (469, 'Spiritual exercises');
INSERT INTO public.categories VALUES (470, 'Spiritual retreats');
INSERT INTO public.categories VALUES (471, 'Meditation');
INSERT INTO public.categories VALUES (472, 'Christian saints');
INSERT INTO public.categories VALUES (473, 'Jesuits');
INSERT INTO public.categories VALUES (474, 'Devotional calendars');
INSERT INTO public.categories VALUES (475, 'Spiritual direction');
INSERT INTO public.categories VALUES (476, 'Spirituality');
INSERT INTO public.categories VALUES (477, 'French');
INSERT INTO public.categories VALUES (478, 'Spiritual excercises');
INSERT INTO public.categories VALUES (479, 'Sources');
INSERT INTO public.categories VALUES (480, 'Pastoral letters and charges');
INSERT INTO public.categories VALUES (481, 'Ignatius,');
INSERT INTO public.categories VALUES (482, 'Christianity - Catholicism');
INSERT INTO public.categories VALUES (483, 'Religion - Classic Works');
INSERT INTO public.categories VALUES (484, 'Inspirational - Catholic');
INSERT INTO public.categories VALUES (485, 'Christian Life - General');
INSERT INTO public.categories VALUES (486, 'Christian Life - Inspirational - Catholic');
INSERT INTO public.categories VALUES (487, '1491-1556.');
INSERT INTO public.categories VALUES (488, 'Of Loyola, Saint,');
INSERT INTO public.categories VALUES (489, 'Christianity - Catholic');
INSERT INTO public.categories VALUES (490, '1491-1556');
INSERT INTO public.categories VALUES (491, 'Exercitia spiritualia');
INSERT INTO public.categories VALUES (492, 'Mauritius in fiction');
INSERT INTO public.categories VALUES (493, 'Readers');
INSERT INTO public.categories VALUES (494, 'Translations into Arabic');
INSERT INTO public.categories VALUES (495, 'Arabic literature');
INSERT INTO public.categories VALUES (496, 'Imprints');
INSERT INTO public.categories VALUES (497, 'Brothers and sisters');
INSERT INTO public.categories VALUES (498, 'Mongols');
INSERT INTO public.categories VALUES (499, 'Chinese Inscriptions');
INSERT INTO public.categories VALUES (500, 'Early maps');
INSERT INTO public.categories VALUES (501, 'Biblioteca civica (Padua, Italy)');
INSERT INTO public.categories VALUES (502, 'Illumination of books and manuscripts');
INSERT INTO public.categories VALUES (503, 'Mongals');
INSERT INTO public.categories VALUES (504, 'Pre-Linnean works');
INSERT INTO public.categories VALUES (505, 'Descriptions et voyages');
INSERT INTO public.categories VALUES (506, 'Voyages');
INSERT INTO public.categories VALUES (507, 'Italians');
INSERT INTO public.categories VALUES (508, 'Asie');
INSERT INTO public.categories VALUES (509, 'Medieval Travel');
INSERT INTO public.categories VALUES (510, 'Fairy tales');
INSERT INTO public.categories VALUES (511, 'Medieval Illumination of books and manuscripts');
INSERT INTO public.categories VALUES (512, 'Theater');
INSERT INTO public.categories VALUES (513, 'Commitment (Psychology)');
INSERT INTO public.categories VALUES (514, 'Planche, Gustave, 1808-1857');
INSERT INTO public.categories VALUES (515, 'Swiss Novelists');
INSERT INTO public.categories VALUES (516, 'Childhood and youth');
INSERT INTO public.categories VALUES (517, 'Literatura Francesa');
INSERT INTO public.categories VALUES (518, 'Plants');
INSERT INTO public.categories VALUES (519, 'German Poets');
INSERT INTO public.categories VALUES (520, 'Effect of chemicals on');
INSERT INTO public.categories VALUES (521, 'Botanical chemistry');
INSERT INTO public.categories VALUES (522, 'German language');
INSERT INTO public.categories VALUES (523, 'Kreissparkasse Köln (Germany)');
INSERT INTO public.categories VALUES (524, 'Dadaism');
INSERT INTO public.categories VALUES (525, 'Drawing, German');
INSERT INTO public.categories VALUES (526, 'Deutsche Lufthansa (1951- )');
INSERT INTO public.categories VALUES (527, 'Sprengel Museum Hannover');
INSERT INTO public.categories VALUES (528, 'Rubbing');
INSERT INTO public.categories VALUES (529, 'Capricorn Trust');
INSERT INTO public.categories VALUES (530, 'Surrealism');
INSERT INTO public.categories VALUES (531, 'German Drawing');
INSERT INTO public.categories VALUES (532, 'German Painting');
INSERT INTO public.categories VALUES (533, 'Ancient Philosophers');
INSERT INTO public.categories VALUES (534, 'Trials, litigation');
INSERT INTO public.categories VALUES (535, 'Classical biography');
INSERT INTO public.categories VALUES (536, 'Emperors');
INSERT INTO public.categories VALUES (537, 'Generals');
INSERT INTO public.categories VALUES (538, 'Latin language');
INSERT INTO public.categories VALUES (539, 'Latin language materials');
INSERT INTO public.categories VALUES (540, 'Legends');
INSERT INTO public.categories VALUES (541, 'Saints');
INSERT INTO public.categories VALUES (542, 'Christian literature, Latin (Medieval and modern)');
INSERT INTO public.categories VALUES (543, 'Heiligen');
INSERT INTO public.categories VALUES (544, 'French Christian literature');
INSERT INTO public.categories VALUES (545, 'Christian women saints');
INSERT INTO public.categories VALUES (546, 'Incunabula');
INSERT INTO public.categories VALUES (547, 'Liturgy');
INSERT INTO public.categories VALUES (548, 'Martyrologies');
INSERT INTO public.categories VALUES (549, 'Church calendar');
INSERT INTO public.categories VALUES (550, 'Texts');
INSERT INTO public.categories VALUES (551, 'Cult');
INSERT INTO public.categories VALUES (552, 'Calendar');
INSERT INTO public.categories VALUES (553, 'Cabinet officers');
INSERT INTO public.categories VALUES (554, 'Diaries');
INSERT INTO public.categories VALUES (555, 'Diarists');
INSERT INTO public.categories VALUES (556, 'English drama');
INSERT INTO public.categories VALUES (557, 'Great Britain');
INSERT INTO public.categories VALUES (558, 'Social conditions');
INSERT INTO public.categories VALUES (559, 'Agriculture');
INSERT INTO public.categories VALUES (560, 'Plant diseases');
INSERT INTO public.categories VALUES (561, 'Tagebuch');
INSERT INTO public.categories VALUES (562, 'Social Environment');
INSERT INTO public.categories VALUES (563, 'Social Conditions');
INSERT INTO public.categories VALUES (564, 'Drama');
INSERT INTO public.categories VALUES (565, 'Outlines, syllabi');
INSERT INTO public.categories VALUES (566, 'Language');
INSERT INTO public.categories VALUES (567, 'Study');
INSERT INTO public.categories VALUES (568, 'Dictionaries');
INSERT INTO public.categories VALUES (569, 'Illustrations');
INSERT INTO public.categories VALUES (570, 'Folios. 1623');
INSERT INTO public.categories VALUES (571, 'Folios');
INSERT INTO public.categories VALUES (572, 'Goths');
INSERT INTO public.categories VALUES (573, 'Concordances');
INSERT INTO public.categories VALUES (574, 'Glossaries');
INSERT INTO public.categories VALUES (575, 'Titus Andronicus (Legendary character)');
INSERT INTO public.categories VALUES (576, 'English Manuscripts');
INSERT INTO public.categories VALUES (577, 'Heroes');
INSERT INTO public.categories VALUES (578, 'English Paleography');
INSERT INTO public.categories VALUES (579, 'English language');
INSERT INTO public.categories VALUES (580, 'Glossaries, vocabularies');
INSERT INTO public.categories VALUES (581, 'Views');
INSERT INTO public.categories VALUES (582, 'Ancient History');
INSERT INTO public.categories VALUES (583, 'Macedonia');
INSERT INTO public.categories VALUES (584, 'Kings and rulers');
INSERT INTO public.categories VALUES (585, 'Latin American literature');
INSERT INTO public.categories VALUES (586, 'Medieval and modern Latin literature');
INSERT INTO public.categories VALUES (587, 'Contemporaries');
INSERT INTO public.categories VALUES (588, 'France');
INSERT INTO public.categories VALUES (589, 'Political and social views');
INSERT INTO public.categories VALUES (590, 'Campaigns');
INSERT INTO public.categories VALUES (591, 'United States');
INSERT INTO public.categories VALUES (592, 'United States. Continental Army');
INSERT INTO public.categories VALUES (593, 'Germanic Law');
INSERT INTO public.categories VALUES (594, 'Germanic Mythology');
INSERT INTO public.categories VALUES (595, 'Germanic antiquities');
INSERT INTO public.categories VALUES (596, 'Germanic peoples');
INSERT INTO public.categories VALUES (597, 'Historical geography');
INSERT INTO public.categories VALUES (598, 'Romans');
INSERT INTO public.categories VALUES (599, 'Irish authors');
INSERT INTO public.categories VALUES (600, 'Irish Authors');
INSERT INTO public.categories VALUES (601, 'Ancient Kings and rulers');
INSERT INTO public.categories VALUES (602, 'Alexander, the Great, 356-323 B.C. -- Early works to 1800');
INSERT INTO public.categories VALUES (603, 'Grace (Theology)');
INSERT INTO public.categories VALUES (604, 'Christian biography');
INSERT INTO public.categories VALUES (605, 'Redemption');
INSERT INTO public.categories VALUES (606, 'Purtians');
INSERT INTO public.categories VALUES (607, 'Christian pilgrims and pilgrimages');
INSERT INTO public.categories VALUES (608, 'English Novelists');
INSERT INTO public.categories VALUES (609, 'Open Library Staff Picks');
INSERT INTO public.categories VALUES (610, 'Children''s poetry, English');
INSERT INTO public.categories VALUES (611, 'Poetic works');
INSERT INTO public.categories VALUES (612, 'World history');
INSERT INTO public.categories VALUES (613, 'Slave insurrections');
INSERT INTO public.categories VALUES (614, 'Jacques, 1712-1778. Les confessions');
INSERT INTO public.categories VALUES (615, 'Jean Rousseau');
INSERT INTO public.categories VALUES (616, 'Rousseau, Jean Jacques, 1712-1778');
INSERT INTO public.categories VALUES (617, 'Dutch Americans');
INSERT INTO public.categories VALUES (618, 'City and town life');
INSERT INTO public.categories VALUES (619, 'Historical Fiction');
INSERT INTO public.categories VALUES (620, 'New York (State)');
INSERT INTO public.categories VALUES (621, 'Commerce');
INSERT INTO public.categories VALUES (622, 'Economic conditions');
INSERT INTO public.categories VALUES (623, 'Economic history');
INSERT INTO public.categories VALUES (624, 'Industrial Trusts');
INSERT INTO public.categories VALUES (625, 'Industries');
INSERT INTO public.categories VALUES (626, 'Affaires');
INSERT INTO public.categories VALUES (627, 'Success in business');
INSERT INTO public.categories VALUES (628, 'Success');
INSERT INTO public.categories VALUES (629, 'Succès');
INSERT INTO public.categories VALUES (630, 'Richesse');
INSERT INTO public.categories VALUES (631, 'Conditions économiques');
INSERT INTO public.categories VALUES (632, 'Capital');
INSERT INTO public.categories VALUES (633, 'Capitalism');
INSERT INTO public.categories VALUES (634, 'Frontier and pioneer life');
INSERT INTO public.categories VALUES (635, 'Gold discoveries');
INSERT INTO public.categories VALUES (636, 'Indians of North America');
INSERT INTO public.categories VALUES (637, 'Overland journeys to the Pacific');
INSERT INTO public.categories VALUES (638, 'Real estate development');
INSERT INTO public.categories VALUES (639, 'Urbanization');
INSERT INTO public.categories VALUES (640, 'Standard Oil Company');
INSERT INTO public.categories VALUES (641, 'Capitalists and financiers');
INSERT INTO public.categories VALUES (642, 'Capitalistes et financiers');
INSERT INTO public.categories VALUES (643, 'Charité');
INSERT INTO public.categories VALUES (644, 'Zamorano 80');
INSERT INTO public.categories VALUES (645, 'American History');
INSERT INTO public.categories VALUES (646, 'Gold discoveries. [from old catalog]');
INSERT INTO public.categories VALUES (647, 'Ethnic groups');
INSERT INTO public.categories VALUES (648, 'Handbooks, manuals');
INSERT INTO public.categories VALUES (649, 'Humor');
INSERT INTO public.categories VALUES (650, 'Quotations, maxims');
INSERT INTO public.categories VALUES (651, 'English Quotations');
INSERT INTO public.categories VALUES (652, 'English Christmas stories');
INSERT INTO public.categories VALUES (653, 'Children');
INSERT INTO public.categories VALUES (654, 'Biography & Autobiography');
INSERT INTO public.categories VALUES (655, 'Sambo (Fictitious character)');
INSERT INTO public.categories VALUES (656, 'Toy and movable books');
INSERT INTO public.categories VALUES (657, 'Blacks');
INSERT INTO public.categories VALUES (658, 'Tigers');
INSERT INTO public.categories VALUES (659, 'India');
INSERT INTO public.categories VALUES (660, 'Jungles');
INSERT INTO public.categories VALUES (661, 'Boys');
INSERT INTO public.categories VALUES (662, 'Clothing and dress');
INSERT INTO public.categories VALUES (663, 'Juvenile fiction');
INSERT INTO public.categories VALUES (664, 'Dogs');
INSERT INTO public.categories VALUES (665, 'Family');
INSERT INTO public.categories VALUES (666, 'Family life');
INSERT INTO public.categories VALUES (667, 'Canadian fiction (English), CIHM');
INSERT INTO public.categories VALUES (668, 'Roman canadien-anglais, ICMH');
INSERT INTO public.categories VALUES (669, 'Orphans');
INSERT INTO public.categories VALUES (670, 'Anne Shirley (Fictitious character)');
INSERT INTO public.categories VALUES (671, 'Friendship');
INSERT INTO public.categories VALUES (672, 'Parenting');
INSERT INTO public.categories VALUES (673, 'Man-woman relationships');
INSERT INTO public.categories VALUES (674, 'Courtship');
INSERT INTO public.categories VALUES (675, 'Adaptations');
INSERT INTO public.categories VALUES (676, 'Stories, plots');
INSERT INTO public.categories VALUES (677, 'Children''s literature, English');
INSERT INTO public.categories VALUES (678, 'Children''s stories, English');
INSERT INTO public.categories VALUES (679, 'Religious life');
INSERT INTO public.categories VALUES (680, 'Religious education');
INSERT INTO public.categories VALUES (681, 'Christian education of children');
INSERT INTO public.categories VALUES (682, 'Christian education');
INSERT INTO public.categories VALUES (683, 'Infant baptism');
INSERT INTO public.categories VALUES (684, 'Christliche Erziehung');


--
-- TOC entry 2915 (class 0 OID 16662)
-- Dependencies: 205
-- Data for Name: category_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.category_books VALUES (2, 2, 2);
INSERT INTO public.category_books VALUES (3, 3, 2);
INSERT INTO public.category_books VALUES (4, 4, 2);
INSERT INTO public.category_books VALUES (5, 5, 2);
INSERT INTO public.category_books VALUES (6, 6, 2);
INSERT INTO public.category_books VALUES (7, 7, 2);
INSERT INTO public.category_books VALUES (8, 8, 2);
INSERT INTO public.category_books VALUES (9, 9, 2);
INSERT INTO public.category_books VALUES (10, 10, 2);
INSERT INTO public.category_books VALUES (11, 11, 2);
INSERT INTO public.category_books VALUES (12, 12, 2);
INSERT INTO public.category_books VALUES (13, 13, 2);
INSERT INTO public.category_books VALUES (14, 14, 2);
INSERT INTO public.category_books VALUES (15, 15, 2);
INSERT INTO public.category_books VALUES (16, 16, 2);
INSERT INTO public.category_books VALUES (17, 17, 2);
INSERT INTO public.category_books VALUES (18, 18, 2);
INSERT INTO public.category_books VALUES (19, 19, 2);
INSERT INTO public.category_books VALUES (20, 20, 2);
INSERT INTO public.category_books VALUES (21, 21, 3);
INSERT INTO public.category_books VALUES (22, 22, 3);
INSERT INTO public.category_books VALUES (23, 23, 3);
INSERT INTO public.category_books VALUES (24, 24, 3);
INSERT INTO public.category_books VALUES (25, 25, 3);
INSERT INTO public.category_books VALUES (26, 26, 3);
INSERT INTO public.category_books VALUES (27, 27, 3);
INSERT INTO public.category_books VALUES (28, 28, 3);
INSERT INTO public.category_books VALUES (29, 29, 3);
INSERT INTO public.category_books VALUES (30, 30, 3);
INSERT INTO public.category_books VALUES (31, 31, 3);
INSERT INTO public.category_books VALUES (32, 32, 3);
INSERT INTO public.category_books VALUES (33, 33, 4);
INSERT INTO public.category_books VALUES (34, 34, 4);
INSERT INTO public.category_books VALUES (35, 35, 4);
INSERT INTO public.category_books VALUES (36, 36, 4);
INSERT INTO public.category_books VALUES (37, 37, 4);
INSERT INTO public.category_books VALUES (38, 38, 4);
INSERT INTO public.category_books VALUES (39, 39, 4);
INSERT INTO public.category_books VALUES (40, 40, 4);
INSERT INTO public.category_books VALUES (41, 41, 4);
INSERT INTO public.category_books VALUES (42, 42, 4);
INSERT INTO public.category_books VALUES (43, 43, 5);
INSERT INTO public.category_books VALUES (44, 44, 5);
INSERT INTO public.category_books VALUES (45, 45, 5);
INSERT INTO public.category_books VALUES (46, 46, 5);
INSERT INTO public.category_books VALUES (47, 47, 5);
INSERT INTO public.category_books VALUES (48, 48, 5);
INSERT INTO public.category_books VALUES (49, 49, 5);
INSERT INTO public.category_books VALUES (50, 50, 5);
INSERT INTO public.category_books VALUES (51, 51, 5);
INSERT INTO public.category_books VALUES (52, 52, 5);
INSERT INTO public.category_books VALUES (53, 53, 5);
INSERT INTO public.category_books VALUES (54, 54, 5);
INSERT INTO public.category_books VALUES (55, 55, 5);
INSERT INTO public.category_books VALUES (56, 56, 5);
INSERT INTO public.category_books VALUES (57, 57, 5);
INSERT INTO public.category_books VALUES (58, 58, 5);
INSERT INTO public.category_books VALUES (59, 59, 5);
INSERT INTO public.category_books VALUES (60, 60, 5);
INSERT INTO public.category_books VALUES (61, 61, 5);
INSERT INTO public.category_books VALUES (62, 62, 6);
INSERT INTO public.category_books VALUES (63, 63, 6);
INSERT INTO public.category_books VALUES (64, 64, 6);
INSERT INTO public.category_books VALUES (65, 65, 7);
INSERT INTO public.category_books VALUES (66, 66, 8);
INSERT INTO public.category_books VALUES (67, 67, 8);
INSERT INTO public.category_books VALUES (68, 68, 8);
INSERT INTO public.category_books VALUES (69, 69, 9);
INSERT INTO public.category_books VALUES (70, 70, 9);
INSERT INTO public.category_books VALUES (71, 71, 9);
INSERT INTO public.category_books VALUES (72, 72, 9);
INSERT INTO public.category_books VALUES (73, 73, 9);
INSERT INTO public.category_books VALUES (74, 74, 9);
INSERT INTO public.category_books VALUES (75, 75, 9);
INSERT INTO public.category_books VALUES (76, 76, 9);
INSERT INTO public.category_books VALUES (77, 77, 10);
INSERT INTO public.category_books VALUES (78, 78, 10);
INSERT INTO public.category_books VALUES (79, 79, 10);
INSERT INTO public.category_books VALUES (80, 80, 10);
INSERT INTO public.category_books VALUES (81, 81, 10);
INSERT INTO public.category_books VALUES (82, 82, 10);
INSERT INTO public.category_books VALUES (83, 83, 10);
INSERT INTO public.category_books VALUES (84, 84, 10);
INSERT INTO public.category_books VALUES (85, 85, 10);
INSERT INTO public.category_books VALUES (86, 86, 10);
INSERT INTO public.category_books VALUES (87, 87, 10);
INSERT INTO public.category_books VALUES (88, 88, 10);
INSERT INTO public.category_books VALUES (89, 89, 10);
INSERT INTO public.category_books VALUES (90, 90, 11);
INSERT INTO public.category_books VALUES (91, 91, 11);
INSERT INTO public.category_books VALUES (92, 92, 12);
INSERT INTO public.category_books VALUES (93, 93, 12);
INSERT INTO public.category_books VALUES (94, 94, 12);
INSERT INTO public.category_books VALUES (95, 95, 12);
INSERT INTO public.category_books VALUES (96, 96, 12);
INSERT INTO public.category_books VALUES (97, 97, 12);
INSERT INTO public.category_books VALUES (98, 98, 12);
INSERT INTO public.category_books VALUES (99, 99, 12);
INSERT INTO public.category_books VALUES (100, 100, 12);
INSERT INTO public.category_books VALUES (101, 101, 13);
INSERT INTO public.category_books VALUES (102, 102, 13);
INSERT INTO public.category_books VALUES (103, 103, 13);
INSERT INTO public.category_books VALUES (104, 104, 13);
INSERT INTO public.category_books VALUES (105, 105, 14);
INSERT INTO public.category_books VALUES (106, 106, 15);
INSERT INTO public.category_books VALUES (107, 107, 15);
INSERT INTO public.category_books VALUES (108, 108, 16);
INSERT INTO public.category_books VALUES (109, 109, 16);
INSERT INTO public.category_books VALUES (110, 110, 16);
INSERT INTO public.category_books VALUES (111, 111, 16);
INSERT INTO public.category_books VALUES (112, 112, 17);
INSERT INTO public.category_books VALUES (113, 113, 17);
INSERT INTO public.category_books VALUES (114, 114, 17);
INSERT INTO public.category_books VALUES (115, 115, 17);
INSERT INTO public.category_books VALUES (116, 116, 17);
INSERT INTO public.category_books VALUES (117, 117, 17);
INSERT INTO public.category_books VALUES (118, 118, 18);
INSERT INTO public.category_books VALUES (119, 119, 18);
INSERT INTO public.category_books VALUES (120, 120, 18);
INSERT INTO public.category_books VALUES (121, 121, 18);
INSERT INTO public.category_books VALUES (122, 122, 18);
INSERT INTO public.category_books VALUES (123, 123, 19);
INSERT INTO public.category_books VALUES (124, 124, 19);
INSERT INTO public.category_books VALUES (125, 125, 19);
INSERT INTO public.category_books VALUES (126, 126, 19);
INSERT INTO public.category_books VALUES (127, 127, 19);
INSERT INTO public.category_books VALUES (128, 128, 19);
INSERT INTO public.category_books VALUES (129, 129, 19);
INSERT INTO public.category_books VALUES (130, 130, 19);
INSERT INTO public.category_books VALUES (131, 131, 19);
INSERT INTO public.category_books VALUES (132, 132, 19);
INSERT INTO public.category_books VALUES (133, 133, 19);
INSERT INTO public.category_books VALUES (134, 134, 19);
INSERT INTO public.category_books VALUES (135, 135, 19);
INSERT INTO public.category_books VALUES (136, 136, 19);
INSERT INTO public.category_books VALUES (137, 137, 20);
INSERT INTO public.category_books VALUES (138, 138, 20);
INSERT INTO public.category_books VALUES (139, 139, 20);
INSERT INTO public.category_books VALUES (140, 140, 20);
INSERT INTO public.category_books VALUES (141, 141, 20);
INSERT INTO public.category_books VALUES (142, 142, 20);
INSERT INTO public.category_books VALUES (143, 143, 20);
INSERT INTO public.category_books VALUES (144, 144, 21);
INSERT INTO public.category_books VALUES (145, 145, 21);
INSERT INTO public.category_books VALUES (146, 146, 21);
INSERT INTO public.category_books VALUES (147, 147, 21);
INSERT INTO public.category_books VALUES (148, 148, 22);
INSERT INTO public.category_books VALUES (149, 149, 22);
INSERT INTO public.category_books VALUES (150, 150, 22);
INSERT INTO public.category_books VALUES (151, 151, 22);
INSERT INTO public.category_books VALUES (152, 152, 22);
INSERT INTO public.category_books VALUES (153, 153, 22);
INSERT INTO public.category_books VALUES (154, 154, 22);
INSERT INTO public.category_books VALUES (155, 155, 22);
INSERT INTO public.category_books VALUES (156, 156, 22);
INSERT INTO public.category_books VALUES (157, 157, 22);
INSERT INTO public.category_books VALUES (158, 158, 22);
INSERT INTO public.category_books VALUES (159, 159, 22);
INSERT INTO public.category_books VALUES (160, 160, 22);
INSERT INTO public.category_books VALUES (161, 161, 22);
INSERT INTO public.category_books VALUES (162, 162, 22);
INSERT INTO public.category_books VALUES (163, 163, 22);
INSERT INTO public.category_books VALUES (164, 164, 22);
INSERT INTO public.category_books VALUES (165, 165, 23);
INSERT INTO public.category_books VALUES (166, 166, 23);
INSERT INTO public.category_books VALUES (167, 167, 23);
INSERT INTO public.category_books VALUES (168, 168, 23);
INSERT INTO public.category_books VALUES (169, 169, 23);
INSERT INTO public.category_books VALUES (170, 170, 23);
INSERT INTO public.category_books VALUES (171, 171, 23);
INSERT INTO public.category_books VALUES (172, 172, 23);
INSERT INTO public.category_books VALUES (173, 173, 23);
INSERT INTO public.category_books VALUES (174, 174, 23);
INSERT INTO public.category_books VALUES (175, 175, 23);
INSERT INTO public.category_books VALUES (176, 176, 23);
INSERT INTO public.category_books VALUES (177, 177, 23);
INSERT INTO public.category_books VALUES (178, 178, 23);
INSERT INTO public.category_books VALUES (179, 179, 23);
INSERT INTO public.category_books VALUES (180, 180, 23);
INSERT INTO public.category_books VALUES (181, 181, 23);
INSERT INTO public.category_books VALUES (182, 182, 23);
INSERT INTO public.category_books VALUES (183, 183, 23);
INSERT INTO public.category_books VALUES (184, 184, 23);
INSERT INTO public.category_books VALUES (185, 185, 23);
INSERT INTO public.category_books VALUES (186, 186, 23);
INSERT INTO public.category_books VALUES (187, 187, 23);
INSERT INTO public.category_books VALUES (188, 188, 23);
INSERT INTO public.category_books VALUES (189, 189, 23);
INSERT INTO public.category_books VALUES (190, 190, 23);
INSERT INTO public.category_books VALUES (191, 191, 23);
INSERT INTO public.category_books VALUES (192, 192, 23);
INSERT INTO public.category_books VALUES (193, 193, 23);
INSERT INTO public.category_books VALUES (194, 194, 23);
INSERT INTO public.category_books VALUES (195, 195, 23);
INSERT INTO public.category_books VALUES (196, 196, 23);
INSERT INTO public.category_books VALUES (197, 197, 23);
INSERT INTO public.category_books VALUES (198, 198, 23);
INSERT INTO public.category_books VALUES (199, 199, 23);
INSERT INTO public.category_books VALUES (200, 200, 23);
INSERT INTO public.category_books VALUES (201, 201, 23);
INSERT INTO public.category_books VALUES (202, 202, 23);
INSERT INTO public.category_books VALUES (203, 203, 23);
INSERT INTO public.category_books VALUES (204, 204, 23);
INSERT INTO public.category_books VALUES (205, 205, 23);
INSERT INTO public.category_books VALUES (206, 206, 24);
INSERT INTO public.category_books VALUES (207, 207, 24);
INSERT INTO public.category_books VALUES (208, 208, 24);
INSERT INTO public.category_books VALUES (209, 209, 24);
INSERT INTO public.category_books VALUES (210, 210, 24);
INSERT INTO public.category_books VALUES (211, 211, 24);
INSERT INTO public.category_books VALUES (212, 212, 24);
INSERT INTO public.category_books VALUES (213, 213, 24);
INSERT INTO public.category_books VALUES (214, 214, 24);
INSERT INTO public.category_books VALUES (215, 215, 24);
INSERT INTO public.category_books VALUES (216, 216, 24);
INSERT INTO public.category_books VALUES (217, 217, 24);
INSERT INTO public.category_books VALUES (218, 218, 24);
INSERT INTO public.category_books VALUES (219, 219, 25);
INSERT INTO public.category_books VALUES (220, 220, 25);
INSERT INTO public.category_books VALUES (221, 221, 25);
INSERT INTO public.category_books VALUES (222, 222, 25);
INSERT INTO public.category_books VALUES (223, 223, 25);
INSERT INTO public.category_books VALUES (224, 224, 25);
INSERT INTO public.category_books VALUES (225, 225, 25);
INSERT INTO public.category_books VALUES (226, 226, 25);
INSERT INTO public.category_books VALUES (227, 227, 25);
INSERT INTO public.category_books VALUES (228, 228, 25);
INSERT INTO public.category_books VALUES (229, 229, 25);
INSERT INTO public.category_books VALUES (230, 230, 25);
INSERT INTO public.category_books VALUES (231, 231, 25);
INSERT INTO public.category_books VALUES (232, 232, 25);
INSERT INTO public.category_books VALUES (233, 233, 25);
INSERT INTO public.category_books VALUES (234, 234, 25);
INSERT INTO public.category_books VALUES (235, 235, 25);
INSERT INTO public.category_books VALUES (236, 236, 25);
INSERT INTO public.category_books VALUES (237, 237, 25);
INSERT INTO public.category_books VALUES (238, 238, 25);
INSERT INTO public.category_books VALUES (239, 239, 25);
INSERT INTO public.category_books VALUES (240, 240, 25);
INSERT INTO public.category_books VALUES (241, 241, 25);
INSERT INTO public.category_books VALUES (242, 242, 25);
INSERT INTO public.category_books VALUES (243, 243, 25);
INSERT INTO public.category_books VALUES (244, 244, 25);
INSERT INTO public.category_books VALUES (245, 245, 25);
INSERT INTO public.category_books VALUES (246, 246, 25);
INSERT INTO public.category_books VALUES (247, 247, 25);
INSERT INTO public.category_books VALUES (248, 248, 25);
INSERT INTO public.category_books VALUES (249, 249, 33);
INSERT INTO public.category_books VALUES (250, 250, 33);
INSERT INTO public.category_books VALUES (251, 251, 33);
INSERT INTO public.category_books VALUES (252, 252, 33);
INSERT INTO public.category_books VALUES (253, 253, 33);
INSERT INTO public.category_books VALUES (254, 254, 33);
INSERT INTO public.category_books VALUES (255, 255, 33);
INSERT INTO public.category_books VALUES (256, 256, 33);
INSERT INTO public.category_books VALUES (257, 257, 33);
INSERT INTO public.category_books VALUES (258, 258, 33);
INSERT INTO public.category_books VALUES (259, 259, 33);
INSERT INTO public.category_books VALUES (260, 260, 33);
INSERT INTO public.category_books VALUES (261, 261, 33);
INSERT INTO public.category_books VALUES (262, 262, 33);
INSERT INTO public.category_books VALUES (263, 263, 33);
INSERT INTO public.category_books VALUES (264, 264, 33);
INSERT INTO public.category_books VALUES (265, 265, 33);
INSERT INTO public.category_books VALUES (266, 266, 33);
INSERT INTO public.category_books VALUES (267, 267, 33);
INSERT INTO public.category_books VALUES (268, 268, 33);
INSERT INTO public.category_books VALUES (269, 269, 26);
INSERT INTO public.category_books VALUES (270, 270, 26);
INSERT INTO public.category_books VALUES (271, 271, 26);
INSERT INTO public.category_books VALUES (272, 272, 26);
INSERT INTO public.category_books VALUES (273, 273, 26);
INSERT INTO public.category_books VALUES (274, 274, 26);
INSERT INTO public.category_books VALUES (275, 275, 26);
INSERT INTO public.category_books VALUES (276, 276, 26);
INSERT INTO public.category_books VALUES (277, 277, 26);
INSERT INTO public.category_books VALUES (278, 278, 26);
INSERT INTO public.category_books VALUES (279, 279, 26);
INSERT INTO public.category_books VALUES (280, 280, 26);
INSERT INTO public.category_books VALUES (281, 281, 26);
INSERT INTO public.category_books VALUES (282, 282, 26);
INSERT INTO public.category_books VALUES (283, 283, 26);
INSERT INTO public.category_books VALUES (284, 284, 26);
INSERT INTO public.category_books VALUES (285, 285, 26);
INSERT INTO public.category_books VALUES (286, 286, 26);
INSERT INTO public.category_books VALUES (287, 287, 26);
INSERT INTO public.category_books VALUES (288, 288, 27);
INSERT INTO public.category_books VALUES (289, 289, 27);
INSERT INTO public.category_books VALUES (290, 290, 27);
INSERT INTO public.category_books VALUES (291, 291, 27);
INSERT INTO public.category_books VALUES (292, 292, 27);
INSERT INTO public.category_books VALUES (293, 293, 27);
INSERT INTO public.category_books VALUES (294, 294, 27);
INSERT INTO public.category_books VALUES (295, 295, 27);
INSERT INTO public.category_books VALUES (296, 296, 28);
INSERT INTO public.category_books VALUES (297, 297, 28);
INSERT INTO public.category_books VALUES (298, 298, 28);
INSERT INTO public.category_books VALUES (299, 299, 28);
INSERT INTO public.category_books VALUES (300, 300, 28);
INSERT INTO public.category_books VALUES (301, 301, 28);
INSERT INTO public.category_books VALUES (302, 302, 29);
INSERT INTO public.category_books VALUES (303, 303, 29);
INSERT INTO public.category_books VALUES (304, 304, 29);
INSERT INTO public.category_books VALUES (305, 305, 29);
INSERT INTO public.category_books VALUES (306, 306, 29);
INSERT INTO public.category_books VALUES (307, 307, 29);
INSERT INTO public.category_books VALUES (308, 308, 29);
INSERT INTO public.category_books VALUES (309, 309, 29);
INSERT INTO public.category_books VALUES (310, 310, 29);
INSERT INTO public.category_books VALUES (311, 311, 29);
INSERT INTO public.category_books VALUES (312, 312, 29);
INSERT INTO public.category_books VALUES (313, 313, 29);
INSERT INTO public.category_books VALUES (314, 314, 29);
INSERT INTO public.category_books VALUES (315, 315, 30);
INSERT INTO public.category_books VALUES (316, 316, 30);
INSERT INTO public.category_books VALUES (317, 317, 30);
INSERT INTO public.category_books VALUES (318, 318, 30);
INSERT INTO public.category_books VALUES (319, 319, 30);
INSERT INTO public.category_books VALUES (320, 320, 30);
INSERT INTO public.category_books VALUES (321, 321, 30);
INSERT INTO public.category_books VALUES (322, 322, 30);
INSERT INTO public.category_books VALUES (323, 323, 30);
INSERT INTO public.category_books VALUES (324, 324, 30);
INSERT INTO public.category_books VALUES (325, 325, 30);
INSERT INTO public.category_books VALUES (326, 326, 31);
INSERT INTO public.category_books VALUES (327, 327, 31);
INSERT INTO public.category_books VALUES (328, 328, 31);
INSERT INTO public.category_books VALUES (329, 329, 31);
INSERT INTO public.category_books VALUES (330, 330, 31);
INSERT INTO public.category_books VALUES (331, 331, 31);
INSERT INTO public.category_books VALUES (332, 332, 32);
INSERT INTO public.category_books VALUES (333, 333, 32);
INSERT INTO public.category_books VALUES (334, 334, 32);
INSERT INTO public.category_books VALUES (335, 335, 32);
INSERT INTO public.category_books VALUES (336, 336, 32);
INSERT INTO public.category_books VALUES (337, 337, 32);
INSERT INTO public.category_books VALUES (338, 338, 32);
INSERT INTO public.category_books VALUES (339, 339, 32);
INSERT INTO public.category_books VALUES (340, 340, 32);
INSERT INTO public.category_books VALUES (341, 341, 32);
INSERT INTO public.category_books VALUES (342, 342, 32);
INSERT INTO public.category_books VALUES (343, 343, 32);
INSERT INTO public.category_books VALUES (344, 344, 32);
INSERT INTO public.category_books VALUES (345, 345, 32);
INSERT INTO public.category_books VALUES (346, 346, 34);
INSERT INTO public.category_books VALUES (347, 347, 34);
INSERT INTO public.category_books VALUES (348, 348, 34);
INSERT INTO public.category_books VALUES (349, 349, 34);
INSERT INTO public.category_books VALUES (350, 350, 34);
INSERT INTO public.category_books VALUES (351, 351, 34);
INSERT INTO public.category_books VALUES (352, 352, 34);
INSERT INTO public.category_books VALUES (353, 353, 34);
INSERT INTO public.category_books VALUES (354, 354, 34);
INSERT INTO public.category_books VALUES (355, 355, 34);
INSERT INTO public.category_books VALUES (356, 356, 34);
INSERT INTO public.category_books VALUES (357, 357, 34);
INSERT INTO public.category_books VALUES (358, 358, 34);
INSERT INTO public.category_books VALUES (359, 359, 35);
INSERT INTO public.category_books VALUES (360, 360, 35);
INSERT INTO public.category_books VALUES (361, 361, 35);
INSERT INTO public.category_books VALUES (362, 362, 35);
INSERT INTO public.category_books VALUES (363, 363, 35);
INSERT INTO public.category_books VALUES (364, 364, 35);
INSERT INTO public.category_books VALUES (365, 365, 35);
INSERT INTO public.category_books VALUES (366, 366, 35);
INSERT INTO public.category_books VALUES (367, 367, 35);
INSERT INTO public.category_books VALUES (368, 368, 36);
INSERT INTO public.category_books VALUES (369, 369, 36);
INSERT INTO public.category_books VALUES (370, 370, 36);
INSERT INTO public.category_books VALUES (371, 371, 36);
INSERT INTO public.category_books VALUES (372, 372, 36);
INSERT INTO public.category_books VALUES (373, 373, 36);
INSERT INTO public.category_books VALUES (374, 374, 36);
INSERT INTO public.category_books VALUES (375, 375, 37);
INSERT INTO public.category_books VALUES (376, 376, 38);
INSERT INTO public.category_books VALUES (377, 377, 38);
INSERT INTO public.category_books VALUES (378, 378, 38);
INSERT INTO public.category_books VALUES (379, 379, 38);
INSERT INTO public.category_books VALUES (380, 380, 38);
INSERT INTO public.category_books VALUES (381, 381, 38);
INSERT INTO public.category_books VALUES (382, 382, 38);
INSERT INTO public.category_books VALUES (383, 383, 38);
INSERT INTO public.category_books VALUES (384, 384, 39);
INSERT INTO public.category_books VALUES (385, 385, 40);
INSERT INTO public.category_books VALUES (386, 386, 41);
INSERT INTO public.category_books VALUES (387, 387, 41);
INSERT INTO public.category_books VALUES (388, 388, 42);
INSERT INTO public.category_books VALUES (389, 389, 43);
INSERT INTO public.category_books VALUES (390, 390, 43);
INSERT INTO public.category_books VALUES (391, 391, 45);
INSERT INTO public.category_books VALUES (392, 392, 45);
INSERT INTO public.category_books VALUES (393, 393, 45);
INSERT INTO public.category_books VALUES (394, 394, 47);
INSERT INTO public.category_books VALUES (395, 395, 47);
INSERT INTO public.category_books VALUES (396, 396, 47);
INSERT INTO public.category_books VALUES (397, 397, 47);
INSERT INTO public.category_books VALUES (398, 398, 47);
INSERT INTO public.category_books VALUES (399, 399, 47);
INSERT INTO public.category_books VALUES (400, 400, 47);
INSERT INTO public.category_books VALUES (401, 401, 47);
INSERT INTO public.category_books VALUES (402, 402, 48);
INSERT INTO public.category_books VALUES (403, 403, 49);
INSERT INTO public.category_books VALUES (404, 404, 49);
INSERT INTO public.category_books VALUES (405, 405, 49);
INSERT INTO public.category_books VALUES (406, 406, 49);
INSERT INTO public.category_books VALUES (407, 407, 49);
INSERT INTO public.category_books VALUES (408, 408, 49);
INSERT INTO public.category_books VALUES (409, 409, 50);
INSERT INTO public.category_books VALUES (410, 410, 50);
INSERT INTO public.category_books VALUES (411, 411, 51);
INSERT INTO public.category_books VALUES (412, 412, 51);
INSERT INTO public.category_books VALUES (413, 413, 51);
INSERT INTO public.category_books VALUES (414, 414, 51);
INSERT INTO public.category_books VALUES (415, 415, 51);
INSERT INTO public.category_books VALUES (416, 416, 51);
INSERT INTO public.category_books VALUES (417, 417, 51);
INSERT INTO public.category_books VALUES (418, 418, 51);
INSERT INTO public.category_books VALUES (419, 419, 51);
INSERT INTO public.category_books VALUES (420, 420, 51);
INSERT INTO public.category_books VALUES (421, 421, 51);
INSERT INTO public.category_books VALUES (422, 422, 51);
INSERT INTO public.category_books VALUES (423, 423, 51);
INSERT INTO public.category_books VALUES (424, 424, 51);
INSERT INTO public.category_books VALUES (425, 425, 51);
INSERT INTO public.category_books VALUES (426, 426, 51);
INSERT INTO public.category_books VALUES (427, 427, 51);
INSERT INTO public.category_books VALUES (428, 428, 52);
INSERT INTO public.category_books VALUES (429, 429, 52);
INSERT INTO public.category_books VALUES (430, 430, 52);
INSERT INTO public.category_books VALUES (431, 431, 52);
INSERT INTO public.category_books VALUES (432, 432, 52);
INSERT INTO public.category_books VALUES (433, 433, 52);
INSERT INTO public.category_books VALUES (434, 434, 52);
INSERT INTO public.category_books VALUES (435, 435, 52);
INSERT INTO public.category_books VALUES (436, 436, 53);
INSERT INTO public.category_books VALUES (437, 437, 53);
INSERT INTO public.category_books VALUES (438, 438, 53);
INSERT INTO public.category_books VALUES (439, 439, 53);
INSERT INTO public.category_books VALUES (440, 440, 53);
INSERT INTO public.category_books VALUES (441, 441, 53);
INSERT INTO public.category_books VALUES (442, 442, 53);
INSERT INTO public.category_books VALUES (443, 443, 54);
INSERT INTO public.category_books VALUES (444, 444, 54);
INSERT INTO public.category_books VALUES (445, 445, 55);
INSERT INTO public.category_books VALUES (446, 446, 55);
INSERT INTO public.category_books VALUES (447, 447, 55);
INSERT INTO public.category_books VALUES (448, 448, 55);
INSERT INTO public.category_books VALUES (449, 449, 55);
INSERT INTO public.category_books VALUES (450, 450, 55);
INSERT INTO public.category_books VALUES (451, 451, 55);
INSERT INTO public.category_books VALUES (452, 452, 55);
INSERT INTO public.category_books VALUES (453, 453, 55);
INSERT INTO public.category_books VALUES (454, 454, 55);
INSERT INTO public.category_books VALUES (455, 455, 55);
INSERT INTO public.category_books VALUES (456, 456, 55);
INSERT INTO public.category_books VALUES (457, 457, 55);
INSERT INTO public.category_books VALUES (458, 458, 55);
INSERT INTO public.category_books VALUES (459, 459, 56);
INSERT INTO public.category_books VALUES (460, 460, 56);
INSERT INTO public.category_books VALUES (461, 461, 56);
INSERT INTO public.category_books VALUES (462, 462, 56);
INSERT INTO public.category_books VALUES (463, 463, 56);
INSERT INTO public.category_books VALUES (464, 464, 56);
INSERT INTO public.category_books VALUES (465, 465, 56);
INSERT INTO public.category_books VALUES (466, 466, 56);
INSERT INTO public.category_books VALUES (467, 467, 56);
INSERT INTO public.category_books VALUES (468, 468, 56);
INSERT INTO public.category_books VALUES (469, 469, 57);
INSERT INTO public.category_books VALUES (470, 470, 57);
INSERT INTO public.category_books VALUES (471, 471, 57);
INSERT INTO public.category_books VALUES (472, 472, 57);
INSERT INTO public.category_books VALUES (473, 473, 57);
INSERT INTO public.category_books VALUES (474, 474, 57);
INSERT INTO public.category_books VALUES (475, 475, 57);
INSERT INTO public.category_books VALUES (476, 476, 57);
INSERT INTO public.category_books VALUES (477, 477, 57);
INSERT INTO public.category_books VALUES (478, 478, 57);
INSERT INTO public.category_books VALUES (479, 479, 57);
INSERT INTO public.category_books VALUES (480, 480, 57);
INSERT INTO public.category_books VALUES (481, 481, 57);
INSERT INTO public.category_books VALUES (482, 482, 57);
INSERT INTO public.category_books VALUES (483, 483, 57);
INSERT INTO public.category_books VALUES (484, 484, 57);
INSERT INTO public.category_books VALUES (485, 485, 57);
INSERT INTO public.category_books VALUES (486, 486, 57);
INSERT INTO public.category_books VALUES (487, 487, 57);
INSERT INTO public.category_books VALUES (488, 488, 57);
INSERT INTO public.category_books VALUES (489, 489, 57);
INSERT INTO public.category_books VALUES (490, 490, 57);
INSERT INTO public.category_books VALUES (491, 491, 57);
INSERT INTO public.category_books VALUES (492, 492, 58);
INSERT INTO public.category_books VALUES (493, 493, 58);
INSERT INTO public.category_books VALUES (494, 494, 58);
INSERT INTO public.category_books VALUES (495, 495, 58);
INSERT INTO public.category_books VALUES (496, 496, 58);
INSERT INTO public.category_books VALUES (497, 497, 58);
INSERT INTO public.category_books VALUES (498, 498, 59);
INSERT INTO public.category_books VALUES (499, 499, 59);
INSERT INTO public.category_books VALUES (500, 500, 59);
INSERT INTO public.category_books VALUES (501, 501, 59);
INSERT INTO public.category_books VALUES (502, 502, 59);
INSERT INTO public.category_books VALUES (503, 503, 59);
INSERT INTO public.category_books VALUES (504, 504, 59);
INSERT INTO public.category_books VALUES (505, 505, 59);
INSERT INTO public.category_books VALUES (506, 506, 59);
INSERT INTO public.category_books VALUES (507, 507, 59);
INSERT INTO public.category_books VALUES (508, 508, 59);
INSERT INTO public.category_books VALUES (509, 509, 59);
INSERT INTO public.category_books VALUES (510, 510, 59);
INSERT INTO public.category_books VALUES (511, 511, 59);
INSERT INTO public.category_books VALUES (512, 512, 60);
INSERT INTO public.category_books VALUES (513, 513, 60);
INSERT INTO public.category_books VALUES (514, 514, 60);
INSERT INTO public.category_books VALUES (515, 515, 60);
INSERT INTO public.category_books VALUES (516, 516, 60);
INSERT INTO public.category_books VALUES (517, 517, 60);
INSERT INTO public.category_books VALUES (518, 518, 61);
INSERT INTO public.category_books VALUES (519, 519, 61);
INSERT INTO public.category_books VALUES (520, 520, 61);
INSERT INTO public.category_books VALUES (521, 521, 61);
INSERT INTO public.category_books VALUES (522, 522, 61);
INSERT INTO public.category_books VALUES (523, 523, 62);
INSERT INTO public.category_books VALUES (524, 524, 62);
INSERT INTO public.category_books VALUES (525, 525, 62);
INSERT INTO public.category_books VALUES (526, 526, 62);
INSERT INTO public.category_books VALUES (527, 527, 62);
INSERT INTO public.category_books VALUES (528, 528, 62);
INSERT INTO public.category_books VALUES (529, 529, 62);
INSERT INTO public.category_books VALUES (530, 530, 62);
INSERT INTO public.category_books VALUES (531, 531, 62);
INSERT INTO public.category_books VALUES (532, 532, 62);
INSERT INTO public.category_books VALUES (533, 533, 63);
INSERT INTO public.category_books VALUES (534, 534, 63);
INSERT INTO public.category_books VALUES (535, 535, 65);
INSERT INTO public.category_books VALUES (536, 536, 65);
INSERT INTO public.category_books VALUES (537, 537, 65);
INSERT INTO public.category_books VALUES (538, 538, 65);
INSERT INTO public.category_books VALUES (539, 539, 65);
INSERT INTO public.category_books VALUES (540, 540, 66);
INSERT INTO public.category_books VALUES (541, 541, 66);
INSERT INTO public.category_books VALUES (542, 542, 66);
INSERT INTO public.category_books VALUES (543, 543, 66);
INSERT INTO public.category_books VALUES (544, 544, 66);
INSERT INTO public.category_books VALUES (545, 545, 66);
INSERT INTO public.category_books VALUES (546, 546, 66);
INSERT INTO public.category_books VALUES (547, 547, 66);
INSERT INTO public.category_books VALUES (548, 548, 66);
INSERT INTO public.category_books VALUES (549, 549, 66);
INSERT INTO public.category_books VALUES (550, 550, 66);
INSERT INTO public.category_books VALUES (551, 551, 66);
INSERT INTO public.category_books VALUES (552, 552, 66);
INSERT INTO public.category_books VALUES (553, 553, 67);
INSERT INTO public.category_books VALUES (554, 554, 67);
INSERT INTO public.category_books VALUES (555, 555, 67);
INSERT INTO public.category_books VALUES (556, 556, 67);
INSERT INTO public.category_books VALUES (557, 557, 67);
INSERT INTO public.category_books VALUES (558, 558, 67);
INSERT INTO public.category_books VALUES (559, 559, 67);
INSERT INTO public.category_books VALUES (560, 560, 67);
INSERT INTO public.category_books VALUES (561, 561, 67);
INSERT INTO public.category_books VALUES (562, 562, 67);
INSERT INTO public.category_books VALUES (563, 563, 67);
INSERT INTO public.category_books VALUES (564, 564, 68);
INSERT INTO public.category_books VALUES (565, 565, 68);
INSERT INTO public.category_books VALUES (566, 566, 68);
INSERT INTO public.category_books VALUES (567, 567, 68);
INSERT INTO public.category_books VALUES (568, 568, 68);
INSERT INTO public.category_books VALUES (569, 569, 68);
INSERT INTO public.category_books VALUES (570, 570, 68);
INSERT INTO public.category_books VALUES (571, 571, 68);
INSERT INTO public.category_books VALUES (572, 572, 68);
INSERT INTO public.category_books VALUES (573, 573, 68);
INSERT INTO public.category_books VALUES (574, 574, 68);
INSERT INTO public.category_books VALUES (575, 575, 68);
INSERT INTO public.category_books VALUES (576, 576, 68);
INSERT INTO public.category_books VALUES (577, 577, 68);
INSERT INTO public.category_books VALUES (578, 578, 68);
INSERT INTO public.category_books VALUES (579, 579, 68);
INSERT INTO public.category_books VALUES (580, 580, 68);
INSERT INTO public.category_books VALUES (581, 581, 70);
INSERT INTO public.category_books VALUES (582, 582, 71);
INSERT INTO public.category_books VALUES (583, 583, 71);
INSERT INTO public.category_books VALUES (584, 584, 71);
INSERT INTO public.category_books VALUES (585, 585, 71);
INSERT INTO public.category_books VALUES (586, 586, 71);
INSERT INTO public.category_books VALUES (587, 587, 73);
INSERT INTO public.category_books VALUES (588, 588, 73);
INSERT INTO public.category_books VALUES (589, 589, 73);
INSERT INTO public.category_books VALUES (590, 590, 74);
INSERT INTO public.category_books VALUES (591, 591, 74);
INSERT INTO public.category_books VALUES (592, 592, 74);
INSERT INTO public.category_books VALUES (593, 593, 76);
INSERT INTO public.category_books VALUES (594, 594, 76);
INSERT INTO public.category_books VALUES (595, 595, 76);
INSERT INTO public.category_books VALUES (596, 596, 76);
INSERT INTO public.category_books VALUES (597, 597, 76);
INSERT INTO public.category_books VALUES (598, 598, 76);
INSERT INTO public.category_books VALUES (599, 599, 77);
INSERT INTO public.category_books VALUES (600, 600, 77);
INSERT INTO public.category_books VALUES (601, 601, 78);
INSERT INTO public.category_books VALUES (602, 602, 78);
INSERT INTO public.category_books VALUES (603, 603, 79);
INSERT INTO public.category_books VALUES (604, 604, 79);
INSERT INTO public.category_books VALUES (605, 605, 79);
INSERT INTO public.category_books VALUES (606, 606, 79);
INSERT INTO public.category_books VALUES (607, 607, 79);
INSERT INTO public.category_books VALUES (608, 608, 80);
INSERT INTO public.category_books VALUES (609, 609, 80);
INSERT INTO public.category_books VALUES (610, 610, 81);
INSERT INTO public.category_books VALUES (611, 611, 81);
INSERT INTO public.category_books VALUES (612, 612, 82);
INSERT INTO public.category_books VALUES (613, 613, 82);
INSERT INTO public.category_books VALUES (614, 614, 83);
INSERT INTO public.category_books VALUES (615, 615, 83);
INSERT INTO public.category_books VALUES (616, 616, 83);
INSERT INTO public.category_books VALUES (617, 617, 84);
INSERT INTO public.category_books VALUES (618, 618, 84);
INSERT INTO public.category_books VALUES (619, 619, 84);
INSERT INTO public.category_books VALUES (620, 620, 84);
INSERT INTO public.category_books VALUES (621, 621, 85);
INSERT INTO public.category_books VALUES (622, 622, 85);
INSERT INTO public.category_books VALUES (623, 623, 85);
INSERT INTO public.category_books VALUES (624, 624, 85);
INSERT INTO public.category_books VALUES (625, 625, 85);
INSERT INTO public.category_books VALUES (626, 626, 85);
INSERT INTO public.category_books VALUES (627, 627, 86);
INSERT INTO public.category_books VALUES (628, 628, 86);
INSERT INTO public.category_books VALUES (629, 629, 86);
INSERT INTO public.category_books VALUES (630, 630, 86);
INSERT INTO public.category_books VALUES (631, 631, 86);
INSERT INTO public.category_books VALUES (632, 632, 87);
INSERT INTO public.category_books VALUES (633, 633, 87);
INSERT INTO public.category_books VALUES (634, 634, 88);
INSERT INTO public.category_books VALUES (635, 635, 88);
INSERT INTO public.category_books VALUES (636, 636, 88);
INSERT INTO public.category_books VALUES (637, 637, 88);
INSERT INTO public.category_books VALUES (638, 638, 88);
INSERT INTO public.category_books VALUES (639, 639, 88);
INSERT INTO public.category_books VALUES (640, 640, 89);
INSERT INTO public.category_books VALUES (641, 641, 89);
INSERT INTO public.category_books VALUES (642, 642, 89);
INSERT INTO public.category_books VALUES (643, 643, 89);
INSERT INTO public.category_books VALUES (644, 644, 90);
INSERT INTO public.category_books VALUES (645, 645, 90);
INSERT INTO public.category_books VALUES (646, 646, 90);
INSERT INTO public.category_books VALUES (647, 647, 91);
INSERT INTO public.category_books VALUES (648, 648, 94);
INSERT INTO public.category_books VALUES (649, 649, 95);
INSERT INTO public.category_books VALUES (650, 650, 95);
INSERT INTO public.category_books VALUES (651, 651, 95);
INSERT INTO public.category_books VALUES (652, 652, 95);
INSERT INTO public.category_books VALUES (653, 653, 95);
INSERT INTO public.category_books VALUES (654, 654, 95);
INSERT INTO public.category_books VALUES (655, 655, 96);
INSERT INTO public.category_books VALUES (656, 656, 96);
INSERT INTO public.category_books VALUES (657, 657, 96);
INSERT INTO public.category_books VALUES (658, 658, 96);
INSERT INTO public.category_books VALUES (659, 659, 96);
INSERT INTO public.category_books VALUES (660, 660, 96);
INSERT INTO public.category_books VALUES (661, 661, 96);
INSERT INTO public.category_books VALUES (662, 662, 96);
INSERT INTO public.category_books VALUES (663, 663, 96);
INSERT INTO public.category_books VALUES (664, 664, 96);
INSERT INTO public.category_books VALUES (665, 665, 97);
INSERT INTO public.category_books VALUES (666, 666, 97);
INSERT INTO public.category_books VALUES (667, 667, 97);
INSERT INTO public.category_books VALUES (668, 668, 97);
INSERT INTO public.category_books VALUES (669, 669, 97);
INSERT INTO public.category_books VALUES (670, 670, 97);
INSERT INTO public.category_books VALUES (671, 671, 97);
INSERT INTO public.category_books VALUES (672, 672, 98);
INSERT INTO public.category_books VALUES (673, 673, 98);
INSERT INTO public.category_books VALUES (674, 674, 98);
INSERT INTO public.category_books VALUES (675, 675, 99);
INSERT INTO public.category_books VALUES (676, 676, 99);
INSERT INTO public.category_books VALUES (677, 677, 99);
INSERT INTO public.category_books VALUES (678, 678, 99);
INSERT INTO public.category_books VALUES (679, 679, 100);
INSERT INTO public.category_books VALUES (680, 680, 100);
INSERT INTO public.category_books VALUES (681, 681, 100);
INSERT INTO public.category_books VALUES (682, 682, 100);
INSERT INTO public.category_books VALUES (683, 683, 100);
INSERT INTO public.category_books VALUES (684, 684, 100);


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 198
-- Name: author_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.author_books_id_seq', 132, true);


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 200
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 132, true);


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 196
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 101, true);


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 202
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 684, true);


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 204
-- Name: category_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_books_id_seq', 684, true);


--
-- TOC entry 2775 (class 2606 OID 16635)
-- Name: author_books author_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_books
    ADD CONSTRAINT author_books_pkey PRIMARY KEY (id);


--
-- TOC entry 2779 (class 2606 OID 16651)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- TOC entry 2771 (class 2606 OID 16611)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 2782 (class 2606 OID 16659)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2784 (class 2606 OID 16667)
-- Name: category_books category_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_books
    ADD CONSTRAINT category_books_pkey PRIMARY KEY (id);


--
-- TOC entry 2773 (class 1259 OID 16668)
-- Name: ab_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ab_idx ON public.author_books USING btree (author_id, book_id);


--
-- TOC entry 2776 (class 1259 OID 16669)
-- Name: author_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX author_idx ON public.author_books USING btree (author_id);


--
-- TOC entry 2777 (class 1259 OID 16670)
-- Name: book_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX book_idx ON public.author_books USING btree (book_id);


--
-- TOC entry 2780 (class 1259 OID 16671)
-- Name: name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX name_idx ON public.authors USING btree (name text_pattern_ops);


--
-- TOC entry 2772 (class 1259 OID 16672)
-- Name: title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX title_idx ON public.books USING btree (title text_pattern_ops);


-- Completed on 2019-08-09 04:57:37 UTC

--
-- PostgreSQL database dump complete
--

