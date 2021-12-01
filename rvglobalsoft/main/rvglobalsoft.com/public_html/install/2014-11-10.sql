REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'EnableClientCaptchaLogin','Captcha verify client login' FROM hb_language WHERE target='admin';
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('EnableClientCaptchaLogin', 'off');