<?php

function smarty_modifier_ssl_getproductvalidation($orderId)
{
	$db = hbm_db();
	$aQuery = $db->query("
			SELECT
				s.ssl_validation_id
    		FROM
    			hb_accounts AS a
				, hb_products AS p
				, hb_ssl AS s
    		WHERE
    			a.order_id = {$orderId}
    			AND a.product_id = p.id
    			AND p.name = s.ssl_name
	")->fetch();

	return ($aQuery) ? $aQuery['ssl_validation_id'] : false;
}