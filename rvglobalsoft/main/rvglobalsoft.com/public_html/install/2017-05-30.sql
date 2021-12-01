ALTER TABLE `hb_invoices` CHANGE `status` `status` ENUM('Paid','Unpaid','Cancelled','Draft','Recurring','Refunded','Credited','Creditnote','Collections')   NOT NULL  DEFAULT 'Draft';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Collections','Collections' FROM hb_language
UNION SELECT id, 'invoices', 'inv_markedcollections','Invoice %s has been marked as Collections' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'invs_markedcollections','Selected Invoices Marked Collections' FROM hb_language WHERE target!='user';