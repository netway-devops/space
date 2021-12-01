ALTER TABLE  `hb_products` ADD  `client_limit` INT( 10 ) NOT NULL DEFAULT  '0';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'product_over_limit','You are not allowed to order more of this product, please contact us to order more' FROM hb_language WHERE target='user';
##########
ALTER TABLE `hb_subscription_items`
ADD COLUMN `gateway_id` INT NOT NULL AFTER `gateway_name`,
ADD INDEX `gateway_id` (`gateway_id`);
##########
UPDATE hb_subscription_items s 
JOIN hb_modules_configuration mc ON 
CASE WHEN s.gateway_name='PayPal' THEN mc.filename='class.paypal.php' 
WHEN s.gateway_name='2checkout' THEN mc.filename='class.checkout.php'
WHEN s.gateway_name='GoCardless.com' THEN mc.filename='class.gocardless_com.php' END
SET s.gateway_id=mc.id;
##########
ALTER TABLE `hb_invoice_items_queue`
ADD COLUMN `note` TEXT NOT NULL AFTER `description`;