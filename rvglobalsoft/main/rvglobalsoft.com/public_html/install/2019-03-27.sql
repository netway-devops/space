ALTER TABLE `hb_domain_periods` ADD `redemption` DECIMAL(12,2)  NULL  DEFAULT '-1.00'  AFTER `renew`;
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('DomainRedemptionPeriod', '0');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Redemption','Redemption' FROM hb_language
UNION SELECT id, 'global', 'Redemptionfee','Redemption Fee' FROM hb_language