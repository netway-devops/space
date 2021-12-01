REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'slidersequenced', 'Slider Sequenced' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'slidersequenced-description', 'You can provide custom steps/increments' FROM hb_language WHERE target!='user';