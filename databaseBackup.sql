--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-06-29 19:26:16

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
-- TOC entry 3550 (class 1262 OID 81932)
-- Name: db_project_2023; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE db_project_2023 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Greek_Greece.1253';


ALTER DATABASE db_project_2023 OWNER TO postgres;

\connect db_project_2023

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
-- TOC entry 2 (class 3079 OID 81933)
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- TOC entry 277 (class 1255 OID 82190)
-- Name: check_duration_between_games(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_duration_between_games() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Games
        WHERE (home_team_id = NEW.home_team_id OR away_team_id = NEW.home_team_id) AND games_date >= (NEW.games_date - INTERVAL '10 days')
    ) THEN
        RAISE EXCEPTION 'The team must have each game at least 10 days after the previous one.';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_duration_between_games() OWNER TO postgres;

--
-- TOC entry 290 (class 1255 OID 90130)
-- Name: statistics_cursors(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.statistics_cursors()
    LANGUAGE plpgsql
    AS $$
DECLARE
  current_player_id INTEGER;
  current_team_id INTEGER;
  current_game_id INTEGER;
  current_start_date DATE := '2022-09-01';
  current_end_date DATE;
  current_stats RECORD;
  current_goals INTEGER;
  current_penalties INTEGER;
  current_red_cards INTEGER;
  current_yellow_cards INTEGER;
  current_active_time TIME;
  current_position VARCHAR(255);
  count INTEGER := 0;

  player_cursor CURSOR FOR SELECT DISTINCT player_id FROM PlayerGameStatistics ORDER BY player_id;
  team_cursor CURSOR (team_player_id INTEGER) FOR SELECT DISTINCT team_id FROM PlayerGameStatistics WHERE player_id = team_player_id ORDER BY team_id;
  game_cursor CURSOR (game_player_id INTEGER, game_team_id INTEGER) FOR SELECT DISTINCT PGS.game_id, games_date FROM PlayerGameStatistics PGS JOIN Games G ON PGS.game_id = G.game_id WHERE player_id = game_player_id AND PGS.team_id = game_team_id ORDER BY PGS.game_id;

BEGIN
  OPEN player_cursor;
  LOOP
    FETCH player_cursor INTO current_player_id;
    EXIT WHEN current_player_id IS NULL;

    OPEN team_cursor(current_player_id);
    LOOP
      FETCH team_cursor INTO current_team_id;
      EXIT WHEN current_team_id IS NULL;

      OPEN game_cursor(current_player_id, current_team_id);
      LOOP
        FETCH game_cursor INTO current_game_id, current_start_date;
        EXIT WHEN current_game_id IS NULL;

        current_end_date := current_start_date + INTERVAL '10 days';

        FOR current_stats IN (
          SELECT
            goals,
            penalties,
            red_cards,
            yellow_cards,
            active_time,
            position
          FROM PlayerGameStatistics PGS
            JOIN Players P ON PGS.player_id = P.player_id
          WHERE
            PGS.player_id = current_player_id AND
            PGS.team_id = current_team_id AND
            game_id IN (SELECT game_id FROM Games WHERE games_date >= current_start_date AND games_date < current_end_date)
          GROUP BY goals, penalties, red_cards, yellow_cards, active_time, position
        ) LOOP

          current_goals := current_stats.goals;
          current_penalties := current_stats.penalties;
          current_red_cards := current_stats.red_cards;
          current_yellow_cards := current_stats.yellow_cards;
          current_active_time := current_stats.active_time;
          current_position := current_stats.position;

          RAISE NOTICE 'Player: %, Team: %, Period: % - %', current_player_id, current_team_id, current_start_date, current_end_date;
          RAISE NOTICE 'Goals: %, Penalties: %, Red Cards: %, Yellow Cards: %, Active Time: %, Position: %', current_goals, current_penalties, current_red_cards, current_yellow_cards, current_active_time, current_position;

          count := count + 1;

          IF count = 10 THEN
            count := 0;
            EXIT WHEN NOT FOUND;
          END IF;
        END LOOP;
      END LOOP;
      CLOSE game_cursor;
    END LOOP;
    CLOSE team_cursor;
  END LOOP;
  CLOSE player_cursor;
END;
$$;


ALTER PROCEDURE public.statistics_cursors() OWNER TO postgres;

--
-- TOC entry 289 (class 1255 OID 82202)
-- Name: team_relegation(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.team_relegation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'RelegatedTeams') THEN
        CREATE TABLE RelegatedTeams (
            team_id SERIAL PRIMARY KEY,
            teams_name VARCHAR(255) NOT NULL, 
            home_field_name VARCHAR(255) NOT NULL,
            history_description TEXT,
            home_wins INTEGER NOT NULL,
            away_wins INTEGER NOT NULL,
            home_losses INTEGER NOT NULL,
            away_losses INTEGER NOT NULL,
            home_draws INTEGER NOT NULL,
            away_draws INTEGER NOT NULL
        );
    END IF;
    INSERT INTO RelegatedTeams (teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) 
    VALUES (OLD.teams_name, OLD.home_field_name, OLD.history_description, OLD.home_wins, OLD.away_wins, OLD.home_losses, OLD.away_losses, OLD.home_draws, OLD.away_draws);
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.team_relegation() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 82074)
-- Name: coaches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coaches (
    coach_id integer NOT NULL,
    player_id integer NOT NULL,
    coaching_role character varying(255) NOT NULL
);


