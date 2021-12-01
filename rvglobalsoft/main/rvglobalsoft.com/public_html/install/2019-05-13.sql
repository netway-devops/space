ALTER TABLE `hb_queue_status`
CHANGE COLUMN `env` `env` LONGBLOB NOT NULL AFTER `human_description`;
##########
INSERT IGNORE INTO `hb_configuration` (`setting`, `value`) VALUES
('TicketImportFromHeaders', 'reply-to,x-original-from,from'),
('TicketImportToHeaders', 'x-original-to,x-delivered-to,delivered-to,x-rcpt-to,rcpt-to,to');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'selected','Selected' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'popular','Popular' FROM hb_language WHERE target='user';