CREATE TABLE IF NOT EXISTS `hb_admin_widgets` (
  `admin_id` int(11) NOT NULL,
  `widget` varchar(32) NOT NULL DEFAULT '',
  `panel` enum('left','right','bottom','top') NOT NULL DEFAULT 'left',
  `collapsed` int(1) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`admin_id`,`widget`),
  KEY `panel` (`panel`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS  `hb_reports_day_range` (
  `range` int(11) NOT NULL,
  `month` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`range`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_reports_day_range` (`range`, `month`)
VALUES
	(1,'January'),
	(2,'February'),
	(3,'March'),
	(4,'April'),
	(5,'May'),
	(6,'June'),
	(7,'July'),
	(8,'August'),
	(9,'September'),
	(10,'October'),
	(11,'November'),
	(12,'December'),
	(13,''),
	(14,''),
	(15,''),
	(16,''),
	(17,''),
	(18,''),
	(19,''),
	(20,''),
	(21,''),
	(22,''),
	(23,''),
	(24,''),
	(25,''),
	(26,''),
	(27,''),
	(28,''),
	(29,''),
	(30,''),
	(31,'');
##########
REPLACE INTO `hb_admin_widgets` (`admin_id`, `widget`, `panel`, `collapsed`, `status`, `sort_order`)
SELECT id, 'adminevents.recentorders', 'left','0','1','1' FROM hb_admin_access
UNION SELECT id, 'adminevents.recentdomains', 'left','0','1','2' FROM hb_admin_access
UNION SELECT id, 'adminevents.mytickets', 'right','0','1','0' FROM hb_admin_access
UNION SELECT id, 'adminevents.recentaccfailures', 'right','0','1','1' FROM hb_admin_access
UNION SELECT id, 'adminevents.noteattention', 'bottom','0','1','0' FROM hb_admin_access
UNION SELECT id, 'hbextras.0', 'bottom','0','1','1' FROM hb_admin_access
UNION SELECT id, 'adminevents.systeminfo', 'bottom','0','1','2' FROM hb_admin_access
UNION SELECT id, 'todolist.0', 'left','0','1','0' FROM hb_admin_access
UNION SELECT id, 'whoisonline.0', 'left','0','1','3' FROM hb_admin_access
UNION SELECT id, 'domainwhois.0', 'right','0','1','2' FROM hb_admin_access;
##########
REPLACE INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(1003, 'Support', 'New tickets daily', 'SELECT r.range as `Day`,\n COUNT(t.id) as `Tickets` \nFROM hb_reports_day_range r \nLEFT JOIN hb_tickets t ON (r.range = DAY(t.date) \nAND DATE(t.date) >= :date_bottom\nAND DATE(t.date) <= :date_top ) \nWHERE\n r.range < 32 \nGROUP BY `Day`,\n DAY(t.date) \n\nORDER BY r.range ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:3:\"Day\";i:1;s:7:\"Tickets\";}'),
	(1002, 'Support', 'New tickets monthly', 'SELECT r.month as `Month`,\n COUNT(t.id) as `Tickets` \nFROM hb_reports_day_range r \nLEFT JOIN hb_tickets t ON (r.range = MONTH(t.date) \nAND DATE(t.date) >= :date_bottom\nAND DATE(t.date) <= :date_top ) \nWHERE\n r.range < 13 \nGROUP BY `Month`,\n MONTH(t.date) \n\nORDER BY r.range ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:18:\"current-year-start\";s:9:\":date_top\";s:16:\"current-year-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:5:\"Month\";i:1;s:7:\"Tickets\";}'),
	(1001, 'Invoices', 'Monthly income', 'SELECT r.month as `Month`,\n COALESCE(SUM((t.`in` - t.`fee`) * t.`rate`),0) as `Income` \nFROM hb_reports_day_range r \nLEFT JOIN hb_transactions t ON (r.range = MONTH(t.date) \nAND DATE(t.date) >= :date_bottom\nAND DATE(t.date) <= :date_top ) \nWHERE\n r.range < 13 \nGROUP BY `Month`,\n MONTH(t.date) \n\nORDER BY r.range ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:18:\"current-year-start\";s:9:\":date_top\";s:16:\"current-year-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}'),
	(1000, 'Invoices', 'Daily income', 'SELECT r.range as `Day`,\n COALESCE(SUM((t.`in` - t.`fee`) * t.`rate`),0) as `Income` \nFROM hb_reports_day_range r \nLEFT JOIN hb_transactions t ON (r.range = DAY(t.date) \nAND DATE(t.date) >= :date_bottom \nAND DATE(t.date) <= :date_top) \nWHERE\n r.range < 32 \nGROUP BY `Day`,\n DAY(t.date) \n\nORDER BY `Day` ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}');
##########
INSERT INTO `hb_reports_widget` (`id`, `report_id`, `name`, `type`)
VALUES
(1, 1000, 'Daily income', 'line-chart'),
(2, 1001, 'Monthly income', 'bar-chart'),
(4, 1002, 'New tickets monthly', 'bar-chart'),
(5, 1003, 'New tickets daily', 'bar-chart');
##########
INSERT INTO `hb_reports_widget` (`id`, `report_id`, `name`, `type`)
SELECT NULL, id, 'Product sales','bar-chart' FROM hb_reports WHERE name='Number of sales per product in given period';
##########
INSERT INTO `hb_reports_widget_series` (`id`, `reports_widget_id`, `state`, `columns`, `name`)
VALUES
	(1, 1, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:20:\"previous-month-start\";s:12:\":date_bottom\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Previous month'),
	(2, 1, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:19:\"current-month-start\";s:12:\":date_bottom\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Current month'),
	(3, 2, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:19:\"previous-year-start\";s:12:\":date_bottom\";s:17:\"previous-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'Last Year'),
	(4, 2, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:18:\"current-year-start\";s:12:\":date_bottom\";s:16:\"current-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'This Year'),
	(5, 6, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:12:\"Product Name\";i:1;s:10:\"Items Sold\";}', 'Last month'),
	(6, 6, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:12:\"Product Name\";i:1;s:10:\"Items Sold\";}', 'This month'),
	(7, 4, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:19:\"previous-year-start\";s:12:\":date_bottom\";s:17:\"previous-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:7:\"Tickets\";}', 'Last Year'),
	(8, 4, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:18:\"current-year-start\";s:12:\":date_bottom\";s:16:\"current-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:7:\"Tickets\";}', 'This Year'),
	(9, 5, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:20:\"previous-month-start\";s:12:\":date_bottom\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:7:\"Tickets\";}', 'Last month'),
	(10, 5, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:19:\"current-month-start\";s:12:\":date_bottom\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:7:\"Tickets\";}', 'This month');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'ugrade_err_invoice','You have an unpaid invoice for this service. Invoice #%s' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ugrade_err_order','This service is already pending upgrade. Order #%s ' FROM hb_language WHERE target='user';
