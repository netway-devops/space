CREATE TABLE IF NOT EXISTS `hb_product_domains` (
	`product_id` int(11) NOT NULL,
	`category_id` int(11) NOT NULL,
	PRIMARY KEY (`product_id`,`category_id`),
	KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO hb_product_domains
	SELECT s.product_id, p.category_id FROM hb_subproducts s
		JOIN hb_products p ON s.subproduct_id=p.id
		JOIN hb_product_types t ON t.id=p.`type`
	WHERE t.`type`='DomainsType'
	GROUP BY s.product_id, p.category_id;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'global', 'CreateSimilar', 'Create Similar' FROM hb_language WHERE target='admin';