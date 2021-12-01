ALTER TABLE `hb_client_login_status`
ADD COLUMN `flag` TINYINT NOT NULL DEFAULT '0' AFTER `lastseen`;