ALTER TABLE public.coaches OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 82073)
-- Name: coaches_coach_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coaches_coach_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coaches_coach_id_seq OWNER TO postgres;

--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 219
-- Name: coaches_coach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coaches_coach_id_seq OWNED BY public.coaches.coach_id;


--
-- TOC entry 225 (class 1259 OID 82143)
-- Name: gameevents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gameevents (
    event_id integer NOT NULL,
    game_id integer NOT NULL,
    player_id integer NOT NULL,
    moment integer NOT NULL,
    event_type character varying(255) NOT NULL,
    CONSTRAINT gameevents_event_type_check CHECK ((upper((event_type)::text) = ANY (ARRAY['ΓΚΟΛ'::text, 'ΑΚΥΡΩΜΕΝΟ ΓΚΟΛ'::text, 'ΚΟΚΚΙΝΗ ΚΑΡΤΑ'::text, 'ΚΙΤΡΙΝΗ ΚΑΡΤΑ'::text, 'ΠΕΝΑΛΤΙ'::text, 'ΚΟΡΝΕΡ'::text])))
);


ALTER TABLE public.gameevents OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 82142)
-- Name: gameevents_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gameevents_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameevents_event_id_seq OWNER TO postgres;

--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 224
-- Name: gameevents_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gameevents_event_id_seq OWNED BY public.gameevents.event_id;


--
-- TOC entry 222 (class 1259 OID 82086)
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    home_team_id integer NOT NULL,
    away_team_id integer NOT NULL,
    home_teams_score integer DEFAULT 0 NOT NULL,
    away_teams_score integer DEFAULT 0 NOT NULL,
    games_date date NOT NULL,
    duration time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    CONSTRAINT games_away_teams_score_check CHECK ((away_teams_score >= 0)),
    CONSTRAINT games_home_teams_score_check CHECK ((home_teams_score >= 0))
);


ALTER TABLE public.games OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 82085)
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO postgres;

--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 221
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- TOC entry 223 (class 1259 OID 82109)
-- Name: playergamestatistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playergamestatistics (
    player_id integer NOT NULL,
    team_id integer NOT NULL,
    game_id integer NOT NULL,
    red_cards integer DEFAULT 0 NOT NULL,
    yellow_cards integer DEFAULT 0 NOT NULL,
    goals integer DEFAULT 0 NOT NULL,
    canceled_goals integer DEFAULT 0 NOT NULL,
    active_time time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    penalties integer DEFAULT 0 NOT NULL,
    corners integer DEFAULT 0 NOT NULL,
    CONSTRAINT playergamestatistics_canceled_goals_check CHECK ((canceled_goals >= 0)),
    CONSTRAINT playergamestatistics_corners_check CHECK ((corners >= 0)),
    CONSTRAINT playergamestatistics_goals_check CHECK ((goals >= 0)),
    CONSTRAINT playergamestatistics_penalties_check CHECK ((penalties >= 0)),
    CONSTRAINT playergamestatistics_red_cards_check CHECK ((red_cards >= 0)),
    CONSTRAINT playergamestatistics_yellow_cards_check CHECK ((yellow_cards >= 0))
);


ALTER TABLE public.playergamestatistics OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 82062)
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    players_name character varying(10) NOT NULL COLLATE pg_catalog."C",
    players_surname character varying(10) NOT NULL COLLATE pg_catalog."C",
    team_id integer,
    "position" character varying(255) NOT NULL
);


