REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'MergeInvoicesCron','Automatically merge invoices generated on the same day (cron run) regardless of due date' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'MergeInvoicesDue', 'Automatically merge generated invoices on the same day (cron run) with the same due date' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'ContinueInvoices_descr', 'Create invoices even if related account is Suspended' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'ContinueInvoices_descr1', 'Create new invoices only for Active accounts' FROM hb_language WHERE target = 'admin';