PGDMP     #    4                 z            DBfamilies_share    14.1    14.1 _    [           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            \           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ]           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ^           1262    16737    DBfamilies_share    DATABASE     ]   CREATE DATABASE "DBfamilies_share" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
 "   DROP DATABASE "DBfamilies_share";
                postgres    false            ?            1255    16738 "   truncate_tables(character varying)    FUNCTION     ?  CREATE FUNCTION public.truncate_tables(username character varying) RETURNS void
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
       public          postgres    false            ?            1259    16739    Announcements    TABLE     ?   CREATE TABLE public."Announcements" (
    id_announcement bigint NOT NULL,
    title text,
    description text,
    creator bigint NOT NULL,
    type boolean
);
 #   DROP TABLE public."Announcements";
       public         heap    postgres    false            ?            1259    16744    AnnouncementsGroups    TABLE     q   CREATE TABLE public."AnnouncementsGroups" (
    id_announcement bigint NOT NULL,
    id_group bigint NOT NULL
);
 )   DROP TABLE public."AnnouncementsGroups";
       public         heap    postgres    false            ?            1259    16747 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE     ?   CREATE SEQUENCE public."AnnouncementsGroups_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public."AnnouncementsGroups_id_announcement_seq";
       public          postgres    false    210            _           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public."AnnouncementsGroups_id_announcement_seq" OWNED BY public."AnnouncementsGroups".id_announcement;
          public          postgres    false    211            ?            1259    16748     AnnouncementsGroups_id_group_seq    SEQUENCE     ?   CREATE SEQUENCE public."AnnouncementsGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."AnnouncementsGroups_id_group_seq";
       public          postgres    false    210            `           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."AnnouncementsGroups_id_group_seq" OWNED BY public."AnnouncementsGroups".id_group;
          public          postgres    false    212            ?            1259    16749    Announcements_creator_seq    SEQUENCE     ?   CREATE SEQUENCE public."Announcements_creator_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."Announcements_creator_seq";
       public          postgres    false    209            a           0    0    Announcements_creator_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."Announcements_creator_seq" OWNED BY public."Announcements".creator;
          public          postgres    false    213            ?            1259    16750 !   Announcements_id_announcement_seq    SEQUENCE     ?   CREATE SEQUENCE public."Announcements_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public."Announcements_id_announcement_seq";
       public          postgres    false    209            b           0    0 !   Announcements_id_announcement_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."Announcements_id_announcement_seq" OWNED BY public."Announcements".id_announcement;
          public          postgres    false    214            ?            1259    16751    Chats    TABLE     s   CREATE TABLE public."Chats" (
    id_chat bigint NOT NULL,
    user1 bigint NOT NULL,
    user2 bigint NOT NULL
);
    DROP TABLE public."Chats";
       public         heap    postgres    false            ?            1259    16754    Chats_announcement_seq    SEQUENCE     ?   CREATE SEQUENCE public."Chats_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."Chats_announcement_seq";
       public          postgres    false    215            c           0    0    Chats_announcement_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."Chats_announcement_seq" OWNED BY public."Chats".user1;
          public          postgres    false    216            ?            1259    16755    Chats_id_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Chats_id_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Chats_id_chat_seq";
       public          postgres    false    215            d           0    0    Chats_id_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Chats_id_chat_seq" OWNED BY public."Chats".id_chat;
          public          postgres    false    217            ?            1259    16756    Chats_interested_seq    SEQUENCE        CREATE SEQUENCE public."Chats_interested_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Chats_interested_seq";
       public          postgres    false    215            e           0    0    Chats_interested_seq    SEQUENCE OWNED BY     L   ALTER SEQUENCE public."Chats_interested_seq" OWNED BY public."Chats".user2;
          public          postgres    false    218            ?            1259    16757    Groups    TABLE     d   CREATE TABLE public."Groups" (
    id_group bigint NOT NULL,
    name text,
    description text
);
    DROP TABLE public."Groups";
       public         heap    postgres    false            ?            1259    16762    Groups_id_group_seq    SEQUENCE     ~   CREATE SEQUENCE public."Groups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Groups_id_group_seq";
       public          postgres    false    219            f           0    0    Groups_id_group_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Groups_id_group_seq" OWNED BY public."Groups".id_group;
          public          postgres    false    220            ?            1259    16763    Images    TABLE     d   CREATE TABLE public."Images" (
    image_path text NOT NULL,
    id_announcement bigint NOT NULL
);
    DROP TABLE public."Images";
       public         heap    postgres    false            ?            1259    16768    Images_id_announcement_seq    SEQUENCE     ?   CREATE SEQUENCE public."Images_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public."Images_id_announcement_seq";
       public          postgres    false    221            g           0    0    Images_id_announcement_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."Images_id_announcement_seq" OWNED BY public."Images".id_announcement;
          public          postgres    false    222            ?            1259    16769    Messages    TABLE     ?   CREATE TABLE public."Messages" (
    id_message bigint NOT NULL,
    text text,
    chat bigint NOT NULL,
    sender bigint,
    date_time timestamp without time zone
);
    DROP TABLE public."Messages";
       public         heap    postgres    false            ?            1259    16774    Messages_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Messages_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Messages_chat_seq";
       public          postgres    false    223            h           0    0    Messages_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Messages_chat_seq" OWNED BY public."Messages".chat;
          public          postgres    false    224            ?            1259    16775    Messages_id_message_seq    SEQUENCE     ?   CREATE SEQUENCE public."Messages_id_message_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Messages_id_message_seq";
       public          postgres    false    223            i           0    0    Messages_id_message_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Messages_id_message_seq" OWNED BY public."Messages".id_message;
          public          postgres    false    225            ?            1259    16776    Users    TABLE     ?   CREATE TABLE public."Users" (
    id_user bigint NOT NULL,
    name text,
    surname text,
    password text,
    birth_date date,
    email text,
    phone bigint,
    street text,
    city text,
    postal_code bigint,
    image_path text
);
    DROP TABLE public."Users";
       public         heap    postgres    false            ?            1259    16781    UsersGroups    TABLE     a   CREATE TABLE public."UsersGroups" (
    id_user bigint NOT NULL,
    id_group bigint NOT NULL
);
 !   DROP TABLE public."UsersGroups";
       public         heap    postgres    false            ?            1259    16784    UsersGroups_id_group_seq    SEQUENCE     ?   CREATE SEQUENCE public."UsersGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."UsersGroups_id_group_seq";
       public          postgres    false    227            j           0    0    UsersGroups_id_group_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."UsersGroups_id_group_seq" OWNED BY public."UsersGroups".id_group;
          public          postgres    false    228            ?            1259    16785    UsersGroups_id_user_seq    SEQUENCE     ?   CREATE SEQUENCE public."UsersGroups_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."UsersGroups_id_user_seq";
       public          postgres    false    227            k           0    0    UsersGroups_id_user_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."UsersGroups_id_user_seq" OWNED BY public."UsersGroups".id_user;
          public          postgres    false    229            ?            1259    16786    Users_id_user_seq    SEQUENCE     |   CREATE SEQUENCE public."Users_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Users_id_user_seq";
       public          postgres    false    226            l           0    0    Users_id_user_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Users_id_user_seq" OWNED BY public."Users".id_user;
          public          postgres    false    230            ?           2604    16787    Announcements id_announcement    DEFAULT     ?   ALTER TABLE ONLY public."Announcements" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Announcements_id_announcement_seq"'::regclass);
 N   ALTER TABLE public."Announcements" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    214    209            ?           2604    16788    Announcements creator    DEFAULT     ?   ALTER TABLE ONLY public."Announcements" ALTER COLUMN creator SET DEFAULT nextval('public."Announcements_creator_seq"'::regclass);
 F   ALTER TABLE public."Announcements" ALTER COLUMN creator DROP DEFAULT;
       public          postgres    false    213    209            ?           2604    16789 #   AnnouncementsGroups id_announcement    DEFAULT     ?   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_announcement SET DEFAULT nextval('public."AnnouncementsGroups_id_announcement_seq"'::regclass);
 T   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    211    210            ?           2604    16790    AnnouncementsGroups id_group    DEFAULT     ?   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."AnnouncementsGroups_id_group_seq"'::regclass);
 M   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    212    210            ?           2604    16791    Chats id_chat    DEFAULT     r   ALTER TABLE ONLY public."Chats" ALTER COLUMN id_chat SET DEFAULT nextval('public."Chats_id_chat_seq"'::regclass);
 >   ALTER TABLE public."Chats" ALTER COLUMN id_chat DROP DEFAULT;
       public          postgres    false    217    215            ?           2604    16792    Chats user1    DEFAULT     u   ALTER TABLE ONLY public."Chats" ALTER COLUMN user1 SET DEFAULT nextval('public."Chats_announcement_seq"'::regclass);
 <   ALTER TABLE public."Chats" ALTER COLUMN user1 DROP DEFAULT;
       public          postgres    false    216    215            ?           2604    16793    Chats user2    DEFAULT     s   ALTER TABLE ONLY public."Chats" ALTER COLUMN user2 SET DEFAULT nextval('public."Chats_interested_seq"'::regclass);
 <   ALTER TABLE public."Chats" ALTER COLUMN user2 DROP DEFAULT;
       public          postgres    false    218    215            ?           2604    16794    Groups id_group    DEFAULT     v   ALTER TABLE ONLY public."Groups" ALTER COLUMN id_group SET DEFAULT nextval('public."Groups_id_group_seq"'::regclass);
 @   ALTER TABLE public."Groups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    220    219            ?           2604    16795    Images id_announcement    DEFAULT     ?   ALTER TABLE ONLY public."Images" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Images_id_announcement_seq"'::regclass);
 G   ALTER TABLE public."Images" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    222    221            ?           2604    16796    Messages id_message    DEFAULT     ~   ALTER TABLE ONLY public."Messages" ALTER COLUMN id_message SET DEFAULT nextval('public."Messages_id_message_seq"'::regclass);
 D   ALTER TABLE public."Messages" ALTER COLUMN id_message DROP DEFAULT;
       public          postgres    false    225    223            ?           2604    16797    Messages chat    DEFAULT     r   ALTER TABLE ONLY public."Messages" ALTER COLUMN chat SET DEFAULT nextval('public."Messages_chat_seq"'::regclass);
 >   ALTER TABLE public."Messages" ALTER COLUMN chat DROP DEFAULT;
       public          postgres    false    224    223            ?           2604    16798    Users id_user    DEFAULT     r   ALTER TABLE ONLY public."Users" ALTER COLUMN id_user SET DEFAULT nextval('public."Users_id_user_seq"'::regclass);
 >   ALTER TABLE public."Users" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    230    226            ?           2604    16799    UsersGroups id_user    DEFAULT     ~   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_user SET DEFAULT nextval('public."UsersGroups_id_user_seq"'::regclass);
 D   ALTER TABLE public."UsersGroups" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    229    227            ?           2604    16800    UsersGroups id_group    DEFAULT     ?   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."UsersGroups_id_group_seq"'::regclass);
 E   ALTER TABLE public."UsersGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    228    227            C          0    16739    Announcements 
   TABLE DATA           ]   COPY public."Announcements" (id_announcement, title, description, creator, type) FROM stdin;
    public          postgres    false    209   ?p       D          0    16744    AnnouncementsGroups 
   TABLE DATA           J   COPY public."AnnouncementsGroups" (id_announcement, id_group) FROM stdin;
    public          postgres    false    210   sq       I          0    16751    Chats 
   TABLE DATA           8   COPY public."Chats" (id_chat, user1, user2) FROM stdin;
    public          postgres    false    215   ?q       M          0    16757    Groups 
   TABLE DATA           ?   COPY public."Groups" (id_group, name, description) FROM stdin;
    public          postgres    false    219   ?q       O          0    16763    Images 
   TABLE DATA           ?   COPY public."Images" (image_path, id_announcement) FROM stdin;
    public          postgres    false    221   "r       Q          0    16769    Messages 
   TABLE DATA           O   COPY public."Messages" (id_message, text, chat, sender, date_time) FROM stdin;
    public          postgres    false    223   ~r       T          0    16776    Users 
   TABLE DATA           ?   COPY public."Users" (id_user, name, surname, password, birth_date, email, phone, street, city, postal_code, image_path) FROM stdin;
    public          postgres    false    226   [s       U          0    16781    UsersGroups 
   TABLE DATA           :   COPY public."UsersGroups" (id_user, id_group) FROM stdin;
    public          postgres    false    227   Bt       m           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_announcement_seq"', 1, false);
          public          postgres    false    211            n           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_group_seq"', 1, false);
          public          postgres    false    212            o           0    0    Announcements_creator_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Announcements_creator_seq"', 1, false);
          public          postgres    false    213            p           0    0 !   Announcements_id_announcement_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public."Announcements_id_announcement_seq"', 87, true);
          public          postgres    false    214            q           0    0    Chats_announcement_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Chats_announcement_seq"', 1, false);
          public          postgres    false    216            r           0    0    Chats_id_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Chats_id_chat_seq"', 25, true);
          public          postgres    false    217            s           0    0    Chats_interested_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Chats_interested_seq"', 1, false);
          public          postgres    false    218            t           0    0    Groups_id_group_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Groups_id_group_seq"', 18, true);
          public          postgres    false    220            u           0    0    Images_id_announcement_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Images_id_announcement_seq"', 1, false);
          public          postgres    false    222            v           0    0    Messages_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Messages_chat_seq"', 1, false);
          public          postgres    false    224            w           0    0    Messages_id_message_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Messages_id_message_seq"', 17, true);
          public          postgres    false    225            x           0    0    UsersGroups_id_group_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."UsersGroups_id_group_seq"', 1, false);
          public          postgres    false    228            y           0    0    UsersGroups_id_user_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."UsersGroups_id_user_seq"', 1, false);
          public          postgres    false    229            z           0    0    Users_id_user_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Users_id_user_seq"', 41, true);
          public          postgres    false    230            ?           2606    16802 ,   AnnouncementsGroups AnnouncementsGroups_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_pkey" PRIMARY KEY (id_announcement, id_group);
 Z   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_pkey";
       public            postgres    false    210    210            ?           2606    16804     Announcements Announcements_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_pkey" PRIMARY KEY (id_announcement);
 N   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_pkey";
       public            postgres    false    209            ?           2606    16806    Chats Chats_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_pkey" PRIMARY KEY (id_chat);
 >   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_pkey";
       public            postgres    false    215            ?           2606    16808    Groups Groups_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Groups"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id_group);
 @   ALTER TABLE ONLY public."Groups" DROP CONSTRAINT "Groups_pkey";
       public            postgres    false    219            ?           2606    16810    Images Images_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_pkey" PRIMARY KEY (image_path);
 @   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_pkey";
       public            postgres    false    221            ?           2606    16812    Messages Messages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id_message);
 D   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_pkey";
       public            postgres    false    223            ?           2606    16814    UsersGroups UsersGroups_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_pkey" PRIMARY KEY (id_user, id_group);
 J   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_pkey";
       public            postgres    false    227    227            ?           2606    16816    Users Users_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public            postgres    false    226            ?           2606    16817 <   AnnouncementsGroups AnnouncementsGroups_id_announcement_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement);
 j   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_announcement_fkey";
       public          postgres    false    209    3487    210            ?           2606    16822 5   AnnouncementsGroups AnnouncementsGroups_id_group_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group) NOT VALID;
 c   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_group_fkey";
       public          postgres    false    219    210    3493            ?           2606    16827 (   Announcements Announcements_creator_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_creator_fkey" FOREIGN KEY (creator) REFERENCES public."Users"(id_user);
 V   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_creator_fkey";
       public          postgres    false    226    209    3499            ?           2606    16832    Chats Chats_user1_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_user1_fkey" FOREIGN KEY (user1) REFERENCES public."Users"(id_user) NOT VALID;
 D   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_user1_fkey";
       public          postgres    false    3499    226    215            ?           2606    16837    Chats Chats_user2_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_user2_fkey" FOREIGN KEY (user2) REFERENCES public."Users"(id_user);
 D   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_user2_fkey";
       public          postgres    false    226    3499    215            ?           2606    16842 "   Images Images_id_announcement_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement) NOT VALID;
 P   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_id_announcement_fkey";
       public          postgres    false    3487    209    221            ?           2606    16847    Messages Messages_chat_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_chat_fkey" FOREIGN KEY (chat) REFERENCES public."Chats"(id_chat);
 I   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_chat_fkey";
       public          postgres    false    215    223    3491            ?           2606    16852    Messages Messages_sender_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_sender_fkey" FOREIGN KEY (sender) REFERENCES public."Users"(id_user) NOT VALID;
 K   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_sender_fkey";
       public          postgres    false    226    3499    223            ?           2606    16857 %   UsersGroups UsersGroups_id_group_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group);
 S   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_group_fkey";
       public          postgres    false    3493    227    219            ?           2606    16862 $   UsersGroups UsersGroups_id_user_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_user_fkey" FOREIGN KEY (id_user) REFERENCES public."Users"(id_user);
 R   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_user_fkey";
       public          postgres    false    226    3499    227            C   ?   x?M?An?@E?3??@E???[T?l??!?;?x"??1ꆝ???????/?h4???A0????V-?5?.???+nA????20??mP?@?y?Z)?ZY?y??ߦ>w?t?f?'RmZİ6?h???VzQ???t???O#??N.1?{?C?????_h????˼gw?8L?7}?;ŝ???p??9??KQ?      D      x??0?4???0?? 2F??? +?g      I      x?32?41?41?????? 0?      M   P   x?3??t/*-(?WH?T(?/K?,,M-.?W8?R?4O!.Y ?TH.JMJ?'???+??'?d&'Ve???r??qqq ǌ?      O   L   x???MLO-ַ0?7?????L???͌???9-L?2?J?0???*1?Tba????"SscCSNs?=... ??&?      Q   ?   x?u?;r!?x8?3?]B?$S[???%??No?K?U???{\Jj?+惢?r?L$m@?N??K[???T???Ge?z/??o?7y?5[?lyB?? ??
iB?? ??ֵ????!*???8?ڋLۼ݊|/???*ǀ??S?m?^???4A???Tg?P?X??}?k~?Oq^*yl????0?ң?????et??
!>?W?      T   ?   x???Mo?0 ??s?;??ڂo3c??Ԅ1???/F?~ B??3K?]?????$???ZJ/?C?aF?4?j_ĭ0???]d=??>?5k?dw????M?IOҹ???1!?YHb@U:?΀????s??re臼>$&̵?]??}Gy#?/_y??Z?ۛ???I??YGq????j&?σ(?i1V?r?6???8D?N?_???0tS?      U      x?31?4??21?1z\\\ ?j     