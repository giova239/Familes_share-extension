--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2021-12-14 00:14:46 CET

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
-- TOC entry 209 (class 1259 OID 16395)
-- Name: Announcements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Announcements" (
    id_announcement bigint NOT NULL,
    title text,
    description text,
    creator bigint NOT NULL,
    type boolean
);


ALTER TABLE public."Announcements" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16400)
-- Name: AnnouncementsGroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AnnouncementsGroups" (
    id_announcement bigint NOT NULL,
    id_group bigint NOT NULL
);


ALTER TABLE public."AnnouncementsGroups" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16403)
-- Name: AnnouncementsGroups_id_announcement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AnnouncementsGroups_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AnnouncementsGroups_id_announcement_seq" OWNER TO postgres;

--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 211
-- Name: AnnouncementsGroups_id_announcement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AnnouncementsGroups_id_announcement_seq" OWNED BY public."AnnouncementsGroups".id_announcement;


--
-- TOC entry 212 (class 1259 OID 16404)
-- Name: AnnouncementsGroups_id_group_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AnnouncementsGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AnnouncementsGroups_id_group_seq" OWNER TO postgres;

--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 212
-- Name: AnnouncementsGroups_id_group_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AnnouncementsGroups_id_group_seq" OWNED BY public."AnnouncementsGroups".id_group;


--
-- TOC entry 213 (class 1259 OID 16405)
-- Name: Announcements_creator_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Announcements_creator_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Announcements_creator_seq" OWNER TO postgres;

--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 213
-- Name: Announcements_creator_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Announcements_creator_seq" OWNED BY public."Announcements".creator;


--
-- TOC entry 214 (class 1259 OID 16406)
-- Name: Announcements_id_announcement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Announcements_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Announcements_id_announcement_seq" OWNER TO postgres;

--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 214
-- Name: Announcements_id_announcement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Announcements_id_announcement_seq" OWNED BY public."Announcements".id_announcement;


--
-- TOC entry 215 (class 1259 OID 16407)
-- Name: Chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Chats" (
    id_chat bigint NOT NULL,
    announcement bigint NOT NULL,
    interested bigint NOT NULL
);


ALTER TABLE public."Chats" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16410)
-- Name: Chats_announcement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Chats_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Chats_announcement_seq" OWNER TO postgres;

--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 216
-- Name: Chats_announcement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Chats_announcement_seq" OWNED BY public."Chats".announcement;


--
-- TOC entry 217 (class 1259 OID 16411)
-- Name: Chats_id_chat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Chats_id_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Chats_id_chat_seq" OWNER TO postgres;

--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 217
-- Name: Chats_id_chat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Chats_id_chat_seq" OWNED BY public."Chats".id_chat;


--
-- TOC entry 218 (class 1259 OID 16412)
-- Name: Chats_interested_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Chats_interested_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Chats_interested_seq" OWNER TO postgres;

--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 218
-- Name: Chats_interested_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Chats_interested_seq" OWNED BY public."Chats".interested;


--
-- TOC entry 219 (class 1259 OID 16413)
-- Name: Groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Groups" (
    id_group bigint NOT NULL,
    name text,
    description text
);


ALTER TABLE public."Groups" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16418)
-- Name: Groups_id_group_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Groups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Groups_id_group_seq" OWNER TO postgres;

--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 220
-- Name: Groups_id_group_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Groups_id_group_seq" OWNED BY public."Groups".id_group;


--
-- TOC entry 229 (class 1259 OID 16504)
-- Name: Images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Images" (
    image_path text NOT NULL,
    id_announcement bigint
);


ALTER TABLE public."Images" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16419)
-- Name: Messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Messages" (
    id_message bigint NOT NULL,
    text text,
    chat bigint NOT NULL
);


ALTER TABLE public."Messages" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16424)
-- Name: Messages_chat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Messages_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Messages_chat_seq" OWNER TO postgres;

--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 222
-- Name: Messages_chat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Messages_chat_seq" OWNED BY public."Messages".chat;


--
-- TOC entry 223 (class 1259 OID 16425)
-- Name: Messages_id_message_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Messages_id_message_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Messages_id_message_seq" OWNER TO postgres;

--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 223
-- Name: Messages_id_message_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Messages_id_message_seq" OWNED BY public."Messages".id_message;


--
-- TOC entry 224 (class 1259 OID 16426)
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id_user bigint NOT NULL,
    username text,
    name text,
    surname text,
    password text,
    birth_date date,
    email text,
    phone bigint,
    street text,
    city text,
    postal_code bigint
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16431)
-- Name: UsersGroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UsersGroups" (
    id_user bigint NOT NULL,
    id_group bigint NOT NULL
);


ALTER TABLE public."UsersGroups" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16434)
-- Name: UsersGroups_id_group_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UsersGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UsersGroups_id_group_seq" OWNER TO postgres;

--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 226
-- Name: UsersGroups_id_group_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UsersGroups_id_group_seq" OWNED BY public."UsersGroups".id_group;


--
-- TOC entry 227 (class 1259 OID 16435)
-- Name: UsersGroups_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UsersGroups_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UsersGroups_id_user_seq" OWNER TO postgres;

