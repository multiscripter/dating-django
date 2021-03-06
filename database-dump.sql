--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Ubuntu 13.2-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.2 (Ubuntu 13.2-1.pgdg16.04+1)

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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(64) NOT NULL,
    parent_id bigint
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: dating_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dating_message (
    id integer NOT NULL,
    text character varying(255) NOT NULL
);


ALTER TABLE public.dating_message OWNER TO postgres;

--
-- Name: dating_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dating_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dating_message_id_seq OWNER TO postgres;

--
-- Name: dating_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dating_message_id_seq OWNED BY public.dating_message.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: matches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matches (
    id bigint NOT NULL,
    is_mutually boolean NOT NULL,
    from_id_id integer NOT NULL,
    to_id_id integer NOT NULL
);


ALTER TABLE public.matches OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.matches_id_seq OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.matches_id_seq OWNED BY public.matches.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying(128) NOT NULL,
    price numeric(8,2) NOT NULL,
    image character varying(100),
    category_id bigint NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(32) NOT NULL,
    last_name character varying(32) NOT NULL,
    email character varying(254) NOT NULL,
    gender character varying(2) NOT NULL,
    avatar character varying(100) NOT NULL,
    coord_x double precision,
    coord_y double precision
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: dating_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dating_message ALTER COLUMN id SET DEFAULT nextval('public.dating_message_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches ALTER COLUMN id SET DEFAULT nextval('public.matches_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add ????????????????	7	add_user
26	Can change ????????????????	7	change_user
27	Can delete ????????????????	7	delete_user
28	Can view ????????????????	7	view_user
29	Can add ????????????????	8	add_client
30	Can change ????????????????	8	change_client
31	Can delete ????????????????	8	delete_client
32	Can view ????????????????	8	view_client
33	Can add ????????????????????	9	add_match
34	Can change ????????????????????	9	change_match
35	Can delete ????????????????????	9	delete_match
36	Can view ????????????????????	9	view_match
37	Can add message	10	add_message
38	Can change message	10	change_message
39	Can delete message	10	delete_message
40	Can view message	10	view_message
41	Can add ??????????	11	add_product
42	Can change ??????????	11	change_product
43	Can delete ??????????	11	delete_product
44	Can view ??????????	11	view_product
45	Can add ??????????????????	12	add_category
46	Can change ??????????????????	12	change_category
47	Can delete ??????????????????	12	delete_category
48	Can view ??????????????????	12	view_category
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$260000$MX6NEIUYweeaV3xuqJeXEA$K6jOHCC0svvgkYQWrI16BnO/8lCDe7BaJ0tLrkRexCc=	2021-04-29 12:22:46.28096+03	t	admin			admin@dating.bot.net	t	t	2021-04-29 12:22:29.406947+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, parent_id) FROM stdin;
1	?????????????????????????? ?? ????????????	\N
2	??????????????????	1
3	?????????????? ????????????	2
\.


