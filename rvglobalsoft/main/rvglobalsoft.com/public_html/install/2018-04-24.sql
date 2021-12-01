REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'manapps','Apps Connections' FROM hb_language WHERE target='admin' AND id=1
UNION SELECT id, 'servers', 'addnewapp','Add new Connection' FROM hb_language WHERE target='admin' AND id=1
UNION SELECT id, 'root', 'addnewserver','Add new Connection' FROM hb_language WHERE target='admin' AND id=1
UNION SELECT id, 'global', 'addnewserver','Add new Connection' FROM hb_language WHERE target='admin' AND id=1
UNION SELECT id, 'global', 'third_party_app','App' FROM hb_language WHERE target='admin' AND id=1
UNION SELECT id, 'global', 'app_connection','App Connection' FROM hb_language WHERE target='admin' AND id=1
UNION SELECT id, 'servers', 'apps','Apps' FROM hb_language WHERE target='admin' AND id=1
UNION SELECT id, 'servers', 'addnewserver','Add new Connection' FROM hb_language WHERE target='admin' AND id=1;

