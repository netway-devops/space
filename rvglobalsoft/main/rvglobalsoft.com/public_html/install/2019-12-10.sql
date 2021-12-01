REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'autoapplycredit','Auto-apply credit' FROM hb_language