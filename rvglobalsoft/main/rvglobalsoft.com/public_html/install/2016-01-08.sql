REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configfields', 'searchselect','Searchable Dropdown' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'searchselect-description','Dropdown form that includes search field' FROM hb_language WHERE target!='user';