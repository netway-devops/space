UPDATE `hb_configuration` SET `value` = '4.3.6' WHERE `setting`= 'Version';
##########
UPDATE `hb_language_locales` SET `value` = 'Add PDF Invoice to email notification' WHERE `section` = 'configuration' AND `keyword` = 'AttachPDFInvoicePaid_descr';
##########
UPDATE `hb_language_locales` SET `value` = 'Add Pro-Forma PDF Invoice to email notification' WHERE `section` = 'configuration' AND `keyword` = 'AttachPDFInvoice_descr3';