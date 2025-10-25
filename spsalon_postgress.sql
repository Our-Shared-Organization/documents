--
-- PostgreSQL database dump
--

\restrict GX29AsyAgg24B8PtyLi86gx7UuSkscaXGhuUbfd5RMiMU6wtcfDPhu1DSQsjlgm

-- Dumped from database version 17.5 (6bc9ef8)
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS user_role_roleid_fk;
ALTER TABLE IF EXISTS ONLY public.service DROP CONSTRAINT IF EXISTS service_category_categoryid_fk;
ALTER TABLE IF EXISTS ONLY public.rating DROP CONSTRAINT IF EXISTS rating_user_userlogin_fk_2;
ALTER TABLE IF EXISTS ONLY public.rating DROP CONSTRAINT IF EXISTS rating_user_userlogin_fk;
ALTER TABLE IF EXISTS ONLY public.master_category DROP CONSTRAINT IF EXISTS master_category_user_userlogin_fk;
ALTER TABLE IF EXISTS ONLY public.master_category DROP CONSTRAINT IF EXISTS master_category_category_categoryid_fk;
ALTER TABLE IF EXISTS ONLY public.booking DROP CONSTRAINT IF EXISTS booking_user_userlogin_fk_2;
ALTER TABLE IF EXISTS ONLY public.booking DROP CONSTRAINT IF EXISTS booking_user_userlogin_fk;
ALTER TABLE IF EXISTS ONLY public.booking DROP CONSTRAINT IF EXISTS booking_service_serviceid_fk;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS user_pk;
ALTER TABLE IF EXISTS ONLY public.service DROP CONSTRAINT IF EXISTS service_pk;
ALTER TABLE IF EXISTS ONLY public.role DROP CONSTRAINT IF EXISTS role_pk;
ALTER TABLE IF EXISTS ONLY public.rating DROP CONSTRAINT IF EXISTS rating_pk;
ALTER TABLE IF EXISTS ONLY public.master_category DROP CONSTRAINT IF EXISTS master_category_pk;
ALTER TABLE IF EXISTS ONLY public.category DROP CONSTRAINT IF EXISTS category_pk;
ALTER TABLE IF EXISTS ONLY public.booking DROP CONSTRAINT IF EXISTS booking_pk;
ALTER TABLE IF EXISTS public.service ALTER COLUMN serviceid DROP DEFAULT;
ALTER TABLE IF EXISTS public.role ALTER COLUMN roleid DROP DEFAULT;
ALTER TABLE IF EXISTS public.rating ALTER COLUMN ratingid DROP DEFAULT;
ALTER TABLE IF EXISTS public.master_category ALTER COLUMN mcid DROP DEFAULT;
ALTER TABLE IF EXISTS public.category ALTER COLUMN categoryid DROP DEFAULT;
DROP TABLE IF EXISTS public."user";
DROP SEQUENCE IF EXISTS public.service_serviceid_seq;
DROP TABLE IF EXISTS public.service;
DROP SEQUENCE IF EXISTS public.role_roleid_seq;
DROP TABLE IF EXISTS public.role;
DROP SEQUENCE IF EXISTS public.rating_ratingid_seq;
DROP TABLE IF EXISTS public.rating;
DROP SEQUENCE IF EXISTS public.master_service_msid_seq;
DROP TABLE IF EXISTS public.master_category;
DROP SEQUENCE IF EXISTS public.category_categoryid_seq;
DROP TABLE IF EXISTS public.category;
DROP TABLE IF EXISTS public.booking;
DROP TYPE IF EXISTS public.usersex;
DROP TYPE IF EXISTS public.bookingstatus;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: bookingstatus; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.bookingstatus AS ENUM (
    'booked',
    'confirmed',
    'executing',
    'finished',
    'canceled'
);


ALTER TYPE public.bookingstatus OWNER TO neondb_owner;

