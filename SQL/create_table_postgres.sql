-- public.auth_group definition

-- Drop table

-- DROP TABLE public.auth_group;

CREATE TABLE public.auth_group (
	id serial NOT NULL,
	name varchar(150) NOT NULL,
	CONSTRAINT auth_group_name_key UNIQUE (name),
	CONSTRAINT auth_group_pkey PRIMARY KEY (id)
);
CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);

-- Permissions

ALTER TABLE public.auth_group OWNER TO admuno;
GRANT ALL ON TABLE public.auth_group TO admuno;


-- public.c_states definition

-- Drop table

-- DROP TABLE public.c_states;

CREATE TABLE public.c_states (
	id serial NOT NULL,
	state varchar(20) NULL,
	CONSTRAINT c_states_pkey PRIMARY KEY (id)
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
	name varchar(255) NOT NULL,
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
	id serial NOT NULL,
	"password" varchar(128) NOT NULL,
	last_login timestamptz NULL,
	email varchar(120) NOT NULL,
	name varchar(50) NOT NULL,
	username varchar(30) NOT NULL,
	usuario_activo bool NOT NULL,
	usuario_administrador bool NOT NULL,
	CONSTRAINT users_email_key UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_username_key UNIQUE (username)
);
CREATE INDEX users_email_0ea73cca_like ON public.users USING btree (email varchar_pattern_ops);
CREATE INDEX users_username_e8658fc8_like ON public.users USING btree (username varchar_pattern_ops);

-- Permissions

ALTER TABLE public.users OWNER TO admuno;
GRANT ALL ON TABLE public.users TO admuno;


-- public.auth_permission definition

-- Drop table

-- DROP TABLE public.auth_permission;

CREATE TABLE public.auth_permission (
	id serial NOT NULL,
	name varchar(255) NOT NULL,
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


-- public.chats definition

-- Drop table

-- DROP TABLE public.chats;

CREATE TABLE public.chats (
	id serial NOT NULL,
	state_id int4 NOT NULL,
	CONSTRAINT chats_pkey PRIMARY KEY (id),
	CONSTRAINT chats_state_id_62edca63_fk_c_states_id FOREIGN KEY (state_id) REFERENCES c_states(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX chats_state_id_62edca63 ON public.chats USING btree (state_id);

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
	CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_id FOREIGN KEY (user_id) REFERENCES users(id) DEFERRABLE INITIALLY DEFERRED
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
	id serial NOT NULL,
	"text" varchar(4000) NULL,
	date_msj timestamptz NULL,
	url_file varchar(500) NULL,
	chat_id int4 NOT NULL,
	user_id int4 NOT NULL,
	CONSTRAINT messages_pkey PRIMARY KEY (id),
	CONSTRAINT messages_chat_id_c921b202_fk_chats_id FOREIGN KEY (chat_id) REFERENCES chats(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT messages_user_id_70242949_fk_users_id FOREIGN KEY (user_id) REFERENCES users(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX messages_chat_id_c921b202 ON public.messages USING btree (chat_id);
CREATE INDEX messages_user_id_70242949 ON public.messages USING btree (user_id);

-- Permissions

ALTER TABLE public.messages OWNER TO admuno;
GRANT ALL ON TABLE public.messages TO admuno;


-- public.u_friends definition

-- Drop table

-- DROP TABLE public.u_friends;

CREATE TABLE public.u_friends (
	id serial NOT NULL,
	user_id int4 NOT NULL,
	user_added_id int4 NOT NULL,
	CONSTRAINT u_friends_pkey PRIMARY KEY (id),
	CONSTRAINT u_friends_user_id_user_added_id_14b7fac5_uniq UNIQUE (user_id, user_added_id),
	CONSTRAINT u_friends_user_added_id_8efc2049_fk_users_id FOREIGN KEY (user_added_id) REFERENCES users(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT u_friends_user_id_fad1f6ba_fk_users_id FOREIGN KEY (user_id) REFERENCES users(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX u_friends_user_added_id_8efc2049 ON public.u_friends USING btree (user_added_id);
CREATE INDEX u_friends_user_id_fad1f6ba ON public.u_friends USING btree (user_id);

-- Permissions

ALTER TABLE public.u_friends OWNER TO admuno;
GRANT ALL ON TABLE public.u_friends TO admuno;


-- public.u_states definition

-- Drop table

-- DROP TABLE public.u_states;

CREATE TABLE public.u_states (
	id serial NOT NULL,
	state varchar(20) NULL,
	user_id int4 NOT NULL,
	CONSTRAINT u_states_pkey PRIMARY KEY (id),
	CONSTRAINT u_states_user_id_c1219a38_fk_users_id FOREIGN KEY (user_id) REFERENCES users(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX u_states_user_id_c1219a38 ON public.u_states USING btree (user_id);

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
	id serial NOT NULL,
	chat_id int4 NOT NULL,
	user_id int4 NOT NULL,
	CONSTRAINT chat_users_pkey PRIMARY KEY (id),
	CONSTRAINT chat_users_chat_id_8dd13625_fk_chats_id FOREIGN KEY (chat_id) REFERENCES chats(id) DEFERRABLE INITIALLY DEFERRED,
	CONSTRAINT chat_users_user_id_431ebf5b_fk_users_id FOREIGN KEY (user_id) REFERENCES users(id) DEFERRABLE INITIALLY DEFERRED
);
CREATE INDEX chat_users_chat_id_8dd13625 ON public.chat_users USING btree (chat_id);
CREATE INDEX chat_users_user_id_431ebf5b ON public.chat_users USING btree (user_id);

-- Permissions

ALTER TABLE public.chat_users OWNER TO admuno;
GRANT ALL ON TABLE public.chat_users TO admuno;
