 
-- public.auth_group definition

-- Drop table

-- DROP TABLE public.auth_group;

CREATE TABLE public.auth_group (
	id serial NOT NULL,
	"name" varchar(150) NOT NULL,
	CONSTRAINT auth_group_name_key UNIQUE (name),
	CONSTRAINT auth_group_pkey PRIMARY KEY (id)
);
CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);

-- Permissions

ALTER TABLE public.auth_group OWNER TO admuno;
GRANT ALL ON TABLE public.auth_group TO admuno;


-- public.auth_user definition

-- Drop table

-- DROP TABLE public.auth_user;

CREATE TABLE public.auth_user (
	id serial NOT NULL,
	"password" varchar(128) NOT NULL,
	last_login timestamptz NULL,
	is_superuser bool NOT NULL,
	username varchar(150) NOT NULL,
	first_name varchar(150) NOT NULL,
	last_name varchar(150) NOT NULL,
	email varchar(254) NOT NULL,
	is_staff bool NOT NULL,
	is_active bool NOT NULL,
	date_joined timestamptz NOT NULL,
	CONSTRAINT auth_user_pkey PRIMARY KEY (id),
	CONSTRAINT auth_user_username_key UNIQUE (username)
);
CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);

-- Permissions

ALTER TABLE public.auth_user OWNER TO admuno;
GRANT ALL ON TABLE public.auth_user TO admuno;


-- public.c_states definition

-- Drop table

-- DROP TABLE public.c_states;

CREATE TABLE public.c_states (
	state_id serial NOT NULL,
	state varchar(20) NULL,
	CONSTRAINT c_states_pk PRIMARY KEY (state_id)
);

-- Permissions

ALTER TABLE public.c_states OWNER TO admuno;
GRANT ALL ON TABLE public.c_states TO admuno;


-- public.django_content_type definition

-- Drop table

-- DROP TABLE public.django_content_type;

CREATE TABLE public.django_content_type (
	id serial NOT NULL,
	app_label varchar(100) NOT NULL,
	model varchar(100) NOT NULL,
	CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model),
	CONSTRAINT django_content_type_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.django_content_type OWNER TO admuno;
GRANT ALL ON TABLE public.django_content_type TO admuno;


-- public.django_migrations definition

-- Drop table

-- DROP TABLE public.django_migrations;

CREATE TABLE public.django_migrations (
	id serial NOT NULL,
	app varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	applied timestamptz NOT NULL,
	CONSTRAINT django_migrations_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.django_migrations OWNER TO admuno;
GRANT ALL ON TABLE public.django_migrations TO admuno;


-- public.django_session definition

-- Drop table

-- DROP TABLE public.django_session;

CREATE TABLE public.django_session (
	session_key varchar(40) NOT NULL,
	session_data text NOT NULL,
	expire_date timestamptz NOT NULL,
	CONSTRAINT django_session_pkey PRIMARY KEY (session_key)
);
CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);

-- Permissions

ALTER TABLE public.django_session OWNER TO admuno;
GRANT ALL ON TABLE public.django_session TO admuno;


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	user_id serial NOT NULL,
	email varchar(120) NOT NULL,
	"name" varchar(50) NOT NULL,
	"password" varchar(50) NULL,
	username varchar(30) NOT NULL,
	usuario_activo bool NULL,
	usuario_administrador bool NULL,
	CONSTRAINT users_pk PRIMARY KEY (user_id)
);

-- Permissions

ALTER TABLE public.users OWNER TO admuno;
GRANT ALL ON TABLE public.users TO admuno;


-- public.auth_permission definition

-- Drop table

-- DROP TABLE public.auth_permission;

CREATE TABLE public.auth_permission (
	id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	content_type_id int4 NOT NULL,
	codename varchar(100) NOT NULL,
	CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename),
	CONSTRAINT auth_permission_pkey PRIMARY KEY (id),
	CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);

-- Permissions

ALTER TABLE public.auth_permission OWNER TO admuno;
GRANT ALL ON TABLE public.auth_permission TO admuno;


-- public.auth_user_groups definition

-- Drop table

-- DROP TABLE public.auth_user_groups;

CREATE TABLE public.auth_user_groups (
	id serial NOT NULL,
	user_id int4 NOT NULL,
	group_id int4 NOT NULL,
	CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id),
	CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id),
	CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);

-- Permissions

