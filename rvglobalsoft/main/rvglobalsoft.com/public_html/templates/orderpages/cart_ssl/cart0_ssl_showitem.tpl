{if $REQUEST.showby=='validation'}
    {php}
        include_once $this->template_dir . '/cart_ssl/cart0_ssl_showitem_byvalidation.tpl.php';
    {/php}
{else}
    {php}
        include_once $this->template_dir . '/cart_ssl/cart0_ssl_showitem_byauthority.tpl.php';
    {/php}
{/if}
{php}
    include_once $this->template_dir . '/order_coupon.tpl.php';
{/php}

<div id="tabs_home">
    <ul class="tabs_product">
{foreach from=$aGroup key="k" item="v"}
        <li style="margin-bottom:15px; display:block; float:left;"><a href="javascript:showTable('{$k}');">{$v}</a></li>
{/foreach}
    </ul>
    <br clear="all" />
    <p style="text-align: center; font-weight: bold;">[ 
{if $REQUEST.showby == 'validation'}
        <a href="{$ca_url}cart/ssl&amp;rvaction=showitem&amp;showby=authorities">Show by Authorities</a>
{else}
        <a href="{$ca_url}cart/ssl&amp;rvaction=showitem&amp;showby=validation">Show by Validation</a>
{/if}
    ]</p>
    
{foreach from=$aSSLItemList key="k" item="v"}
    <div id="show_{$k}" class="tbl_product fix-table">
    <h2>See your price listed sorted by provider lists below:</h2>
    <table width="100%">
        <thead>
            <tr>
                <th>
    {if $REQUEST.showby=='validation'}
                    <strong>{$v->validation_name}</strong>
    {else}
                        <img src="{$template_dir}images/ssl/logo_{$k}.jpg" 
                        alt="{$v->authority_name}" title="{$v->authority_name}"/>
    {/if}
                </th>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <th>
                    <div>{$cv->ssl_name}</div>
                    <div>
        {if $REQUEST.showby=='validation'}
                        <img src="{$template_dir}images/ssl/logo_{$cv->ssl_authority_id}.jpg"
                            alt="" title="" />
        {/if}
                    </div>
                </th>
    {/foreach}
            </tr>
            <tr class="nonebdr">
                <td><strong>Price</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td valign="top">
        {foreach from=$cv->_Price key="pk" item="pv"}
                    <div>${$pv->price}/{$pv->contract}</div>
        {/foreach}
                <div>
                    {php}
                        order_coupon::singleton()->displayCoupon(0, $this->_tpl_vars[cv]->pid);
                    {/php}
                </div>
                </td>
    {/foreach}
            </tr>
			<tr class="odd">
                <td>&nbsp;</td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td valign="top">
                    <div align="center" style="margin:5px 0;">
                        <a href="{$ca_url}cart/ssl&amp;rvaction=preorder&amp;ssl_id={$cv->ssl_id}" class="btn-sslorder">Order</a> 
                    </div>
                </td>
    {/foreach}
            </tr>
        </thead>
        <tbody>
            <tr class="even">
                <td><strong>Warranty</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td >{$cv->warranty} USD</td>
    {/foreach}
            </tr>
            <tr class="odd">
                <td><strong>Multi domain</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
        {assign var="multidomainid" value=$cv->ssl_multidomain_id}
                <td>{$aMultidomain->$multidomainid}</td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Issuance Time</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td>{$cv->issuance_time}</td>
    {/foreach}
            </tr>
            <tr class="odd">
                <td><strong>Key Length</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td>{$cv->key_length}</td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Encryption Strength</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td>{$cv->encryption}</td>
    {/foreach}
            </tr>
            <tr class="odd">
                <td><strong>Reissue</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->reissue}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Green Address Bar</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->green_addressbar}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="odd">
                <td><strong>Secure Sub-domain</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->secure_subdomain}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Non-FQDN Domain (for intranet)</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->non_fqdn}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="odd">
                <td><strong>Mobile Support</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->mobile_support}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Licensing for multiple servers</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->licensing_multi_server}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="odd">
                <td><strong>International domain name support(IND)</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->ind}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Installation Checker</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td>
        {assign var="authority_id" value=$cv->ssl_authority_id}
                <a href="{$aInstallChk.$authority_id}" title="Installation Checker" target="_blank">
                    <img src="{$template_dir}images/ssl/install_chk.jpg" title="Installation Checker" />
                </a>
                </td>
    {/foreach}
            </tr>
            <tr class="odd">
                <td><strong>Support for SAN(UC)</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->uc}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Malware Scaning</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->malware_scan}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="onHidden odd">
                <td><strong>Seal-in-Search</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td><img src="{$template_dir}images/action_{$cv->seal_in_search}.gif" /></td>
    {/foreach}
            </tr>
            <tr class="even">
                <td><strong>Trust Site Seal</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td>
        {assign var="authority_id" value=$cv->ssl_authority_id}
        {foreach from=$aSiteseal key="sk" item="sv"}
            {if $sv->ssl_authority_id==$authority_id}
                {assign var="install_siteseal" value=$sv->install_url}
                {break}
            {/if}              
        {/foreach}
                    <a href="{$install_siteseal}">
                    <img src="{$template_dir}images/ssl/siteseal_{$authority_id}.jpg" 
                        alt="{$aSSLAuthority.$authority_id} Siteseal" 
                        title="{$aSSLAuthority.$authority_id} Siteseal" width="42" />
                    </a>
                </td>
    {/foreach}
            </tr>
             <tr class="nonebdr">
                <td><strong>Price</strong></td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td valign="top">
        {foreach from=$cv->_Price key="pk" item="pv"}
                    <div>
                        ${$pv->price}/{$pv->contract}
                    </div>
        {/foreach}
                </td>
    {/foreach}
            </tr>
			<tr class="odd">
                <td>&nbsp;</td>
    {foreach from=$v->_Certificate key="ck" item="cv"}
                <td valign="top">
                     <div align="center" style="margin:5px 0;">
                        <a href="{$ca_url}cart/ssl&amp;rvaction=preorder&amp;ssl_id={$cv->ssl_id}" class="btn-sslorder">Order</a> 
                    </div>
                </td>
    {/foreach}
            </tr>
        </tbody>
    </table> 
    </div>
{/foreach}
</div>

<script type="text/javascript">
    {literal}var RVTABS_CTRL = {};{/literal}
    {foreach from=$aSSLItemList key="k" item="v"}
        RVTABS_CTRL[{$k}] = {$k};
    {/foreach}

{literal}
    function showTable(id) {
        for (k in RVTABS_CTRL) { 
            $("#show_" + k).hide();
        }
        $("#show_" + id).show();
    }
{/literal}
    showTable({$activeItem});
</script>