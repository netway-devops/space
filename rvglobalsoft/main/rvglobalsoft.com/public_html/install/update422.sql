UPDATE `hb_configuration` SET `value` = '4.2.2' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ssl_org_info_missing','%s is required for Organization Details' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'ssl_contact_info_missing','%s is required for %s contact' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'phonecountrycode','Phone Country Code' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'unit','Unit' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'locality','Locality' FROM hb_language WHERE target='user';
##########
ALTER TABLE `hb_tickets`
ADD COLUMN `creator_id` INT(11) NOT NULL DEFAULT '0' AFTER `client_id`;
##########
REPLACE INTO `hb_configuration` VALUES ('MobileNotificationsAPriority',''),
('MobileNotificationsDepts','');
##########
INSERT INTO `hb_reports` (
`id` ,
`type` ,
`name` ,
`query` ,
`options`
)
VALUES (
NULL , 'Orders', 'Income per product in given period', 'SELECT p.name AS `Product Name`, SUM(it.`amount`) AS `Product Income`, p.id AS `Product ID` FROM hb_invoices i JOIN hb_invoice_items it ON (it.invoice_id=i.id) JOIN hb_accounts a ON (a.id=it.item_id AND it.type=''Hosting'') JOIN hb_products p ON (p.id=a.product_id) WHERE i.status=''Paid'' AND i.`datepaid`>= :date_bottom AND i.`datepaid`<= :date_top GROUP BY p.id ORDER BY `Product Income` DESC', '1'
);