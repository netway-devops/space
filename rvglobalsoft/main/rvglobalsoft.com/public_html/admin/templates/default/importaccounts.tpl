<script src="{$template_dir}js/import.js?v={$hb_version}" type="text/javascript"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=importaccounts" class="tstyled {if $action != 'import_tld' && $action != 'tld_profile' && $action != 'import_products' && $action != 'products_profile'}selected{/if}">Import Services</a>
            <a href="?cmd=importaccounts&action=import_tld" class="tstyled {if $action == 'import_tld' || $action == 'tld_profile'}selected{/if}" >Import TLD prices</a>
            <a href="?cmd=importaccounts&action=import_products" class="tstyled {if $action == 'import_products' || $action == 'products_profile'}selected{/if}">Import Products</a>
        </td>
        <td valign="top" class="bordered">
            <div id="bodycont">
                <div class="newhorizontalnav" id="newshelfnav">
                    <div class="list-1">
                        <ul>
                            <li class="list-1elem {if $action == 'default'}active{/if}"><a href="?cmd=importaccounts">Import Services</a></li>
                            <li class="list {if $action == 'import_tld'}active{/if}"><a href="?cmd=importaccounts&action=import_tld">Import TLD prices</a></li>
                            <li class="list {if $action == 'import_products'}active{/if}"><a href="?cmd=importaccounts&action=import_products">Import Products</a></li>
                            {if $action == 'tld_profile'}
                                <li class="list {if $action == 'tld_profile'}active{/if}">
                                    {if $profile.id}
                                        <a href="?cmd=importaccounts&action=import_tld&id={$profile.id}">{$profile.name|truncate:30:"..."}</a>
                                    {else}
                                        <a href="?cmd=importaccounts&action=import_tld">Add new TLD profile</a>
                                    {/if}
                                </li>
                            {elseif $action == 'tld_profile_prices'}
                                <li class="list {if $action == 'tld_profile_prices'}active{/if}">
                                    <a href="#">TLD Prices: {$profile.name|truncate:30:"..."}</a>
                                </li>
                            {elseif $action == 'products_profile'}
                                <li class="list {if $action == 'products_profile'}active{/if}">
                                    {if $profile.id}
                                        <a href="?cmd=importaccounts&action=products_profile&id={$profile.id}">{$profile.name|truncate:30:"..."}</a>
                                    {else}
                                        <a href="?cmd=importaccounts&action=products_profile">Add new Product profile</a>
                                    {/if}
                                </li>
                            {/if}
                        </ul>
                    </div>
                    {if $action=='import_tld'}
                        <div class="list-2">
                            <div class="subm1 haveitems" style="">
                                <ul>
                                    <li >
                                        <a href="?cmd=importaccounts&action=tld_profile" ><span>Add new TLD profile</span></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    {elseif $action=='import_products'}
                        <div class="list-2">
                            <div class="subm1 haveitems" style="">
                                <ul>
                                    <li >
                                        <a href="?cmd=importaccounts&action=products_profile" ><span>Add new Product profile</span></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    {/if}
                </div>

                <div>
                    {if $action === 'getpackages'}
                        {include file="import/products.tpl"}
                    {elseif $action === 'accounts'}
                        {include file="import/accounts.tpl"}
                    {elseif $action === 'domains'}
                        {include file="import/domains.tpl"}
                    {elseif $action === 'result'}
                        {include file="import/result.tpl"}
                    {elseif $action === 'logs'}
                        {include file="import/logs.tpl"}
                    {elseif $action === 'import_tld'}
                        {include file="import/tld_profiles.tpl"}
                    {elseif $action === 'tld_profile'}
                        {include file="import/tld_profile.tpl"}
                    {elseif $action === 'tld_profile_prices'}
                        {include file="import/tld_profile_prices.tpl"}
                    {elseif $action === 'import_products'}
                        {include file="import/products_profiles.tpl"}
                    {elseif $action === 'products_profile'}
                        {include file="import/products_profile.tpl"}
                    {else}
                        {include file="import/servers.tpl"}
                    {/if}
                </div>
            </div>
        </td>
    </tr>
</table>