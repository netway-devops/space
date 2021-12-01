REPLACE INTO `hb_configuration` VALUES ('ChatRoundRobinEnable','off');
##########
INSERT INTO `hb_email_templates` ( `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES
	( 'Mobile:Chat:Pending', 'Mobile', 'Admin', 1, 'New Pending Chat', 'Subject: {$chat.subject}\r\nSubmitter: {$chat.visitor_name} ', 'Subject: {$chat.subject}\r\nSubmitter: {$chat.visitor_name} ', 1, 2, 1, 0);