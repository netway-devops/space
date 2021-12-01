REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'clientarea', 'InvoiceDeliveryMethod_descr2','Email + Plain text' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'InvoiceDeliveryMethod_descr3','Paper' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'InvoiceDeliveryMethod_descr4','Email + Paper' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'delete_attachment_q','Are you sure want to delete this attachment?' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'tickets', 'delete_attachment_dont_permission','You do not have permission to delete this attachment' FROM hb_language WHERE target='admin';