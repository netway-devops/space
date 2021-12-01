REPLACE INTO `hb_language_locales` (`language_id`, `section`, `keyword`, `value`, `flags`) VALUES
(2, 'clientarea', 'warn_destination_url', 'ปัจจุบัน browser ได้พัฒนาไปมาก และ มีระบบป้องกันความปลอดภัยสูงขึ้นเรื่อย ๆ เทคนิคที่ใช้ในการ forward นี้ ไม่สามารถทำการ ซ่อน URL ปลายทาง ได้อีกต่อไป\r\n<br>ณ ขณะนี้ ลูกค้า จำเป็นต้อง ยกเลิก การทำ URL masking และ ยอมให้ URLเปลี่ยนไปยัง domain จริง', 1),
(8, 'clientarea', 'warn_destination_url', 'ปัจจุบัน browser ได้พัฒนาไปมาก และ มีระบบป้องกันความปลอดภัยสูงขึ้นเรื่อย ๆ เทคนิคที่ใช้ในการ forward นี้ ไม่สามารถทำการ ซ่อน URL ปลายทาง ได้อีกต่อไป\r\n<br>ณ ขณะนี้ ลูกค้า จำเป็นต้อง ยกเลิก การทำ URL masking และ ยอมให้ URLเปลี่ยนไปยัง domain จริง', 1);
REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('LateFeeInitialOrders', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'LateFeeInitialOrders','Late Fee initial orders' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'LateFeeInitialOrdersNO','do not add late fees on initial orders' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'LateFeeInitialOrdersYES','add late fee also on initial orders' FROM hb_language WHERE target!='user';
