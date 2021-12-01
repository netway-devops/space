REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'has_pending_upgrade','Account is pending upgrade from another order' FROM hb_language;