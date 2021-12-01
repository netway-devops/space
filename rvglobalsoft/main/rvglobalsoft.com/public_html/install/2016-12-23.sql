ALTER TABLE `hb_email_log`
CHANGE COLUMN `email` `email` TEXT NOT NULL AFTER `client_id`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'passistooshort','Password is too short (minimum is %d characters)' FROM hb_language
UNION SELECT id, 'tickets', 'max_number_of_files','Maximum number of files exceeded' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'accept_file_types','Filetype not allowed' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'min_file_size','File is too small' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'max_file_size','File is too big' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_unknown','Upload Error ' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_php_ext','Upload Error (8)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_failed_write','Upload Error (7)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_no_tmp_dir','Upload Error (6)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_no_data','No file was uploaded' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_partially','The uploaded file was only partially uploaded' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_max_filesizeform','File is too big (2)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'uploaderror_max_filesizeini','File is too big (1)' FROM hb_language WHERE target='user';