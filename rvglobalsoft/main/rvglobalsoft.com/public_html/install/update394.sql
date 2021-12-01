UPDATE `hb_configuration` SET `value` = '3.9.4' WHERE `setting`= 'Version';
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_replies_rating` (
    `reply_id` INT(10) NOT NULL,
    `rating` INT(10) NOT NULL,
    `date` DATETIME NOT NULL,
    PRIMARY KEY (`reply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_departments_staff` (
	`dept_id` INT(10) NOT NULL,
	`staff_id` INT(10) NOT NULL,
	`options` INT(10) NOT NULL,
    `date` DATETIME NOT NULL,
	PRIMARY KEY (`dept_id`, `staff_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_config_items` CHANGE COLUMN `name` `name` VARCHAR(255) NOT NULL AFTER `category_id`;
##########
ALTER TABLE `hb_error_log` CHANGE `type` `type` ENUM( 'Exception', 'PHP Error', 'Other' )  NOT NULL ;
##########
UPDATE `hb_client_fields` SET options = (options & -17) | 64 | 256 WHERE `code`='email' LIMIT 1;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'viewSupportRating','View Ticket Rating' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'ratemyresponse','Rate my response' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ticketdepts', 'ratesupport','Staff response ratings' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'supportrating_yes','allow users to rate staff responses' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'supportrating_no','disable this feature' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'supportrating','Ticket Rating' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'allrating','Overall Rating' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'staffrating','Staff Rating' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'dptrating','Department Rating' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'ofalltime','Of all time' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'allmonths','All months' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'ratingdisabled','Ticket ratings are disabled' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'norateddepartment','There are no departments that would let clients rate support staff responses, you can enable it by setting it on in at least one department.' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'avergerating','Averge rating' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'rated','Rated' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'unrated','Unrated' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'bestrating','Best rating' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'lowestrating','Lowest rating' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'noratesyet','There are no rated responses yet.' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'supportrating', 'ratingscale','Rating scale' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'editadmins', 'deleteServices','Delete accounts/services' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'deleteClients','Delete clients' FROM hb_language WHERE target='admin';
