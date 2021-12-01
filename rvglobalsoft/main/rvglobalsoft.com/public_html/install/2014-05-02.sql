REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configfields', 'selectboxqty','Dropdown with qty input' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'selectboxqty-description','Your customers will be able to choose one from number of values, and specify number of those items' FROM hb_language WHERE target='admin';