--
-- Data for Name: dating_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dating_message (id, text) FROM stdin;
1	ddddddddddd
2	ffffffffffffffffffff
3	ghjghj
4	fghhh
5	asdasd
6	asdasd
7	ffffffffffffff
8	;khdjkhfkgsdfg
9	zzzzzzzzzz
10	99
11	ddddddddddddddd
12	ddddddddffffffffff
13	ffffff
14	ssssssssssss
15	ddddddd
16	fffffffff
17	sdfsdf
18	dfgdfgdggg
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-04-29 13:47:43.104343+03	1	User{id:1, name:???????????? ????????}	1	[{"added": {}}]	7	1
2	2021-04-29 14:36:05.319741+03	1	User{id:1, name:???????????? ????????}	3		7	1
3	2021-04-29 14:51:19.129369+03	2	User{id:2, name:???????????? ????????}	1	[{"added": {}}]	7	1
4	2021-04-29 14:53:12.416157+03	2	User{id:2, name:???????????? ????????}	3		7	1
5	2021-04-29 14:53:40.703341+03	3	User{id:3, name:???????????? ????????}	1	[{"added": {}}]	7	1
6	2021-04-29 15:29:55.955382+03	3	User{id:3, name:???????????? ????????}	3		7	1
7	2021-04-29 15:30:21.48739+03	4	User{id:4, name:???????????? ????????}	1	[{"added": {}}]	7	1
8	2021-04-29 15:33:22.795313+03	4	User{id:4, name:???????????? ????????}	3		7	1
9	2021-04-29 15:33:39.270005+03	5	User{id:5, name:???????????? ????????}	1	[{"added": {}}]	7	1
10	2021-04-29 15:51:39.646295+03	5	User{id:5, name:???????????? ????????}	3		7	1
11	2021-04-29 15:52:09.328538+03	6	User{id:6, name:???????????? ????????}	1	[{"added": {}}]	7	1
12	2021-04-29 15:52:42.333316+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
13	2021-04-29 15:53:44.643003+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
14	2021-04-29 15:54:11.116985+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
15	2021-04-29 15:54:43.37554+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
16	2021-04-29 16:03:45.712488+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
17	2021-04-29 16:16:18.951084+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
18	2021-04-29 16:16:28.200004+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
19	2021-04-29 16:21:58.939744+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
20	2021-04-29 16:26:22.537766+03	6	User{id:6, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
21	2021-04-29 16:27:09.835969+03	6	User{id:6, name:???????????? ????????}	3		7	1
22	2021-04-29 16:27:29.271619+03	7	User{id:7, name:???????????? ????????}	1	[{"added": {}}]	7	1
23	2021-04-29 16:28:12.194246+03	7	User{id:7, name:???????????? ????????}	3		7	1
24	2021-04-29 16:28:43.552159+03	8	User{id:8, name:???????????? ????????}	1	[{"added": {}}]	7	1
25	2021-04-29 16:30:33.520433+03	8	User{id:8, name:???????????? ????????}	3		7	1
26	2021-04-29 16:30:57.837878+03	9	User{id:9, name:???????????? ????????}	1	[{"added": {}}]	7	1
27	2021-04-29 16:32:20.777886+03	9	User{id:9, name:???????????? ????????}	3		7	1
28	2021-04-29 16:34:48.464191+03	10	User{id:10, name:???????????? ????????}	1	[{"added": {}}]	7	1
29	2021-04-29 16:35:37.107851+03	10	User{id:10, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
30	2021-04-29 16:39:15.288434+03	10	User{id:10, name:???????????? ????????}	3		7	1
31	2021-04-29 16:39:35.588282+03	11	User{id:11, name:???????????? ????????}	1	[{"added": {}}]	7	1
32	2021-04-29 16:40:08.465321+03	11	User{id:11, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
33	2021-04-29 16:41:56.46515+03	11	User{id:11, name:???????????? ????????}	3		7	1
34	2021-04-29 16:42:47.772007+03	12	User{id:12, name:???????????? ????????}	1	[{"added": {}}]	7	1
35	2021-04-29 16:43:46.858774+03	12	User{id:12, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
36	2021-04-29 16:48:50.141987+03	12	User{id:12, name:???????????? ????????}	3		7	1
37	2021-04-29 16:49:15.073196+03	13	User{id:13, name:???????????? ????????}	1	[{"added": {}}]	7	1
38	2021-04-29 16:51:20.341276+03	13	User{id:13, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
39	2021-04-29 16:51:37.034658+03	13	User{id:13, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
40	2021-04-29 16:53:16.378049+03	13	User{id:13, name:???????????? ????????}	3		7	1
41	2021-04-29 16:53:37.558568+03	14	User{id:14, name:???????????? ????????}	1	[{"added": {}}]	7	1
42	2021-04-29 16:54:25.775562+03	14	User{id:14, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
43	2021-04-29 16:55:35.066496+03	14	User{id:14, name:???????????? ????????}	2	[]	7	1
44	2021-04-29 16:55:38.651024+03	14	User{id:14, name:???????????? ????????}	2	[]	7	1
45	2021-04-29 16:57:13.430162+03	14	User{id:14, name:???????????? ????????}	3		7	1
46	2021-04-29 16:57:35.289088+03	15	User{id:15, name:???????????? ????????}	1	[{"added": {}}]	7	1
47	2021-04-29 17:00:02.347104+03	15	User{id:15, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
48	2021-04-29 17:04:00.425635+03	15	User{id:15, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
49	2021-04-29 17:05:01.814564+03	15	User{id:15, name:???????????? ????????}	3		7	1
50	2021-04-29 17:05:20.636283+03	16	User{id:16, name:???????????? ????????}	1	[{"added": {}}]	7	1
51	2021-04-29 17:05:51.436068+03	16	User{id:16, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
52	2021-04-29 17:07:52.062882+03	16	User{id:16, name:???????????? ????????}	3		7	1
53	2021-04-29 17:08:11.694075+03	17	User{id:17, name:???????????? ????????}	1	[{"added": {}}]	7	1
54	2021-04-29 17:08:33.623513+03	17	User{id:17, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
55	2021-04-29 17:09:13.779956+03	17	User{id:17, name:???????????? ????????}	2	[]	7	1
56	2021-04-29 17:09:59.050697+03	17	User{id:17, name:???????????? ????????}	2	[]	7	1
57	2021-04-29 17:10:22.488829+03	17	User{id:17, name:???????????? ????????}	3		7	1
58	2021-04-29 17:10:44.048869+03	18	User{id:18, name:???????????? ????????}	1	[{"added": {}}]	7	1
59	2021-04-29 17:10:57.405983+03	18	User{id:18, name:???????????? ????????}	2	[]	7	1
60	2021-04-29 17:12:04.556888+03	18	User{id:18, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
61	2021-04-29 17:16:50.814551+03	18	User{id:18, name:???????????? ????????}	2	[]	7	1
62	2021-04-29 17:19:23.267034+03	18	User{id:18, name:???????????? ????????}	2	[]	7	1
63	2021-04-29 17:20:19.781862+03	18	User{id:18, name:???????????? ????????}	2	[]	7	1
64	2021-04-29 17:20:27.328853+03	18	User{id:18, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
65	2021-04-29 17:20:48.458209+03	18	User{id:18, name:???????????? ????????}	2	[]	7	1
66	2021-04-29 17:20:54.420578+03	18	User{id:18, name:???????????? ????????}	2	[]	7	1
67	2021-04-29 17:21:19.169576+03	18	User{id:18, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
68	2021-04-29 17:23:09.296754+03	18	User{id:18, name:???????????? ????????}	2	[]	7	1
69	2021-04-29 17:23:27.8329+03	18	User{id:18, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
70	2021-04-29 17:25:54.278414+03	18	User{id:18, name:???????????? ????????}	3		7	1
71	2021-04-29 17:26:08.608571+03	19	User{id:19, name:???????????? ????????}	1	[{"added": {}}]	7	1
72	2021-04-29 17:37:32.666645+03	19	User{id:19, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
73	2021-04-29 17:40:09.305677+03	19	User{id:19, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
74	2021-04-29 17:41:29.266862+03	19	User{id:19, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
75	2021-04-29 17:45:40.520176+03	19	User{id:19, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
76	2021-04-29 17:48:38.41199+03	19	User{id:19, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
77	2021-04-29 17:49:45.187455+03	19	User{id:19, name:???????????? ????????}	3		7	1
78	2021-04-29 17:50:01.457046+03	20	User{id:20, name:???????????? ????????}	1	[{"added": {}}]	7	1
79	2021-04-29 17:50:49.095247+03	20	User{id:20, name:???????????? ????????}	2	[{"changed": {"fields": ["\\u0424\\u0430\\u0439\\u043b \\u0430\\u0432\\u0430\\u0442\\u0430\\u0440\\u0430"]}}]	7	1
80	2021-04-29 17:52:27.374236+03	20	User{id:20, name:???????????? ????????}	2	[]	7	1
81	2021-04-29 17:52:30.247615+03	20	User{id:20, name:???????????? ????????}	2	[]	7	1
82	2021-04-29 20:40:24.34196+03	21	Client{ id: 21 first_name: ['????????'] last_name: ['????????????'] email: ['pupkin@mail.ru'] gender: 1 avatar: avatars/no-photo.png	3		8	1
83	2021-04-29 20:45:30.553152+03	22	Client{ id: 22 first_name: ???????? last_name: ['????????????'] email: ['pupkin@mail.ru'] gender: 1 avatar: avatars/no-photo.png	3		8	1
84	2021-04-29 21:49:14.82156+03	23	Client{ id: 23 first_name: ???????? last_name: ???????????? email: pupkin@mail.ru gender: 1 avatar: avatars/foto-vasia-pupkin.jpeg	3		8	1
85	2021-04-29 23:32:45.59732+03	1	Match{ from_id: Client{ id: 20 first_name: ???????? last_name: ???????????? email: ivan@mail.ru gender: 1 avatar: avatars/foto-ivan-ivanov_FJMCSPQ.jpeg to_id: Client{ id: 25 first_name: ???????? last_name: ???????????? e	1	[{"added": {}}]	9	1
86	2021-04-29 23:34:51.382695+03	1	Match{ from_id: Client{ id: 20 first_name: ???????? last_name: ???????????? email: ivan@mail.ru gender: 1 avatar: avatars/foto-ivan-ivanov_FJMCSPQ.jpeg to_id: Client{ id: 25 first_name: ???????? last_name: ???????????? e	3		9	1
87	2021-04-29 23:44:40.874669+03	2	Match{ from_id: Client{ id: 20 first_name: ???????? last_name: ???????????? email: ivan@mail.ru gender: 1 avatar: avatars/foto-ivan-ivanov_FJMCSPQ.jpeg to_id: Client{ id: 20 first_name: ???????? last_name: ???????????? e	3		9	1
88	2021-04-29 23:49:54.234751+03	3	Match{ from_id: Client{ id: 20 first_name: ???????? last_name: ???????????? email: ivan@mail.ru gender: 1 avatar: avatars/foto-ivan-ivanov_FJMCSPQ.jpeg to_id: Client{ id: 25 first_name: ???????? last_name: ???????????? e	3		9	1
89	2021-04-30 00:13:55.140354+03	4	Match{ from_id: Client{ id: 20 first_name: ???????? last_name: ???????????? email: ivan@mail.ru gender: 1 avatar: avatars/foto-ivan-ivanov_FJMCSPQ.jpeg to_id: Client{ id: 25 first_name: ???????? last_name: ???????????? e	3		9	1
90	2021-04-30 14:46:45.570104+03	26	Client{ id: 26 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_yo2mIpy.jpeg }	3		8	1
91	2021-04-30 14:46:45.703144+03	27	Client{ id: 27 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_R3dDIev.jpeg }	3		8	1
92	2021-04-30 14:46:45.721751+03	28	Client{ id: 28 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_A3RUaYZ.jpeg }	3		8	1
93	2021-04-30 14:46:45.730242+03	29	Client{ id: 29 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_alIaADB.jpeg }	3		8	1
94	2021-04-30 14:46:45.738456+03	30	Client{ id: 30 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_0ogqj8f.jpeg }	3		8	1
95	2021-04-30 14:46:45.746564+03	31	Client{ id: 31 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_kvOCWDK.jpeg }	3		8	1
96	2021-04-30 15:59:02.359645+03	32	Client{ id: 32 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_B5oWXle.jpeg }	3		8	1
97	2021-04-30 16:53:16.759567+03	6	Match{ from_id: Client{ id: 25 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina.jpeg } to_id: Client{ id: 20 first_name: ???????? last_name: ???????????? em	3		9	1
98	2021-04-30 17:10:25.516737+03	7	Match{ from_id: 25 to_id: 20 is_mutually: False }	3		9	1
99	2021-04-30 17:13:04.13887+03	8	Match{ from_id: 25 to_id: 20 is_mutually: False }	3		9	1
100	2021-04-30 17:14:28.582846+03	9	Match{ from_id: 25 to_id: 20 is_mutually: False }	3		9	1
101	2021-04-30 17:35:31.982599+03	10	Match{ from_id: 25 to_id: 20 is_mutually: True }	3		9	1
102	2021-04-30 17:39:31.022547+03	11	Match{ from_id: 20 to_id: 25 is_mutually: True }	3		9	1
103	2021-04-30 17:41:32.844588+03	12	Match{ from_id: 25 to_id: 20 is_mutually: True }	3		9	1
104	2021-04-30 17:47:53.657071+03	13	Match{ from_id: 20 to_id: 25 is_mutually: True }	3		9	1
105	2021-04-30 17:58:23.525474+03	14	Match{ from_id: 25 to_id: 20 is_mutually: True }	3		9	1
106	2021-04-30 18:01:02.529117+03	15	Match{ from_id: 20 to_id: 25 is_mutually: True }	3		9	1
107	2021-04-30 18:01:51.719205+03	16	Match{ from_id: 25 to_id: 20 is_mutually: True }	3		9	1
108	2021-04-30 18:04:32.462891+03	17	Match{ from_id: 20 to_id: 25 is_mutually: True }	3		9	1
109	2021-04-30 21:57:37.596607+03	18	Match{ from_id: 25 to_id: 20 is_mutually: True }	3		9	1
110	2021-04-30 21:58:26.865184+03	33	Client{ id: 33 first_name: ???????? last_name: ???????????? email: mashina@mail.ru gender: 2 avatar: avatars/foto-masha-mashina_FcVya59.jpeg }	3		8	1
111	2021-05-06 10:40:17.708319+03	1	Category object (1)	1	[{"added": {}}]	12	1
112	2021-05-06 10:42:11.320445+03	2	Category{ id: 2 name: ?????????????????? }	1	[{"added": {}}]	12	1
113	2021-05-06 10:47:25.263851+03	3	Category{ id: 3 name: ?????????????? ???????????? }	1	[{"added": {}}]	12	1
114	2021-05-06 10:48:43.810048+03	3	Category{ id: 3 name: ?????????????? ???????????? }	2	[{"changed": {"fields": ["Parent"]}}]	12	1
115	2021-05-06 10:52:38.057615+03	1	Product object (1)	1	[{"added": {}}]	11	1
116	2021-05-06 11:08:09.214756+03	1	Product object (1)	3		11	1
117	2021-05-06 11:09:30.944905+03	2	Product object (2)	1	[{"added": {}}]	11	1
118	2021-05-06 11:31:25.073423+03	2	Product object (2)	3		11	1
119	2021-05-06 11:32:00.223971+03	3	Product object (3)	1	[{"added": {}}]	11	1
120	2021-05-06 11:32:46.871303+03	3	Product object (3)	3		11	1
121	2021-05-06 11:34:17.295219+03	4	Product object (4)	1	[{"added": {}}]	11	1
122	2021-05-06 11:34:23.915891+03	4	Product object (4)	3		11	1
123	2021-05-06 11:36:04.410833+03	5	Product object (5)	1	[{"added": {}}]	11	1
124	2021-05-06 11:36:11.261183+03	5	Product object (5)	3		11	1
125	2021-05-06 11:39:50.550939+03	6	Product object (6)	1	[{"added": {}}]	11	1
126	2021-05-06 11:44:42.49739+03	6	Product object (6)	3		11	1
127	2021-05-06 11:46:09.777909+03	7	Product object (7)	1	[{"added": {}}]	11	1
129	2021-05-06 11:48:12.618728+03	7	Product object (7)	3		11	1
130	2021-05-06 11:48:42.94731+03	8	Product object (8)	1	[{"added": {}}]	11	1
132	2021-05-06 11:49:55.852866+03	8	Product object (8)	3		11	1
133	2021-05-06 11:50:14.016174+03	9	Product object (9)	1	[{"added": {}}]	11	1
134	2021-05-06 11:50:19.352784+03	9	Product object (9)	3		11	1
135	2021-05-06 13:46:13.576944+03	10	Product object (10)	1	[{"added": {}}]	11	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	dating	user
8	dating	client
9	dating	match
10	dating	message
11	products	product
12	products	category
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-04-29 12:12:39.632911+03
2	auth	0001_initial	2021-04-29 12:12:40.632202+03
3	admin	0001_initial	2021-04-29 12:12:40.823307+03
4	admin	0002_logentry_remove_auto_add	2021-04-29 12:12:40.842878+03
5	admin	0003_logentry_add_action_flag_choices	2021-04-29 12:12:40.856445+03
6	contenttypes	0002_remove_content_type_name	2021-04-29 12:12:40.884754+03
7	auth	0002_alter_permission_name_max_length	2021-04-29 12:12:40.897519+03
8	auth	0003_alter_user_email_max_length	2021-04-29 12:12:40.915767+03
9	auth	0004_alter_user_username_opts	2021-04-29 12:12:40.929013+03
10	auth	0005_alter_user_last_login_null	2021-04-29 12:12:40.94901+03
11	auth	0006_require_contenttypes_0002	2021-04-29 12:12:40.956708+03
12	auth	0007_alter_validators_add_error_messages	2021-04-29 12:12:40.974236+03
13	auth	0008_alter_user_username_max_length	2021-04-29 12:12:41.048893+03
14	auth	0009_alter_user_last_name_max_length	2021-04-29 12:12:41.085581+03
15	auth	0010_alter_group_name_max_length	2021-04-29 12:12:41.122569+03
16	auth	0011_update_proxy_permissions	2021-04-29 12:12:41.137666+03
17	auth	0012_alter_user_first_name_max_length	2021-04-29 12:12:41.156381+03
18	sessions	0001_initial	2021-04-29 12:12:41.364329+03
19	dating	0001_initial	2021-04-29 12:21:06.065522+03
20	dating	0002_user_avatar	2021-04-29 13:43:45.36701+03
21	dating	0003_alter_user_avatar	2021-04-29 13:45:18.040892+03
23	dating	0004_auto_20210429_2031	2021-04-29 23:31:21.51598+03
24	dating	0005_auto_20210430_1025	2021-04-30 13:25:17.940993+03
25	dating	0006_alter_client_avatar	2021-05-03 15:01:24.467254+03
26	dating	0007_alter_client_email	2021-05-04 11:37:12.091075+03
27	dating	0008_message	2021-05-04 11:41:00.797924+03
28	products	0001_initial	2021-05-06 09:44:17.718054+03
29	products	0002_auto_20210506_0650	2021-05-06 09:50:43.30153+03
30	products	0003_alter_product_name	2021-05-06 10:20:36.098423+03
31	products	0004_alter_product_image	2021-05-06 10:37:19.850798+03
32	products	0005_alter_product_image	2021-05-06 11:08:39.328761+03
33	dating	0007_auto_20210507_1203	2021-05-07 15:03:59.847533+03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
50ffq2b02689x2sb2jv5z5kvwwelpw1o	.eJxVjDkOwjAUBe_iGlnyblPScwbrLzYOIEfKUkXcHVlKAe2bmXeIDPvW8r6WJU8srkKJy--GQK_SB-An9Mcsae7bMqEcijzpKu8zl_ftdP8OGqxt1MwhWoNRQdWOPSDaQioQ2mBiVUYnRO1IJ12t5-BdqlRNJVQKHGvx-QL_NziQ:1lc2sg:8a8fexMwtjdX1Sojei6yVkmFcCFw-rsWPcxjBtHhLu8	2021-05-13 12:22:46.289829+03
\.


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matches (id, is_mutually, from_id_id, to_id_id) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, price, image, category_id) FROM stdin;
165	???????????? ?????????????????????? ????????-????(??) LS 3x1.5????2 50?? ???????? ???????? ????????????	2470.00	products/1394030-v01-m.jpg	3
166	???????????? ?????????????????????? ?????? 2x2.5????2 50?? ???????? ???????? ??????????	2340.00	products/1393994-v01-m.jpg	3
167	???????????? Falcon Eye ????????-????(??) LS 2x2.5????2 20?? ???????? ???????? ????????????	820.00	products/1366117-v01-m.jpg	3
168	???????????? Falcon Eye ????????-????(??) LS 3x1.5????2 50?? ???????? ???????? ????????????	2030.00	products/1366121-v01-m.jpg	3
169	???????????? ?????????????????????? ????????-???? 3x2.5????2 50?? ???????? ???????? ????????????	3790.00	products/1393968-v01-m.jpg	3
170	???????????? ?????????????????????? ?????? 2x1.5????2 50?? ???????? ???????? ??????????	1920.00	products/1393983-v01-m.jpg	3
171	???????????? ?????????????????????? ????????-????(??) LS 3x2.5????2 20?? ???????? ???????? ????????????	1580.00	products/1394034-v01-m.jpg	3
172	???????????? ?????????????????????? ?????? 2x1.5????2 20?? ???????? ???????? ??????????	810.00	products/1393982-v01-m.jpg	3
173	???????????? ?????????????????????? ????????-????(??) LS 3x1.5????2 10?? ???????? ???????? ????????????	430.00	products/1394077-v01-m.jpg	3
10	???????????????? ??????????	999.00	products/dating-product-test-image.jpg	3
174	???????????? ?????????????????????? ???????? 2x0.75????2 20?? ???????? ???????? ??????????	400.00	products/1393971-v01-m.jpg	3
175	???????????? ?????????????????????? ????????-???? 2x1.5????2 50?? ???????? ???????? ????????????	1680.00	products/1393948-v01-m.jpg	3
176	???????????? ?????????????????????? ????????-???? 3x1.5????2 20?? ???????? ???????? ????????????	790.00	products/1393960-v01-m.jpg	3
177	???????????? ?????????????????????? ?????? 2x2.5????2 10?? ???????? ???????? ??????????	510.00	products/1394068-v01-m.jpg	3
178	???????????? ?????????????????????? ?????? 3x0.75????2 10?? ???????? ???????? ??????????	270.00	products/1394069-v01-m.jpg	3
179	???????????? ?????????????????????? ???????? 2x0.75????2 50?? ???????? ???????? ??????????	940.00	products/1393972-v01-m.jpg	3
180	???????????? ?????????????????????? ????????-????(??) LS 2x2.5????2 10?? ???????? ???????? ????????????	480.00	products/1394076-v01-m.jpg	3
181	???????????? ?????????????????????? ?????? 3x2.5????2 20?? ???????? ???????? ??????????	1320.00	products/1394006-v01-m.jpg	3
182	???????????? ?????????????????????? NUM-O 2x2.5????2 20?? ???????? ???????? ??????????	1050.00	products/1394043-v01-m.jpg	3
183	???????????? Falcon Eye ?????? 2x2.5????2 100?? ???????? ???????? ??????????	4480.00	products/1366097-v01-m.jpg	3
184	???????????? Falcon Eye ?????? 2x1.5????2 50?? ???????? ???????? ??????????	1420.00	products/1366091-v01-m.jpg	3
185	???????????? Falcon Eye ?????? 3x1.5????2 20?? ???????? ???????? ??????????	800.00	products/1366106-v01-m.jpg	3
186	???????????? ?????????????????????? NUM-O 2x1.5????2 10?? ???????? ???????? ??????????	360.00	products/1394082-v01-m.jpg	3
187	???????????? ?????????????????????? ?????? 3x1.5????2 20?? ???????? ???????? ??????????	850.00	products/1394002-v01-m.jpg	3
188	???????????? Falcon Eye ?????? 3x2.5????2 50?? ???????? ???????? ??????????	3060.00	products/1366111-v01-m.jpg	3
189	???????????? ?????????????????????? ????????-???? 2x2.5????2 10?? ???????? ???????? ????????????	450.00	products/1394056-v01-m.jpg	3
190	???????????? ?????????????????????? NUM-O 2x1.5????2 50?? ???????? ???????? ??????????	1720.00	products/1394040-v01-m.jpg	3
191	???????????? Falcon Eye ?????? 3x2.5????2 100?? ???????? ???????? ??????????	6100.00	products/1366112-v01-m.jpg	3
192	???????????? ?????????????????????? ?????? 3x1.5????2 10?? ???????? ???????? ??????????	490.00	products/1394072-v01-m.jpg	3
193	???????????? ?????????????????????? ?????? 3x2.5????2 50?? ???????? ???????? ??????????	3270.00	products/1394007-v01-m.jpg	3
194	???????????? ?????????????????????? NUM-O 2x2.5????2 50?? ???????? ???????? ??????????	2580.00	products/1394044-v01-m.jpg	3
195	???????????? ?????????????????????? ?????? 2x2.5????2 100?? ???????? ???????? ??????????	4590.00	products/1393995-v01-m.jpg	3
196	???????????? ?????????????????????? NUM-J 3x2.5????2 10?? ???????? ???????? ??????????	720.00	products/1394085-v01-m.jpg	3
197	???????????? Falcon Eye ?????? 3x1.5????2 50?? ???????? ???????? ??????????	1970.00	products/1366108-v01-m.jpg	3
198	???????????? ?????????????????????? ?????? 3x2.5????2 10?? ???????? ???????? ??????????	710.00	products/1394073-v01-m.jpg	3
199	???????????? Rexant ????????-???? 1x50????2 3?? ???????? ???????? ???????????? (01-8414-3)	1490.00	products/1385919-v01-m.jpg	3
200	???????????? Falcon Eye ?????? 3x2.5????2 20?? ???????? ???????? ??????????	1270.00	products/1366110-v01-m.jpg	3
201	???????????? ?????????????????????? ?????? 3x0.75????2 50?? ???????? ???????? ??????????	1170.00	products/1393998-v01-m.jpg	3
202	???????????? Falcon Eye ?????? 2x1.5????2 100?? ???????? ???????? ??????????	2840.00	products/1366092-v01-m.jpg	3
203	???????????? ?????????????????????? NUM-J 3x1.5????2 10?? ???????? ???????? ??????????	490.00	products/1394084-v01-m.jpg	3
204	???????????? Rexant ?????? 2x1.5????2 50?? ???????? ???????? ?????????? (01-8035-50)	1790.00	products/1385855-v01-m.jpg	3
205	???????????? Rexant ?????? 2x2.5????2 50?? ???????? ???????? ?????????? (01-8036-50)	2900.00	products/1385859-v01-m.jpg	3
206	???????????? Falcon Eye ?????? 3x0.75????2 50?? ???????? ???????? ??????????	1130.00	products/1366103-v01-m.jpg	3
207	???????????? Rexant ?????? 3x2.5????2 50?? ???????? ???????? ?????????? (01-8048-50)	4080.00	products/1385871-v01-m.jpg	3
208	???????????? Rexant ?????? 3x0.75????2 20?? ???????? ???????? ?????????? (01-8042-20)	600.00	products/1385861-v01-m.jpg	3
209	???????????? Rexant ????????-???? 3x2.5????2 50?? ???????? ???????? ???????????? (01-8421-50)	4080.00	products/1385932-v01-m.jpg	3
210	???????????? ?????????????????????? ?????? 3x0.75????2 100?? ???????? ???????? ??????????	2300.00	products/1393999-v01-m.jpg	3
211	???????????? Rexant ?????? 3x1.5????2 20?? ???????? ???????? ?????????? (01-8046-20)	1010.00	products/1385865-v01-m.jpg	3
212	???????????? Falcon Eye ?????? 3x0.75????2 100?? ???????? ???????? ??????????	2220.00	products/1366104-v01-m.jpg	3
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, gender, avatar, coord_x, coord_y) FROM stdin;
20	????????	????????????	ivan@mail.ru	1	avatars/foto-ivan-ivanov_FJMCSPQ.jpeg	\N	\N
24	????????	????????????	pupkin@mail.ru	1	avatars/foto-vasia-pupkin_ZI4vVT8.jpeg	\N	\N
25	????????	????????????	mashina@mail.ru	2	avatars/foto-masha-mashina.jpeg	\N	\N
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 3, true);


--
-- Name: dating_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dating_message_id_seq', 18, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 135, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 33, true);


--
-- Name: matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.matches_id_seq', 18, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 212, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 33, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: dating_message dating_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dating_message
    ADD CONSTRAINT dating_message_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_email_0ea73cca_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_0ea73cca_uniq UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: categories_parent_id_fc02df82; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX categories_parent_id_fc02df82 ON public.categories USING btree (parent_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: matches_from_id_id_c2f42b40; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX matches_from_id_id_c2f42b40 ON public.matches USING btree (from_id_id);


--
-- Name: matches_to_id_id_b1c913a5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX matches_to_id_id_b1c913a5 ON public.matches USING btree (to_id_id);


--
-- Name: products_category_id_a7a3a156; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_category_id_a7a3a156 ON public.products USING btree (category_id);


--
-- Name: users_email_0ea73cca_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_email_0ea73cca_like ON public.users USING btree (email varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: categories categories_parent_id_fc02df82_fk_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_fc02df82_fk_categories_id FOREIGN KEY (parent_id) REFERENCES public.categories(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: matches matches_from_id_id_c2f42b40_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_from_id_id_c2f42b40_fk_users_id FOREIGN KEY (from_id_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: matches matches_to_id_id_b1c913a5_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_to_id_id_b1c913a5_fk_users_id FOREIGN KEY (to_id_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products products_category_id_a7a3a156_fk_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_a7a3a156_fk_categories_id FOREIGN KEY (category_id) REFERENCES public.categories(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

