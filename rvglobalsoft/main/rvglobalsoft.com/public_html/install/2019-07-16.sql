REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'global', 'forgetthanks3','If your email exists in our database, you will receive a reset link' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'global', 'wait_5_minutes_between_resets','Please wait 5 minutes between password reset attempts' FROM hb_language WHERE target='user'