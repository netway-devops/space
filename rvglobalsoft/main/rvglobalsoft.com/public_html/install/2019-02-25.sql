UPDATE `hb_common` SET `paytype` = 'Regular'
WHERE `paytype`='Free' AND rel='Config'
  AND 0 != `m_setup`+ `q_setup` + `s_setup` + `a_setup` + `b_setup` + `t_setup` + `d_setup` + `w_setup` + `h_setup`
             +  `m` + `q` + `s` + `a` + `b` + `t` + `d` + `w` + `h`;
##########
REPLACE INTO `hb_reports` (`type`, `name`, `query`, `options`, `state`, `columns`) VALUES
('Support', 'Time tracking entries',
'SELECT i.id AS `Entry ID`, i.admin AS `Admin`, t.ticket_number AS `Ticket Number`, i.`date` AS `Date Added`, i.`start` AS `Date Started`,
i.`end` AS `Date Finished`, b.name AS `Rate Name`, i.`type` AS `Rate Type`, i.rate AS `Rate`,
CASE
WHEN  i.`status` = 0 THEN "Draft"
WHEN  i.`status` = 1 THEN "Billed"
WHEN  i.`status` = 2 THEN "Pending"
WHEN  i.`status` = 3 THEN "Cancelled"
WHEN  i.`status` = 4 THEN "Billed External"
END AS `Status`
FROM hb_ticket_billing_items i
JOIN hb_ticket_billing b ON (b.id = i.rate_id)
LEFT JOIN hb_tickets t ON (t.id = i.ticket_id)
WHERE i.`date`>= :date_bottom AND i.`date`<= :date_top', 1, '', '')