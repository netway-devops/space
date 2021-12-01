REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'bandwidthlimit','Bandwidth limit' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'overage','Overage' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'used','Used' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'overagerate','Overage rate' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'currentoveragecharge','Current overage charge' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'projectedusage','Projected usage' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'projectedoverage','Projected overage' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'projectedoveragecharge','Projected overage charge' FROM hb_language WHERE target='user';
