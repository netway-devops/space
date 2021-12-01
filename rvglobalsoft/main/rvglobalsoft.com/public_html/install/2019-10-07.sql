REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'invoices', 'CreateBulkPayment','Create bulk payment' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'invoices', 'CreateBulkPaymentError','There was a problem with generating bulk payment invoice' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'tickets', 'Scheduled','Scheduled' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'recentlysentemails','Recently sent emails' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'orders', 'override_recipients','Override recipients' FROM hb_language WHERE target = 'admin';