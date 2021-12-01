REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'invalid_invoice_id','Invalid invoice ID' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'invalid_order_id','Invalid order ID' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'order_invoicechanged','The invoice has been set for the order' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'order_invoicechanged_err','An error occurred while setting the invoice for the order' FROM hb_language WHERE target!='user';