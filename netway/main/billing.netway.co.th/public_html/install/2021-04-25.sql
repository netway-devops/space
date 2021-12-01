REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'signagreement', 'Sign Agreement' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'signagreement-description', 'Allow client to review and sign agreement before order' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'save_to_set_contract', 'Save the field to set the <b>Contract</b>' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'contract_template', 'Contract template' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'contract_template_not_found', 'Contract template not found. Add a contract template in the settings.' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'new_contract_template', 'Create a new contract template' FROM hb_language WHERE target!='user'
UNION SELECT id, 'cart', 'agreement', 'agreement' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'cart', 'agreement_not_accepted', 'The agreement was not accepted' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'cart', 'use_existing_customer', 'Use existing customer' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'cart', 'use_new_customer', 'Use new customer' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'contracts', 'change_customer', 'Change customer' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'contracts', 'Agreement', 'Agreement' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'contracts', 'agreement_fill_required_data', 'To accept the agreement, fill in the required data' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'contracts', 'agreement_fill_changed_details', 'If you have changed your details, fill in all the fields to accept the agreement' FROM hb_language WHERE target!='admin';
##########
CREATE TABLE IF NOT EXISTS `hb_sign_agreement` (
  `id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id`  int(11) UNSIGNED NOT NULL,
  `cart` varchar(127) NOT NULL DEFAULT '',
  `hash` varchar(32) NOT NULL DEFAULT '',
  `type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `type_id`  int(11) UNSIGNED NOT NULL DEFAULT '0',
  `agree` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metadata` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `client_id` (`client_id`),
  KEY `type` (`type`,`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;