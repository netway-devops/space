REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('PassDisabledChars', ''),
('RemoveTerminatedAccounts', 'off'),
('RemoveTerminatedAccountsDelay', '30');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'automation', 'removeservice','Account will be removed' FROM hb_language;