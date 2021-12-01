REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT l.id, 'clientarea', t.keyword, t.value
FROM hb_language_locales t
JOIN hb_language l ON l.id=t.language_id
LEFT JOIN hb_language_locales tx ON
      tx.language_id=t.language_id
  AND tx.section IN ('clientarea', 'global')
  AND tx.keyword=t.keyword
WHERE t.section='onapp' AND l.target='user' AND tx.value IS NULL;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'isos', 'ISO List' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uploadiso', 'Upload ISO' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'virtualization', 'Virtualization' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'distro', 'Distribution' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uploadisodescr', 'Choose ISO file to upload, either URL or local file uploaded using File Manager' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'bootfromiso', 'Boot ISO' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'min_memory_size', 'Min memory size' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'isolimit_left', 'You can add <b>%d</b> additional ISO image' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'selectefilefrommanageror', 'Select existing file from file manager or' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uploadnew', 'Upload new' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uploadfromurl', 'Enter URL to ISO file' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uploadfile', 'Upload file' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uploadfileurl', 'File URL' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uploadselectfile', 'Select file' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'confirmremoveiso', 'Are you sure you want to remove this iso?' FROM hb_language WHERE target='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('UpgradeProratePrecision', 'seconds');