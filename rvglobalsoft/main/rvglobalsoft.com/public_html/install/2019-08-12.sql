REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'configuration', 'InvoiceDeliveryMethod','Invoice Delivery Method' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'InvoiceDeliveryMethod_descr1','Email + PDF' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'InvoiceDeliveryMethod_descr2','Email + Plain text' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'InvoiceDeliveryMethod_descr3','Paper' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'InvoiceDeliveryMethod_descr4','Paper + PDF' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'AddToPrintQueue','Add to print queue' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'ProForma','Pro-forma' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'FinalInvoice','Final invoice' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'configuration', 'AllowControlInvoiceDelivery','Allow client to control Invoice Delivery method' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'clientarea', 'InvoiceDeliveryMethod','Invoice Delivery Method' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'InvoiceDeliveryMethod_descr1','Email' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'InvoiceDeliveryMethod_descr2','Paper' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'InvoiceDeliveryMethod_descr3','Email + Paper' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'AddToPrintQueue','Add to print queue' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'ProForma','Pro-forma' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'clientarea', 'FinalInvoice','Final invoice' FROM hb_language WHERE target='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('AddToPrintQueue', 'final'),
('AllowControlInvoiceDelivery', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'invoices', 'PrintQueue','Print Queue' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'AddPrintQueue','Add to print queue' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'RemovePrintQueue','Remove from print queue' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'MarkAsPrinted','Mark as printed' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'global', 'AddPrintQueueInfo','The invoice %s has been added to the print queue' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'global', 'RemovePrintQueueInfo','The invoice %s has been removed from the print queue' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'global', 'MarkAsPrintedInfo','The invoice %s has been marked as printed' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'Actions','Actions' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'Print','Print' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'Notify','Notify' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'MarkAsPrintedSubmenu','Mark as Printed' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'MarkAsNotPrintedSubmenu','Mark as Not-Printed' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'Printed','Printed' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'invoices', 'NotPrinted','Not-Printed' FROM hb_language WHERE target='admin';
