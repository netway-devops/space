REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clients', 'taxrateoverride','Custom Tax rate' FROM hb_language WHERE target!='user';