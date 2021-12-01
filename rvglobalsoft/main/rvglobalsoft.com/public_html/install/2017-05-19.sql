REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clients', 'services_full','Full control over services' FROM hb_language WHERE target!='user'
UNION SELECT id, 'clients', 'domains_full','Full control over domains' FROM hb_language WHERE target!='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('MoveDueDays', '0');