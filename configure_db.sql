DROP SCHEMA public;
CREATE SCHEMA pjsip;
ALTER SCHEMA pjsip OWNER TO asterisk;

CREATE TABLE pjsip.auths (
    id VARCHAR(40) PRIMARY KEY,
    auth_type VARCHAR(40),
    password VARCHAR(80),
    username VARCHAR(80)
);

CREATE TABLE pjsip.endpoints (
    id VARCHAR(40) PRIMARY KEY,
    transport VARCHAR(20),
    aors VARCHAR(40),
    auth VARCHAR(40),
    context VARCHAR(40),
    disallow VARCHAR(100),
    allow VARCHAR(100),
    direct_media VARCHAR(10),
    mailboxes VARCHAR(40)
);

CREATE TABLE pjsip.aors (
    id VARCHAR(40) PRIMARY KEY,
    max_contacts INT
);

ALTER TABLE pjsip.aors OWNER TO asterisk;
ALTER TABLE pjsip.auths OWNER TO asterisk;
ALTER TABLE pjsip.endpoints OWNER TO asterisk; 

GRANT USAGE ON SCHEMA pjsip TO asterisk_ro;

CREATE OR REPLACE VIEW pjsip.v_aors as SELECT * from pjsip.aors;
CREATE OR REPLACE VIEW pjsip.v_auths as SELECT * from pjsip.auths;
CREATE OR REPLACE VIEW pjsip.v_endpoints as SELECT * from pjsip.endpoints; 

GRANT SELECT ON pjsip.v_auths TO asterisk_ro;
GRANT SELECT ON pjsip.v_endpoints TO asterisk_ro;
GRANT SELECT ON pjsip.v_aors TO asterisk_ro;
