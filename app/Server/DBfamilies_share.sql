PGDMP                          z            DBfamilies_share    13.5    13.2 _                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            !           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            "           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            #           1262    16819    DBfamilies_share    DATABASE     n   CREATE DATABASE "DBfamilies_share" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';
 "   DROP DATABASE "DBfamilies_share";
                postgres    false            �            1255    17246 "   truncate_tables(character varying)    FUNCTION     �  CREATE FUNCTION public.truncate_tables(username character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    statements CURSOR FOR
        SELECT tablename FROM pg_tables
        WHERE tableowner = username AND schemaname = 'public';
BEGIN
    FOR stmt IN statements LOOP
        EXECUTE 'TRUNCATE TABLE ' || quote_ident(stmt.tablename) || ' CASCADE;';
    END LOOP;
END;
$$;
 B   DROP FUNCTION public.truncate_tables(username character varying);
       public          postgres    false            �            1259    17091    Announcements    TABLE     �   CREATE TABLE public."Announcements" (
    id_announcement bigint NOT NULL,
    title text,
    description text,
    creator bigint NOT NULL,
    type boolean
);
 #   DROP TABLE public."Announcements";
       public         heap    postgres    false            �            1259    17121    AnnouncementsGroups    TABLE     q   CREATE TABLE public."AnnouncementsGroups" (
    id_announcement bigint NOT NULL,
    id_group bigint NOT NULL
);
 )   DROP TABLE public."AnnouncementsGroups";
       public         heap    postgres    false            �            1259    17117 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."AnnouncementsGroups_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public."AnnouncementsGroups_id_announcement_seq";
       public          postgres    false    209            $           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public."AnnouncementsGroups_id_announcement_seq" OWNED BY public."AnnouncementsGroups".id_announcement;
          public          postgres    false    207            �            1259    17119     AnnouncementsGroups_id_group_seq    SEQUENCE     �   CREATE SEQUENCE public."AnnouncementsGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."AnnouncementsGroups_id_group_seq";
       public          postgres    false    209            %           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."AnnouncementsGroups_id_group_seq" OWNED BY public."AnnouncementsGroups".id_group;
          public          postgres    false    208            �            1259    17089    Announcements_creator_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_creator_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."Announcements_creator_seq";
       public          postgres    false    204            &           0    0    Announcements_creator_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."Announcements_creator_seq" OWNED BY public."Announcements".creator;
          public          postgres    false    203            �            1259    17087 !   Announcements_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public."Announcements_id_announcement_seq";
       public          postgres    false    204            '           0    0 !   Announcements_id_announcement_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."Announcements_id_announcement_seq" OWNED BY public."Announcements".id_announcement;
          public          postgres    false    202            �            1259    17165    Chats    TABLE     s   CREATE TABLE public."Chats" (
    id_chat bigint NOT NULL,
    user1 bigint NOT NULL,
    user2 bigint NOT NULL
);
    DROP TABLE public."Chats";
       public         heap    postgres    false            �            1259    17161    Chats_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Chats_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."Chats_announcement_seq";
       public          postgres    false    216            (           0    0    Chats_announcement_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."Chats_announcement_seq" OWNED BY public."Chats".user1;
          public          postgres    false    214            �            1259    17159    Chats_id_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Chats_id_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Chats_id_chat_seq";
       public          postgres    false    216            )           0    0    Chats_id_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Chats_id_chat_seq" OWNED BY public."Chats".id_chat;
          public          postgres    false    213            �            1259    17163    Chats_interested_seq    SEQUENCE        CREATE SEQUENCE public."Chats_interested_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Chats_interested_seq";
       public          postgres    false    216            *           0    0    Chats_interested_seq    SEQUENCE OWNED BY     L   ALTER SEQUENCE public."Chats_interested_seq" OWNED BY public."Chats".user2;
          public          postgres    false    215            �            1259    17108    Groups    TABLE     d   CREATE TABLE public."Groups" (
    id_group bigint NOT NULL,
    name text,
    description text
);
    DROP TABLE public."Groups";
       public         heap    postgres    false            �            1259    17106    Groups_id_group_seq    SEQUENCE     ~   CREATE SEQUENCE public."Groups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Groups_id_group_seq";
       public          postgres    false    206            +           0    0    Groups_id_group_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Groups_id_group_seq" OWNED BY public."Groups".id_group;
          public          postgres    false    205            �            1259    17206    Images    TABLE     d   CREATE TABLE public."Images" (
    image_path text NOT NULL,
    id_announcement bigint NOT NULL
);
    DROP TABLE public."Images";
       public         heap    postgres    false            �            1259    17204    Images_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Images_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public."Images_id_announcement_seq";
       public          postgres    false    221            ,           0    0    Images_id_announcement_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."Images_id_announcement_seq" OWNED BY public."Images".id_announcement;
          public          postgres    false    220            �            1259    17188    Messages    TABLE     �   CREATE TABLE public."Messages" (
    id_message bigint NOT NULL,
    text text,
    chat bigint NOT NULL,
    sender bigint,
    date_time timestamp without time zone
);
    DROP TABLE public."Messages";
       public         heap    postgres    false            �            1259    17186    Messages_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Messages_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Messages_chat_seq";
       public          postgres    false    219            -           0    0    Messages_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Messages_chat_seq" OWNED BY public."Messages".chat;
          public          postgres    false    218            �            1259    17184    Messages_id_message_seq    SEQUENCE     �   CREATE SEQUENCE public."Messages_id_message_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Messages_id_message_seq";
       public          postgres    false    219            .           0    0    Messages_id_message_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Messages_id_message_seq" OWNED BY public."Messages".id_message;
          public          postgres    false    217            �            1259    17078    Users    TABLE     �   CREATE TABLE public."Users" (
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
    DROP TABLE public."Users";
       public         heap    postgres    false            �            1259    17142    UsersGroups    TABLE     a   CREATE TABLE public."UsersGroups" (
    id_user bigint NOT NULL,
    id_group bigint NOT NULL
);
 !   DROP TABLE public."UsersGroups";
       public         heap    postgres    false            �            1259    17140    UsersGroups_id_group_seq    SEQUENCE     �   CREATE SEQUENCE public."UsersGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."UsersGroups_id_group_seq";
       public          postgres    false    212            /           0    0    UsersGroups_id_group_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."UsersGroups_id_group_seq" OWNED BY public."UsersGroups".id_group;
          public          postgres    false    211            �            1259    17138    UsersGroups_id_user_seq    SEQUENCE     �   CREATE SEQUENCE public."UsersGroups_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."UsersGroups_id_user_seq";
       public          postgres    false    212            0           0    0    UsersGroups_id_user_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."UsersGroups_id_user_seq" OWNED BY public."UsersGroups".id_user;
          public          postgres    false    210            �            1259    17076    Users_id_user_seq    SEQUENCE     |   CREATE SEQUENCE public."Users_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Users_id_user_seq";
       public          postgres    false    201            1           0    0    Users_id_user_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Users_id_user_seq" OWNED BY public."Users".id_user;
          public          postgres    false    200            _           2604    17094    Announcements id_announcement    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Announcements_id_announcement_seq"'::regclass);
 N   ALTER TABLE public."Announcements" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    202    204    204            `           2604    17095    Announcements creator    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN creator SET DEFAULT nextval('public."Announcements_creator_seq"'::regclass);
 F   ALTER TABLE public."Announcements" ALTER COLUMN creator DROP DEFAULT;
       public          postgres    false    204    203    204            b           2604    17124 #   AnnouncementsGroups id_announcement    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_announcement SET DEFAULT nextval('public."AnnouncementsGroups_id_announcement_seq"'::regclass);
 T   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    209    207    209            c           2604    17125    AnnouncementsGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."AnnouncementsGroups_id_group_seq"'::regclass);
 M   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    209    208    209            f           2604    17168    Chats id_chat    DEFAULT     r   ALTER TABLE ONLY public."Chats" ALTER COLUMN id_chat SET DEFAULT nextval('public."Chats_id_chat_seq"'::regclass);
 >   ALTER TABLE public."Chats" ALTER COLUMN id_chat DROP DEFAULT;
       public          postgres    false    213    216    216            g           2604    17169    Chats user1    DEFAULT     u   ALTER TABLE ONLY public."Chats" ALTER COLUMN user1 SET DEFAULT nextval('public."Chats_announcement_seq"'::regclass);
 <   ALTER TABLE public."Chats" ALTER COLUMN user1 DROP DEFAULT;
       public          postgres    false    216    214    216            h           2604    17170    Chats user2    DEFAULT     s   ALTER TABLE ONLY public."Chats" ALTER COLUMN user2 SET DEFAULT nextval('public."Chats_interested_seq"'::regclass);
 <   ALTER TABLE public."Chats" ALTER COLUMN user2 DROP DEFAULT;
       public          postgres    false    216    215    216            a           2604    17111    Groups id_group    DEFAULT     v   ALTER TABLE ONLY public."Groups" ALTER COLUMN id_group SET DEFAULT nextval('public."Groups_id_group_seq"'::regclass);
 @   ALTER TABLE public."Groups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    205    206    206            k           2604    17209    Images id_announcement    DEFAULT     �   ALTER TABLE ONLY public."Images" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Images_id_announcement_seq"'::regclass);
 G   ALTER TABLE public."Images" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    221    220    221            i           2604    17191    Messages id_message    DEFAULT     ~   ALTER TABLE ONLY public."Messages" ALTER COLUMN id_message SET DEFAULT nextval('public."Messages_id_message_seq"'::regclass);
 D   ALTER TABLE public."Messages" ALTER COLUMN id_message DROP DEFAULT;
       public          postgres    false    217    219    219            j           2604    17192    Messages chat    DEFAULT     r   ALTER TABLE ONLY public."Messages" ALTER COLUMN chat SET DEFAULT nextval('public."Messages_chat_seq"'::regclass);
 >   ALTER TABLE public."Messages" ALTER COLUMN chat DROP DEFAULT;
       public          postgres    false    219    218    219            ^           2604    17081    Users id_user    DEFAULT     r   ALTER TABLE ONLY public."Users" ALTER COLUMN id_user SET DEFAULT nextval('public."Users_id_user_seq"'::regclass);
 >   ALTER TABLE public."Users" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    201    200    201            d           2604    17145    UsersGroups id_user    DEFAULT     ~   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_user SET DEFAULT nextval('public."UsersGroups_id_user_seq"'::regclass);
 D   ALTER TABLE public."UsersGroups" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    212    210    212            e           2604    17146    UsersGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."UsersGroups_id_group_seq"'::regclass);
 E   ALTER TABLE public."UsersGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    212    211    212                      0    17091    Announcements 
   TABLE DATA           ]   COPY public."Announcements" (id_announcement, title, description, creator, type) FROM stdin;
    public          postgres    false    204   (q                 0    17121    AnnouncementsGroups 
   TABLE DATA           J   COPY public."AnnouncementsGroups" (id_announcement, id_group) FROM stdin;
    public          postgres    false    209   Eq                 0    17165    Chats 
   TABLE DATA           8   COPY public."Chats" (id_chat, user1, user2) FROM stdin;
    public          postgres    false    216   bq                 0    17108    Groups 
   TABLE DATA           ?   COPY public."Groups" (id_group, name, description) FROM stdin;
    public          postgres    false    206   q                 0    17206    Images 
   TABLE DATA           ?   COPY public."Images" (image_path, id_announcement) FROM stdin;
    public          postgres    false    221   �q                 0    17188    Messages 
   TABLE DATA           O   COPY public."Messages" (id_message, text, chat, sender, date_time) FROM stdin;
    public          postgres    false    219   �q       	          0    17078    Users 
   TABLE DATA           �   COPY public."Users" (id_user, username, name, surname, password, birth_date, email, phone, street, city, postal_code) FROM stdin;
    public          postgres    false    201   �q                 0    17142    UsersGroups 
   TABLE DATA           :   COPY public."UsersGroups" (id_user, id_group) FROM stdin;
    public          postgres    false    212   �q       2           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_announcement_seq"', 1, false);
          public          postgres    false    207            3           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_group_seq"', 1, false);
          public          postgres    false    208            4           0    0    Announcements_creator_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Announcements_creator_seq"', 1, false);
          public          postgres    false    203            5           0    0 !   Announcements_id_announcement_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public."Announcements_id_announcement_seq"', 56, true);
          public          postgres    false    202            6           0    0    Chats_announcement_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Chats_announcement_seq"', 1, false);
          public          postgres    false    214            7           0    0    Chats_id_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Chats_id_chat_seq"', 22, true);
          public          postgres    false    213            8           0    0    Chats_interested_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Chats_interested_seq"', 1, false);
          public          postgres    false    215            9           0    0    Groups_id_group_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Groups_id_group_seq"', 17, true);
          public          postgres    false    205            :           0    0    Images_id_announcement_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Images_id_announcement_seq"', 1, false);
          public          postgres    false    220            ;           0    0    Messages_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Messages_chat_seq"', 1, false);
          public          postgres    false    218            <           0    0    Messages_id_message_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Messages_id_message_seq"', 3, true);
          public          postgres    false    217            =           0    0    UsersGroups_id_group_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."UsersGroups_id_group_seq"', 1, false);
          public          postgres    false    211            >           0    0    UsersGroups_id_user_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."UsersGroups_id_user_seq"', 1, false);
          public          postgres    false    210            ?           0    0    Users_id_user_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Users_id_user_seq"', 39, true);
          public          postgres    false    200            s           2606    17127 ,   AnnouncementsGroups AnnouncementsGroups_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_pkey" PRIMARY KEY (id_announcement, id_group);
 Z   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_pkey";
       public            postgres    false    209    209            o           2606    17100     Announcements Announcements_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_pkey" PRIMARY KEY (id_announcement);
 N   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_pkey";
       public            postgres    false    204            w           2606    17172    Chats Chats_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_pkey" PRIMARY KEY (id_chat);
 >   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_pkey";
       public            postgres    false    216            q           2606    17116    Groups Groups_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Groups"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id_group);
 @   ALTER TABLE ONLY public."Groups" DROP CONSTRAINT "Groups_pkey";
       public            postgres    false    206            {           2606    17214    Images Images_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_pkey" PRIMARY KEY (image_path);
 @   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_pkey";
       public            postgres    false    221            y           2606    17197    Messages Messages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id_message);
 D   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_pkey";
       public            postgres    false    219            u           2606    17148    UsersGroups UsersGroups_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_pkey" PRIMARY KEY (id_user, id_group);
 J   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_pkey";
       public            postgres    false    212    212            m           2606    17086    Users Users_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public            postgres    false    201            }           2606    17128 <   AnnouncementsGroups AnnouncementsGroups_id_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement);
 j   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_announcement_fkey";
       public          postgres    false    209    204    2927            ~           2606    17133 5   AnnouncementsGroups AnnouncementsGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group) NOT VALID;
 c   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_group_fkey";
       public          postgres    false    209    206    2929            |           2606    17101 (   Announcements Announcements_creator_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_creator_fkey" FOREIGN KEY (creator) REFERENCES public."Users"(id_user);
 V   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_creator_fkey";
       public          postgres    false    2925    201    204            �           2606    17236    Chats Chats_user1_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_user1_fkey" FOREIGN KEY (user1) REFERENCES public."Users"(id_user) NOT VALID;
 D   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_user1_fkey";
       public          postgres    false    216    2925    201            �           2606    17178    Chats Chats_user2_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_user2_fkey" FOREIGN KEY (user2) REFERENCES public."Users"(id_user);
 D   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_user2_fkey";
       public          postgres    false    201    2925    216            �           2606    17215 "   Images Images_id_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement) NOT VALID;
 P   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_id_announcement_fkey";
       public          postgres    false    2927    204    221            �           2606    17198    Messages Messages_chat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_chat_fkey" FOREIGN KEY (chat) REFERENCES public."Chats"(id_chat);
 I   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_chat_fkey";
       public          postgres    false    2935    219    216            �           2606    17241    Messages Messages_sender_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_sender_fkey" FOREIGN KEY (sender) REFERENCES public."Users"(id_user) NOT VALID;
 K   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_sender_fkey";
       public          postgres    false    2925    201    219            �           2606    17154 %   UsersGroups UsersGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group);
 S   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_group_fkey";
       public          postgres    false    2929    206    212                       2606    17149 $   UsersGroups UsersGroups_id_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_user_fkey" FOREIGN KEY (id_user) REFERENCES public."Users"(id_user);
 R   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_user_fkey";
       public          postgres    false    201    212    2925                  x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �      	      x������ � �            x������ � �     