REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'invoices', 'clientcreditavailable','Client credit' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'clientcreditaddtoinvoice','Add to invoice' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'clientcreditapplyfromcredit','Apply from credit' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'clientcreditapplyinfo','Credit has been applied to invoice' FROM hb_language WHERE target!='user';