--
-- Name: usersex; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.usersex AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.usersex OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.booking (
    bookingid integer NOT NULL,
    bookinguserlogin character varying(45),
    bookingserviceid integer,
    bookingmasterlogin character varying(45),
    bookingstart timestamp without time zone NOT NULL,
    bookingfinish timestamp without time zone,
    bookingstatus public.bookingstatus NOT NULL,
    bookingbookedat timestamp without time zone NOT NULL
);


ALTER TABLE public.booking OWNER TO neondb_owner;

--
-- Name: category; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.category (
    categoryid integer NOT NULL,
    categoryname character varying(255) NOT NULL,
    categorydescription text,
    categorystatus boolean DEFAULT true NOT NULL
);


ALTER TABLE public.category OWNER TO neondb_owner;

--
-- Name: category_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.category_categoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_categoryid_seq OWNER TO neondb_owner;

--
-- Name: category_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.category_categoryid_seq OWNED BY public.category.categoryid;


--
-- Name: master_category; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.master_category (
    mcid integer NOT NULL,
    mcmasterlogin character varying(45) NOT NULL,
    mccategoryid integer NOT NULL
);


ALTER TABLE public.master_category OWNER TO neondb_owner;

--
-- Name: master_service_msid_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.master_service_msid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.master_service_msid_seq OWNER TO neondb_owner;

--
-- Name: master_service_msid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.master_service_msid_seq OWNED BY public.master_category.mcid;


--
-- Name: rating; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.rating (
    ratingid integer NOT NULL,
    ratinguserlogin character varying(45) NOT NULL,
    ratingmasterlogin character varying(45) NOT NULL,
    ratingtext text NOT NULL,
    ratingstars integer DEFAULT 5 NOT NULL
);


ALTER TABLE public.rating OWNER TO neondb_owner;

--
-- Name: rating_ratingid_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.rating_ratingid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rating_ratingid_seq OWNER TO neondb_owner;

--
-- Name: rating_ratingid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.rating_ratingid_seq OWNED BY public.rating.ratingid;


--
-- Name: role; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.role (
    roleid integer NOT NULL,
    rolename character varying(255) NOT NULL
);


ALTER TABLE public.role OWNER TO neondb_owner;

--
-- Name: role_roleid_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.role_roleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_roleid_seq OWNER TO neondb_owner;

--
-- Name: role_roleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.role_roleid_seq OWNED BY public.role.roleid;


--
-- Name: service; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.service (
    serviceid integer NOT NULL,
    servicename character varying(255) NOT NULL,
    servicedescription text,
    serviceduration integer DEFAULT 0 NOT NULL,
    serviceprice numeric(5,2) DEFAULT 0 NOT NULL,
    servicecategoryid integer NOT NULL,
    servicestatus boolean DEFAULT true NOT NULL
);


ALTER TABLE public.service OWNER TO neondb_owner;

--
-- Name: service_serviceid_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.service_serviceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_serviceid_seq OWNER TO neondb_owner;

--
-- Name: service_serviceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.service_serviceid_seq OWNED BY public.service.serviceid;


--
-- Name: user; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public."user" (
    userlogin character varying(45) NOT NULL,
    username character varying(255) NOT NULL,
    usersurname character varying(255) NOT NULL,
    userphone character varying(12) NOT NULL,
    usersex public.usersex NOT NULL,
    userroleid integer DEFAULT 1 NOT NULL,
    userpassword text NOT NULL,
    userstatus boolean DEFAULT true NOT NULL
);


ALTER TABLE public."user" OWNER TO neondb_owner;

--
-- Name: category categoryid; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.category ALTER COLUMN categoryid SET DEFAULT nextval('public.category_categoryid_seq'::regclass);


--
-- Name: master_category mcid; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.master_category ALTER COLUMN mcid SET DEFAULT nextval('public.master_service_msid_seq'::regclass);


--
-- Name: rating ratingid; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.rating ALTER COLUMN ratingid SET DEFAULT nextval('public.rating_ratingid_seq'::regclass);


--
-- Name: role roleid; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.role ALTER COLUMN roleid SET DEFAULT nextval('public.role_roleid_seq'::regclass);


