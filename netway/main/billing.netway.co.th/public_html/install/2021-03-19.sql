CREATE TABLE IF NOT EXISTS `hb_configuration_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin_login` VARCHAR(32) NOT NULL,
  `setting` VARCHAR(128) NOT NULL,
  `from` text NOT NULL,
  `to` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `setting` (`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'use_stored_billing', 'Use stored details' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'override_stored_billing', 'Override details for this payment' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'credit_card_payment', 'Credit/Debit Card Payment' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'credit_card_payment_descr', 'Verify your credit/debit card details and submit payment' FROM hb_language WHERE target='user';