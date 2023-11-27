--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

--
-- Name: fastf1_staging; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE fastf1_staging WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Dutch_Netherlands.1252';


ALTER DATABASE fastf1_staging OWNER TO postgres;

\connect fastf1_staging

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

SET default_table_access_method = heap;

--
-- Name: driverinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driverinfo (
    season bigint,
    permanentnumber bigint,
    code character varying(3),
    url character varying(100),
    dateofbirth timestamp without time zone,
    nationality character varying(13),
    familyname character varying(50),
    drivernumber bigint,
    driverid character varying(50),
    givenname character varying(20)
);


ALTER TABLE public.driverinfo OWNER TO postgres;

--
-- Name: lapspeeds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lapspeeds (
    racename character varying(100),
    racedate timestamp without time zone,
    driver character varying(3),
    lapnumber smallint,
    stint smallint,
    tyrelife smallint,
    "position" smallint,
    raceavgspeedkmh numeric(32,14),
    laptime numeric(16,6),
    drivernumber numeric(50,0),
    team character varying(50),
    lapavgspeedkmh numeric(32,14)
);


ALTER TABLE public.lapspeeds OWNER TO postgres;

--
-- Name: racecalendar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.racecalendar (
    index bigint,
    roundnumber bigint,
    country character varying(13),
    location character varying(17),
    eventdate timestamp without time zone,
    eventformat character varying(15),
    session1 character varying(10),
    session1date character varying(25),
    session1dateutc timestamp without time zone,
    session2 character varying(10),
    session2date character varying(25),
    session2dateutc timestamp without time zone,
    session3 character varying(15),
    session3date character varying(25),
    session3dateutc timestamp without time zone,
    session4 character varying(10),
    session4date character varying(25),
    session4dateutc timestamp without time zone,
    session5 character varying(4),
    session5date character varying(25),
    session5dateutc timestamp without time zone,
    f1apisupport boolean,
    officialeventname character varying(100),
    eventname character varying(100)
);


ALTER TABLE public.racecalendar OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

