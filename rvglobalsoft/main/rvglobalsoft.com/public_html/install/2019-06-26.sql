CREATE TABLE IF NOT EXISTS `hb_product_offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) COLLATE utf8_general_ci NOT NULL,
  `cartcode` blob NOT NULL,
  `status` tinyint(4) NOT NULL,
  `target` tinyint(4) NOT NULL,
  `cycle` ENUM('once','recurring') NOT NULL,
  `maxuse` int(11) NOT NULL,
  `conditions` blob NOT NULL,
  `offer` blob NOT NULL,
  `discount` decimal(12,2) NOT NULL default 100,
  `expire_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status_target` (`status`,`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_product_offer_usage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `offer_id_client_id` (`offer_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'product_offers', 'Free products' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'enable_offer', 'Claim offer' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'disable_offer', 'Disable' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'offer_free_domain', 'Register %s for free!' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'offer_free_tld', 'Register %s domain for free!' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'offer_free_product', 'Add %s for free!' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'offer_claim_item', 'Add to Cart' FROM hb_language WHERE target='user';
