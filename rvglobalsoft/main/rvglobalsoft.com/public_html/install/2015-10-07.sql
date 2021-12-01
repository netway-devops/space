REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'func_scheduled_for_execute','Function has been scheduled for execution' FROM hb_language;