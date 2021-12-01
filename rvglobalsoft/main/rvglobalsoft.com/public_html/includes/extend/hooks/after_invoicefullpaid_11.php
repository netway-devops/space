<?php 
/**
 * Invoice has been fully paid
 * Following variable is available to use in this file:  $details This array of invoice details contains following keys:
 * $details["id"]; // Invoice id
 * $details["status"]; //Current invoice status
 * $details["client_id"]; //Owner of invoice
 * $details["date"]; //Invoice generation date
 * $details["subtotal"]; //Subtotal
 * $details["credit"]; //Credit applied to invoice
 * $details["tax"]; //Tax applied to invoice
 * $details["total"]; //Invoice total
 * $details["payment_module"]; //ID of gateway used with invoice
 * $details["currency_id"]; //ID of invoice currency, default =0
 * $details["notes"]; //Invoice notes
 * $details["items"]; // Invoice items are listed under this key, sample item:
 * $details["items"][0]["type"]; //Item type (ie. Hosting, Domain)
 * $details["items"][0]["item_id"]; //Item id, for type=Hosting this relates to hb_accounts.id field
 * $details["items"][0]["description"]; //Item line text
 * $details["items"][0]["amount"]; //Item price
 * $details["items"][0]["taxed"]; //Is item taxed? 1/0
 * $details["items"][0]["qty"]; //Item quantitiy
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


echo <<<EOF
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga_inv');

ga_inv('create', 'UA-90549966-1', 'auto', {'allowLinker': true});
ga_inv('require', 'linker');
ga_inv('linker:autoLink', ['rvglobalsoft.com', 'rvsitebuilder.com', 'rvskin.com', 'rvssl.com', 'rvlogin.technology'] );
ga_inv('send', 'pageview');
ga_inv('require', 'ecommerce');
ga_inv('ecommerce:addTransaction', {
	'id': '{$details["id"]}',
	'affiliation': 'rvglobalsoft.com',
	'revenue': '{$details["total"]}',
	'shipping': '',
	'tax': '{$details["tax"]}'
});
	
EOF;
	
foreach($details["items"] as $foo){
	echo <<<EOF
ga_inv('ecommerce: addItem', {
	'id': '{$details["id"]}',
	'name': '{$foo["description"]}',
	'sku': '',
	'category': '{$foo["type"]}',
	'price': '{$foo["amount"]}',
	'quantity': '{$foo["qty"]}'
			
});
	
EOF;
}

echo <<<EOF
ga_inv('ecommerce:send');

</script>
EOF;

