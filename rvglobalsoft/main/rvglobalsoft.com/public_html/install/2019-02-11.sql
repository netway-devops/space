REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'sendmessage', 'compose_message','Compose new message' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'use_template','Use email template' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'select_template','Select email template' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'save_as_email_template','Save as email template' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'use_variables','Use variables' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'add_notify','Add portal notification' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'use_mobile_template','Use mobile template' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'select_mobile_template','Select mobile template' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'save_as_mobile_template','Save as mobile template' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'cantsendmessageto', 'Can not send message to' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'messagesentto','Send message to' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'sendmessage', 'no_clients_found','The message could not be sent because no clients were found' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'send_notification','Send Mobile Notification' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'search_clients','Search clients' FROM hb_language WHERE target = 'admin';
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`) VALUES 
(NULL, 'Invoices', 'MOSS Summary Report', 'SELECT cd.country as `Country code`,i.taxrate as `VAT rate %`, COUNT(i.id) as `Invoices`, sql_currency(SUM(sql_normalize_currency(i.subtotal,i.currency_id,:currency,0)),:currency,0) as `Net amount`, sql_currency(SUM(sql_normalize_currency(i.tax,i.currency_id,:currency,0)),:currency,0) as `VAT collected` FROM hb_invoices i LEFT JOIN hb_client_details cd ON i.client_id = cd.id WHERE i.taxrate > 0 AND i.tax > 0 AND i.date > :date_bottom AND i.date < :date_top  AND cd.country IN ("BE", "BG", "CZ", "DK", "DE", "EE", "IE", "EL", "ES", "FR", "HR", "IT", "CY", "LV", "LT", "LU", "HU", "MT", "NL", "AT", "PL", "PT", "RO", "SI", "SK", "FI", "SE", "UK")  GROUP BY cd.country, i.taxrate  ORDER BY cd.country ASC, i.taxrate ASC', 1, 'sql', '', '');
##########
ALTER TABLE `hb_client_fields` CHANGE `field_type` `field_type` enum('Select','Check','Input','Password','File') DEFAULT NULL;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clients', 'fileupload','File upload' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'global', 'File','File' FROM hb_language;
##########
UPDATE hb_language_locales s SET s.section = 'global' WHERE keyword = 'allowedext';
##########
UPDATE hb_language_locales s SET s.section = 'global' WHERE keyword = 'accept_file_types';
##########
UPDATE hb_language_locales s SET s.section = 'global' WHERE keyword = 'min_file_size';
##########
UPDATE hb_language_locales s SET s.section = 'global' WHERE keyword = 'max_file_size';