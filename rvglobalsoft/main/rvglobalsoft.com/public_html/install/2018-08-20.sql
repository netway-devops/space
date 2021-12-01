REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tickets', 'rate_ticket', 'Rate Ticket' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'rate_ticket_desc', 'To improve our future work, please enter comments to support supervisor (optional)' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'rate_ticket_success', 'Thank you for your rating. Your opinion will be very helpful for us!' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'rate_ticket_submit', 'Please, rate us first' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'ticket_is_rated', 'The ticket is already rated' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'ticket_must_closed', 'To rate a ticket it must be closed earlier' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'ticket_rate_disabled', 'The ticket rating option has been disabled by the administrator' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ticketdepts', 'overall_ticket_rating', 'Overall ticket ratings' FROM hb_language WHERE target!='user'
UNION SELECT id, 'ticketdepts', 'overall_ticket_rating_yes', 'allow users to rate tickets upon closing them' FROM hb_language WHERE target!='user'
UNION SELECT id, 'ticketdepts', 'overall_ticket_rating_no', 'do not allow users to rate tickets' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'ticket_ratings', 'Ticket ratings' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'per_reply', 'Per reply' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'per_ticket', 'Per ticket' FROM hb_language WHERE target!='user';
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_rating` (
            `ticket_id` INT(11) NOT NULL,
            `rating` INT(11) NOT NULL,
            `date` DATETIME NOT NULL,
            `comment` TEXT,
            PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;