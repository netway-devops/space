REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'signin','Sign in' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'youalsointerestedin','You may also be interested in' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'ticketstatus','Ticket status' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'solved','Solved' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'viewall','View All' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'unanswered','Unanswered' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'noservicesyet','No services yet' FROM hb_language WHERE target='user';
