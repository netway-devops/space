ALTER TABLE `hb_client_billing` ADD `billing_contact_id` INT(11)  UNSIGNED  NULL  DEFAULT '0'  AFTER `disableemails`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, "global", "billing_contact","Billing Contact" FROM hb_language WHERE target='user'
UNION SELECT id, "clientarea", "billing_contact_descr","Select which contact details should be used for billing/payments with us" FROM hb_language WHERE target='user'
UNION SELECT id, "clientarea", "billing_contact_none","None, use main profile details" FROM hb_language WHERE target='user'
UNION SELECT id, "clientarea", "billing_contact_changed","Billing contact changed" FROM hb_language WHERE target='user'
;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, "clients", "billing_newinvoices","Receive new invoices" FROM hb_language WHERE target='admin'
UNION SELECT id, "profiles", "billing_newinvoices","Receive new invoices" FROM hb_language WHERE target='user'
UNION SELECT id, "clients", "billing_invoicereminders","Receive invoice reminders" FROM hb_language WHERE target='admin'
UNION SELECT id, "profiles", "billing_invoicereminders","Receive invoice reminders" FROM hb_language WHERE target='user'
UNION SELECT id, "clients", "billing_quotasestimates","Receive quotes/estimates" FROM hb_language WHERE target='admin'
UNION SELECT id, "profiles", "billing_quotasestimates","Receive quotes/estimates" FROM hb_language WHERE target='user';