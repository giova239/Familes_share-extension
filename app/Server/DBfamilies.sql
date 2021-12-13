PGDMP                         y            DBfamilies_share    13.5    13.2 U               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16819    DBfamilies_share    DATABASE     n   CREATE DATABASE "DBfamilies_share" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';
 "   DROP DATABASE "DBfamilies_share";
                postgres    false            �            1259    17091    Announcements    TABLE     �   CREATE TABLE public."Announcements" (
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
       public          postgres    false    209                       0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public."AnnouncementsGroups_id_announcement_seq" OWNED BY public."AnnouncementsGroups".id_announcement;
          public          postgres    false    207            �            1259    17119     AnnouncementsGroups_id_group_seq    SEQUENCE     �   CREATE SEQUENCE public."AnnouncementsGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."AnnouncementsGroups_id_group_seq";
       public          postgres    false    209                       0    0     AnnouncementsGroups_id_group_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."AnnouncementsGroups_id_group_seq" OWNED BY public."AnnouncementsGroups".id_group;
          public          postgres    false    208            �            1259    17089    Announcements_creator_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_creator_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."Announcements_creator_seq";
       public          postgres    false    204                       0    0    Announcements_creator_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."Announcements_creator_seq" OWNED BY public."Announcements".creator;
          public          postgres    false    203            �            1259    17087 !   Announcements_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public."Announcements_id_announcement_seq";
       public          postgres    false    204                       0    0 !   Announcements_id_announcement_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."Announcements_id_announcement_seq" OWNED BY public."Announcements".id_announcement;
          public          postgres    false    202            �            1259    17165    Chats    TABLE        CREATE TABLE public."Chats" (
    id_chat bigint NOT NULL,
    announcement bigint NOT NULL,
    interested bigint NOT NULL
);
    DROP TABLE public."Chats";
       public         heap    postgres    false            �            1259    17161    Chats_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Chats_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."Chats_announcement_seq";
       public          postgres    false    216                       0    0    Chats_announcement_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."Chats_announcement_seq" OWNED BY public."Chats".announcement;
          public          postgres    false    214            �            1259    17159    Chats_id_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Chats_id_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Chats_id_chat_seq";
       public          postgres    false    216                       0    0    Chats_id_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Chats_id_chat_seq" OWNED BY public."Chats".id_chat;
          public          postgres    false    213            �            1259    17163    Chats_interested_seq    SEQUENCE        CREATE SEQUENCE public."Chats_interested_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Chats_interested_seq";
       public          postgres    false    216                       0    0    Chats_interested_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."Chats_interested_seq" OWNED BY public."Chats".interested;
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
       public          postgres    false    206                       0    0    Groups_id_group_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Groups_id_group_seq" OWNED BY public."Groups".id_group;
          public          postgres    false    205            �            1259    17188    Messages    TABLE     l   CREATE TABLE public."Messages" (
    id_message bigint NOT NULL,
    text text,
    chat bigint NOT NULL
);
    DROP TABLE public."Messages";
       public         heap    postgres    false            �            1259    17186    Messages_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Messages_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Messages_chat_seq";
       public          postgres    false    219                       0    0    Messages_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Messages_chat_seq" OWNED BY public."Messages".chat;
          public          postgres    false    218            �            1259    17184    Messages_id_message_seq    SEQUENCE     �   CREATE SEQUENCE public."Messages_id_message_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Messages_id_message_seq";
       public          postgres    false    219                       0    0    Messages_id_message_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Messages_id_message_seq" OWNED BY public."Messages".id_message;
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
       public          postgres    false    212                       0    0    UsersGroups_id_group_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."UsersGroups_id_group_seq" OWNED BY public."UsersGroups".id_group;
          public          postgres    false    211            �            1259    17138    UsersGroups_id_user_seq    SEQUENCE     �   CREATE SEQUENCE public."UsersGroups_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."UsersGroups_id_user_seq";
       public          postgres    false    212                        0    0    UsersGroups_id_user_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."UsersGroups_id_user_seq" OWNED BY public."UsersGroups".id_user;
          public          postgres    false    210            �            1259    17076    Users_id_user_seq    SEQUENCE     |   CREATE SEQUENCE public."Users_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Users_id_user_seq";
       public          postgres    false    201            !           0    0    Users_id_user_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Users_id_user_seq" OWNED BY public."Users".id_user;
          public          postgres    false    200            W           2604    17094    Announcements id_announcement    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Announcements_id_announcement_seq"'::regclass);
 N   ALTER TABLE public."Announcements" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    204    202    204            X           2604    17095    Announcements creator    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN creator SET DEFAULT nextval('public."Announcements_creator_seq"'::regclass);
 F   ALTER TABLE public."Announcements" ALTER COLUMN creator DROP DEFAULT;
       public          postgres    false    204    203    204            Z           2604    17124 #   AnnouncementsGroups id_announcement    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_announcement SET DEFAULT nextval('public."AnnouncementsGroups_id_announcement_seq"'::regclass);
 T   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    209    207    209            [           2604    17125    AnnouncementsGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."AnnouncementsGroups_id_group_seq"'::regclass);
 M   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    209    208    209            ^           2604    17168    Chats id_chat    DEFAULT     r   ALTER TABLE ONLY public."Chats" ALTER COLUMN id_chat SET DEFAULT nextval('public."Chats_id_chat_seq"'::regclass);
 >   ALTER TABLE public."Chats" ALTER COLUMN id_chat DROP DEFAULT;
       public          postgres    false    213    216    216            _           2604    17169    Chats announcement    DEFAULT     |   ALTER TABLE ONLY public."Chats" ALTER COLUMN announcement SET DEFAULT nextval('public."Chats_announcement_seq"'::regclass);
 C   ALTER TABLE public."Chats" ALTER COLUMN announcement DROP DEFAULT;
       public          postgres    false    214    216    216            `           2604    17170    Chats interested    DEFAULT     x   ALTER TABLE ONLY public."Chats" ALTER COLUMN interested SET DEFAULT nextval('public."Chats_interested_seq"'::regclass);
 A   ALTER TABLE public."Chats" ALTER COLUMN interested DROP DEFAULT;
       public          postgres    false    215    216    216            Y           2604    17111    Groups id_group    DEFAULT     v   ALTER TABLE ONLY public."Groups" ALTER COLUMN id_group SET DEFAULT nextval('public."Groups_id_group_seq"'::regclass);
 @   ALTER TABLE public."Groups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    205    206    206            a           2604    17191    Messages id_message    DEFAULT     ~   ALTER TABLE ONLY public."Messages" ALTER COLUMN id_message SET DEFAULT nextval('public."Messages_id_message_seq"'::regclass);
 D   ALTER TABLE public."Messages" ALTER COLUMN id_message DROP DEFAULT;
       public          postgres    false    219    217    219            b           2604    17192    Messages chat    DEFAULT     r   ALTER TABLE ONLY public."Messages" ALTER COLUMN chat SET DEFAULT nextval('public."Messages_chat_seq"'::regclass);
 >   ALTER TABLE public."Messages" ALTER COLUMN chat DROP DEFAULT;
       public          postgres    false    218    219    219            V           2604    17081    Users id_user    DEFAULT     r   ALTER TABLE ONLY public."Users" ALTER COLUMN id_user SET DEFAULT nextval('public."Users_id_user_seq"'::regclass);
 >   ALTER TABLE public."Users" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    201    200    201            \           2604    17145    UsersGroups id_user    DEFAULT     ~   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_user SET DEFAULT nextval('public."UsersGroups_id_user_seq"'::regclass);
 D   ALTER TABLE public."UsersGroups" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    210    212    212            ]           2604    17146    UsersGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."UsersGroups_id_group_seq"'::regclass);
 E   ALTER TABLE public."UsersGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    212    211    212            �          0    17091    Announcements 
   TABLE DATA           ]   COPY public."Announcements" (id_announcement, title, description, creator, type) FROM stdin;
    public          postgres    false    204   �c                 0    17121    AnnouncementsGroups 
   TABLE DATA           J   COPY public."AnnouncementsGroups" (id_announcement, id_group) FROM stdin;
    public          postgres    false    209   Wd                 0    17165    Chats 
   TABLE DATA           D   COPY public."Chats" (id_chat, announcement, interested) FROM stdin;
    public          postgres    false    216   xd                 0    17108    Groups 
   TABLE DATA           ?   COPY public."Groups" (id_group, name, description) FROM stdin;
    public          postgres    false    206   �d                 0    17188    Messages 
   TABLE DATA           <   COPY public."Messages" (id_message, text, chat) FROM stdin;
    public          postgres    false    219   �d       �          0    17078    Users 
   TABLE DATA           �   COPY public."Users" (id_user, username, name, surname, password, birth_date, email, phone, street, city, postal_code) FROM stdin;
    public          postgres    false    201   e                 0    17142    UsersGroups 
   TABLE DATA           :   COPY public."UsersGroups" (id_user, id_group) FROM stdin;
    public          postgres    false    212   �e       "           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_announcement_seq"', 1, false);
          public          postgres    false    207            #           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_group_seq"', 1, false);
          public          postgres    false    208            $           0    0    Announcements_creator_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Announcements_creator_seq"', 1, false);
          public          postgres    false    203            %           0    0 !   Announcements_id_announcement_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."Announcements_id_announcement_seq"', 3, true);
          public          postgres    false    202            &           0    0    Chats_announcement_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Chats_announcement_seq"', 1, false);
          public          postgres    false    214            '           0    0    Chats_id_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Chats_id_chat_seq"', 1, false);
          public          postgres    false    213            (           0    0    Chats_interested_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Chats_interested_seq"', 1, false);
          public          postgres    false    215            )           0    0    Groups_id_group_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Groups_id_group_seq"', 1, false);
          public          postgres    false    205            *           0    0    Messages_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Messages_chat_seq"', 1, false);
          public          postgres    false    218            +           0    0    Messages_id_message_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Messages_id_message_seq"', 1, false);
          public          postgres    false    217            ,           0    0    UsersGroups_id_group_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."UsersGroups_id_group_seq"', 1, false);
          public          postgres    false    211            -           0    0    UsersGroups_id_user_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."UsersGroups_id_user_seq"', 1, false);
          public          postgres    false    210            .           0    0    Users_id_user_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Users_id_user_seq"', 1, false);
          public          postgres    false    200            j           2606    17127 ,   AnnouncementsGroups AnnouncementsGroups_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_pkey" PRIMARY KEY (id_announcement, id_group);
 Z   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_pkey";
       public            postgres    false    209    209            f           2606    17100     Announcements Announcements_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_pkey" PRIMARY KEY (id_announcement);
 N   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_pkey";
       public            postgres    false    204            n           2606    17172    Chats Chats_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_pkey" PRIMARY KEY (id_chat);
 >   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_pkey";
       public            postgres    false    216            h           2606    17116    Groups Groups_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Groups"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id_group);
 @   ALTER TABLE ONLY public."Groups" DROP CONSTRAINT "Groups_pkey";
       public            postgres    false    206            p           2606    17197    Messages Messages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id_message);
 D   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_pkey";
       public            postgres    false    219            l           2606    17148    UsersGroups UsersGroups_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_pkey" PRIMARY KEY (id_user, id_group);
 J   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_pkey";
       public            postgres    false    212    212            d           2606    17086    Users Users_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public            postgres    false    201            r           2606    17128 <   AnnouncementsGroups AnnouncementsGroups_id_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement);
 j   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_announcement_fkey";
       public          postgres    false    209    204    2918            s           2606    17133 5   AnnouncementsGroups AnnouncementsGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group) NOT VALID;
 c   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_group_fkey";
       public          postgres    false    206    2920    209            q           2606    17101 (   Announcements Announcements_creator_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_creator_fkey" FOREIGN KEY (creator) REFERENCES public."Users"(id_user);
 V   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_creator_fkey";
       public          postgres    false    2916    201    204            v           2606    17173    Chats Chats_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_announcement_fkey" FOREIGN KEY (announcement) REFERENCES public."Announcements"(id_announcement);
 K   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_announcement_fkey";
       public          postgres    false    204    216    2918            w           2606    17178    Chats Chats_interested_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_interested_fkey" FOREIGN KEY (interested) REFERENCES public."Users"(id_user);
 I   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_interested_fkey";
       public          postgres    false    216    2916    201            x           2606    17198    Messages Messages_chat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_chat_fkey" FOREIGN KEY (chat) REFERENCES public."Chats"(id_chat);
 I   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_chat_fkey";
       public          postgres    false    2926    216    219            u           2606    17154 %   UsersGroups UsersGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group);
 S   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_group_fkey";
       public          postgres    false    206    2920    212            t           2606    17149 $   UsersGroups UsersGroups_id_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_user_fkey" FOREIGN KEY (id_user) REFERENCES public."Users"(id_user);
 R   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_user_fkey";
       public          postgres    false    2916    201    212            �   Z   x�%�;
�0 �9=EN ���	������MJ���������mT�0��(CLڍ��Sysy��d��Cmꦹ���f����A��Z�s���            x�3�4����� k             x������ � �         L   x�3�t/*-(�W(.�/�L�(J-.�,�W��L*�THɄJp�&��bQ�2�)JO�O/JL�j \�+F��� ��,�            x������ � �      �   �   x�M��
�0Dϛ����&�&7��M���t�@�@ۀ�o�A���o����`�8g8�8�ٺ7IՂD���܁-%�����и4��F�Fo������;�+/�̠�:%$�qM�OpO�� �1]��&]f�d�y��4�[���6�n�<ڕ��!䘠�R<!�F�>t            x�3�4�2�4bc.# ����� Y�     