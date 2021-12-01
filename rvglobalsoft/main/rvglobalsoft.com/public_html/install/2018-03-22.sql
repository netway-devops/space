REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configfields', 'servergroupselector','Select Server Group' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'servergroupselector-description','This field allows customer to select server group during order. Read *How To use this field?* tab in field details for more informations.' FROM hb_language WHERE target='admin';
