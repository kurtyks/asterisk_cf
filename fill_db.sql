INSERT INTO pjsip.aors (id, max_contacts)
VALUES
    ('2200', 10),
    ('3300', 10),
    ('4400', 10),
    ('5500', 10),
    ('6600', 10),
    ('7700', 10),
    ('8800', 10),
    ('9900', 10);

INSERT INTO pjsip.auths (id, auth_type, password, username)
VALUES
    ('2200', 'userpass', 'adm', '2200'),
    ('3300', 'userpass', 'adm', '3300'),
    ('4400', 'userpass', 'adm', '4400'),
    ('5500', 'userpass', 'adm', '5500'),
    ('6600', 'userpass', 'adm', '6600'),
    ('7700', 'userpass', 'adm', '7700'),
    ('8800', 'userpass', 'adm', '8800'),
    ('9900', 'userpass', 'adm', '9900');

INSERT INTO pjsip.endpoints (id, transport, aors, auth, context, disallow, allow, direct_media)
VALUES
    ('2200', 'transport-udp', '2200', '2200', 'default', 'all', 'all', 'no'),
    ('3300', 'transport-udp', '3300', '3300', 'default', 'all', 'all', 'no'),
    ('4400', 'transport-udp', '4400', '4400', 'default', 'all', 'all', 'no'),
    ('5500', 'transport-udp', '5500', '5500', 'default', 'all', 'all', 'no'),
    ('6600', 'transport-udp', '6600', '6600', 'default', 'all', 'all', 'no'),
    ('7700', 'transport-udp', '7700', '7700', 'default', 'all', 'all', 'no'),
    ('8800', 'transport-udp', '8800', '8800', 'default', 'all', 'all', 'no'),
    ('9900', 'transport-udp', '9900', '9900', 'default', 'all', 'all', 'no');

