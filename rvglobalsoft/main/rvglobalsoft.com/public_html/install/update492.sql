UPDATE `hb_configuration` SET `value` = '4.9.2' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_notes`
CHANGE COLUMN `type` `type` ENUM('client','account','domain','order','draft') NOT NULL AFTER `id`;
##########
INSERT INTO `hb_notes` (`type`, `rel_id`, `admin_id`, `note`, `date`) 
SELECT 'order', o.id, 0, o.notes, o.date_created FROM hb_orders o 
LEFT JOIN hb_notes n ON n.rel_id=o.id AND n.`type`='order' 
WHERE o.notes!='' AND n.id IS NULL;
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_departments_mail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `method` enum('POP','PIPE') NOT NULL,
  `host` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `port` int(10) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_ticket_departments_mail` (`dept_id`, `email`, `method`, `host`, `login`, `port`, `password`) 
SELECT d.id, d.email, d.method, d.host, d.login, d.port, d.`password` FROM hb_ticket_departments d ON DUPLICATE KEY UPDATE 
host=d.host, login=d.login, port=d.port, `password`=d.`password`, method=d.method;