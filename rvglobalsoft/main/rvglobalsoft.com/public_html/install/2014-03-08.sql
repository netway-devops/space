REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'landurldescr','Provide on our domain URL your referals should be redirected to after visiting your affiliate URL' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'landingpage','Landing page' FROM hb_language WHERE target='user';