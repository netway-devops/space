REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'search_noResultsHeader','No Results' FROM hb_language WHERE target = 'user';