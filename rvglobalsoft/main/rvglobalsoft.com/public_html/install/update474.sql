UPDATE `hb_configuration` SET `value` = '4.7.4' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'warning','Warning' FROM hb_language WHERE target='user'
UNION SELECT id, 'chat', 'popupsenable','If you do not have pop-ups enabled in your browser, you may be uanable to continue.' FROM hb_language WHERE target='user'
UNION SELECT id, 'chat', 'tryenablingpopups','Try enabling pop-ups in yor browser and refreash this page.' FROM hb_language WHERE target='user';