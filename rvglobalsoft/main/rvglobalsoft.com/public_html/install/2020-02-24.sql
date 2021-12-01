ALTER TABLE `hb_transactions` ADD `type` ENUM('invoice','bulk','credit','refund','chargeback')   NULL  DEFAULT 'credit'  AFTER `refund_of`;
##########
UPDATE  `hb_transactions` SET `type` = 'credit' WHERE invoice_id = 0;
##########
UPDATE  `hb_transactions` SET `type` = 'invoice' WHERE invoice_id <> 0;
##########
UPDATE  `hb_transactions` SET `type` = 'refund' WHERE refund_of > 0;
##########
ALTER TABLE `hb_transactions` ADD `status` ENUM('Success','Processing','Refunded','Chargeback')  NULL  DEFAULT 'Success' AFTER `invoice_id`;
##########
ALTER TABLE `hb_transactions` ADD `parent_id` INT(11) NULL DEFAULT 0 AFTER `id`;
##########
ALTER TABLE `hb_transactions` ADD INDEX (`parent_id`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Processing','Processing' FROM hb_language
UNION SELECT id, 'global', 'Processing','Processing' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountCreate', 'Create Account'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountTerminate', 'Terminate Account'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountSuspend', 'Suspend Account'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountUnsuspend', 'Unsuspend Account'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountRenewal', 'Renew Account'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountSynchronize', 'Synchronize Account'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountChangePackage', 'Change Account Package'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountChangePassword', 'Change Account Password'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'accountOrderUpgrade', 'Issue Account Upgrade Order'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainRegister', 'Register Domain'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainTransfer', 'Transfer Domain'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainRenew', 'Renew Domain'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainDelete', 'Delete Domain at registry'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainSynchronize', 'Synchronize Domain'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainOrderRenew', 'Issue Domain Renewal Order'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainDNSmanagement', 'Manage Domain Registry DNS records'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainContactInfo', 'Manage Domain Contacts'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainRegisterNameServers', 'Register Domain Nameservers'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainEppCode', 'Get Domain EPP Code'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainDomainForwarding', 'Manage Domain Forwarding'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'domainEmailForwarding', 'Manage Domain Email Forwarding'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'Provisioning', 'Provisioning'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'out_of_stock_badge', 'Out</br>of stock' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'out_of_stock_btn', 'Out of stock!' FROM hb_language WHERE target='user'
UNION SELECT id, 'invoices', 'em', 'Monthly - on last day of month' FROM hb_language;
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',accountCreate,accountSuspend,accountUnsuspend,accountRenewal,accountSynchronize,accountChangePackage,accountChangePassword,accountOrderUpgrade') WHERE access LIKE '%editAccounts%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',accountCreate,accountSuspend,accountUnsuspend,accountRenewal,accountSynchronize,accountChangePackage,accountChangePassword,accountOrderUpgrade') WHERE access LIKE '%editAccounts%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',accountTerminate') WHERE access LIKE '%deleteServices%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',accountTerminate') WHERE access LIKE '%deleteServices%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',domainRegister,domainTransfer,domainRenew,domainSynchronize,domainOrderRenew,domainDNSmanagement,domainContactInfo,domainRegisterNameServers,domainEppCode,domainDomainForwarding,domainEmailForwarding') WHERE access LIKE '%editDomains%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',domainRegister,domainTransfer,domainRenew,domainSynchronize,domainOrderRenew,domainDNSmanagement,domainContactInfo,domainRegisterNameServers,domainEppCode,domainDomainForwarding,domainEmailForwarding') WHERE access LIKE '%editDomains%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',domainDelete') WHERE access LIKE '%deleteDomains%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',domainDelete') WHERE access LIKE '%deleteDomains%';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('OutOfStockProducts', 'hide');
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('SyncTransferredOut', '0');
##########
ALTER TABLE hb_domains ADD COLUMN `failed_syncs` INT NOT NULL DEFAULT 0;
##########
ALTER TABLE `hb_recurring_invoices` CHANGE COLUMN `frequency` `frequency` ENUM('1w','2w','4w','1m','em','2m','3m','6m','1y','2y') NOT NULL DEFAULT '1w' AFTER `id`;
##########
