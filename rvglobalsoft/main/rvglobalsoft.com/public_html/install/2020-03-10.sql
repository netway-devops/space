REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'dnssec','DNSSEC' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_key_tag','Key Tag' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_algorithm', 'Algorithm'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_digest_type', 'Digest type'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_key_digest', 'Key Digest'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_flags', 'Flags'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_protocol', 'Protocol'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_public_key', 'Public key'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_no_records', 'No DNSSEC records added yet.'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_new_key_tag', 'New Key Tag'  FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnssec_key_algorithm', 'DNSKEY Algorithm'  FROM hb_language WHERE target = 'user';