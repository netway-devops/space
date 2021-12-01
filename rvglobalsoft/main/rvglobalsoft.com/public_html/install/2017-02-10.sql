ALTER TABLE `hb_ticket_departments_mail` CHANGE `password` `password` TEXT   NOT NULL;
##########
REPLACE INTO hb_configuration VALUE('UpgradesAddPeriod','off');