REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'sshkey_type_unsupported','Unsupported SSH key type, please use RSA, DSA or ECDSA public key' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'sshkey_read_error','Unable to read SSH key' FROM hb_language WHERE target = 'user';