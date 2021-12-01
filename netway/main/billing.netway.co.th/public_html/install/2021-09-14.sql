REPLACE INTO `hb_language_locales` (`language_id`, `section`, `keyword`, `value`, `flags`) VALUES
(1, 'services', 'not_orderpage', 'ยังไม่สามารถแสดงหน้า Order Page ได้ เนื่องจากไม่มีไฟล์', 1);
REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('DefaultPaymentModule', '0');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'DefaultPaymentModule','Default payment gateway' FROM hb_language;
