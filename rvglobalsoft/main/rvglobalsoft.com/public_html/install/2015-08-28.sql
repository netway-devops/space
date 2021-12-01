REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'welcometo','Welcome to' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'pleaseloginyouraccount','Please login to your account' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'forgotpassword','Forgot password?' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'ticketshort','tickets' FROM hb_language WHERE target='user';