REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Creditnote','Credit Note' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'creditnote','credit note' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'Creditnotes','Credit Notes' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'creditnotes ','credit notes' FROM hb_language WHERE target='user';
