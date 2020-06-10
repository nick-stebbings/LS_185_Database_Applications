--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7 (Debian 11.7-0+deb10u1)
-- Dumped by pg_dump version 11.7 (Debian 11.7-0+deb10u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: expenses; Type: TABLE; Schema: public; Owner: nickst757
--

CREATE TABLE public.expenses (
    id integer NOT NULL,
    amount numeric(6,2) NOT NULL,
    memo text NOT NULL,
    created_on date NOT NULL,
    CONSTRAINT positive_amount CHECK ((amount > (0)::numeric))
);


ALTER TABLE public.expenses OWNER TO nickst757;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: nickst757
--

CREATE SEQUENCE public.expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expenses_id_seq OWNER TO nickst757;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nickst757
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: nickst757
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: nickst757
--

COPY public.expenses (id, amount, memo, created_on) FROM stdin;
6	14.56	Pencils	2020-06-10
7	3.29	Coffee	2020-06-10
8	49.99	Text Editor	2020-06-10
9	4.00	coffee	2020-06-10
10	4.00	Gas for karen's car	2020-06-10
\.


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nickst757
--

SELECT pg_catalog.setval('public.expenses_id_seq', 10, true);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: nickst757
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

