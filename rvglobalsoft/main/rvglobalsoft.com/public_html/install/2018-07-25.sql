REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'field_uniquevalue_error','The value of the "%s" field is not unique' FROM hb_language;