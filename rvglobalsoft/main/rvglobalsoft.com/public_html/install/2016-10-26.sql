REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'automation', 'accountduedate','account will reach its due date' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tasklist', 'AccountDueDate','Account due date' FROM hb_language  WHERE target='admin';