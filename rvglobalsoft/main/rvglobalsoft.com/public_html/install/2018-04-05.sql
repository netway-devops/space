REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'accessReportsCustom','Access Reports: Custom' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'accessReportsClients','Access Reports: Clients' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'accessReportsStaff','Access Reports: Staff' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'accessReportsInvoices','Access Reports: Invoices' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'accessReportsOrders','Access Reports: Orders' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'accessReportsSupport','Access Reports: Support' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReports','Customize Reports' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'manageClientGroups','Manage Client groups' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewAccountsPasswords','View accounts passwords' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewOrdersPrices','View orders prices' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewAccountsPrices','View accounts prices' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewDomainsPrices','View domains prices' FROM hb_language WHERE target='admin';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewOrdersPrices') WHERE access LIKE '%viewOrders%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewDomainsPrices') WHERE access LIKE '%viewDomains%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewAccountsPrices') WHERE access LIKE '%viewAccounts%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',viewAccountsPasswords') WHERE access LIKE '%passwordSettings%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',manageClientGroups') WHERE access LIKE '%editConfiguration%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',accessReportsCustom,accessReportsClients,accessReportsStaff,accessReportsInvoices,accessReportsSupport,accessReportsOrders,customizeReports') WHERE access LIKE '%viewStats%';
##########
UPDATE `hb_admin_log` SET `update`=3 WHERE `logout` = '0000-00-00 00:00:00';