REPLACE INTO `hb_admin_widgets` (`admin_id`, `widget`, `panel`, `collapsed`, `status`, `sort_order`, `autorefresh`)
SELECT
id,  'adminevents.allinpromo2', 'left', 0, 1, 0, 0  FROM hb_admin_access WHERE status = 'Active';
