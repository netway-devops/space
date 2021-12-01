{php}
    include_once $this->template_dir . '/cart_ssl/cart_ssl.tpl.php';
{/php}

{if $REQUEST.rvaction == 'showitem'}
    {include file='cart_ssl/cart0_ssl_showitem.tpl'}
{elseif $REQUEST.rvaction == 'preorder'}
    {include file='cart_ssl/cart0_ssl_preorder.tpl'}
{elseif $REQUEST.rvaction == 'order'}
    {include file='cart_ssl/cart0_ssl_order.tpl'}
{elseif $REQUEST.rvaction == 'chklogin'}
    	{include file='cart_ssl/product_details.tpl'}
{else}
   	{*include file='cart_ssl/cart0_ssl.tpl'*}
   	{include file='cart_ssl/product_list.tpl'}
{/if}
