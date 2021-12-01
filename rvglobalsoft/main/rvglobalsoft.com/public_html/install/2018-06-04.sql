REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'global', 'MailUseTransactional', 'Transactional email' FROM hb_language WHERE target='admin';