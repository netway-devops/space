REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'FinalNumberForCreditedInvoices','Create final number for credit-paid invoices' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'RedirectAfterFailedPayment','Redirect after failed payment' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'RedirectAfterFailedPayment_desc','After client payment failed using offsite processing gateway, redirect him to this URL' FROM hb_language WHERE target='admin'
UNION SELECT id, 'clientarea', 'payment_was_not_completed','Your Payment was not completed' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'payment_was_not_completed_desc',"We're sorry but your payment was not completed, please try to submit payment again." FROM hb_language WHERE target='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('FinalNumberForCreditedInvoices', 'on');