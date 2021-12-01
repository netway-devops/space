ALTER TABLE  `hb_ticket_departments` ADD  `sla_level_zero` INT( 10 ) NOT NULL DEFAULT  '0' AFTER  `autoclose`;
##########
ALTER TABLE  `hb_ticket_departments` ADD  `macro_sla0_id` INT( 10 ) NOT NULL DEFAULT  '0' AFTER  `sla_level_two`