REPLACE INTO `hb_configuration` (`setting`, `value`) 
SELECT 'EstimateTemplate', e.id FROM hb_templates e WHERE e.target='estimate';