--
-- Name: service serviceid; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service ALTER COLUMN serviceid SET DEFAULT nextval('public.service_serviceid_seq'::regclass);


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.booking (bookingid, bookinguserlogin, bookingserviceid, bookingmasterlogin, bookingstart, bookingfinish, bookingstatus, bookingbookedat) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.category (categoryid, categoryname, categorydescription, categorystatus) FROM stdin;
\.


--
-- Data for Name: master_category; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.master_category (mcid, mcmasterlogin, mccategoryid) FROM stdin;
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.rating (ratingid, ratinguserlogin, ratingmasterlogin, ratingtext, ratingstars) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.role (roleid, rolename) FROM stdin;
1	user
2	master
3	manager
\.


--
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.service (serviceid, servicename, servicedescription, serviceduration, serviceprice, servicecategoryid, servicestatus) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public."user" (userlogin, username, usersurname, userphone, usersex, userroleid, userpassword, userstatus) FROM stdin;
testlogin	test	test	test	male	1	123	t
\.


--
-- Name: category_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.category_categoryid_seq', 1, false);


--
-- Name: master_service_msid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.master_service_msid_seq', 1, false);


--
-- Name: rating_ratingid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.rating_ratingid_seq', 1, false);


--
-- Name: role_roleid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.role_roleid_seq', 1, true);


--
-- Name: service_serviceid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.service_serviceid_seq', 1, false);


--
-- Name: booking booking_pk; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pk PRIMARY KEY (bookingid);


--
-- Name: category category_pk; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (categoryid);


--
-- Name: master_category master_category_pk; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.master_category
    ADD CONSTRAINT master_category_pk PRIMARY KEY (mcid);


--
-- Name: rating rating_pk; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pk PRIMARY KEY (ratingid);


--
-- Name: role role_pk; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pk PRIMARY KEY (roleid);


--
-- Name: service service_pk; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pk PRIMARY KEY (serviceid);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (userlogin);


--
-- Name: booking booking_service_serviceid_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_service_serviceid_fk FOREIGN KEY (bookingserviceid) REFERENCES public.service(serviceid) ON UPDATE CASCADE;


--
-- Name: booking booking_user_userlogin_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_userlogin_fk FOREIGN KEY (bookinguserlogin) REFERENCES public."user"(userlogin) ON UPDATE CASCADE;


--
-- Name: booking booking_user_userlogin_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_userlogin_fk_2 FOREIGN KEY (bookinguserlogin) REFERENCES public."user"(userlogin) ON UPDATE CASCADE;


--
-- Name: master_category master_category_category_categoryid_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.master_category
    ADD CONSTRAINT master_category_category_categoryid_fk FOREIGN KEY (mccategoryid) REFERENCES public.category(categoryid) ON UPDATE CASCADE;


--
-- Name: master_category master_category_user_userlogin_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.master_category
    ADD CONSTRAINT master_category_user_userlogin_fk FOREIGN KEY (mcmasterlogin) REFERENCES public."user"(userlogin) ON UPDATE CASCADE;


--
-- Name: rating rating_user_userlogin_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_user_userlogin_fk FOREIGN KEY (ratinguserlogin) REFERENCES public."user"(userlogin) ON UPDATE CASCADE;


--
-- Name: rating rating_user_userlogin_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_user_userlogin_fk_2 FOREIGN KEY (ratingmasterlogin) REFERENCES public."user"(userlogin) ON UPDATE CASCADE;


--
-- Name: service service_category_categoryid_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_category_categoryid_fk FOREIGN KEY (servicecategoryid) REFERENCES public.category(categoryid) ON UPDATE CASCADE;


--
-- Name: user user_role_roleid_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_role_roleid_fk FOREIGN KEY (userroleid) REFERENCES public.role(roleid) ON UPDATE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict GX29AsyAgg24B8PtyLi86gx7UuSkscaXGhuUbfd5RMiMU6wtcfDPhu1DSQsjlgm

