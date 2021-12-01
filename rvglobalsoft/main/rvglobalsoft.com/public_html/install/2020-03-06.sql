UPDATE hb_configuration SET `value` = CONCAT('{"default":{"name":"Default","banners":',`value`, '}}') WHERE `setting` = 'AffIntegrationBanners';
##########