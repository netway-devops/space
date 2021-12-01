REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configfields', 'san','Subject Alternative Name' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configfields', 'san-description','Allows clients to add additional domain names with additional pricing' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ssl', 'sameasadmin','Use same details as for admin contact' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_email','Email Validation' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_dns','DNS-based validation' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_http','HTTP-based validation' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_https','HTTPS-based validation' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_descr_email','You will receive an email with an unique link to approve the certificate and validate your domain ownership.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_descr_dns','Validation by DNS implies that you have access to the DNS zone file of your domain, and can add a record to it. If you select this method, the record to be inserted into the zone will be available after order is completed.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_descr_http','HTTP validation method requires that you have access to the web server that hosts the website that the domain will point to. You will be provided with a file that has to be placed in the root directory of the website.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_verify_failed','We were unable to verify the domain %s. Please ensure: 1. The domain is publicly accessible. 2. The verification details are located in an approved location. 3. The DCV data exactly matches the one we have provided.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'cn_invalid_for_wildcard','Common Name has to start with asterix (*) for wildcard certificates' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'csr_invalid_for_product','Provided CSR can\'t be used with this product.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'csr_invalid','The CSR cannot be decoded or is invalid' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_email_invalid','Selected DCV Email is not a valid option' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_invalid','Selected DCV Method is not available' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_email_sent','DCV Email was re-sent to approver' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_verify_success','Domain control validation was successful' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'dcv_verify_reset','Request for domain validation was sent to vendor' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'sslorder_processed','Your order was sent to SSL vendor and is being processed' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'csr_updated','CSR was updated' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'san_ip_is_private','Invalid SAN %s, IPs is in private range are not allowed.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'san_ips_not_allowed','Invalid SAN %s, IPs are not allowed.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'san_invalid_domain','%s is not a valid domain name' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'san_invalid_subdomain','%s is not a valid sub-domain for %s' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'cart', 'san','Additional Domain Names' FROM hb_language WHERE target!='admin';
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`) 
VALUES ('sslSync', 'Synchronize SSL certificates status and expiry date', '', 1, 0, '', '', 'Run', '1200', 1);
##########
CREATE TABLE IF NOT EXISTS `hb_enom_certs` (
    `account_id` INT(11) NOT NULL PRIMARY KEY,
    `cert_id` VARCHAR(128) NOT NULL,
    `cert_oid` VARCHAR(128) NOT NULL,
    `cert_status` VARCHAR(128) NOT NULL DEFAULT '',
    `cert_type` VARCHAR(32) NOT NULL DEFAULT 'Rapid',
    `cert_expires` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    `csr` TEXT NOT NULL DEFAULT '',
    `contacts` TEXT NOT NULL DEFAULT '',
    `organization` TEXT NOT NULL DEFAULT '',
    `cert_email` TEXT NOT NULL DEFAULT '',
    `software` INT(3) NOT NULL DEFAULT 1
) DEFAULT CHARACTER SET utf8 ENGINE=InnoDB;