create index hb_ticket_replies_status on hb_ticket_replies (`status`);
##########
create index hb_tickets_deptid_flags on hb_tickets(`dept_id`, `flags`);
##########
ALTER TABLE `hb_mettered_summary`
ADD COLUMN `recalc` TINYINT(4) NOT NULL DEFAULT '1' AFTER `charge`;
##########
INSERT IGNORE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'p4', 'Quadrennially' FROM hb_language
UNION SELECT id, 'global', 'p5', 'Quinquennially' FROM hb_language
UNION SELECT id, 'global', 't', 'Triennially' FROM hb_language
UNION SELECT id, 'global', 'Quadrennially', 'Quadrennially' FROM hb_language
UNION SELECT id, 'global', 'Quinquennially', 'Quinquennially' FROM hb_language
UNION SELECT id, 'global', 'Triennially', 'Triennially' FROM hb_language;