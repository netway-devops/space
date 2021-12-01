ALTER TABLE  `hb_ssl` ADD  `san_max_servers` INT( 5 ) NOT NULL ;
ALTER TABLE  `hb_ssl_order` ADD  `cron_update` BOOLEAN NOT NULL ,
ADD  `cert_status` VARCHAR( 20 ) NOT NULL ,
ADD  `is_renewal` BOOLEAN NOT NULL ,
ADD  `is_revoke` BOOLEAN NOT NULL ,
ADD  `dns_name` TEXT NOT NULL ,
ADD  `san_amount` INT( 5 ) NOT NULL ,
ADD  `server_amount` INT( 5 ) NOT NULL ,
ADD  `hashing_algorithm` VARCHAR( 20 ) NOT NULL ;
ALTER TABLE  `hb_accounts` CHANGE  `status`  `status` ENUM(  'Pending',  'Active',  'Suspended',  'Terminated',  'Cancelled',  'Fraud', 'Transfer',  'Transfer Request',  'Pending Transfer',  'Renewing' ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ;
