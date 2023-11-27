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
-- Name: fastf1_dwh; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE fastf1_dwh WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Dutch_Netherlands.1252';


ALTER DATABASE fastf1_dwh OWNER TO postgres;

\connect fastf1_dwh

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
-- Name: sp_fact_lapspeeds_add_fk_constraints(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_fact_lapspeeds_add_fk_constraints()
    LANGUAGE plpgsql
    AS $$
BEGIN
	ALTER TABLE fact_lapspeeds ADD CONSTRAINT fk_racedateid FOREIGN KEY (racedateid) REFERENCES dim_date(id) ON DELETE CASCADE;
	ALTER TABLE fact_lapspeeds ADD CONSTRAINT fk_raceid FOREIGN KEY (raceid) REFERENCES dim_race(id) ON DELETE CASCADE;
	ALTER TABLE fact_lapspeeds ADD CONSTRAINT fk_teamid FOREIGN KEY (teamid) REFERENCES dim_team(id) ON DELETE CASCADE;
	ALTER TABLE fact_lapspeeds ADD CONSTRAINT fk_driverid FOREIGN KEY (driverid) REFERENCES dim_driver(id) ON DELETE CASCADE;
	ALTER TABLE fact_lapspeeds ADD CONSTRAINT fk_stintid FOREIGN KEY (stintid) REFERENCES dim_stint(id) ON DELETE CASCADE;
	ALTER TABLE fact_lapspeeds ADD CONSTRAINT fk_positionid FOREIGN KEY (positionid) REFERENCES dim_position(id) ON DELETE CASCADE;
	ALTER TABLE fact_lapspeeds ADD CONSTRAINT fk_lapid FOREIGN KEY (lapid) REFERENCES dim_lap(id) ON DELETE CASCADE;
	
	
END; 
$$;


ALTER PROCEDURE public.sp_fact_lapspeeds_add_fk_constraints() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_date (
    id integer NOT NULL,
    date_ timestamp without time zone,
    datename text,
    weekdaynumber integer,
    monthdaynumber integer,
    weekid integer,
    weeknumber integer,
    weekname_short text,
    weekname_long text,
    weekyearname_short text,
    weekyearname_long text,
    monthid integer,
    monthnumber integer,
    monthname_short text,
    monthname_long text,
    monthyear_short text,
    monthyear_long text,
    quarterid integer,
    quarternumber integer,
    quartername_short text,
    quartername_long text,
    yearnumber integer,
    yearname_short text,
    weekdayname_short text,
    weekdayname_long text,
    holidayname text,
    isholiday integer,
    isworkingday integer,
    workingdayid integer
);


ALTER TABLE public.dim_date OWNER TO postgres;

--
-- Name: dim_driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_driver (
    id double precision NOT NULL,
    code character varying(3),
    driverid character varying(50),
    permanentnumber bigint,
    url character varying(100),
    givenname character varying(20),
    familyname character varying(100),
    dateofbirth timestamp without time zone,
    nationality character varying(13)
);


ALTER TABLE public.dim_driver OWNER TO postgres;

--
-- Name: dim_lap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_lap (
    id smallint NOT NULL,
    lapname text
);


ALTER TABLE public.dim_lap OWNER TO postgres;

--
-- Name: dim_position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_position (
    id integer NOT NULL,
    "position" smallint,
    positionname text
);


ALTER TABLE public.dim_position OWNER TO postgres;

--
-- Name: dim_race; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_race (
    racename character varying(100),
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
    racename_short text,
    id double precision NOT NULL
);


ALTER TABLE public.dim_race OWNER TO postgres;

--
-- Name: dim_stint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_stint (
    stint smallint,
    id double precision NOT NULL,
    stintname text
);


ALTER TABLE public.dim_stint OWNER TO postgres;

--
-- Name: dim_team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_team (
    id integer NOT NULL,
    teamname character varying(50)
);


ALTER TABLE public.dim_team OWNER TO postgres;

--
-- Name: fact_lapspeeds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_lapspeeds (
    id integer NOT NULL,
    racedateid integer,
    raceid integer,
    teamid integer,
    driverid integer,
    stintid integer,
    positionid integer,
    lapid integer,
    tyrelife smallint,
    laptime_seconds numeric(22,6),
    avgspeed_lap_kmh numeric(46,14),
    avgspeed_race_kmh numeric(46,14),
    "position" integer
);


ALTER TABLE public.fact_lapspeeds OWNER TO postgres;

--
-- Name: dim_date dim_date_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_date
    ADD CONSTRAINT dim_date_pkey PRIMARY KEY (id);


--
-- Name: dim_driver dim_driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_driver
    ADD CONSTRAINT dim_driver_pkey PRIMARY KEY (id);


--
-- Name: dim_lap dim_lap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_lap
    ADD CONSTRAINT dim_lap_pkey PRIMARY KEY (id);


--
-- Name: dim_position dim_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_position
    ADD CONSTRAINT dim_position_pkey PRIMARY KEY (id);


--
-- Name: dim_race dim_race_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_race
    ADD CONSTRAINT dim_race_pkey PRIMARY KEY (id);


--
-- Name: dim_stint dim_stint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_stint
    ADD CONSTRAINT dim_stint_pkey PRIMARY KEY (id);


--
-- Name: dim_team dim_team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_team
    ADD CONSTRAINT dim_team_pkey PRIMARY KEY (id);


--
-- Name: fact_lapspeeds fact_lapspeeds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fact_lapspeeds_pkey PRIMARY KEY (id);


--
-- Name: fact_lapspeeds fk_driverid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fk_driverid FOREIGN KEY (driverid) REFERENCES public.dim_driver(id) ON DELETE CASCADE;


--
-- Name: fact_lapspeeds fk_lapid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fk_lapid FOREIGN KEY (lapid) REFERENCES public.dim_lap(id) ON DELETE CASCADE;


--
-- Name: fact_lapspeeds fk_positionid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fk_positionid FOREIGN KEY (positionid) REFERENCES public.dim_position(id) ON DELETE CASCADE;


--
-- Name: fact_lapspeeds fk_racedateid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fk_racedateid FOREIGN KEY (racedateid) REFERENCES public.dim_date(id) ON DELETE CASCADE;


--
-- Name: fact_lapspeeds fk_raceid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fk_raceid FOREIGN KEY (raceid) REFERENCES public.dim_race(id) ON DELETE CASCADE;


--
-- Name: fact_lapspeeds fk_stintid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fk_stintid FOREIGN KEY (stintid) REFERENCES public.dim_stint(id) ON DELETE CASCADE;


--
-- Name: fact_lapspeeds fk_teamid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_lapspeeds
    ADD CONSTRAINT fk_teamid FOREIGN KEY (teamid) REFERENCES public.dim_team(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

