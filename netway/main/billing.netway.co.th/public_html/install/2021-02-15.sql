REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, "cart", "en_csrgenerate","I don't have my CSR ready. I want to generate one now." FROM hb_language WHERE target='user'
UNION SELECT id, "cart", "countryName","Country" FROM hb_language WHERE target='user'
UNION SELECT id, "cart", "stateOrProvinceName","State" FROM hb_language WHERE target='user'
UNION SELECT id, "cart", "localityName","Locality" FROM hb_language WHERE target='user'
UNION SELECT id, "cart", "organizationName","Organization Name" FROM hb_language WHERE target='user'
UNION SELECT id, "cart", "organizationalUnitName","Organization Unit" FROM hb_language WHERE target='user'
UNION SELECT id, "cart", "commonName","Common Name" FROM hb_language WHERE target='user'
UNION SELECT id, "clientarea", "ssl_csr","CSR" FROM hb_language WHERE target='user'
UNION SELECT id, "clientarea", "ssl_show_csr","Show CSR" FROM hb_language WHERE target='user'
UNION SELECT id, "clientarea", "ssl_private_key","Private Key" FROM hb_language WHERE target='user'
UNION SELECT id, "clientarea", "ssl_show_private_key","Show Private Key" FROM hb_language WHERE target='user'
UNION SELECT id, "configuration", "BCCInvoiceEmailsPaid","Send only paid invoices" FROM hb_language WHERE target='admin';
##########
ALTER TABLE hb_enom_certs ADD COLUMN `private_key` TEXT;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('BCCInvoiceEmailsPaid', 'off');
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`)
VALUES ('Invoice:Collections', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Moved to Collections', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br />\r\n<p>Your invoice #{$invoice.id} has been moved to Collections.</p>\r\n<br />\r\n<p><b>All invoices</b>: <a href="{$clientarea_url}">{$clientarea_url}</a></p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYour invoice #{$invoice.id} has been moved to Collections.\r\nAll invoices: {$clientarea_url}', 1, 2, 1, 0, 0);
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`) VALUES
('Invoice:Collections', 'Invoice', 'Admin', 1, 'Invoice #{$invoice.id}: Moved to Collections', '<h1>Invoice #{$invoice.id} has been moved to Collections.</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Invoice ID:</b> {$invoice.id}<br>\r\n    <b>Invoice URL:</b> {$invoice_url}<br>\r\n</p>\r\n', 'Invoice #{$invoice.id} has been moved to Collections.\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Invoice ID: {$invoice.id}\r\n# Invoice URL: {$invoice_url}\r\n', 1, 2, 1, 0);