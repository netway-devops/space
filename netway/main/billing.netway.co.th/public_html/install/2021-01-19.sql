REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'credit_failed_renewals','Credit failed renewals' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'ContinueInvoices_descr', 'Create recurring invoices for all accounts even if previous related invoice is not Paid' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'ContinueInvoices_descr1', 'Create recurring invoices only for accounts with previous invoice Paid' FROM hb_language WHERE target = 'admin';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('CreditFailedRenewals', 'off');