ALTER TABLE public.players OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 82039)
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    teams_name character varying(255) NOT NULL,
    home_field_name character varying(255) NOT NULL,
    history_description text,
    home_wins integer DEFAULT 0 NOT NULL,
    away_wins integer DEFAULT 0 NOT NULL,
    home_losses integer DEFAULT 0 NOT NULL,
    away_losses integer DEFAULT 0 NOT NULL,
    home_draws integer DEFAULT 0 NOT NULL,
    away_draws integer DEFAULT 0 NOT NULL,
    CONSTRAINT teams_away_draws_check CHECK ((away_draws >= 0)),
    CONSTRAINT teams_away_losses_check CHECK ((away_losses >= 0)),
    CONSTRAINT teams_away_wins_check CHECK ((away_wins >= 0)),
    CONSTRAINT teams_home_draws_check CHECK ((home_draws >= 0)),
    CONSTRAINT teams_home_losses_check CHECK ((home_losses >= 0)),
    CONSTRAINT teams_home_wins_check CHECK ((home_wins >= 0))
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 82192)
-- Name: games_program; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.games_program AS
 SELECT g.games_date,
    t1.home_field_name AS stadium,
    g.duration,
    t1.teams_name AS home_team,
    t2.teams_name AS away_team,
    g.home_teams_score AS home_score,
    g.away_teams_score AS away_score,
    array_agg(DISTINCT concat(p.players_name, ' ', p.players_surname)) FILTER (WHERE ((pgs.team_id = g.home_team_id) AND (p.player_id = pgs.player_id))) AS home_players,
    array_agg(DISTINCT p."position") FILTER (WHERE (p.team_id = g.home_team_id)) AS home_positions,
    array_agg(DISTINCT pgs.active_time) FILTER (WHERE (pgs.team_id = g.home_team_id)) AS home_active_times,
    array_agg(pgs.yellow_cards) FILTER (WHERE (pgs.team_id = g.home_team_id)) AS home_yellow_cards,
    array_agg(pgs.red_cards) FILTER (WHERE (pgs.team_id = g.home_team_id)) AS home_red_cards,
    array_agg(pgs.goals) FILTER (WHERE (pgs.team_id = g.home_team_id)) AS home_goals,
    array_agg(ge.moment) FILTER (WHERE ((pgs.team_id = g.home_team_id) AND (ge.game_id = g.game_id) AND ((ge.event_type)::text = 'ΓΚΟΛ'::text))) AS home_goal_moments,
    array_agg(DISTINCT concat(p.players_name, ' ', p.players_surname)) FILTER (WHERE ((pgs.team_id = g.away_team_id) AND (p.player_id = pgs.player_id))) AS away_players,
    array_agg(DISTINCT p."position") FILTER (WHERE (p.team_id = g.away_team_id)) AS away_positions,
    array_agg(DISTINCT pgs.active_time) FILTER (WHERE (pgs.team_id = g.away_team_id)) AS away_active_times,
    array_agg(pgs.yellow_cards) FILTER (WHERE (pgs.team_id = g.away_team_id)) AS away_yellow_cards,
    array_agg(pgs.red_cards) FILTER (WHERE (pgs.team_id = g.away_team_id)) AS away_red_cards,
    array_agg(pgs.goals) FILTER (WHERE (pgs.team_id = g.away_team_id)) AS away_goals,
    array_agg(ge.moment) FILTER (WHERE ((pgs.team_id = g.away_team_id) AND (ge.game_id = g.game_id) AND ((ge.event_type)::text = 'ΓΚΟΛ'::text))) AS away_goal_moments
   FROM (((((public.games g
     JOIN public.teams t1 ON ((g.home_team_id = t1.team_id)))
     JOIN public.teams t2 ON ((g.away_team_id = t2.team_id)))
     JOIN public.playergamestatistics pgs ON ((g.game_id = pgs.game_id)))
     JOIN public.players p ON ((pgs.player_id = p.player_id)))
     JOIN public.gameevents ge ON (((g.game_id = ge.game_id) AND (pgs.player_id = ge.player_id))))
  WHERE (g.games_date = '2022-09-01'::date)
  GROUP BY t1.home_field_name, g.game_id, g.games_date, g.duration, t1.teams_name, t2.teams_name, g.home_teams_score, g.away_teams_score;


ALTER TABLE public.games_program OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 82175)
-- Name: hascoached; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hascoached (
    coach_id integer NOT NULL,
    team_id integer NOT NULL,
    in_transfer_date date NOT NULL,
    out_transfer_date date
);


ALTER TABLE public.hascoached OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 82160)
-- Name: hasplayed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hasplayed (
    player_id integer NOT NULL,
    team_id integer NOT NULL,
    in_transfer_date date NOT NULL,
    out_transfer_date date
);


ALTER TABLE public.hasplayed OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 82061)
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_id_seq OWNER TO postgres;

--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 217
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- TOC entry 231 (class 1259 OID 90132)
-- Name: relegatedteams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relegatedteams (
    team_id integer NOT NULL,
    teams_name character varying(255) NOT NULL,
    home_field_name character varying(255) NOT NULL,
    history_description text,
    home_wins integer NOT NULL,
    away_wins integer NOT NULL,
    home_losses integer NOT NULL,
    away_losses integer NOT NULL,
    home_draws integer NOT NULL,
    away_draws integer NOT NULL
);


