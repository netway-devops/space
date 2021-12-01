UPDATE hb_language_locales s JOIN hb_language l ON l.id=s.language_id  
SET s.value='Generate Renewal orders' 
WHERE s.keyword="AutoRenew"  and l.target='admin';
##########
UPDATE hb_language_locales s JOIN hb_language l ON l.id=s.language_id  
SET s.value='Generate Renewal orders is ' 
WHERE s.keyword="autorenewis"  and l.target='admin';