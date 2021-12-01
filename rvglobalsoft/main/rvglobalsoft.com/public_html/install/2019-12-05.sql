REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'search_source','Cannot search. No source used, and Search API module was not included' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'search_noResults','Your search returned no results' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'search_noEndpoint','No search endpoint was specified' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'search_serverError','There was an issue querying the server.' FROM hb_language WHERE target = 'user';