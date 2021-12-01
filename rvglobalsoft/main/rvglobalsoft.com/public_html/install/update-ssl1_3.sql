ALTER TABLE  `hb_ssl` ADD  `ssl_productcode` VARCHAR( 50 ) NOT NULL COMMENT  'Symantec Product Code' AFTER  `ssl_name`;
ALTER TABLE  `hb_ssl_order` ADD  `symantec_status` TEXT NOT NULL COMMENT  'Status จาก Symantec' AFTER  `status_detail`;
ALTER TABLE  `hb_ssl_order` ADD  `partner_order_id` TEXT NOT NULL COMMENT  'Order Id กับ Symantec' AFTER  `order_id`;
ALTER TABLE  `hb_ssl_order_contact` CHANGE  `time_verify`  `time_verify_from` TEXT NOT NULL COMMENT  'GMT +0'
ALTER TABLE  `hb_ssl_order_contact` ADD  `time_verify_to` TEXT NOT NULL COMMENT  'GMT +0' AFTER  `time_verify_from`
ALTER TABLE  `hb_ssl_order_contact` ADD  `time_verify_from2` TEXT NOT NULL AFTER  `time_verify_to` ,
ADD  `time_verify_to2` TEXT NOT NULL AFTER  `time_verify_from2`
ALTER TABLE `hb_ssl_authority` ADD `authority_email` VARCHAR( 255 ) NOT NULL AFTER `authority_name` 
ALTER TABLE `hb_ssl_order` ADD `code_pkcs7` TEXT NOT NULL AFTER `code_ca` 

ALTER TABLE  `hb_ssl_order_contact` ADD  `address_type` INT NOT NULL

ALTER TABLE  `hb_ssl_order_contact` ADD  `organization_name` TEXT NOT NULL AFTER  `lastname` ,
ADD  `address` TEXT NOT NULL AFTER  `organization_name` ,
ADD  `city` TEXT NOT NULL AFTER  `address` ,
ADD  `state` TEXT NOT NULL AFTER  `city` ,
ADD  `country` TEXT NOT NULL AFTER  `state` ,
ADD  `postal_code` TEXT NOT NULL AFTER  `country`

ALTER TABLE  `hb_ssl_order` ADD  `custom_techaddress` INT NOT NULL DEFAULT  '0' COMMENT  '0 : techaddress = adminaddress , 1 : custom techaddress'
