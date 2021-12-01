UPDATE `hb_configuration` SET `value` = '4.3.2' WHERE `setting`= 'Version';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) 
VALUES ('LiveChat:Chat transcription', 'Support', 'Client', 1, 'Chat session transcription - {$chat.start_date|dateformat:$date_format}', 'Hello {$client.visitor_name},\r\n\r\nYou can find requested chat session transcription bellow.\r\n\r\n{foreach from=$chat.messages item=line}\r\n{if $line.type=="Staff"}\r\n\r\n#{$line.submitter_name}:\r\n{elseif $line.type=="Client"}\r\n\r\n#{$line.submitter_name}:\r\n{else}-{/if}{$line.message}\r\n{/foreach}', 1, 1, 1, 0);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'hbchat', 'email_transcript_sent','Conversation transcript sent to %s' FROM hb_language WHERE target='user'
UNION SELECT id, 'hbchat', 'email_transcript_fail','Could not send conversation transcript' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'pending_upgrade_lock','Your account is pending upgrade, you can\'t create new VMs until it is completed' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'setupyour','Setup Your' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'additionaldetails','Additional details' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'option','Option' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'ordersteps','Order steps' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'plandetails','Plan Details' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'extrafeatures','extra features' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'removethisaddon','Remove this addon' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'removethisproduct','Remove this product' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'yourcarttotal','your cart total' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'cloudserver','cloud server' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'maximum','maximum' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'minimum','minimum' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'currenttotal','Current total' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'productrequiresdomain','The product or service you have chosen requires a domain name' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'billingcycle','Billing cycle' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'returnhome','Return to home' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'premadepackages','Premade Packages' FROM hb_language WHERE target='user'
UNION SELECT id, 'configuration', 'InitialDueDays','First invoice due date set to ' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'InitialDueDays2',' days after order' FROM hb_language WHERE target!='user';
##########
ALTER TABLE `hb_tickets`
ADD COLUMN `tags` TINYINT UNSIGNED NOT NULL DEFAULT '0' AFTER `notes`;
##########
UPDATE hb_tickets t
JOIN (SELECT ticket_id, COUNT(tag_id) `count` FROM hb_tickets_tags GROUP BY ticket_id) ttg ON ttg.ticket_id=t.id
SET t.tags = ttg.`count`;
##########
REPLACE INTO `hb_configuration` (`setting`, `value`)
 VALUES
('AdvancedDueDate', 'off'),
('InitialDueDays', '0');
##########
ALTER TABLE `hb_tickets` ADD INDEX ( `lastreply` );
##########
ALTER TABLE `hb_ticket_replies` ADD INDEX ( `date` );