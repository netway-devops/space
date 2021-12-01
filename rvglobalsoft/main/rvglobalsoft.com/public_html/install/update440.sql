UPDATE `hb_configuration` SET `value` = '4.4.0' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'unknown','unknown' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'body','Body' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'wasthisarticleusefulyou','Was This article useful for You?' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'articleviewed','Article was viewed' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'times','times' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'wasuseful','was useful' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'category','Category' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'articles','Articles' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'banreason','Ban Reason' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'banexpires','Ban Expires' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'creditcardfile','Credit card on file' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'examplerules','Example rules' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'options','Options' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'download','Download' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'more','More' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'mainmenu','main menu' FROM hb_language WHERE target='user';