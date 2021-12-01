-----------------------------------------------
- ใช้เก็บจำนวน quota ที่เหลือ
- update rvglobalsoft.com 15/11/56
-----------------------------------------------
CREATE TABLE `rvglobal_hostbill`.`hb_rv_license_quota` (
`id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`client_id` INT( 11 ) NOT NULL ,
`quota_ded_max` INT( 11 ) NOT NULL ,
`quota_vps_max` INT( 11 ) NOT NULL ,
`data_update` INT( 11 ) NOT NULL
) ENGINE = InnoDB;


-----------------------------------------------
- ถ้าทำ google ก็ค่อยเพิ่มเข้ามา
-----------------------------------------------
ALTER TABLE `hb_knowledgebase_cat` ADD `google_drive_id` VARCHAR( 64 ) NOT NULL;
ALTER TABLE `hb_knowledgebase_cat` ADD `sync_date` INT NOT NULL;