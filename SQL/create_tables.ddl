-- Generado por Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   en:        2020-09-23 22:19:28 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE c_states (
    state_id  INTEGER NOT NULL,
    state     VARCHAR2(20)
);

ALTER TABLE c_states ADD CONSTRAINT c_states_pk PRIMARY KEY ( state_id );

CREATE TABLE chat_users (
    user_id  INTEGER NOT NULL,
    chat_id  INTEGER NOT NULL
);

CREATE TABLE chats (
    chat_id   INTEGER NOT NULL,
    state_id  INTEGER NOT NULL
);

ALTER TABLE chats ADD CONSTRAINT chats_pk PRIMARY KEY ( chat_id );

CREATE TABLE messages (
    message_id  INTEGER NOT NULL,
    chat_id     INTEGER NOT NULL,
    user_id     INTEGER NOT NULL,
    text        VARCHAR2(4000 CHAR),
    time        TIMESTAMP,
    url_file    VARCHAR2(500 CHAR)
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
    state    VARCHAR2(20)
);

CREATE TABLE users (
    user_id   INTEGER NOT NULL,
    email     VARCHAR2(120) NOT NULL,
    name      VARCHAR2(50) NOT NULL,
    password  VARCHAR2(50) NOT NULL
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

CREATE SEQUENCE chats_chat_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER chats_chat_id_trg BEFORE
    INSERT ON chats
    FOR EACH ROW
    WHEN ( new.chat_id IS NULL )
BEGIN
    :new.chat_id := chats_chat_id_seq.nextval;
END;
/

CREATE SEQUENCE messages_message_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER messages_message_id_trg BEFORE
    INSERT ON messages
    FOR EACH ROW
    WHEN ( new.message_id IS NULL )
BEGIN
    :new.message_id := messages_message_id_seq.nextval;
END;
/

CREATE SEQUENCE users_user_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER users_user_id_trg BEFORE
    INSERT ON users
    FOR EACH ROW
    WHEN ( new.user_id IS NULL )
BEGIN
    :new.user_id := users_user_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             13
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           3
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          3
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
