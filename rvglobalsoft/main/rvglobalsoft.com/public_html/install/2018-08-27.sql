REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tickets', 'dont_have_permission', 'You do not have permission to view this ticket' FROM hb_language WHERE target!='user'
UNION SELECT id, 'services', 'copy_settings_warning', 'Please be aware that copying will remove related original settings from your target product' FROM hb_language WHERE target!='user';