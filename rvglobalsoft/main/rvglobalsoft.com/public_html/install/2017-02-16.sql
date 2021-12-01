REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'cancelinvoice','Cancel Invoice' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'order_domains_cancelled','Order domains statuses marked Cancelled' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'order_invoice_cancelled','Order invoice marked Cancelled' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'order_cancelled','Order Cancelled' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'order_cancelled','Order Cancelled' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'order_addons_cancelled','Order addons statuses set to Cancelled' FROM hb_language WHERE target!='admin'
;
