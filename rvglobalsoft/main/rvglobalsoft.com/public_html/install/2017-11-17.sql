UPDATE hb_tickets t
JOIN hb_ticket_status s ON s.`status`=t.`status`
SET t.`status` = 'Scheduled-Notification'
WHERE t.`status` = 'Scheduled' AND s.options=4;
##########
DELETE FROM hb_ticket_status WHERE
  `status` = 'Scheduled' AND `options` = 4;
##########
INSERT INTO hb_ticket_status (`status`, `options`, `color`, `sort_order`) VALUES
  ('Answered', 3, '000000', 2),
  ('Client-Reply', 1, '000000', 4),
  ('Closed', 1, '000000', 1),
  ('In-Progress', 1, '000000', 3),
  ('Open', 1, '000000', 0),
  ('Scheduled-Notification', 5, '000000', 0),
  ('Sent-Out', 5, '000000', 0)
ON DUPLICATE KEY UPDATE `options`=VALUES(`options`);
