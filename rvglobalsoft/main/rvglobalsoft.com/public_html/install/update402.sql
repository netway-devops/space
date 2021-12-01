UPDATE `hb_configuration` SET `value` = '4.0.2' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'metteredschemes','<b>Tiered scheme</b><br/>
                                           Every unit charge is calculated with each measurement based on its own tier.<br/>
                                           i.e.: <i>1-2: $1, 3-4: $2, qtys are: 1,3; charge: 1*$1 + 3*$2</i> <br/><br/>
                                           <b>Overage tiers</b><br/>
                                            Use this scheme as tiered, where each expected measurement is low (i.e. hourly bandwidth).<br/>
                                           i.e.: <i>0-100: $0, 101-150: $1 </i>:<br/> up to 100 - free, everything above 100 - $1/unit. So total of: 102 measured will cost $2<br/><br/>
                                           <b>Volume scheme</b><br/>All units charge is calculated based on total count in period and related bracket.<br/>
                                           ie.: <i>1-2: $1, 3-4: $2, qtys are: 1,3; charge: 4*$2</i><br/><br/>
                                           <b>Stairstep scheme</b><br/>Total cost is calculated based on price bracket, charge is for entire bracket not certain units<br/>
                                           i.e.: <i>1-5: $1, 6-10: $2, total qty: 7, charge: $2</i>' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_mettered_variables` CHANGE `scheme` `scheme` ENUM( 'unit', 'volume', 'tiered', 'stairstep', 'overage' ) NOT NULL DEFAULT 'unit';