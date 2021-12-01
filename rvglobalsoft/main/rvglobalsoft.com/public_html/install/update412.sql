UPDATE `hb_configuration` SET `value` = '4.1.2' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'monthlybandwidth','Monthly Bandwidth' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'diskspaceusage','Disk Space Usage' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'yourehere','You\'re here' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'apps','Apps' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'couldconectto','Could not conect to' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'checkyourloginpassword','Check your login and password' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'nobackups','No backups' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'yourbackapslocatedin','Your backups are located in' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'wildcardallowed','wildcard is allowed' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'usage','Usage' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'managementfunctions','Management Functions' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'changequota','Change Quota' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'quota','Quota' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'addemailaccount','Add new Email account' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'homedirectory','Home Directory' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'specialaccounts','Special FTP Accounts' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'addftpaccount','Add new FTP account' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'clickhereaccesscontrolpanel','Click here to access Control Panel' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'clickhereaccesswebmail','Click here to access WebMail' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'backto','Back to' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'youagreeoremoveresource','By checking fields you agree to remove related resources even if these are used by other users or applications.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'wordpressversion','WordPress Version' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'path','Path' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'directory','Directory' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'databasehost','Database Host' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'databasename','Database Name' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'databaseuser','Database User' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'databasepassword','Database Password' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'cleanform','Clean form' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'newinstallation','New Installation' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'installwordpresson','Install WordPress on' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'checking','Checking' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'directorynotempty','Directory is not empty' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'database','Database' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'downloadinglatestwordpress','Downloading latest WordPress' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'extractingfiles','Extracting files' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'done','Done' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'retry','Retry' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'version','Version' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'reinstall','Reinstall' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'youdonthavewordpressinstalled','You don\'t have any WordPress installed' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'upgradeinfo','Upgrade Info' FROM hb_language WHERE target='user';
##########
INSERT INTO `hb_reports` (
`id` ,
`type` ,
`name` ,
`query` ,
`options`
)
VALUES (
NULL , 'Support', 'Weekend support by staff member in given period', '
SELECT COUNT(DISTINCT t.`id`) AS `Tickets answered`,  r.name AS `Staff Name`
FROM hb_tickets t
JOIN hb_ticket_replies r ON (r.ticket_id=t.id)
WHERE
 r.type=\'Admin\'
 AND
 r.`date` > :date_bottom
AND
 r.`date` < :date_top
 AND
 DAYOFWEEK(r.`date`) IN (1,7)
GROUP BY
r.replier_id
)
', '1'
);

