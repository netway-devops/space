CREATE TABLE IF NOT EXISTS `hb_tags_items` (
  `tag_id` int(11) NOT NULL,
  `rel` enum('Product','Account','Domain') NOT NULL DEFAULT 'Product',
  `rel_id` int(11) NOT NULL,
  PRIMARY KEY (`tag_id`,`rel`,`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;