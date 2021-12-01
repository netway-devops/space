REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('ImmediateServiceOwnerChange', 'on');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'changeowner_pending','This service is pending transfer approval to: <b>%s</b> submitted on: <b>%s</b>' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'changeowner_cancelbtn','Cancel transfer process' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'transfers','Transfers' FROM hb_language
UNION SELECT id, 'transfers', 'approve','Approve' FROM hb_language  WHERE target = 'user'
UNION SELECT id, 'transfers', 'changeowner_request_ok','Request has been sent' FROM hb_language  WHERE target = 'user'
UNION SELECT id, 'transfers', 'changeowner_request_failed','Request failed' FROM hb_language  WHERE target = 'user'
UNION SELECT id, 'transfers', 'changeowner_failed','Change of owner failed' FROM hb_language  WHERE target = 'user'
UNION SELECT id, 'global', 'account_owner_changed','Account&#39;s owner id changed to: %s' FROM hb_language  WHERE target = 'user'
UNION SELECT id, 'transfers', 'reject','Reject' FROM hb_language  WHERE target = 'user'
UNION SELECT `id`, 'global', 'taxpercent','Tax %' FROM hb_language WHERE target = 'admin'
UNION SELECT `id`, 'global', 'nontax','None' FROM hb_language WHERE target = 'admin'
UNION SELECT `id`, 'global', 'taxgroup','Tax Group' FROM hb_language WHERE target = 'admin'
UNION SELECT `id`, 'taxconfig', 'taxgroups','Tax Groups' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'clientarea', 'manualrenew_pendingorder', 'This service is currently pending upgrade. Upgrade Order #%s' FROM hb_language WHERE target!='admin';;
##########
INSERT INTO `hb_email_templates` ( `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES
('Account:ChangeOwner:Request', 'General', 'Client', 1, 'Ownership change', 'Dear {$client.firstname} {$client.lastname} <br><br>{if $domain}Domain {$domain.name}{else}Account #{$service.id} - {$service.product_name} ({$service.domain}){/if} was sent to your account on {$curdate|dateformat:$date_format}<br><br><a style="color:blue;" href="{$system_url}?cmd=clientarea&action=transfers">Approve</a><br><br><a style="color:red;" href="{$system_url}?cmd=clientarea&action=transfers">Reject</a>', 'Dear {$client.firstname} {$client.lastname}, {if $domain}Domain {$domain.name}{else}Account #{$service.id} - {$service.product_name} ({$service.domain}){/if} was sent to your account on {$curdate|dateformat:$date_format}.\r\n\r\n Click on the next link to approve or reject \r\n\r\n {$system_url}?cmd=clientarea&action=transfers', 1, 2, 1, 0),
('Account:ChangeOwner:OldOwnerReject', 'General', 'Client', 1, 'Ownership change', 'Dear {$client.firstname} {$client.lastname} <br><br>{$transfer.new_client_email} rejected transfer of {if $domain}domain {$domain.name}{else}service #{$service.id} - {$service.product_name} ({$service.domain}){/if} to his account\r\n', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\n {$transfer.new_client_email} rejected transfer of {if $domain}domain {$domain.name}{else}service #{$service.id} - {$service.product_name} ({$service.domain}){/if} to his account\r\n\r\n', 1, 2, 1, 0);
##########
CREATE TABLE IF NOT EXISTS `hb_transfers` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`rel_type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
`rel_id` int(11) NOT NULL,
`old_client_id` int(11) NOT NULL,
`new_client_id` int(11) DEFAULT NULL,
`new_client_email` varchar(255) NOT NULL,
`description` text DEFAULT NULL,
`status` enum('Pending','Approved','Rejected','Immediate') NOT NULL DEFAULT 'Pending',
`date_request` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
PRIMARY KEY (`id`,`rel_type`,`rel_id`),
KEY `old_client_id` (`old_client_id`),
KEY `new_client_id` (`new_client_id`),
KEY `new_client_email` (`new_client_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_tax_group`(
 `id` INT NOT NULL AUTO_INCREMENT,
 `name` VARCHAR(128) NOT NULL,
 `description` TEXT NOT NULL,
 PRIMARY KEY (`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1;
##########
REPLACE INTO `hb_tax_group` (`id`, `name`, `description`)
VALUES (1, 'Standard', 'Default group ');
##########
ALTER TABLE `hb_tax`
ADD COLUMN `group_id` INT NOT NULL DEFAULT '1' AFTER `name`,
ADD INDEX `group_id` (`group_id`);
##########
ALTER TABLE `hb_products`
ADD COLUMN `tax_group_id` INT NOT NULL DEFAULT '1' AFTER `tax`;
##########
ALTER TABLE `hb_addons`
ADD COLUMN `tax_group_id` INT NOT NULL DEFAULT '1' AFTER `taxable`;
##########
ALTER TABLE `hb_invoice_items`
ADD COLUMN `tax_rate` DECIMAL(10,2) NULL DEFAULT NULL AFTER `taxed`,
ADD COLUMN `tax` DECIMAL(10,2) NULL DEFAULT NULL AFTER `tax_rate`;
##########
ALTER TABLE `hb_estimate_items`
ADD COLUMN `tax_rate` DECIMAL(10,2) NULL DEFAULT NULL AFTER `taxed`,
ADD COLUMN `tax` DECIMAL(10,2) NULL DEFAULT NULL AFTER `tax_rate`;
##########
ALTER TABLE `hb_invoice_items_queue`
ADD COLUMN `tax_rate` DECIMAL(10,2) NULL DEFAULT NULL AFTER `taxed`;
##########
UPDATE hb_template_content SET content=REPLACE(content, 'taxitm.name}%', 'taxitm.name}')
WHERE content LIKE '%taxitm.name}\%%';