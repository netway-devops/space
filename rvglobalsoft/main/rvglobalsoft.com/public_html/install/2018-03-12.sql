CREATE TABLE IF NOT EXISTS `hb_admin_teams` (
  `id`     INT(11)     NOT NULL AUTO_INCREMENT,
  `name`   VARCHAR(50) NOT NULL,
  `access` TEXT        NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_admin_team_assignment` (
  `admin_id` INT(11) NOT NULL,
  `team_id`  INT(11) NOT NULL,
  UNIQUE KEY `admin_id_team_id` (`admin_id`, `team_id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
##########
ALTER TABLE `hb_ticket_departments_staff`
  ADD COLUMN `staff_type` ENUM('admin','team') NOT NULL AFTER `staff_id`,
  DROP COLUMN `date`,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (`dept_id`, `staff_id`, `staff_type`),
  ADD INDEX `dept_id` (`dept_id`);
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_staff_autoassign` (
  `staff_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `last_assign` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`staff_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;