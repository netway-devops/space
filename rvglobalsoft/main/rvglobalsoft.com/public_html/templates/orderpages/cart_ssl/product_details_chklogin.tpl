{php}
include_once $this->template_dir . '/cart_ssl/product_details_chklogin.tpl.php';
{/php}
{if $chksession}
    {include file='cart_ssl/product_details.tpl'}
{else}
    {include file='cart_ssl/product_login.tpl'}
{/if}
