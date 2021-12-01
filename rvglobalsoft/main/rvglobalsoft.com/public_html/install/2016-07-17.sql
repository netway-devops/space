ALTER TABLE `hb_fraud_output`
ADD COLUMN `type` ENUM('Order','Client') NOT NULL DEFAULT 'Order' AFTER `id`,
CHANGE COLUMN `order_id` `rel_id` INT(11) NOT NULL AFTER `type`,
DROP INDEX `order_id`,
ADD INDEX `type_rel_id` (`type`, `rel_id`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'urlpointresource','Invalid URL format' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'invalidurlformat','URL has to point to resource in' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'addfunds_highriskoffraud','Adding funds is not available becouse of a high risk transaction, please contact support for more details' FROM hb_language WHERE target='user';