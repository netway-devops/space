ALTER TABLE `hb_admin_widgets` ADD `autorefresh` INT(11)  UNSIGNED  NOT NULL  DEFAULT '0'  AFTER `sort_order`;
##########
ALTER TABLE `hb_categories`
CHANGE COLUMN `template` `template` TEXT NOT NULL AFTER `sort_order`;
##########
UPDATE hb_categories c
JOIN hb_product_types t ON t.id=c.ptype
SET c.template = CASE WHEN c.template = 'custom' THEN 'includes/types/ssltype/cart.desc' ELSE 'includes/types/ssltype/cart2.desc' END
WHERE c.template IN ('custom', 'custom1')
AND (t.`type` LIKE "%ssl%" OR  t.`type` LIKE "%cert%");
##########
UPDATE hb_categories c
JOIN hb_product_types t ON t.id=c.ptype
SET c.template ='includes/types/server/cart.desc'
WHERE c.template = 'custom'
AND t.`type` IN ('Server', 'Colocation');
##########
REPLACE INTO `hb_configuration` (`setting`, `value`)
 VALUES
('CancelInvoicesOnDays', 'off'),
('CancelInvoicesOnDaysValue', '0');