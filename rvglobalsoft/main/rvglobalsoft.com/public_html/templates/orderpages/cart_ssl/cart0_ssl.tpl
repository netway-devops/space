{php}
    include_once $this->template_dir . '/cart_ssl/cart0_ssl.tpl.php';
{/php}
<div id="tabs_home" class="clrmargin">
    <div class="content">
        <h2>Choose our desired SSL Certificates</h2>
            There are different types of SSL Certificates in the market today. 
            Also, the trustworthiness of individual providers is also diverse across different industries. 
            Choose either your preferred validation process or providers below:
     </div>    
    <table width="90%" cellpadding="10" cellspacing="10" class="marl ssl-validation">
        <tr>
            <th style="width: 50%; text-align: left;">Validation Process</th>
            <th style="width: 50%; text-align: left;">Providers</th>
        </tr>
        <tr>
            <td valign="top">
                {foreach from=$aSSLValidation key="k" item="v"}
                    <div align="left">
                        <a href="{$ca_url}cart/ssl&amp;rvaction=showitem&amp;showby=validation&amp;id={$k}" class="link">{$v}</a>
                    </div>
                {/foreach}
            </td>
            <td valign="top">
                {foreach from=$aSSLAuthority key="k" item="v"}
                    <div align="left">
                        <a href="{$ca_url}cart/ssl&amp;rvaction=showitem&amp;showby=authorities&amp;id={$v->ssl_authority_id}" class="link">{$v->authority_name}</a>
                    </div>
                {/foreach}
            </td>
        </tr>
    </table>
</div>