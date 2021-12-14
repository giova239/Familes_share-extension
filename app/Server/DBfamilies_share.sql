PGDMP         $    
            y            DBfamilies_share    13.5    13.2 ]               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    16819    DBfamilies_share    DATABASE     n   CREATE DATABASE "DBfamilies_share" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';
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
       public          postgres    false    209            "           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public."AnnouncementsGroups_id_announcement_seq" OWNED BY public."AnnouncementsGroups".id_announcement;
          public          postgres    false    207            �            1259    17119     AnnouncementsGroups_id_group_seq    SEQUENCE     �   CREATE SEQUENCE public."AnnouncementsGroups_id_group_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."AnnouncementsGroups_id_group_seq";
       public          postgres    false    209            #           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."AnnouncementsGroups_id_group_seq" OWNED BY public."AnnouncementsGroups".id_group;
          public          postgres    false    208            �            1259    17089    Announcements_creator_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_creator_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."Announcements_creator_seq";
       public          postgres    false    204            $           0    0    Announcements_creator_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."Announcements_creator_seq" OWNED BY public."Announcements".creator;
          public          postgres    false    203            �            1259    17087 !   Announcements_id_announcement_seq    SEQUENCE     �   CREATE SEQUENCE public."Announcements_id_announcement_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public."Announcements_id_announcement_seq";
       public          postgres    false    204            %           0    0 !   Announcements_id_announcement_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."Announcements_id_announcement_seq" OWNED BY public."Announcements".id_announcement;
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
       public          postgres    false    216            &           0    0    Chats_announcement_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."Chats_announcement_seq" OWNED BY public."Chats".announcement;
          public          postgres    false    214            �            1259    17159    Chats_id_chat_seq    SEQUENCE     |   CREATE SEQUENCE public."Chats_id_chat_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Chats_id_chat_seq";
       public          postgres    false    216            '           0    0    Chats_id_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Chats_id_chat_seq" OWNED BY public."Chats".id_chat;
          public          postgres    false    213            �            1259    17163    Chats_interested_seq    SEQUENCE        CREATE SEQUENCE public."Chats_interested_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Chats_interested_seq";
       public          postgres    false    216            (           0    0    Chats_interested_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."Chats_interested_seq" OWNED BY public."Chats".interested;
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
       public          postgres    false    206            )           0    0    Groups_id_group_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Groups_id_group_seq" OWNED BY public."Groups".id_group;
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
       public          postgres    false    221            *           0    0    Images_id_announcement_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."Images_id_announcement_seq" OWNED BY public."Images".id_announcement;
          public          postgres    false    220            �            1259    17188    Messages    TABLE     l   CREATE TABLE public."Messages" (
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
       public          postgres    false    219            +           0    0    Messages_chat_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Messages_chat_seq" OWNED BY public."Messages".chat;
          public          postgres    false    218            �            1259    17184    Messages_id_message_seq    SEQUENCE     �   CREATE SEQUENCE public."Messages_id_message_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Messages_id_message_seq";
       public          postgres    false    219            ,           0    0    Messages_id_message_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Messages_id_message_seq" OWNED BY public."Messages".id_message;
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
       public          postgres    false    212            -           0    0    UsersGroups_id_group_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."UsersGroups_id_group_seq" OWNED BY public."UsersGroups".id_group;
          public          postgres    false    211            �            1259    17138    UsersGroups_id_user_seq    SEQUENCE     �   CREATE SEQUENCE public."UsersGroups_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."UsersGroups_id_user_seq";
       public          postgres    false    212            .           0    0    UsersGroups_id_user_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."UsersGroups_id_user_seq" OWNED BY public."UsersGroups".id_user;
          public          postgres    false    210            �            1259    17076    Users_id_user_seq    SEQUENCE     |   CREATE SEQUENCE public."Users_id_user_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Users_id_user_seq";
       public          postgres    false    201            /           0    0    Users_id_user_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Users_id_user_seq" OWNED BY public."Users".id_user;
          public          postgres    false    200            ^           2604    17094    Announcements id_announcement    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Announcements_id_announcement_seq"'::regclass);
 N   ALTER TABLE public."Announcements" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    204    202    204            _           2604    17095    Announcements creator    DEFAULT     �   ALTER TABLE ONLY public."Announcements" ALTER COLUMN creator SET DEFAULT nextval('public."Announcements_creator_seq"'::regclass);
 F   ALTER TABLE public."Announcements" ALTER COLUMN creator DROP DEFAULT;
       public          postgres    false    203    204    204            a           2604    17124 #   AnnouncementsGroups id_announcement    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_announcement SET DEFAULT nextval('public."AnnouncementsGroups_id_announcement_seq"'::regclass);
 T   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    209    207    209            b           2604    17125    AnnouncementsGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."AnnouncementsGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."AnnouncementsGroups_id_group_seq"'::regclass);
 M   ALTER TABLE public."AnnouncementsGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    209    208    209            e           2604    17168    Chats id_chat    DEFAULT     r   ALTER TABLE ONLY public."Chats" ALTER COLUMN id_chat SET DEFAULT nextval('public."Chats_id_chat_seq"'::regclass);
 >   ALTER TABLE public."Chats" ALTER COLUMN id_chat DROP DEFAULT;
       public          postgres    false    213    216    216            f           2604    17169    Chats announcement    DEFAULT     |   ALTER TABLE ONLY public."Chats" ALTER COLUMN announcement SET DEFAULT nextval('public."Chats_announcement_seq"'::regclass);
 C   ALTER TABLE public."Chats" ALTER COLUMN announcement DROP DEFAULT;
       public          postgres    false    216    214    216            g           2604    17170    Chats interested    DEFAULT     x   ALTER TABLE ONLY public."Chats" ALTER COLUMN interested SET DEFAULT nextval('public."Chats_interested_seq"'::regclass);
 A   ALTER TABLE public."Chats" ALTER COLUMN interested DROP DEFAULT;
       public          postgres    false    215    216    216            `           2604    17111    Groups id_group    DEFAULT     v   ALTER TABLE ONLY public."Groups" ALTER COLUMN id_group SET DEFAULT nextval('public."Groups_id_group_seq"'::regclass);
 @   ALTER TABLE public."Groups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    205    206    206            j           2604    17209    Images id_announcement    DEFAULT     �   ALTER TABLE ONLY public."Images" ALTER COLUMN id_announcement SET DEFAULT nextval('public."Images_id_announcement_seq"'::regclass);
 G   ALTER TABLE public."Images" ALTER COLUMN id_announcement DROP DEFAULT;
       public          postgres    false    220    221    221            h           2604    17191    Messages id_message    DEFAULT     ~   ALTER TABLE ONLY public."Messages" ALTER COLUMN id_message SET DEFAULT nextval('public."Messages_id_message_seq"'::regclass);
 D   ALTER TABLE public."Messages" ALTER COLUMN id_message DROP DEFAULT;
       public          postgres    false    219    217    219            i           2604    17192    Messages chat    DEFAULT     r   ALTER TABLE ONLY public."Messages" ALTER COLUMN chat SET DEFAULT nextval('public."Messages_chat_seq"'::regclass);
 >   ALTER TABLE public."Messages" ALTER COLUMN chat DROP DEFAULT;
       public          postgres    false    218    219    219            ]           2604    17081    Users id_user    DEFAULT     r   ALTER TABLE ONLY public."Users" ALTER COLUMN id_user SET DEFAULT nextval('public."Users_id_user_seq"'::regclass);
 >   ALTER TABLE public."Users" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    200    201    201            c           2604    17145    UsersGroups id_user    DEFAULT     ~   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_user SET DEFAULT nextval('public."UsersGroups_id_user_seq"'::regclass);
 D   ALTER TABLE public."UsersGroups" ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    210    212    212            d           2604    17146    UsersGroups id_group    DEFAULT     �   ALTER TABLE ONLY public."UsersGroups" ALTER COLUMN id_group SET DEFAULT nextval('public."UsersGroups_id_group_seq"'::regclass);
 E   ALTER TABLE public."UsersGroups" ALTER COLUMN id_group DROP DEFAULT;
       public          postgres    false    212    211    212            
          0    17091    Announcements 
   TABLE DATA           ]   COPY public."Announcements" (id_announcement, title, description, creator, type) FROM stdin;
    public          postgres    false    204   \m                 0    17121    AnnouncementsGroups 
   TABLE DATA           J   COPY public."AnnouncementsGroups" (id_announcement, id_group) FROM stdin;
    public          postgres    false    209   3n                 0    17165    Chats 
   TABLE DATA           D   COPY public."Chats" (id_chat, announcement, interested) FROM stdin;
    public          postgres    false    216   bn                 0    17108    Groups 
   TABLE DATA           ?   COPY public."Groups" (id_group, name, description) FROM stdin;
    public          postgres    false    206   �n                 0    17206    Images 
   TABLE DATA           ?   COPY public."Images" (image_path, id_announcement) FROM stdin;
    public          postgres    false    221   �n                 0    17188    Messages 
   TABLE DATA           <   COPY public."Messages" (id_message, text, chat) FROM stdin;
    public          postgres    false    219   o                 0    17078    Users 
   TABLE DATA           �   COPY public."Users" (id_user, username, name, surname, password, birth_date, email, phone, street, city, postal_code) FROM stdin;
    public          postgres    false    201    o                 0    17142    UsersGroups 
   TABLE DATA           :   COPY public."UsersGroups" (id_user, id_group) FROM stdin;
    public          postgres    false    212   �o       0           0    0 '   AnnouncementsGroups_id_announcement_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_announcement_seq"', 1, false);
          public          postgres    false    207            1           0    0     AnnouncementsGroups_id_group_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."AnnouncementsGroups_id_group_seq"', 1, false);
          public          postgres    false    208            2           0    0    Announcements_creator_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Announcements_creator_seq"', 1, false);
          public          postgres    false    203            3           0    0 !   Announcements_id_announcement_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public."Announcements_id_announcement_seq"', 30, true);
          public          postgres    false    202            4           0    0    Chats_announcement_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Chats_announcement_seq"', 1, false);
          public          postgres    false    214            5           0    0    Chats_id_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Chats_id_chat_seq"', 1, false);
          public          postgres    false    213            6           0    0    Chats_interested_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Chats_interested_seq"', 1, false);
          public          postgres    false    215            7           0    0    Groups_id_group_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Groups_id_group_seq"', 1, false);
          public          postgres    false    205            8           0    0    Images_id_announcement_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Images_id_announcement_seq"', 1, false);
          public          postgres    false    220            9           0    0    Messages_chat_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Messages_chat_seq"', 1, false);
          public          postgres    false    218            :           0    0    Messages_id_message_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Messages_id_message_seq"', 1, false);
          public          postgres    false    217            ;           0    0    UsersGroups_id_group_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."UsersGroups_id_group_seq"', 1, false);
          public          postgres    false    211            <           0    0    UsersGroups_id_user_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."UsersGroups_id_user_seq"', 1, false);
          public          postgres    false    210            =           0    0    Users_id_user_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Users_id_user_seq"', 1, false);
          public          postgres    false    200            r           2606    17127 ,   AnnouncementsGroups AnnouncementsGroups_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_pkey" PRIMARY KEY (id_announcement, id_group);
 Z   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_pkey";
       public            postgres    false    209    209            n           2606    17100     Announcements Announcements_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_pkey" PRIMARY KEY (id_announcement);
 N   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_pkey";
       public            postgres    false    204            v           2606    17172    Chats Chats_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_pkey" PRIMARY KEY (id_chat);
 >   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_pkey";
       public            postgres    false    216            p           2606    17116    Groups Groups_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Groups"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id_group);
 @   ALTER TABLE ONLY public."Groups" DROP CONSTRAINT "Groups_pkey";
       public            postgres    false    206            z           2606    17214    Images Images_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_pkey" PRIMARY KEY (image_path);
 @   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_pkey";
       public            postgres    false    221            x           2606    17197    Messages Messages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id_message);
 D   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_pkey";
       public            postgres    false    219            t           2606    17148    UsersGroups UsersGroups_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_pkey" PRIMARY KEY (id_user, id_group);
 J   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_pkey";
       public            postgres    false    212    212            l           2606    17086    Users Users_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id_user);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public            postgres    false    201            |           2606    17128 <   AnnouncementsGroups AnnouncementsGroups_id_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement);
 j   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_announcement_fkey";
       public          postgres    false    204    2926    209            }           2606    17133 5   AnnouncementsGroups AnnouncementsGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AnnouncementsGroups"
    ADD CONSTRAINT "AnnouncementsGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group) NOT VALID;
 c   ALTER TABLE ONLY public."AnnouncementsGroups" DROP CONSTRAINT "AnnouncementsGroups_id_group_fkey";
       public          postgres    false    209    2928    206            {           2606    17101 (   Announcements Announcements_creator_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Announcements"
    ADD CONSTRAINT "Announcements_creator_fkey" FOREIGN KEY (creator) REFERENCES public."Users"(id_user);
 V   ALTER TABLE ONLY public."Announcements" DROP CONSTRAINT "Announcements_creator_fkey";
       public          postgres    false    204    201    2924            �           2606    17173    Chats Chats_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_announcement_fkey" FOREIGN KEY (announcement) REFERENCES public."Announcements"(id_announcement);
 K   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_announcement_fkey";
       public          postgres    false    2926    216    204            �           2606    17178    Chats Chats_interested_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Chats"
    ADD CONSTRAINT "Chats_interested_fkey" FOREIGN KEY (interested) REFERENCES public."Users"(id_user);
 I   ALTER TABLE ONLY public."Chats" DROP CONSTRAINT "Chats_interested_fkey";
       public          postgres    false    216    2924    201            �           2606    17215 "   Images Images_id_announcement_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Images"
    ADD CONSTRAINT "Images_id_announcement_fkey" FOREIGN KEY (id_announcement) REFERENCES public."Announcements"(id_announcement) NOT VALID;
 P   ALTER TABLE ONLY public."Images" DROP CONSTRAINT "Images_id_announcement_fkey";
       public          postgres    false    204    2926    221            �           2606    17198    Messages Messages_chat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_chat_fkey" FOREIGN KEY (chat) REFERENCES public."Chats"(id_chat);
 I   ALTER TABLE ONLY public."Messages" DROP CONSTRAINT "Messages_chat_fkey";
       public          postgres    false    2934    216    219                       2606    17154 %   UsersGroups UsersGroups_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."Groups"(id_group);
 S   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_group_fkey";
       public          postgres    false    212    206    2928            ~           2606    17149 $   UsersGroups UsersGroups_id_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UsersGroups"
    ADD CONSTRAINT "UsersGroups_id_user_fkey" FOREIGN KEY (id_user) REFERENCES public."Users"(id_user);
 R   ALTER TABLE ONLY public."UsersGroups" DROP CONSTRAINT "UsersGroups_id_user_fkey";
       public          postgres    false    201    212    2924            
   �   x����� Eg�|A�{�Եj�.n���#��_�T�,Y�8:x�W����y�3mr#�L{���m��ط\i3
��0%
�^�ذ!<p��驱�@gMU`0恈昌�P�|�3�E�/f�=Y3���L�cz=�����t���c��#�'��я�H�"튴/ҡHGX>6��$.x�kH�_黟1Ƴ�ϋ�~��            x�3�4�22 �Hpq��qqq ;p�            x�3�4�4�2�4�R1z\\\ ?C         L   x�3�t/*-(�W(.�/�L�(J-.�,�W��L*�THɄJp�&��bQ�2�)JO�O/JL�j \�+F��� ��,�            x������ � �            x������ � �         �   x�M��
�0Dϛ����&�&7��M���t�@�@ۀ�o�A���o����`�8g8�8�ٺ7IՂD���܁-%�����и4��F�Fo������;�+/�̠�:%$�qM�OpO�� �1]��&]f�d�y��4�[���6�n�<ڕ��!䘠�R<!�F�>t            x�3�4�2�4bc.# ����� Y�     