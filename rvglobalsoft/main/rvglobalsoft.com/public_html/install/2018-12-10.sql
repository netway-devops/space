REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'VoteKnowledgebaseArticles','Let clients vote for knowledgebase articles' FROM hb_language WHERE target!='user'
UNION SELECT id, 'knowledgebase', 'article_helpful','Was this article helpful?' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'knowledgebase', 'add_vote','Thank you for your vote!' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'knowledgebase', 'article_voted','You have already voted for this article!' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'knowledgebase', 'like','Like' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'knowledgebase', 'dislike','Dislike' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'knowledgebase', 'views','Views' FROM hb_language WHERE target!='admin';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('VoteKnowledgebaseArticles', 'on');
##########
ALTER TABLE hb_knowledgebase
ADD COLUMN `upvotes` INT(11) NULL DEFAULT 0,
ADD COLUMN `downvotes` INT(11) NULL DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'knowledgebase', 'statistics','Statistics' FROM hb_language WHERE target!='user';
##########
REPLACE INTO hb_reports (`type`, `name`, `query`, `options`, `handler`, `state`, `columns`, `displayname`) VALUES
('Knowledgebase', '100 most viewed articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n
FROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`views` DESC LIMIT 100', 1, 'sql', '', '', '100 most viewed articles'),
('Knowledgebase', '100 Most upvoted articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n
FROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`upvotes` DESC LIMIT 100', 1, 'sql', '', '', '100 Most upvoted articles'),
('Knowledgebase', '100 Most downvoted articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n
FROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`downvotes` DESC LIMIT 100', 1, 'sql', '', '', '100 Most downvoted articles'),
('Knowledgebase', '100 least viewed articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n
FROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`views` ASC LIMIT 100', 1, 'sql', '', '', '100 least viewed articles');
##########
CREATE TABLE `hb_knowledgebase_relations` (
	`parent_id` INT(10) NOT NULL,
	`child_id` INT(10) NOT NULL,
	PRIMARY KEY (`parent_id`, `child_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'knowledgebase', 'related_articles','Related articles' FROM hb_language
UNION SELECT id, 'knowledgebase', 'Slug','Slug' FROM hb_language WHERE target!='user';
##########
DELETE FROM `hb_admin_widgets` WHERE `widget` = 'adminevents.allinpromo';