ALTER TABLE  `hb_downloads` ADD  `rel_type` INT( 11 ) NOT NULL DEFAULT  '0',
ADD  `rel_id` INT( 11 ) NOT NULL DEFAULT  '0',
ADD INDEX (  `rel_type` ,  `rel_id` );
##########
ALTER TABLE  `hb_aff` ADD  `landing_url` TEXT NOT NULL;