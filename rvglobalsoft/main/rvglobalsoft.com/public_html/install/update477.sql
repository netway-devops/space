
--
-- Table structure for table hb_vip_cp_quota
-- update rvglobalsoft.com
--
CREATE TABLE `hb_vip_cp_quota` (
  `quota_id` int(11) NOT NULL AUTO_INCREMENT,
  `cpuser_id` varchar(35) NOT NULL,
  `quota_cp_amount` int(11) NOT NULL DEFAULT '0',
  `quota_app_amount` int(11) NOT NULL DEFAULT '0',
  `enable_status_cp` varchar(20) NOT NULL DEFAULT 'DISABLED' COMMENT 'DISABLED , ENABLED',
  `enable_status_app` varchar(20) NOT NULL DEFAULT 'DISABLED' COMMENT 'DISABLED , ENABLED',
  `usage_status` varchar(20) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE , SUSPENDED',
  PRIMARY KEY (`quota_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Table structure for table hb_vip_info_cp_apps
-- update rvglobalsoft.com
--
CREATE TABLE `hb_vip_info_cp_apps` (
  `vip_info_cp_apps_id` int(11) NOT NULL AUTO_INCREMENT,
  `vip_info_id` int(11) NOT NULL,
  `usr_id` varchar(45) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date_created` int(11) NOT NULL,
  `last_updated` int(11) NOT NULL,
  `certificate_file_name` varchar(200) NOT NULL,
  `certificate_file_type` varchar(100) NOT NULL,
  `certificate_file_size` int(11) NOT NULL DEFAULT '0',
  `certificate_file_path` varchar(200) NOT NULL,
  `certificate_file_content` text NOT NULL,
  `certificate_file_password` varchar(200) NOT NULL,
  `symantec_connection` varchar(200) NOT NULL,
  `md5sum` varchar(50) NOT NULL,
  `date_file_upload` int(11) NOT NULL,
  `date_file_last_upload` int(11) NOT NULL,
  `certificate_expire_date` int(11) NOT NULL,
  `certificate_file_name_p12` varchar(200) NOT NULL,
  `certificate_file_type_p12` varchar(100) NOT NULL,
  `certificate_file_size_p12` int(11) NOT NULL DEFAULT '0',
  `certificate_file_path_p12` varchar(200) NOT NULL,
  `certificate_file_content_p12` text NOT NULL,
  `certificate_file_password_p12` varchar(200) NOT NULL,
  `md5sum_p12` varchar(50) NOT NULL,
  `date_file_upload_p12` int(11) NOT NULL DEFAULT '0',
  `date_file_last_upload_p12` int(11) NOT NULL DEFAULT '0',
  `certificate_expire_date_p12` int(11) NOT NULL DEFAULT '0',
  `can_manage_status` char(1) NOT NULL DEFAULT 'P',
  `status` char(1) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cp_apps_type` varchar(20) NOT NULL COMMENT 'cPanel,Apps',
  PRIMARY KEY (`vip_info_cp_apps_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Alter Table structure for table hb_vip_acct
-- update rvglobalsoft.com
--
ALTER TABLE  `hb_vip_acct` ADD  `vip_info_cp_apps_id` INT( 11 ) NOT NULL DEFAULT  '0' AFTER  `vip_info_id`;
ALTER TABLE  `hb_vip_acct` ADD  `vip_acct_status` VARCHAR( 20 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT  'ENABLED'  AFTER  `vip_info_cp_apps_id`;
ALTER TABLE  `hb_vip_acct` ADD  `cpuser_id` VARCHAR( 35 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE  `hb_vip_acct` ADD  `cp_apps_service_status` VARCHAR( 20 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'ENABLED' COMMENT 'ใช้สำหรับ เปิด ปิด การใช้งานของแต่ละ cpuser , mail user , app user (ENABLED , DISABLED )';
ALTER TABLE  `hb_vip_acct` ADD  `appsuser_id` VARCHAR( 35 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `cpuser_id` ;
--
-- update rvglobalsoft.com 03/08/56
--
ALTER TABLE `hb_client_billing` ADD `cardcvv` INT( 3 ) NOT NULL AFTER `cardholder` 


--
-- Table structure for table `hb_vip_apps_version`
--

CREATE TABLE IF NOT EXISTS `hb_vip_apps_version` (
  `app_version_id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(100) NOT NULL,
  `app_version` varchar(100) NOT NULL,
  `download_url` varchar(255) NOT NULL,
  PRIMARY KEY (`app_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- ที่ rvskin
ALTER TABLE `partner_leased_price` ADD `hostbill_client_id` INT( 11 ) NOT NULL AFTER `user_id` 
-- ที่ rvsitebuilder
ALTER TABLE `rv_partner_quota` ADD `hostbill_client_id` INT( 11 ) NOT NULL AFTER `client_id` 
ALTER TABLE `rv_partner_quota` ADD `dedi_price` DECIMAL( 10, 2 ) NOT NULL AFTER `vps` ,
ADD `vps_price` DECIMAL( 10, 2 ) NOT NULL AFTER `dedi_price` 


--
-- Table structure for table `hb_partner_leased_price`
--
CREATE TABLE  `rvglobal_hostbill`.`hb_partner_leased_price` (
`user_id` VARCHAR( 32 ) NOT NULL ,
`hostbill_client_id` INT( 11 ) NOT NULL ,
`vps_min_q` INT( 3 ) NOT NULL ,
`vps_price` DECIMAL( 10, 2 ) NOT NULL ,
`ded_min_q` INT( 3 ) NOT NULL ,
`ded_price` DECIMAL( 10, 2 ) NOT NULL ,
`noc_vps_price` DECIMAL( 10, 2 ) NOT NULL ,
`noc_ded_price` DECIMAL( 10, 2 ) NOT NULL ,
PRIMARY KEY (  `user_id` )
) ENGINE = MYISAM ;



--
-- Table structure for table `hb_commission`
--
CREATE TABLE IF NOT EXISTS `hb_commission` (
  `owner_id` int(11) NOT NULL,
  `commission` decimal(10,2) NOT NULL,
  `withdrawn` decimal(10,2) NOT NULL,
  PRIMARY KEY (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `hb_commission_history`
--

CREATE TABLE IF NOT EXISTS `hb_commission_history` (
  `invoice_id` int(11) NOT NULL,
  `product_cat` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `usr_id` int(11) NOT NULL,
  `cpserver_id` int(11) NOT NULL,
  `active_customers` int(11) NOT NULL,
  `resold_acct` int(11) NOT NULL,
  `totel` int(11) NOT NULL,
  UNIQUE KEY `invoice_id` (`invoice_id`,`owner_id`,`usr_id`,`cpserver_id`,`product_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `hb_commission_summery`
--

CREATE TABLE IF NOT EXISTS `hb_commission_summery` (
  `invoice_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `product_cat` int(11) NOT NULL,
  `date` varchar(8) NOT NULL,
  `totel` int(11) NOT NULL,
  `commission` decimal(10,2) NOT NULL,
  `payment_status` varchar(16) NOT NULL,
  UNIQUE KEY `invoice_id` (`invoice_id`,`owner_id`,`date`,`product_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `hb_vip_cp_app_login_status` (
  `login_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(200) NOT NULL,
  `cpserver_id` int(11) NOT NULL,
  `usr_id` varchar(35) NOT NULL,
  `status` varchar(20) NOT NULL COMMENT 'ENABLED , DISABLED for cpanel and app',
  PRIMARY KEY (`login_status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='config value by reseller';
