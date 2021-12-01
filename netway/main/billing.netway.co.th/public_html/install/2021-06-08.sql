REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'contactselector', 'Select Contact' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'contactselector-description', 'Choosing the customer''s contact' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'mainprofiledetails', 'Main profile details' FROM hb_language;