ALTER TABLE `hb_accounts` CHANGE `label` `label` VARCHAR(40)   NOT NULL  DEFAULT '',
CHANGE `synch_date` `synch_date` DATETIME  NOT NULL  DEFAULT '0000-00-00 00:00:00',
CHANGE `synch_error` `synch_error` TINYINT(1)  NOT NULL  DEFAULT '0',
CHANGE `user_error` `user_error` TINYINT(1)  NOT NULL  DEFAULT '0',
CHANGE `domain_error` `domain_error` TINYINT(1)  NOT NULL  DEFAULT '0',
CHANGE `manual` `manual` TINYINT(1)  NOT NULL  DEFAULT '0';
##########
ALTER TABLE `hb_products` CHANGE `visible` `visible` TINYINT(1)  NOT NULL  DEFAULT '1',
CHANGE `autosetup` `autosetup` TINYINT(1)  NOT NULL  DEFAULT '0',
CHANGE `tax` `tax` TINYINT(1)  NOT NULL  DEFAULT '0',
CHANGE `domain_options` `domain_options` TINYINT(1)  NOT NULL  DEFAULT '0';
##########
ALTER TABLE `hb_order_drafts` CHANGE `options` `options` INT(4)  NOT NULL  DEFAULT '7';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'orders', 'recipients','Recipients' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'orders', 'override_recipients','Override recipients' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'ServiceStatusesLimitCalculation','Service statuses for limit calculation' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'ServiceStatusesLimitCalculationDesc','When product ordered by client have limitation per client set you can select which service statuses goes into usage calculation. Leave empty for all statuses' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'clientarea', 'epp_sent_to_registrar','An email containing this domain\'s AuthInfo/EPP Code was sent to registrar email %s' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'epp_sent_to_registrar_error','There was a problem sending the email with the AuthInfo / EPP Code' FROM hb_language WHERE target = 'user';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`,`altmessage`) VALUES
('Domain:EppCode', 'Domain', 'Client', 1, 'AuthInfo / EPP Code request for domain: {$domain.name}', 'Hello {$client.firstname} {$client.lastname},\r\n\r\nOn {$now|dateformat:$date_format} from computer with IP address: {$ip_address} epp code was requested using our system for one of your domains: {$domain.name}. You can find it below:\r\n\r\nDomain: {$domain.name}\r\nEPP code: {$domain.epp_code}', 1, 1, 1, 0,'');