REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'importdnsrecords','Import Records' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'importzonecontents','Import zone contents' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'rdnsnotavailable','rDNS management is not available for your IP addresses at the moment.' FROM hb_language WHERE target='user';
