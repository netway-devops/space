DELETE FROM hb_reports WHERE `name` = 'report.incomeoffvattax.php';
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(NULL, 'Invoices', 'Metric: EU: Income minus tax', 'report.incomeoffvattax.php', 0, 'php', 'a:3:{s:6:\"params\";N;s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:3:{i:0;s:9:\"This Year\";i:1;s:10:\"This Month\";i:2;s:5:\"Today\";}');
##########
INSERT INTO `hb_reports_widget` (`id`, `report_id`, `name`, `type`)
SELECT NULL,`id`, 'EU: Income minus tax', 'metric' FROM hb_reports WHERE `name` = 'Metric: EU: Income minus tax';
##########
INSERT INTO `hb_reports_widget_series` (`id`, `reports_widget_id`, `state`, `columns`, `name`)
SELECT
NULL, `id`, 'a:3:{s:6:\"params\";N;s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:3:{i:0;s:9:\"This Year\";i:1;s:10:\"This Month\";i:2;s:5:\"Today\";}', 'EU: Daily income minus tax'
FROM hb_reports_widget WHERE `name` = 'EU: Income minus tax';
##########