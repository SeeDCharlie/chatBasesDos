 CREATE TABLE c_states (
    state_id  serial,
    state     VARCHAR(20)
);

ALTER TABLE c_states ADD CONSTRAINT c_states_pk PRIMARY KEY ( state_id );

CREATE TABLE chat_users (
    user_id  serial,
    chat_id  INTEGER NOT NULL
);

CREATE TABLE chats (
    chat_id   INTEGER NOT NULL,
    state_id  INTEGER NOT NULL
);

ALTER TABLE chats ADD CONSTRAINT chats_pk PRIMARY KEY ( chat_id );

CREATE TABLE messages (
    message_id  serial,
    chat_id     INTEGER NOT NULL,
    user_id     INTEGER NOT NULL,
    text        VARCHAR(4000),
    date_msj    TIMESTAMP,  
    url_file    VARCHAR(500)
);

ALTER TABLE messages ADD CONSTRAINT messages_pk PRIMARY KEY ( message_id );

CREATE TABLE u_friends (
    "user"      INTEGER NOT NULL,
    user_added  INTEGER NOT NULL
);

ALTER TABLE u_friends ADD CONSTRAINT u_friends_pk PRIMARY KEY ( "user",
                                                                user_added );

CREATE TABLE u_states (
    user_id  INTEGER NOT NULL,
    state    VARCHAR(20)
);

CREATE TABLE users (
    user_id   serial,
    email     VARCHAR(120) NOT NULL,
    name      VARCHAR(50) NOT NULL,
    password  VARCHAR(50) NOT NULL
);

ALTER TABLE users ADD CONSTRAINT users_pk PRIMARY KEY ( user_id );

ALTER TABLE u_friends
    ADD CONSTRAINT agrega FOREIGN KEY ( "user" )
        REFERENCES users ( user_id );

ALTER TABLE u_friends
    ADD CONSTRAINT agregado FOREIGN KEY ( user_added )
        REFERENCES users ( user_id );

ALTER TABLE chat_users
    ADD CONSTRAINT chat FOREIGN KEY ( chat_id )
        REFERENCES chats ( chat_id );

ALTER TABLE messages
    ADD CONSTRAINT messages_chats_fk FOREIGN KEY ( chat_id )
        REFERENCES chats ( chat_id );

ALTER TABLE messages
    ADD CONSTRAINT messages_users_fk FOREIGN KEY ( user_id )
        REFERENCES users ( user_id );

ALTER TABLE chats
    ADD CONSTRAINT tipo FOREIGN KEY ( state_id )
        REFERENCES c_states ( state_id );

ALTER TABLE u_states
    ADD CONSTRAINT u_states_users_fk FOREIGN KEY ( user_id )
        REFERENCES users ( user_id );

ALTER TABLE chat_users
    ADD CONSTRAINT "user" FOREIGN KEY ( user_id )
        REFERENCES users ( user_id );
