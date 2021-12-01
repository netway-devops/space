INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(2000, 'Invoices', 'Monthly cumulative income', 'SELECT r.month as `Month`,\r\n @total := @total + COALESCE(t.income,0) as `Income` \r\nFROM hb_reports_day_range r \r\nLEFT JOIN (SELECT MONTH(date) as date, COALESCE(SUM((`in` - `fee`) * `rate`),0) as income \r\nFROM hb_transactions \r\nWHERE\r\n DATE(date) >= :date_bottom \r\nAND DATE(date) <= :date_top \r\nGROUP BY MONTH(date)) as t ON (r.range = t.date) \r\nINNER JOIN (SELECT @total := 0) as tx \r\nWHERE\r\n r.range < 13 \r\nGROUP BY `Month` \r\n\r\nORDER BY r.range ASC', 1, 'sql', '', ''),
	(2001, 'Invoices', 'Daily cumulative income', 'SELECT \r\n	r.range as `Day`,\r\n 	@total := @total + COALESCE(t.income,0)  AS `Income`\r\n\r\nFROM hb_reports_day_range r \r\n\r\nLEFT JOIN \r\n(\r\n	SELECT\r\n	DATE(date) as date,\r\n	COALESCE(SUM((`in` - `fee`) * `rate`),0) as income\r\n	FROM\r\n	hb_transactions \r\n	WHERE\r\n	 	DATE(date) >= :date_bottom\r\n	 AND\r\n		DATE(date) <= :date_top\r\n	GROUP BY DATE(date)\r\n) AS t ON (r.range = DAY(t.date))\r\nJOIN (SELECT @total:=0) AS tx\r\n\r\nWHERE\r\n r.range < 32 \r\nGROUP BY `Day`\r\n\r\nORDER BY `Day` ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}');
##########
INSERT INTO `hb_reports_widget` (`id`, `report_id`, `name`, `type`)
VALUES
	(50, 2000, 'Monthly cumulative income', 'bar-chart'),
	(51, 2001, 'Daily cumulative income', 'line-chart');
##########
INSERT INTO `hb_reports_widget_series` (`id`, `reports_widget_id`, `state`, `columns`, `name`)
VALUES
	(100, 51, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Previous Month'),
	(101, 51, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Current Month');
##########
INSERT INTO `hb_reports_widget_series` (`id`, `reports_widget_id`, `state`, `columns`, `name`)
VALUES
	(102, 50, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"previous-year-start\";s:9:\":date_top\";s:17:\"previous-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'Last Year'),
	(103, 50, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:18:\"current-year-start\";s:9:\":date_top\";s:16:\"current-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'This Year');
