	{include file='dedicated/cart_header.tpl'}


		{if $paymodule}<br />
<br />

<center>
{$lang.redirection}<br />
<img src="{$template_dir}img/ajax-loading.gif" /><br />
{$paymodule}</center>

{elseif $thanks}

<h1 class="cart2">{$lang.order_ok}</h1>

<p>{$lang.order_thanks}</p>


<h2>{$lang.order_num} {$order_num}</h2>

<p>{$lang.order_thanks2}</p>
{/if}
	{include file='dedicated/cart_footer.tpl'}