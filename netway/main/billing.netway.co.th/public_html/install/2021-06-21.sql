REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'DefaultPaymentSubject', 'Default payment subject' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'DocumentFilename', 'Document Filename' FROM hb_language WHERE target!='user';
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('DefaultPaymentSubject', '{$business_name} - Invoice #{$invoice_id}'),
('DocumentFilename', '');