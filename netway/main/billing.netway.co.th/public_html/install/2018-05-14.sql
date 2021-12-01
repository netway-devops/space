REPLACE INTO hb_configuration (`setting`, `value`) VALUES
  ('FinalInvoiceOnPayment', 'on'),
  ('CanSetMergeInvoice', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'FinalInvoiceOnPayment', 'Generate final invoice after payment' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'FinalInvoiceOnPayment_on','generate final invoice number after payment' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'FinalInvoiceOnPayment_off','issue final invoice number immediately ' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MergeInvoices','Merge Invoices' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'MergeInvoicesCron','Automatically merge invoices generated on the same day (cron run)' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'MergeInvoicesDue','Automatically merge generated invoices with the same due date' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'MergeInvoiceNone','Generate separate invoice for each service' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'MergeInvoiceOptions','Merge Options' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'MergeDomainRenewals','Issue invoice for domain renewal sooner, if customer has invoice for other services issued in renewal month' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'GenerateSeparateTax','Do not merge invoices for taxed items with invoices for non-taxed items' FROM hb_language WHERE target='admin'
UNION SELECT id, 'clientarea', 'MergeInvoices','Merge Invoices' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'MergeInvoicesCron','Automatically merge invoices generated on the same day' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'MergeInvoicesDue','Automatically merge generated invoices with the same due date' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'MergeInvoiceNone','Generate separate invoice for each service' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'Settings','Settings' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'Settings_p','Control our billing system settings related to your account' FROM hb_language WHERE target='user';