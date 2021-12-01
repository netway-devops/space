REPLACE INTO `hb_language_locales` (`language_id`, `section`, `keyword`, `value`, `flags`) VALUES
(1, 'global', 'deal_running', 'ระบบกำลังสร้าง Deal กรุณารอสักครู่ แล้ว Reload หน้านี้ใหม่อีกครั้ง', 1);
ALTER TABLE `hb_template_content` CHANGE `content` `content` LONGTEXT   NOT NULL;