--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 227
-- Name: UsersGroups_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UsersGroups_id_user_seq" OWNED BY public."UsersGroups".id_user;


--
-- TOC entry 228 (class 1259 OID 16436)
-- Name: Users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Users_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Users_id_user_seq" OWNER TO postgres;

--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 228
-- Name: Users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Users_id_user_seq" OWNED BY public."Users".id_user;


--
-- TOC entry 3470 (class 2604 OID 16437)
-- Name: Announcements id_announcement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Announcements" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Announcements_id_announcement_seq"'::regclass);


--
-- TOC entry 3471 (class 2604 OID 16438)
-- Name: Announcements creator; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Announcements" ALTER COLUMN creator SET DEFAULT nextval('public."Announcements_creator_seq"'::regclass);


--
-- TOC entry 3472 (class 2604 OID 16439)
-- Name: AnnouncementsGroups id_announcement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_announcement SET DEFAULT nextval('public."AnnouncementsGroups_id_announcement_seq"'::regclass);


--
-- TOC entry 3473 (class 2604 OID 16440)
-- Name: AnnouncementsGroups id_group; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."AnnouncementsGroups_id_group_seq"'::regclass);


--
-- TOC entry 3474 (class 2604 OID 16441)
-- Name: Chats id_chat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chats" ALTER COLUMN id_chat SET DEFAULT nextval('public."Chats_id_chat_seq"'::regclass);


--
-- TOC entry 3475 (class 2604 OID 16442)
-- Name: Chats announcement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chats" ALTER COLUMN announcement SET DEFAULT nextval('public."Chats_announcement_seq"'::regclass);


--
-- TOC entry 3476 (class 2604 OID 16443)
-- Name: Chats interested; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chats" ALTER COLUMN interested SET DEFAULT nextval('public."Chats_interested_seq"'::regclass);


--
-- TOC entry 3477 (class 2604 OID 16444)
-- Name: Groups id_group; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Groups" ALTER COLUMN id_group SET DEFAULT nextval('public."Groups_id_group_seq"'::regclass);


--
-- TOC entry 3478 (class 2604 OID 16445)
-- Name: Messages id_message; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages" ALTER COLUMN id_message SET DEFAULT nextval('public."Messages_id_message_seq"'::regclass);


--
-- TOC entry 3479 (class 2604 OID 16446)
-- Name: Messages chat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages" ALTER COLUMN chat SET DEFAULT nextval('public."Messages_chat_seq"'::regclass);


--
-- TOC entry 3480 (class 2604 OID 16447)
-- Name: Users id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id_user SET DEFAULT nextval('public."Users_id_user_seq"'::regclass);


--
-- TOC entry 3481 (class 2604 OID 16448)
-- Name: UsersGroups id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_user SET DEFAULT nextval('public."UsersGroups_id_user_seq"'::regclass);


--
-- TOC entry 3482 (class 2604 OID 16449)
-- Name: UsersGroups id_group; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."UsersGroups_id_group_seq"'::regclass);


--
-- TOC entry 3646 (class 0 OID 16395)
-- Dependencies: 209
-- Data for Name: Announcements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Announcements" (id_announcement, title, description, creator, type) FROM stdin;
1	Geografia con noi	Scopri i paesi del mondo	1	f
2	Storia moderna	Racconti del 1956	2	f
4	prova	prova	1	f
5	immagine	desc	1	f
6	prova	con immagine	1	t
7	prova	lol	1	t
8	lol	lol	1	f
9	awfawf	awfawfawf	1	f
10	prova	prova	1	f
11	prova	prova	1	f
12	proco	wamfawf	1	f
13	lol	wdawd	1	f
14	prova finale	desc	1	f
15	prova immagine	immagine	1	f
16	prova	prova	1	f
17			1	f
18			1	f
19	awdawd	awdawd	1	f
20	prova finale	lezgo	1	f
21	2 imm	lol	1	f
22	one	lol	1	f
23			1	f
24			1	f
25			1	f
26	dwadwa	awdawd	1	f
27			1	f
28			1	f
29			1	f
30			1	f
\.


--
-- TOC entry 3647 (class 0 OID 16400)
-- Dependencies: 210
-- Data for Name: AnnouncementsGroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AnnouncementsGroups" (id_announcement, id_group) FROM stdin;
1	3
4	3
5	3
6	1
7	2
8	1
9	2
10	2
11	2
12	1
13	2
14	1
15	1
16	3
17	3
18	3
19	2
20	2
21	2
22	2
23	2
24	3
25	3
26	2
27	2
28	2
29	2
30	1
\.


--
-- TOC entry 3652 (class 0 OID 16407)
-- Dependencies: 215
-- Data for Name: Chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Chats" (id_chat, announcement, interested) FROM stdin;
\.


--
-- TOC entry 3656 (class 0 OID 16413)
-- Dependencies: 219
-- Data for Name: Groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Groups" (id_group, name, description) FROM stdin;
1	Gruppo storia	Prestito libri di storia
2	Gruppo arte	Prestito libri di arte
3	Gruppo geografia	Prestito libri di geografia
\.


