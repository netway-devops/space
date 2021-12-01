CREATE TABLE IF NOT EXISTS `hb_aff_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_type` varchar(50) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rate` decimal(12,2) NOT NULL,
  `type` enum('Fixed','Percent') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_type_ref_id` (`rel_type`,`rel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_aff_orders`
  ADD COLUMN `client_id` INT(11) NOT NULL AFTER `aff_id`,
  ADD COLUMN `type` ENUM('order','recurring', 'manual','sub-affiliate') NOT NULL DEFAULT 'order' AFTER `invoice_id`,
  ADD INDEX `client_id` (`client_id`);
##########
UPDATE `hb_aff_orders` a
  JOIN `hb_invoices` i ON i.id=a.invoice_id
SET a.`client_id` = i.client_id,
    `type`=IF(a.order_id, 'recurring', 'manual')
WHERE a.invoice_id!=0 AND a.client_id=0;
##########
UPDATE `hb_aff_orders` a
  JOIN `hb_orders` o ON o.id=a.order_id
SET a.`client_id` = o.client_id
WHERE a.client_id=0;
##########
ALTER TABLE `hb_aff_orders_items`
  CHANGE COLUMN `type` `type` VARCHAR(50) NOT NULL AFTER `aff_order_id`,
  ADD COLUMN `amount` DECIMAL(12,2) NULL AFTER `plan_id`,
  ADD COLUMN `rateType` ENUM('Fixed','Percent') NULL AFTER `amount`,
  ADD COLUMN `rate` DECIMAL(12,2) NULL AFTER `rateType`;
