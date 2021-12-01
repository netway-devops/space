UPDATE `hb_configuration` SET `value` = '4.9.4' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'addInvoices','Add Invoices' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editInvoices', 'Edit Invoices' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'refundInvoices', 'Refund Invoices' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'addTransactions', 'Add Transactions' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editTransactions', 'Edit Transactions'FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editClients', 'Edit Clients' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editClientsCredit', 'Edit Clients Credit' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'addOrders', 'Add Orders' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editOrders', 'Edit Orders' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editAccounts', 'Edit Accounts' FROM hb_language WHERE target!='user'
UNION SELECT id, 'editadmins', 'editNegativeInvoices', 'Create Negative Invoices' FROM hb_language WHERE target!='user';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',editInvoices,refundInvoices,addInvoices') WHERE access LIKE '%viewInvoices%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',addTransactions,editTransactions') WHERE access LIKE '%viewTransactions%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',addOrders,editOrders') WHERE access LIKE '%viewOrders%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',editAccounts') WHERE access LIKE '%viewAccounts%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',editClients,editClientsCredit') WHERE access LIKE '%listClients%';
