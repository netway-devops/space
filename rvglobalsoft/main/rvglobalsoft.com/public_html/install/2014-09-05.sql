CREATE TABLE `hb_client_login_status` (
 `client_id` int(11) NOT NULL,
 `session_id` varchar(32) NOT NULL,
 `token` varchar(40) NOT NULL,
 `lastseen` datetime NOT NULL,
 PRIMARY KEY (`client_id`,`session_id`),
 KEY `token` (`token`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;