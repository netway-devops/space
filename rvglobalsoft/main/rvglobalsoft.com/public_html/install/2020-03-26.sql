UPDATE hb_language_locales SET `section`='global' WHERE keyword = 'UpgradeDowngrade';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'UpgradeDowngrade','Upgrade / Downgrade' FROM hb_language WHERE target = 'admin'