REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'global', 'removed', 'Removed' FROM hb_language WHERE 1
  UNION SELECT id, 'global', 'upgradefee', 'Upgrade fee' FROM hb_language WHERE 1
  UNION SELECT id, 'global', 'downgradefee', 'Downgrade fee' FROM hb_language WHERE 1;