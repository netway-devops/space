REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'RecordsPerPage','Records per page' FROM hb_language;