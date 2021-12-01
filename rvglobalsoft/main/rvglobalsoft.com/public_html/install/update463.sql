--
-- Table structure for table hb_server_name
-- update rvglobalsoft.com 20/08/56 16:52
--
CREATE TABLE `rvglobal_hostbill`.`hb_server_name` (
`host_id` INT( 100 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`ip_user` VARCHAR( 100 ) NOT NULL ,
`hostname` VARCHAR( 100 ) NOT NULL ,
`hostdate` INT( 20 ) NOT NULL
) ENGINE = MYISAM ;


--
-- Table structure for table `hb_transfer_log`
-- update rvglobalsoft.com 26/08/56 16:52
--

CREATE TABLE IF NOT EXISTS `hb_transfer_log` (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `acc_id` int(11) NOT NULL,
  `from_ip` varchar(32) NOT NULL,
  `to_ip` varchar(32) NOT NULL,
  `create_date` int(11) NOT NULL,
  `active_by` char(1) NOT NULL COMMENT 'u=user,s=staff',
  `active_id` int(11) NOT NULL,
  `product_type` varchar(4) NOT NULL COMMENT 'rvk=rvskin,sb=rvsiteuilder,cp=cpanel',
  PRIMARY KEY (`t_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Table structure for table `hb_transfer_limit`
-- update rvglobalsoft.com 26/08/56 16:52
--
CREATE TABLE `rvglobal_hostbill`.`hb_transfer_limit` (
`t_id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`acc_id` INT( 11 ) NOT NULL ,
`icount` DECIMAL( 10, 2 ) NOT NULL
) ENGINE = MYISAM ;