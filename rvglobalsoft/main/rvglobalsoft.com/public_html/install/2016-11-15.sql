REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'changebillingcycle_widget','Change Billing Cycle' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'newbcycle','New Billing Cycle' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'changebillingcycle_notsupported','Current billing cycle of this service does not allow for change' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'changebillingcycle_guide','This feature allows you to change billing cycle of your service. Note that you can change/upgrade to higher cycle (i.e: Monthly -> Annually). Once you\'ve selected new cycle and confirmed change renewal date and fee for this service will be adjusted accordingly.' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'changebillingcycle_invoiceinfo','Changing billing cycle is not possible, if last invoice for this service is unpaid.' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'changebillingcycle_ok','Billing cycle has been changed' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'changebillingcycle_guide2','Note: If service contains customizations/sliders, new recurring fee will be adjusted accordingly' FROM hb_language  WHERE target!='admin';
