ALTER TABLE  `hb_estimates` ADD  `hash` VARCHAR( 32 ) NOT NULL;
##########
UPDATE `hb_estimates` SET `hash` = MD5(RAND());
##########REPLACE INTO `hb_configuration` (`setting`,`value`) VALUES ('CancelInvoicesOnExpire', 'off');