REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'invoices', 'sendoverduenotice', 'Send overdue notice' FROM hb_language WHERE target='admin';