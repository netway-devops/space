{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/cart5.tpl.php');
{/php}

<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
{if $paymodule}
    <br />
    <br />

    <center>
        {$lang.redirection}<br />
        <img src="{$template_dir}img/ajax-loading.gif" alt=""/><br />
        {$paymodule}
    </center>

{elseif $thanks}
    <h1 class="cart2">{$lang.order_ok}</h1>
    
    {if $category_name}
    {literal}
        <script type="text/javascript">
        var url = '{/literal}{$system_url}{literal}';
        var urlStep4 = url + "index.php/clientarea/services/{/literal}{$category_name}{literal}/";
        window.location.assign(urlStep4);
        </script>
    {/literal}
    {/if}
    
    <p>{$lang.order_thanks}</p>
    <h2>{$lang.order_num} {$order_num}</h2>
    <p>{$lang.order_thanks2}</p>
{/if}
<img src="?cmd=cronimg&action=afterorder" alt="" />