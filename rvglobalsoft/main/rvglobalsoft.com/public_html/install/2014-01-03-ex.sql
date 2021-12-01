
## เก็บ log การแก้ไข CSR ของ SSL
## update บน rvglobalsoft.com 27/01/57
CREATE TABLE `rvglobal_hostbill`.`hb_ssl_csr_log` (
`id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`order_id` INT( 11 ) NOT NULL ,
`csr_old` TEXT NOT NULL ,
`csr_new` TEXT NOT NULL,
`i_date` INT (11) NOT NULL
) ENGINE = InnoDB;