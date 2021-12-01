UPDATE `hb_configuration` SET `value` = '4.5.2' WHERE `setting`= 'Version';
##########
ALTER TABLE  `hb_modules_configuration` ADD  `remote` VARCHAR( 63 ) NULL;
##########
UPDATE `hb_modules_configuration` SET `remote`='dedimgrv3' WHERE `filename`='class.dedimgr.php';
##########
UPDATE `hb_modules_configuration` SET `remote`='endofshift' WHERE `filename`='class.endofshift.php';
##########
UPDATE `hb_modules_configuration` SET `remote`='fraudprotect_extended' WHERE `filename`='class.hostbill_froudprotection_extended.php';
##########
UPDATE `hb_modules_configuration` SET `remote`='ipam' WHERE `filename`='class.ipam.php';
##########
UPDATE `hb_modules_configuration` SET `remote`='manage2' WHERE `filename`='class.cpanelmanage.php';
##########
UPDATE `hb_modules_configuration` SET `remote`='onappbalancer' WHERE `filename`='class.onappbalancer.php';
##########
UPDATE `hb_modules_configuration` SET `remote`='smsverification' WHERE `filename`='class.smsverification.php';
##########
UPDATE `hb_modules_configuration` SET `remote`='supportfields' WHERE `filename`='class.supportfields.php';
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('PluginUpdates', '');
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('RenewInvoice', '1');
##########
REPLACE INTO hb_automation_settings (`item_id`, `type`, `setting`, `value`) SELECT `product_id`, 'Domain', 'RenewInvoice', 0 FROM hb_domain_prices WHERE `not_renew`=1;
##########
ALTER TABLE `hb_ticket_replies`
CHANGE COLUMN `type` `type` ENUM('Client','Admin','Email','Unregistered') NULL DEFAULT 'Client' AFTER `status`;
##########
ALTER TABLE `hb_tickets`
CHANGE COLUMN `type` `type` ENUM('Client','Admin','Email','Unregistered') NULL DEFAULT 'Client' AFTER `client_read`;