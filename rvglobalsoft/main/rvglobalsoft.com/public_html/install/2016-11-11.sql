REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'manualrenew','Manual Service Renew' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'manualrenew_notsupported','Billing cycle of your service does not allow for manual renew' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'manualrenew_unpaidinvoice','You currently have an outstanding invoice for this service: ' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'manualrenew_guide','If you\'d like to issue renewal invoice for this service sooner, click on button below. Please note that it will change next invoice date of this service to match Today\'s renewal' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'manualrenew_confirm','Are you sure?' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'manualrenew_now','Renew now' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'clientarea', 'manualrenew_ok','New invoice has been issued' FROM hb_language  WHERE target!='admin';