ALTER TABLE public.relegatedteams OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 90131)
-- Name: relegatedteams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.relegatedteams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relegatedteams_team_id_seq OWNER TO postgres;

--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 230
-- Name: relegatedteams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.relegatedteams_team_id_seq OWNED BY public.relegatedteams.team_id;


--
-- TOC entry 229 (class 1259 OID 82197)
-- Name: season_program; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.season_program AS
SELECT
    NULL::date AS games_date,
    NULL::character varying(255) AS stadium,
    NULL::time without time zone AS duration,
    NULL::character varying(255) AS home_team,
    NULL::character varying(255) AS away_team,
    NULL::text AS score;


ALTER TABLE public.season_program OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 82038)
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO postgres;

--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 215
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- TOC entry 3320 (class 2604 OID 82077)
-- Name: coaches coach_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches ALTER COLUMN coach_id SET DEFAULT nextval('public.coaches_coach_id_seq'::regclass);


--
-- TOC entry 3332 (class 2604 OID 82146)
-- Name: gameevents event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gameevents ALTER COLUMN event_id SET DEFAULT nextval('public.gameevents_event_id_seq'::regclass);


--
-- TOC entry 3321 (class 2604 OID 82089)
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- TOC entry 3319 (class 2604 OID 82065)
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- TOC entry 3333 (class 2604 OID 90135)
-- Name: relegatedteams team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relegatedteams ALTER COLUMN team_id SET DEFAULT nextval('public.relegatedteams_team_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 82042)
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- TOC entry 3535 (class 0 OID 82074)
-- Dependencies: 220
-- Data for Name: coaches; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (1, 111, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (2, 112, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (3, 113, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (4, 114, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (5, 115, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (6, 116, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (7, 117, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (8, 118, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (9, 119, 'Head Coach');
INSERT INTO public.coaches (coach_id, player_id, coaching_role) VALUES (10, 120, 'Head Coach');


--
-- TOC entry 3540 (class 0 OID 82143)
-- Dependencies: 225
-- Data for Name: gameevents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (1, 1, 1, 12, 'ΓΚΟΛ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (2, 1, 2, 23, 'ΓΚΟΛ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (3, 1, 1, 42, 'ΠΕΝΑΛΤΙ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (4, 1, 1, 45, 'ΓΚΟΛ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (5, 1, 14, 18, 'ΓΚΟΛ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (6, 2, 13, 33, 'ΓΚΟΛ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (7, 2, 13, 59, 'ΓΚΟΛ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (8, 2, 13, 10, 'ΓΚΟΛ');
INSERT INTO public.gameevents (event_id, game_id, player_id, moment, event_type) VALUES (9, 2, 15, 36, 'ΓΚΟΛ');


--
-- TOC entry 3537 (class 0 OID 82086)
-- Dependencies: 222
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (1, 1, 2, 3, 1, '2022-09-01', '01:32:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (2, 2, 3, 4, 0, '2022-09-13', '01:38:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (3, 3, 4, 2, 5, '2022-09-25', '01:40:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (4, 4, 5, 1, 2, '2022-10-07', '01:35:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (5, 5, 6, 0, 4, '2022-10-19', '01:37:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (6, 6, 7, 5, 2, '2022-10-31', '01:39:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (7, 7, 8, 1, 3, '2022-11-12', '01:36:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (8, 8, 9, 2, 0, '2022-11-24', '01:40:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (9, 9, 10, 3, 2, '2022-12-06', '01:33:00');
INSERT INTO public.games (game_id, home_team_id, away_team_id, home_teams_score, away_teams_score, games_date, duration) VALUES (10, 10, 1, 0, 1, '2022-12-18', '01:38:00');


--
-- TOC entry 3542 (class 0 OID 82175)
-- Dependencies: 227
-- Data for Name: hascoached; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (1, 1, '2021-05-10', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (2, 2, '2021-06-15', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (3, 3, '2021-07-02', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (4, 4, '2021-05-18', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (5, 5, '2021-06-27', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (6, 6, '2021-07-12', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (7, 7, '2021-05-05', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (8, 8, '2021-06-20', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (9, 9, '2021-07-28', NULL);
INSERT INTO public.hascoached (coach_id, team_id, in_transfer_date, out_transfer_date) VALUES (10, 10, '2021-05-14', NULL);


--
-- TOC entry 3541 (class 0 OID 82160)
-- Dependencies: 226
-- Data for Name: hasplayed; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (1, 1, '2020-05-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (2, 1, '2020-06-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (3, 1, '2020-07-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (4, 1, '2020-08-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (5, 1, '2020-05-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (6, 1, '2020-06-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (7, 1, '2020-07-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (8, 1, '2020-08-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (9, 1, '2020-05-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (10, 1, '2020-06-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (11, 1, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (12, 2, '2020-05-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (13, 2, '2020-06-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (14, 2, '2020-07-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (15, 2, '2020-08-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (16, 2, '2020-05-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (17, 2, '2020-06-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (18, 2, '2020-07-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (19, 2, '2020-08-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (20, 2, '2020-05-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (21, 2, '2020-06-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (22, 2, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (23, 3, '2020-05-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (24, 3, '2020-06-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (25, 3, '2020-07-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (26, 3, '2020-08-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (27, 3, '2020-05-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (28, 3, '2020-06-30', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (29, 3, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (30, 3, '2020-08-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (31, 3, '2020-05-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (32, 3, '2020-06-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (33, 3, '2020-07-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (34, 4, '2020-08-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (35, 4, '2020-05-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (36, 4, '2020-06-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (37, 4, '2020-07-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (38, 4, '2020-08-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (39, 4, '2020-05-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (40, 4, '2020-06-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (41, 4, '2020-07-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (42, 4, '2020-08-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (43, 4, '2020-05-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (44, 4, '2020-06-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (45, 5, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (46, 5, '2020-05-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (47, 5, '2020-06-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (48, 5, '2020-07-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (49, 5, '2020-08-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (50, 5, '2020-05-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (51, 5, '2020-06-30', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (52, 5, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (53, 5, '2020-08-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (54, 5, '2020-05-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (55, 5, '2020-06-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (56, 6, '2020-07-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (57, 6, '2020-08-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (58, 6, '2020-05-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (59, 6, '2020-06-30', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (60, 6, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (61, 6, '2020-08-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (62, 6, '2020-05-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (63, 6, '2020-06-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (64, 6, '2020-05-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (65, 6, '2020-06-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (66, 6, '2020-07-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (67, 7, '2020-08-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (68, 7, '2020-05-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (69, 7, '2020-06-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (70, 7, '2020-07-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (71, 7, '2020-08-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (72, 7, '2020-05-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (73, 7, '2020-06-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (74, 7, '2020-07-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (75, 7, '2020-08-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (76, 7, '2020-05-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (77, 7, '2020-06-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (78, 8, '2020-07-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (79, 8, '2020-08-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (80, 8, '2020-05-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (81, 8, '2020-06-30', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (82, 8, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (83, 8, '2020-08-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (84, 8, '2020-05-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (85, 8, '2020-06-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (86, 8, '2020-07-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (87, 8, '2020-08-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (88, 8, '2020-05-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (89, 9, '2020-06-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (90, 9, '2020-07-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (91, 9, '2020-08-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (92, 9, '2020-05-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (93, 9, '2020-06-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (94, 9, '2020-07-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (95, 9, '2020-08-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (96, 9, '2020-05-25', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (97, 9, '2020-06-30', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (98, 9, '2020-07-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (99, 9, '2020-08-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (100, 10, '2020-05-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (101, 10, '2020-06-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (102, 10, '2020-07-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (103, 10, '2020-08-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (104, 10, '2020-05-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (105, 10, '2020-06-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (106, 10, '2020-07-01', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (107, 10, '2020-08-10', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (108, 10, '2020-05-15', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (109, 10, '2020-06-20', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (110, 10, '2020-07-05', NULL);
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (111, 1, '1999-05-18', '2005-05-18');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (112, 2, '1994-08-10', '2001-08-10');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (113, 3, '2003-02-27', '2010-02-27');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (114, 4, '1997-11-21', '2004-11-21');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (115, 5, '1992-12-03', '1999-12-03');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (116, 6, '1998-07-06', '2005-07-06');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (117, 7, '1995-04-14', '2002-04-14');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (118, 8, '1996-09-29', '2003-09-29');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (119, 9, '1993-06-08', '2000-06-08');
INSERT INTO public.hasplayed (player_id, team_id, in_transfer_date, out_transfer_date) VALUES (120, 10, '1999-01-17', '2006-01-17');


--
-- TOC entry 3538 (class 0 OID 82109)
-- Dependencies: 223
-- Data for Name: playergamestatistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.playergamestatistics (player_id, team_id, game_id, red_cards, yellow_cards, goals, canceled_goals, active_time, penalties, corners) VALUES (1, 1, 1, 0, 0, 2, 1, '01:32:00', 1, 5);
INSERT INTO public.playergamestatistics (player_id, team_id, game_id, red_cards, yellow_cards, goals, canceled_goals, active_time, penalties, corners) VALUES (2, 1, 1, 1, 0, 1, 2, '01:32:00', 0, 5);
INSERT INTO public.playergamestatistics (player_id, team_id, game_id, red_cards, yellow_cards, goals, canceled_goals, active_time, penalties, corners) VALUES (14, 2, 1, 0, 1, 2, 1, '01:32:00', 0, 5);
INSERT INTO public.playergamestatistics (player_id, team_id, game_id, red_cards, yellow_cards, goals, canceled_goals, active_time, penalties, corners) VALUES (13, 1, 2, 0, 1, 3, 0, '01:38:00', 0, 5);
INSERT INTO public.playergamestatistics (player_id, team_id, game_id, red_cards, yellow_cards, goals, canceled_goals, active_time, penalties, corners) VALUES (15, 1, 2, 0, 0, 1, 1, '01:38:00', 0, 5);


--
-- TOC entry 3533 (class 0 OID 82062)
-- Dependencies: 218
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (1, 'Lionel', 'Messi', 1, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (2, 'Marc-André', 'ter Stegen', 1, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (3, 'Gerard', 'Piqué', 1, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (4, 'Jordi', 'Alba', 1, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (5, 'Sergio', 'Busquets', 1, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (6, 'Frenkie', 'de Jong', 1, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (7, 'Pedri', '', 1, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (8, 'Sergiño', 'Dest', 1, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (9, 'Antoine', 'Griezmann', 1, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (10, 'Ronald', 'Araújo', 1, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (11, 'Sergi', 'Roberto', 1, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (12, 'Karim', 'Benzema', 2, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (13, 'Thibaut', 'Courtois', 2, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (14, 'Raphael', 'Varane', 2, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (15, 'Marcelo', '', 2, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (16, 'Luka', 'Modric', 2, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (17, 'Toni', 'Kroos', 2, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (18, 'Eden', 'Hazard', 2, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (19, 'Dani', 'Carvajal', 2, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (20, 'Casemiro', '', 2, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (21, 'Ferland', 'Mendy', 2, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (22, 'Federico', 'Valverde', 2, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (23, 'Cristiano', 'Ronaldo', 3, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (24, 'Bruno', 'Fernandes', 3, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (25, 'Paul', 'Pogba', 3, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (26, 'Marcus', 'Rashford', 3, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (27, 'Harry', 'Maguire', 3, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (28, 'Luke', 'Shaw', 3, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (29, 'Aaron', 'WanBissaka', 3, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (30, 'Scott', 'McTominay', 3, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (31, 'Fred', 'Rodrigues', 3, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (32, 'Victor', 'Lindelof', 3, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (33, 'Dean', 'Henderson', 3, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (34, 'Robert', 'Lewndowski', 4, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (35, 'Thomas', 'Mueller', 4, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (36, 'Manuel', 'Neuer', 4, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (37, 'David', 'Alaba', 4, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (38, 'Joshua', 'Kimmich', 4, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (39, 'Leon', 'Goretzka', 4, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (40, 'Niklas', 'Sule', 4, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (41, 'Alphonso', 'Davies', 4, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (42, 'Kingsley', 'Coman', 4, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (43, 'Leroy', 'Sane', 4, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (44, 'Corentin', 'Tolisso', 4, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (45, 'Cristiano', 'Ronaldo', 5, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (46, 'Giorgio', 'Chiellini', 5, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (47, 'Leonardo', 'Bonucci', 5, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (48, 'Federico', 'Chiesa', 5, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (49, 'Arthur', 'Melocni', 5, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (50, 'Juan', 'Cuadrado', 5, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (51, 'Paulo', 'Dybala', 5, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (52, 'Aaron', 'Ramsey', 5, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (53, 'Weston', 'McKennie', 5, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (54, 'Dejan', 'Kulusevski', 5, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (55, 'Wojciech', 'Szczesny', 5, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (56, 'Mohamed', 'Salah', 6, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (57, 'Sadio', 'Mane', 6, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (58, 'Virgil', 'van Dijk', 6, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (59, 'Alexander', 'Arnold', 6, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (60, 'Andrew', 'Robertson', 6, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (61, 'Jordan', 'Henderson', 6, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (62, 'Fabinho', 'Tavares', 6, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (63, 'Diogo', 'Jota', 6, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (64, 'Joel', 'Matip', 6, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (65, 'Thiago', 'Alcantara', 6, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (66, 'Alisson', 'Becker', 6, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (67, 'Kylian', 'Mbappe', 7, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (68, 'Neymar', 'Jr', 7, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (69, 'Angel', 'Di Maria', 7, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (70, 'Marco', 'Verratti', 7, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (71, 'Presnel', 'Kimpembe', 7, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (72, 'Marquinhos', '', 7, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (73, 'Leandro', 'Paredes', 7, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (74, 'Keylor', 'Navas', 7, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (75, 'Achraf', 'Hakimi', 7, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (76, 'Mauro', 'Icardi', 7, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (77, 'Georginio', 'Wijnaldum', 7, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (78, 'Golo', 'Kante', 8, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (79, 'Mason', 'Mount', 8, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (80, 'Timo', 'Werner', 8, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (81, 'Cesar', 'Azplicueta', 8, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (82, 'Kai', 'Havertz', 8, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (83, 'Ben', 'Chilwell', 8, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (84, 'Jorginho', '', 8, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (85, 'Thiago', 'Silva', 8, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (86, 'Reece', 'James', 8, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (87, 'Edouard', 'Mendy', 8, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (88, 'Hakim', 'Ziyech', 8, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (89, 'Pierre', 'Aubameyang', 9, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (90, 'Bukayo', 'Saka', 9, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (91, 'Thomas', 'Partey', 9, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (92, 'Gabriel', 'Magalhaes', 9, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (93, 'Emile', 'Smith Rowe', 9, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (94, 'Kieran', 'Tierney', 9, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (95, 'Nicolas', 'Pepe', 9, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (96, 'Bernd', 'Leno', 9, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (97, 'Hector', 'Bellerin', 9, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (98, 'Granit', 'Xhaka', 9, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (99, 'Rob', 'Holding', 9, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (100, 'Gianluigi', 'Donnarumma', 10, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (101, 'Theo', 'Hernandez', 10, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (102, 'Franck', 'Kessie', 10, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (103, 'Simon', 'Kjaer', 10, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (104, 'Ante', 'Rebic', 10, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (105, 'Ismael', 'Bennacer', 10, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (106, 'Rafael', 'Leao', 10, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (107, 'Alessio', 'Romagnoli', 10, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (108, 'Sandro', 'Tonali', 10, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (109, 'Zlatan', 'Ibraimovic', 10, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (110, 'Davide', 'Calabria', 10, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (111, 'Luis', 'Garcia', 1, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (112, 'Marc', 'Lopez', 2, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (113, 'Ryan', 'Wilson', 3, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (114, 'Julian', 'Muller', 4, 'Goalkeeper');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (115, 'Matteo', 'Rossi', 5, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (116, 'Adam', 'Johnson', 6, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (117, 'Antoine', 'Dubois', 7, 'Forward');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (118, 'Oliver', 'Baker', 8, 'Midfielder');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (119, 'Samuel', 'Wright', 9, 'Defender');
INSERT INTO public.players (player_id, players_name, players_surname, team_id, "position") VALUES (120, 'Leonardo', 'Ricci', 10, 'Forward');


--
-- TOC entry 3544 (class 0 OID 90132)
-- Dependencies: 231
-- Data for Name: relegatedteams; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.relegatedteams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (1, 'Test', 'Test', 'History of Test', 0, 1, 0, 1, 0, 1);


--
-- TOC entry 3531 (class 0 OID 82039)
-- Dependencies: 216
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (1, 'Barcelona', 'Camp Nou', 'History of Barcelona', 2, 1, 0, 1, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (2, 'Real Madrid', 'Santiago Bernabeu', 'History of Real Madrid', 1, 1, 1, 1, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (3, 'Manchester United', 'Old Trafford', 'History of Manchester United', 1, 0, 1, 2, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (4, 'Bayern Munich', 'Allianz Arena', 'History of Bayern Munich', 1, 2, 1, 0, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (5, 'Juventus', 'Allianz Stadium', 'History of Juventus', 0, 1, 2, 1, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (6, 'Liverpool', 'Anfield', 'History of Liverpool', 1, 1, 1, 1, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (7, 'Paris Saint-Germain', 'Parc des Princes', 'History of Paris Saint-Germain', 0, 1, 2, 1, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (8, 'Chelsea', 'Stamford Bridge', 'History of Chelsea', 2, 2, 0, 0, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (9, 'Arsenal', 'Emirates Stadium', 'History of Arsenal', 2, 1, 0, 1, 0, 0);
INSERT INTO public.teams (team_id, teams_name, home_field_name, history_description, home_wins, away_wins, home_losses, away_losses, home_draws, away_draws) VALUES (10, 'AC Milan', 'San Siro', 'History of AC Milan', 0, 0, 2, 2, 0, 0);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 219
-- Name: coaches_coach_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coaches_coach_id_seq', 10, true);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 224
-- Name: gameevents_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gameevents_event_id_seq', 9, true);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 221
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_game_id_seq', 10, true);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 217
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_player_id_seq', 120, true);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 230
-- Name: relegatedteams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.relegatedteams_team_id_seq', 1, true);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 215
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 11, true);


--
-- TOC entry 3356 (class 2606 OID 82079)
-- Name: coaches coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (coach_id);


--
-- TOC entry 3364 (class 2606 OID 82149)
-- Name: gameevents gameevents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gameevents
    ADD CONSTRAINT gameevents_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3358 (class 2606 OID 82096)
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- TOC entry 3368 (class 2606 OID 82179)
-- Name: hascoached hascoached_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hascoached
    ADD CONSTRAINT hascoached_pkey PRIMARY KEY (coach_id, team_id);


--
-- TOC entry 3366 (class 2606 OID 82164)
-- Name: hasplayed hasplayed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasplayed
    ADD CONSTRAINT hasplayed_pkey PRIMARY KEY (player_id, team_id);


--
-- TOC entry 3362 (class 2606 OID 82126)
-- Name: playergamestatistics playergamestatistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playergamestatistics
    ADD CONSTRAINT playergamestatistics_pkey PRIMARY KEY (player_id, game_id);


--
-- TOC entry 3354 (class 2606 OID 82067)
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- TOC entry 3370 (class 2606 OID 90139)
-- Name: relegatedteams relegatedteams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relegatedteams
    ADD CONSTRAINT relegatedteams_pkey PRIMARY KEY (team_id);


--
-- TOC entry 3350 (class 2606 OID 82058)
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- TOC entry 3352 (class 2606 OID 82060)
-- Name: teams teams_teams_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_teams_name_key UNIQUE (teams_name);


--
-- TOC entry 3360 (class 2606 OID 82108)
-- Name: games unique_game_per_day; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT unique_game_per_day UNIQUE (home_team_id, away_team_id, games_date);


--
-- TOC entry 3529 (class 2618 OID 82200)
-- Name: season_program _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.season_program AS
 SELECT g.games_date,
    t1.home_field_name AS stadium,
    g.duration,
    t1.teams_name AS home_team,
    t2.teams_name AS away_team,
    concat(g.home_teams_score, ' - ', g.away_teams_score) AS score
   FROM ((public.games g
     JOIN public.teams t1 ON ((g.home_team_id = t1.team_id)))
     JOIN public.teams t2 ON ((g.away_team_id = t2.team_id)))
  WHERE ((g.games_date >= '2022-09-01'::date) AND (g.games_date <= '2023-06-30'::date))
  GROUP BY g.game_id, t1.home_field_name, t1.teams_name, t2.teams_name;


--
-- TOC entry 3385 (class 2620 OID 82191)
-- Name: games enforce_duration_between_games; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER enforce_duration_between_games BEFORE INSERT ON public.games FOR EACH ROW EXECUTE FUNCTION public.check_duration_between_games();


--
-- TOC entry 3384 (class 2620 OID 82203)
-- Name: teams enforce_team_relegation; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER enforce_team_relegation AFTER DELETE ON public.teams FOR EACH ROW EXECUTE FUNCTION public.team_relegation();


--
-- TOC entry 3372 (class 2606 OID 82080)
-- Name: coaches coaches_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id) ON DELETE CASCADE;


--
-- TOC entry 3378 (class 2606 OID 82150)
-- Name: gameevents gameevents_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gameevents
    ADD CONSTRAINT gameevents_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- TOC entry 3379 (class 2606 OID 82155)
-- Name: gameevents gameevents_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gameevents
    ADD CONSTRAINT gameevents_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- TOC entry 3373 (class 2606 OID 82102)
-- Name: games games_away_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_away_team_id_fkey FOREIGN KEY (away_team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3374 (class 2606 OID 82097)
-- Name: games games_home_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_home_team_id_fkey FOREIGN KEY (home_team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3382 (class 2606 OID 82180)
-- Name: hascoached hascoached_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hascoached
    ADD CONSTRAINT hascoached_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coaches(coach_id) ON DELETE CASCADE;


--
-- TOC entry 3383 (class 2606 OID 82185)
-- Name: hascoached hascoached_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hascoached
    ADD CONSTRAINT hascoached_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;


--
-- TOC entry 3380 (class 2606 OID 82165)
-- Name: hasplayed hasplayed_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasplayed
    ADD CONSTRAINT hasplayed_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id) ON DELETE CASCADE;


--
-- TOC entry 3381 (class 2606 OID 82170)
-- Name: hasplayed hasplayed_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasplayed
    ADD CONSTRAINT hasplayed_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;


--
-- TOC entry 3375 (class 2606 OID 82137)
-- Name: playergamestatistics playergamestatistics_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playergamestatistics
    ADD CONSTRAINT playergamestatistics_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(game_id) ON DELETE CASCADE;


--
-- TOC entry 3376 (class 2606 OID 82127)
-- Name: playergamestatistics playergamestatistics_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playergamestatistics
    ADD CONSTRAINT playergamestatistics_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id) ON DELETE CASCADE;


--
-- TOC entry 3377 (class 2606 OID 82132)
-- Name: playergamestatistics playergamestatistics_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playergamestatistics
    ADD CONSTRAINT playergamestatistics_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3371 (class 2606 OID 82068)
-- Name: players players_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE SET NULL;


-- Completed on 2023-06-29 19:26:17

--
-- PostgreSQL database dump complete
--

