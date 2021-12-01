{php}
    include_once $this->template_dir . '/cart_ssl/cart0_ssl_order.tpl.php';
   /* echo '<pre>';
    print_r($_SESSION['SSLITEM']);
    echo '</pre>';*/
{/php}

<form id="rv_cart" name="rv_cart" action="" method="post">
	<input name="action" type="hidden" value="add">
	<input name="id" type="hidden" value="{$pid}">
	<input name="cycle" type="hidden" value="{$cycle}">
	
</form>

<script type="text/javascript">
		$('#rv_cart').submit();
	
</script>