REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'after_accountinsert','Initial Order' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'after_domaininsertregister','Initial Registration Order' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'services', 'after_domaininserttransfer','Initial Transfer Order' FROM hb_language  WHERE target='admin';