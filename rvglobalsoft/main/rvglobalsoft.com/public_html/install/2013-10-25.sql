REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configfields', 'multicheckbox','Groupped Checkbox' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'multicheckbox-description','If you have multiple checkbox to display on one site, you can group them together using this form item' FROM hb_language WHERE target='admin'
UNION SELECT id, 'clientarea', 'convertvolume','Convert to volume' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshotconversiondesc','Snapshot conversion lets you create a Template from an existing Virtual Machine configuration, which you can then use to redeploy new Virtual Machines.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'convertyoursnapsho','To convert your Snapshot, enter a Label name for your new template and click the convert button.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshotconversionvolume','Snapshot conversion lets you create new volume from an existing snapshot, which you can then attach to existing Virtual Machines.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'timezone','Time zone' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'maxsnapshots','Max snapshots' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'yhour','Hour' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'time','Time' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'daymonth','Day of month' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'dayweek','Day of week' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshotkeep','Snapshot to keep' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'attach','Attach' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'detach','Detach' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshotschedule','Snapshot Schedule' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'suretocreatesnapshot','Are you sure you wish to create new snapshot?' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'youhavestopthisvm','You have to stop this virtual machine before detaching volumes' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'additionalmayaddedyourbill','Additional fee may be added to your bill' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'aresuredeletethisvolume','Are you sure to delete this volume' FROM hb_language WHERE target='user';
##########
UPDATE hb_language_locales SET value = 'Still can\'t find what you\'re looking for? Please <a href="tickets/new/" class="bold">send us a message.' 
WHERE value = 'Still can\'t find what you\'re looking for? Please <a href="{$ca_url}tickets/new/" class="bold">send us a message.';
##########
DELETE m FROM hb_ticket_departments_mail m LEFT JOIN hb_ticket_departments d ON d.id=m.dept_id WHERE d.id IS NULL;