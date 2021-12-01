ALTER TABLE `hb_tickets_emails`
ADD COLUMN `headers` TEXT NOT NULL AFTER `subject`,
ADD COLUMN `rel` ENUM('ticket','reply') NULL AFTER `status`,
ADD COLUMN `rel_id` INT NULL AFTER `rel`;