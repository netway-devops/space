

-------------------------------------------------------
- เวลากด renew ที่product perpertual จะได้รู้ว่ากดไปเมื่อไหร่
-------------------------------------------------------
CREATE TABLE `rvglobal_hostbill`.`hb_rv_renew_log` (
`id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`account_id` INT( 11 ) NOT NULL ,
`itype` VARCHAR( 100 ) NOT NULL ,
`dt_update` INT (11) NOT NULL
) ENGINE = InnoDB;