--
-- TOC entry 3666 (class 0 OID 16504)
-- Dependencies: 229
-- Data for Name: Images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Images" (image_path, id_announcement) FROM stdin;
images/30_image_1639436965699	30
\.


--
-- TOC entry 3658 (class 0 OID 16419)
-- Dependencies: 221
-- Data for Name: Messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Messages" (id_message, text, chat) FROM stdin;
\.


--
-- TOC entry 3661 (class 0 OID 16426)
-- Dependencies: 224
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id_user, username, name, surname, password, birth_date, email, phone, street, city, postal_code) FROM stdin;
1	Alex	Alexandru	Condurache	1234	2000-06-25	alexcondurache00@gmail.com	3893111808	Via San Felice	Mestre	30173
2	Anto	Antonio	Rossi	0000	1997-03-18	aldo97@gmail.com	3489291849	Via Dalle Palle Sudate	Belluno	23482
\.


--
-- TOC entry 3662 (class 0 OID 16431)
-- Dependencies: 225
-- Data for Name: UsersGroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UsersGroups" (id_user, id_group) FROM stdin;
1	1
1	2
1	3
2	3
\.


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 211
-- Name: AnnouncementsGroups_id_announcement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AnnouncementsGroups_id_announcement_seq"', 1, false);


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 212
-- Name: AnnouncementsGroups_id_group_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AnnouncementsGroups_id_group_seq"', 1, false);


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 213
-- Name: Announcements_creator_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Announcements_creator_seq"', 1, false);


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 214
-- Name: Announcements_id_announcement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Announcements_id_announcement_seq"', 30, true);


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 216
-- Name: Chats_announcement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Chats_announcement_seq"', 1, false);


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 217
-- Name: Chats_id_chat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Chats_id_chat_seq"', 1, false);


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 218
-- Name: Chats_interested_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Chats_interested_seq"', 1, false);


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 220
-- Name: Groups_id_group_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Groups_id_group_seq"', 1, false);


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 222
-- Name: Messages_chat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Messages_chat_seq"', 1, false);


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 223
-- Name: Messages_id_message_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Messages_id_message_seq"', 1, false);


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 226
-- Name: UsersGroups_id_group_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UsersGroups_id_group_seq"', 1, false);


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 227
-- Name: UsersGroups_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UsersGroups_id_user_seq"', 1, false);


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 228
-- Name: Users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_user_seq"', 1, false);


--
-- TOC entry 3486 (class 2606 OID 16451)
-- Name: AnnouncementsGroups AnnouncementsGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_pkey" PRIMARY KEY (id_announcement, id_group);


--
-- TOC entry 3484 (class 2606 OID 16453)
-- Name: Announcements Announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_pkey" PRIMARY KEY (id_announcement);


--
-- TOC entry 3488 (class 2606 OID 16455)
-- Name: Chats Chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_pkey" PRIMARY KEY (id_chat);


--
-- TOC entry 3490 (class 2606 OID 16457)
-- Name: Groups Groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Groups"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id_group);


--
-- TOC entry 3498 (class 2606 OID 16510)
-- Name: Images Images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_pkey" PRIMARY KEY (image_path);


--
-- TOC entry 3492 (class 2606 OID 16459)
-- Name: Messages Messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id_message);


--
-- TOC entry 3496 (class 2606 OID 16461)
-- Name: UsersGroups UsersGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_pkey" PRIMARY KEY (id_user, id_group);


--
-- TOC entry 3494 (class 2606 OID 16463)
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id_user);


--
-- TOC entry 3500 (class 2606 OID 16464)
-- Name: AnnouncementsGroups AnnouncementsGroups_id_announcement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement);


--
-- TOC entry 3501 (class 2606 OID 16469)
-- Name: AnnouncementsGroups AnnouncementsGroups_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group) NOT VALID;


--
-- TOC entry 3499 (class 2606 OID 16474)
-- Name: Announcements Announcements_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_creator_fkey" FOREIGN KEY (creator) REFERENCES public."Users"(id_user);


--
-- TOC entry 3502 (class 2606 OID 16479)
-- Name: Chats Chats_announcement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_announcement_fkey" FOREIGN KEY (announcement) REFERENCES public."Announcements"(id_announcement);


--
-- TOC entry 3503 (class 2606 OID 16484)
-- Name: Chats Chats_interested_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_interested_fkey" FOREIGN KEY (interested) REFERENCES public."Users"(id_user);


--
-- TOC entry 3504 (class 2606 OID 16489)
-- Name: Messages Messages_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_chat_fkey" FOREIGN KEY (chat) REFERENCES public."Chats"(id_chat);


--
-- TOC entry 3505 (class 2606 OID 16494)
-- Name: UsersGroups UsersGroups_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group);


--
-- TOC entry 3506 (class 2606 OID 16499)
-- Name: UsersGroups UsersGroups_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_user_fkey" FOREIGN KEY (id_user) REFERENCES public."Users"(id_user);


-- Completed on 2021-12-14 00:14:46 CET

--
-- PostgreSQL database dump complete
--

