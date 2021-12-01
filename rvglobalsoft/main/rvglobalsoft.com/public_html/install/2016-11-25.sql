INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES
	(NULL, 'Clients:Password Forgotten', 'General', 'Admin', 1, 'Client #{$client.id} requested password reminder', '<h3>Client #{$client.id} {$client.firstname} {$client.lastname} Just requested his password reminder</h3>\r\n\r\n IP: {$ip_addr} \r\n Host: {$host_addr}',
	'Client #{$client.id} {$client.firstname} {$client.lastname} Client #{$client.id} {$client.firstname} {$client.lastname} Just requested his password reminder \r\n\r\n IP: {$ip_addr} \r\n Host: {$host_addr}', 1, 2, 1, 0);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'checkdomain', 'findrightdomainname','Find the Right Domain Name.' FROM hb_language WHERE target='user'
UNION SELECT id, 'checkdomain', 'transferyourdomain','Transfer Your Domain.' FROM hb_language WHERE target='user'
UNION SELECT id, 'checkdomain', 'enteryourdesireddomainname','Enter your desired domain name' FROM hb_language WHERE target='user'
UNION SELECT id, 'checkdomain', 'enterdomaintotransfer','Enter domain name that you want to transfer' FROM hb_language WHERE target='user'
UNION SELECT id, 'checkdomain', 'removefromcart','Remove from cart' FROM hb_language WHERE target='user'
UNION SELECT id, 'checkdomain', 'resultsfor','Results for' FROM hb_language WHERE target='user'
UNION SELECT id, 'checkdomain', 'orderselecteddomains','Order selected domains' FROM hb_language WHERE target='user'
UNION SELECT id, 'checkdomain', 'domainprices','Domain Prices' FROM hb_language WHERE target='user';
