ALTER TABLE `hb_accounts`
ADD COLUMN `due_day` TINYINT NOT NULL DEFAULT '0' AFTER `next_due`;
##########
ALTER TABLE `hb_accounts_addons`
ADD COLUMN `due_day` TINYINT NOT NULL DEFAULT '0' AFTER `next_due`;
##########
UPDATE `hb_accounts` SET `due_day` = DAY(`next_due`);
##########
UPDATE `hb_accounts_addons` SET `due_day` = DAY(`next_due`);
##########
REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('DueDateFlow', 'continue')