ALTER TABLE public.auth_user_groups OWNER TO admuno;
GRANT ALL ON TABLE public.auth_user_groups TO admuno;


-- public.auth_user_user_permissions definition

-- Drop table

-- DROP TABLE public.auth_user_user_permissions;

CREATE TABLE public.auth_user_user_permissions (
	id serial NOT NULL,
	user_id int4 NOT NULL,
	permission_id int4 NOT NULL,
	CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id),
	CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id),
	CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);

-- Permissions

ALTER TABLE public.auth_user_user_permissions OWNER TO admuno;
GRANT ALL ON TABLE public.auth_user_user_permissions TO admuno;


-- public.chats definition

-- Drop table

-- DROP TABLE public.chats;

CREATE TABLE public.chats (
	chat_id int4 NOT NULL,
	state_id int4 NOT NULL,
	CONSTRAINT chats_pk PRIMARY KEY (chat_id),
	CONSTRAINT tipo FOREIGN KEY (state_id) REFERENCES c_states(state_id)
);

-- Permissions

ALTER TABLE public.chats OWNER TO admuno;
GRANT ALL ON TABLE public.chats TO admuno;


-- public.django_admin_log definition

-- Drop table

-- DROP TABLE public.django_admin_log;

CREATE TABLE public.django_admin_log (
	id serial NOT NULL,
	action_time timestamptz NOT NULL,
	object_id text NULL,
	object_repr varchar(200) NOT NULL,
	action_flag int2 NOT NULL,
	change_message text NOT NULL,
	content_type_id int4 NULL,
	user_id int4 NOT NULL,
	CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0)),
	CONSTRAINT django_admin_log_pkey PRIMARY KEY (id),
	CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);

-- Permissions

ALTER TABLE public.django_admin_log OWNER TO admuno;
GRANT ALL ON TABLE public.django_admin_log TO admuno;


-- public.messages definition

-- Drop table

-- DROP TABLE public.messages;

CREATE TABLE public.messages (
	message_id serial NOT NULL,
	chat_id int4 NOT NULL,
	user_id int4 NOT NULL,
	"text" varchar(4000) NULL,
	date_msj timestamp NULL,
	url_file varchar(500) NULL,
	CONSTRAINT messages_pk PRIMARY KEY (message_id),
	CONSTRAINT messages_chats_fk FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
	CONSTRAINT messages_users_fk FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Permissions

ALTER TABLE public.messages OWNER TO admuno;
GRANT ALL ON TABLE public.messages TO admuno;


-- public.u_friends definition

-- Drop table

-- DROP TABLE public.u_friends;

CREATE TABLE public.u_friends (
	"user" int4 NOT NULL,
	user_added int4 NOT NULL,
	CONSTRAINT u_friends_pk PRIMARY KEY ("user", user_added),
	CONSTRAINT agrega FOREIGN KEY ("user") REFERENCES users(user_id),
	CONSTRAINT agregado FOREIGN KEY (user_added) REFERENCES users(user_id)
);

-- Permissions

ALTER TABLE public.u_friends OWNER TO admuno;
GRANT ALL ON TABLE public.u_friends TO admuno;


-- public.u_states definition

-- Drop table

-- DROP TABLE public.u_states;

CREATE TABLE public.u_states (
	user_id int4 NOT NULL,
	state varchar(20) NULL,
	CONSTRAINT u_states_users_fk FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Permissions

ALTER TABLE public.u_states OWNER TO admuno;
GRANT ALL ON TABLE public.u_states TO admuno;


-- public.auth_group_permissions definition

-- Drop table

-- DROP TABLE public.auth_group_permissions;

CREATE TABLE public.auth_group_permissions (
	id serial NOT NULL,
	group_id int4 NOT NULL,
	permission_id int4 NOT NULL,
	CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id),
	CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id),
	CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);

-- Permissions

ALTER TABLE public.auth_group_permissions OWNER TO admuno;
GRANT ALL ON TABLE public.auth_group_permissions TO admuno;


-- public.chat_users definition

-- Drop table

-- DROP TABLE public.chat_users;

CREATE TABLE public.chat_users (
	user_id serial NOT NULL,
	chat_id int4 NOT NULL,
	CONSTRAINT chat FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
	CONSTRAINT "user" FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Permissions

ALTER TABLE public.chat_users OWNER TO admuno;
GRANT ALL ON TABLE public.chat_users TO admuno;