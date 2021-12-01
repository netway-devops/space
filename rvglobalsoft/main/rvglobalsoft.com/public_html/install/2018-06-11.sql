REPLACE INTO hb_configuration (`setting`, `value`) VALUES
  ('CanSetCreditAuto', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'configuration', 'autocredit_no', 'Let customer use his credit manually' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'configuration', 'autocredit_yes', 'apply available credit to new orders & recurring invoices immediately.' FROM hb_language WHERE target='admin'
  UNION SELECT id, 'clientarea', 'autocredit_no', 'do not apply credit automatically' FROM hb_language WHERE target='user'
  UNION SELECT id, 'clientarea', 'autocredit_yes', 'apply available credit to new orders & recurring invoices immediately' FROM hb_language WHERE target='user'
  UNION SELECT id, 'global', 'timezone', 'Time zone' FROM hb_language WHERE target='admin';