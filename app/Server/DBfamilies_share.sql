PGDMP     ,                    y            DBfamilies_share    14.1    14.1 ]    Y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            [           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            \           1262    16394    DBfamilies_share    DATABASE     ]   CREATE DATABASE "DBfamilies_share" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
 "   DROP DATABASE "DBfamilies_share";
                postgres    false            �            1259    16395    Announcements    TABLE     �   CREATE TABLE public."Announcements" (
    id_announcement bigint NOT NULL,
    title text,
    description text,
    creator bigint NOT NULL,
    type boolean
);
 #   DROP TABLE public."Announcements";
       public         heap    postgres    false            �            1259    16400    AnnouncementsGroups    TABLE     q   CREATE TABLE public."AnnouncementsGroups" (
    id_announcement bigint NOT NULL,
    id_group bigint NOT NULL
);
 )   DROP TABLE public."AnnouncementsGroups";
       public         heap    postgres    false            �            1259    16403 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."AnnouncementsGroups_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public."AnnouncementsGroups_id_announcement_seq";
       public          postgres    false    210            ]           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public."AnnouncementsGroups_id_announcement_seq" OWNED BY public."AnnouncementsGroups".id_announcement;
          public          postgres    false    211            �            1259    16404     AnnouncementsGroups_id_group_seq    SEQUENCE     �   CREATE SEQUENCE public."AnnouncementsGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."AnnouncementsGroups_id_group_seq";
       public          postgres    false    210            ^           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."AnnouncementsGroups_id_group_seq" OWNED BY public."AnnouncementsGroups".id_group;
          public          postgres    false    212            �            1259    16405    Announcements_creator_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_creator_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."Announcements_creator_seq";
       public          postgres    false    209            _           0    0    Announcements_creator_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."Announcements_creator_seq" OWNED BY public."Announcements".creator;
          public          postgres    false    213            �            1259    16406 !   Announcements_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public."Announcements_id_announcement_seq";
       public          postgres    false    209            `           0    0 !   Announcements_id_announcement_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."Announcements_id_announcement_seq" OWNED BY public."Announcements".id_announcement;
          public          postgres    false    214            �            1259    16407    Chats    TABLE        CREATE TABLE public."Chats" (
    id_chat bigint NOT NULL,
    announcement bigint NOT NULL,
    interested bigint NOT NULL
);
    DROP TABLE public."Chats";
       public         heap    postgres    false            �            1259    16410    Chats_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Chats_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."Chats_announcement_seq";
       public          postgres    false    215            a           0    0    Chats_announcement_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."Chats_announcement_seq" OWNED BY public."Chats".announcement;
          public          postgres    false    216            �            1259    16411    Chats_id_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Chats_id_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Chats_id_chat_seq";
       public          postgres    false    215            b           0    0    Chats_id_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Chats_id_chat_seq" OWNED BY public."Chats".id_chat;
          public          postgres    false    217            �            1259    16412    Chats_interested_seq    SEQUENCE        CREATE SEQUENCE public."Chats_interested_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Chats_interested_seq";
       public          postgres    false    215            c           0    0    Chats_interested_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."Chats_interested_seq" OWNED BY public."Chats".interested;
          public          postgres    false    218            �            1259    16413    Groups    TABLE     d   CREATE TABLE public."Groups" (
    id_group bigint NOT NULL,
    name text,
    description text
);
    DROP TABLE public."Groups";
       public         heap    postgres    false            �            1259    16418    Groups_id_group_seq    SEQUENCE     ~   CREATE SEQUENCE public."Groups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Groups_id_group_seq";
       public          postgres    false    219            d           0    0    Groups_id_group_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Groups_id_group_seq" OWNED BY public."Groups".id_group;
          public          postgres    false    220            �            1259    16504    Images    TABLE     [   CREATE TABLE public."Images" (
    image_path text NOT NULL,
    id_announcement bigint
);
    DROP TABLE public."Images";
       public         heap    postgres    false            �            1259    16511    Images_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Images_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public."Images_id_announcement_seq";
       public          postgres    false    229            e           0    0    Images_id_announcement_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."Images_id_announcement_seq" OWNED BY public."Images".id_announcement;
          public          postgres    false    230            �            1259    16419    Messages    TABLE     l   CREATE TABLE public."Messages" (
    id_message bigint NOT NULL,
    text text,
    chat bigint NOT NULL
);
    DROP TABLE public."Messages";
       public         heap    postgres    false            �            1259    16424    Messages_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Messages_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Messages_chat_seq";
       public          postgres    false    221            f           0    0    Messages_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Messages_chat_seq" OWNED BY public."Messages".chat;
          public          postgres    false    222            �            1259    16425    Messages_id_message_seq    SEQUENCE     �   CREATE SEQUENCE public."Messages_id_message_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Messages_id_message_seq";
       public          postgres    false    221            g           0    0    Messages_id_message_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Messages_id_message_seq" OWNED BY public."Messages".id_message;
          public          postgres    false    223            �            1259    16426    Users    TABLE     �   CREATE TABLE public."Users" (
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
       public         heap    postgres    false            �            1259    16431    UsersGroups    TABLE     a   CREATE TABLE public."UsersGroups" (
    id_user bigint NOT NULL,
    id_group bigint NOT NULL
);
 !   DROP TABLE public."UsersGroups";
       public         heap    postgres    false            �            1259    16434    UsersGroups_id_group_seq    SEQUENCE     �   CREATE SEQUENCE public."UsersGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."UsersGroups_id_group_seq";
       public          postgres    false    225            h           0    0    UsersGroups_id_group_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."UsersGroups_id_group_seq" OWNED BY public."UsersGroups".id_group;
          public          postgres    false    226            �            1259    16435    UsersGroups_id_user_seq    SEQUENCE     �   CREATE SEQUENCE public."UsersGroups_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."UsersGroups_id_user_seq";
       public          postgres    false    225            i           0    0    UsersGroups_id_user_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."UsersGroups_id_user_seq" OWNED BY public."UsersGroups".id_user;
          public          postgres    false    227            �            1259    16436    Users_id_user_seq    SEQUENCE     |   CREATE SEQUENCE public."Users_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Users_id_user_seq";
       public          postgres    false    224            j           0    0    Users_id_user_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Users_id_user_seq" OWNED BY public."Users".id_user;
          public          postgres    false    228            �           2604    16512    Announcements id_announcement    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Announcements_id_announcement_seq"'::regclass);
 N   ALTER TABLE public."Announcements" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    214    209            �           2604    16513    Announcements creator    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN creator SET DEFAULT nextval('public."Announcements_creator_seq"'::regclass);
 F   ALTER TABLE public."Announcements" ALTER COLUMN creator DROP DEFAULT;
       public          postgres    false    213    209            �           2604    16514 #   AnnouncementsGroups id_announcement    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_announcement SET DEFAULT nextval('public."AnnouncementsGroups_id_announcement_seq"'::regclass);
 T   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    211    210            �           2604    16515    AnnouncementsGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."AnnouncementsGroups_id_group_seq"'::regclass);
 M   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    212    210            �           2604    16516    Chats id_chat    DEFAULT     r   ALTER TABLE ONLY public."Chats" ALTER COLUMN id_chat SET DEFAULT nextval('public."Chats_id_chat_seq"'::regclass);
 >   ALTER TABLE public."Chats" ALTER COLUMN id_chat DROP DEFAULT;
       public          postgres    false    217    215            �           2604    16517    Chats announcement    DEFAULT     |   ALTER TABLE ONLY public."Chats" ALTER COLUMN announcement SET DEFAULT nextval('public."Chats_announcement_seq"'::regclass);
 C   ALTER TABLE public."Chats" ALTER COLUMN announcement DROP DEFAULT;
       public          postgres    false    216    215            �           2604    16518    Chats interested    DEFAULT     x   ALTER TABLE ONLY public."Chats" ALTER COLUMN interested SET DEFAULT nextval('public."Chats_interested_seq"'::regclass);
 A   ALTER TABLE public."Chats" ALTER COLUMN interested DROP DEFAULT;
       public          postgres    false    218    215            �           2604    16519    Groups id_group    DEFAULT     v   ALTER TABLE ONLY public."Groups" ALTER COLUMN id_group SET DEFAULT nextval('public."Groups_id_group_seq"'::regclass);
 @   ALTER TABLE public."Groups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    220    219            �           2604    16520    Images id_announcement    DEFAULT     �   ALTER TABLE ONLY public."Images" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Images_id_announcement_seq"'::regclass);
 G   ALTER TABLE public."Images" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    230    229            �           2604    16521    Messages id_message    DEFAULT     ~   ALTER TABLE ONLY public."Messages" ALTER COLUMN id_message SET DEFAULT nextval('public."Messages_id_message_seq"'::regclass);
 D   ALTER TABLE public."Messages" ALTER COLUMN id_message DROP DEFAULT;
       public          postgres    false    223    221            �           2604    16522    Messages chat    DEFAULT     r   ALTER TABLE ONLY public."Messages" ALTER COLUMN chat SET DEFAULT nextval('public."Messages_chat_seq"'::regclass);
 >   ALTER TABLE public."Messages" ALTER COLUMN chat DROP DEFAULT;
       public          postgres    false    222    221            �           2604    16523    Users id_user    DEFAULT     r   ALTER TABLE ONLY public."Users" ALTER COLUMN id_user SET DEFAULT nextval('public."Users_id_user_seq"'::regclass);
 >   ALTER TABLE public."Users" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    228    224            �           2604    16524    UsersGroups id_user    DEFAULT     ~   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_user SET DEFAULT nextval('public."UsersGroups_id_user_seq"'::regclass);
 D   ALTER TABLE public."UsersGroups" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    227    225            �           2604    16525    UsersGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."UsersGroups_id_group_seq"'::regclass);
 E   ALTER TABLE public."UsersGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    226    225            A          0    16395    Announcements 
   TABLE DATA           ]   COPY public."Announcements" (id_announcement, title, description, creator, type) FROM stdin;
    public          postgres    false    209   �l       B          0    16400    AnnouncementsGroups 
   TABLE DATA           J   COPY public."AnnouncementsGroups" (id_announcement, id_group) FROM stdin;
    public          postgres    false    210   ym       G          0    16407    Chats 
   TABLE DATA           D   COPY public."Chats" (id_chat, announcement, interested) FROM stdin;
    public          postgres    false    215   �m       K          0    16413    Groups 
   TABLE DATA           ?   COPY public."Groups" (id_group, name, description) FROM stdin;
    public          postgres    false    219   �m       U          0    16504    Images 
   TABLE DATA           ?   COPY public."Images" (image_path, id_announcement) FROM stdin;
    public          postgres    false    229   n       M          0    16419    Messages 
   TABLE DATA           <   COPY public."Messages" (id_message, text, chat) FROM stdin;
    public          postgres    false    221   �n       P          0    16426    Users 
   TABLE DATA           �   COPY public."Users" (id_user, username, name, surname, password, birth_date, email, phone, street, city, postal_code) FROM stdin;
    public          postgres    false    224   �n       Q          0    16431    UsersGroups 
   TABLE DATA           :   COPY public."UsersGroups" (id_user, id_group) FROM stdin;
    public          postgres    false    225   �o       k           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_announcement_seq"', 1, false);
          public          postgres    false    211            l           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_group_seq"', 1, false);
          public          postgres    false    212            m           0    0    Announcements_creator_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Announcements_creator_seq"', 1, false);
          public          postgres    false    213            n           0    0 !   Announcements_id_announcement_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public."Announcements_id_announcement_seq"', 49, true);
          public          postgres    false    214            o           0    0    Chats_announcement_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Chats_announcement_seq"', 1, false);
          public          postgres    false    216            p           0    0    Chats_id_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Chats_id_chat_seq"', 1, false);
          public          postgres    false    217            q           0    0    Chats_interested_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Chats_interested_seq"', 1, false);
          public          postgres    false    218            r           0    0    Groups_id_group_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Groups_id_group_seq"', 1, false);
          public          postgres    false    220            s           0    0    Images_id_announcement_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Images_id_announcement_seq"', 1, false);
          public          postgres    false    230            t           0    0    Messages_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Messages_chat_seq"', 1, false);
          public          postgres    false    222            u           0    0    Messages_id_message_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Messages_id_message_seq"', 1, false);
          public          postgres    false    223            v           0    0    UsersGroups_id_group_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."UsersGroups_id_group_seq"', 1, false);
          public          postgres    false    226            w           0    0    UsersGroups_id_user_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."UsersGroups_id_user_seq"', 1, false);
          public          postgres    false    227            x           0    0    Users_id_user_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Users_id_user_seq"', 1, false);
          public          postgres    false    228            �           2606    16451 ,   AnnouncementsGroups AnnouncementsGroups_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_pkey" PRIMARY KEY (id_announcement, id_group);
 Z   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_pkey";
       public            postgres    false    210    210            �           2606    16453     Announcements Announcements_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_pkey" PRIMARY KEY (id_announcement);
 N   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_pkey";
       public            postgres    false    209            �           2606    16455    Chats Chats_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_pkey" PRIMARY KEY (id_chat);
 >   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_pkey";
       public            postgres    false    215            �           2606    16457    Groups Groups_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Groups"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id_group);
 @   ALTER TABLE ONLY public."Groups" DROP CONSTRAINT "Groups_pkey";
       public            postgres    false    219            �           2606    16510    Images Images_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_pkey" PRIMARY KEY (image_path);
 @   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_pkey";
       public            postgres    false    229            �           2606    16459    Messages Messages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id_message);
 D   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_pkey";
       public            postgres    false    221            �           2606    16461    UsersGroups UsersGroups_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_pkey" PRIMARY KEY (id_user, id_group);
 J   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_pkey";
       public            postgres    false    225    225            �           2606    16463    Users Users_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public            postgres    false    224            �           2606    16464 <   AnnouncementsGroups AnnouncementsGroups_id_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement);
 j   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_announcement_fkey";
       public          postgres    false    3486    210    209            �           2606    16469 5   AnnouncementsGroups AnnouncementsGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group) NOT VALID;
 c   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_group_fkey";
       public          postgres    false    210    3492    219            �           2606    16474 (   Announcements Announcements_creator_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_creator_fkey" FOREIGN KEY (creator) REFERENCES public."Users"(id_user);
 V   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_creator_fkey";
       public          postgres    false    209    224    3496            �           2606    16479    Chats Chats_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_announcement_fkey" FOREIGN KEY (announcement) REFERENCES public."Announcements"(id_announcement);
 K   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_announcement_fkey";
       public          postgres    false    215    209    3486            �           2606    16484    Chats Chats_interested_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_interested_fkey" FOREIGN KEY (interested) REFERENCES public."Users"(id_user);
 I   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_interested_fkey";
       public          postgres    false    215    3496    224            �           2606    16526 "   Images Images_id_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement) NOT VALID;
 P   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_id_announcement_fkey";
       public          postgres    false    209    3486    229            �           2606    16489    Messages Messages_chat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_chat_fkey" FOREIGN KEY (chat) REFERENCES public."Chats"(id_chat);
 I   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_chat_fkey";
       public          postgres    false    221    215    3490            �           2606    16494 %   UsersGroups UsersGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group);
 S   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_group_fkey";
       public          postgres    false    219    3492    225            �           2606    16499 $   UsersGroups UsersGroups_id_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_user_fkey" FOREIGN KEY (id_user) REFERENCES public."Users"(id_user);
 R   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_user_fkey";
       public          postgres    false    224    3496    225            A   �   x���;�0D��)�H��	7�1�&Z���xM�ӓ���f�ݧ7���v�Rǥ�_��?����K�� IE.�n�If��HM!��,0��bab��Eb��!+��1��*�W�ӕXuoF��`��P�K�9!��?C�m�c�� BAX�      B      x�31�4�21 �H��qqq .�g      G      x������ � �      K   L   x�3�t/*-(�W(.�/�L�(J-.�,�W��L*�THɄJp�&��bQ�2�)JO�O/JL�j \�+F��� ��,�      U   �   x�m�A
1��=��4/is���
�����R��u��'i{޷�}�V�����lb�d"�<^�v��v�\�s@2뮳<0�8³�k�=';+��I�c����>g�T����k�43���s��:����%��?oA      M      x������ � �      P   �   x�M��
�0Dϛ����&�&7��M���t�@�@ۀ�o�A���o����`�8g8�8�ٺ7IՂD���܁-%�����и4��F�Fo������;�+/�̠�:%$�qM�OpO�� �1]��&]f�d�y��4�[���6�n�<ڕ��!䘠�R<!�F�>t      Q      x�3�4�2�4bc.# ����� Y�     