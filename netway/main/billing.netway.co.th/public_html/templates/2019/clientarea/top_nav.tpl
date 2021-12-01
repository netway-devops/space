{if $nav_type == 'billing'}
    {assign var='nav_items' value=','|explode:"invoices,creditreceipts,addfunds,ccard,ach,estimates,creditlogs"}
{elseif $nav_type == 'details'}
    {assign var='nav_items' value=','|explode:"overview,details,profilepassword,password,settings"}
{elseif $nav_type == 'history'}
    {assign var='nav_items' value=','|explode:"logs,emails,creditlogs,portal_notifications"}
{/if}

<div class="nav-tabs-wrapper">
    <ul class="nav nav-tabs d-flex justify-content-between align-items-center flex-nowrap">
        <li>
            <ul class="nav nav-slider flex-nowrap">
                {foreach from=$nav_items item=nav_item}
                    {assign var="link" value=$sitemap.account.pages.$nav_item}
                    {if $link.visible}
                        <li class="nav-item {if $link.active} active {/if}">
                            <a href="{$link.url}" class="nav-link">
                                {if $lang[$link.alt_lang]}
                                    {$lang[$link.alt_lang]}
                                {else}
                                    {$lang[$link.lang]}
                                {/if}
                            </a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        </li>
        {if $action == 'invoices' || $action == 'creditreceipts'}
            <li>
                <ul class="nav">
                    <li>
                        <button class="btn btn-sm btn-secondary dropdown-toggle ml-3" id="service-filters" data-box="service-filters-box" type="button">
                            {$lang.filterdata}
                        </button>
                    </li>
                </ul>
            </li>
        {/if}
    </ul>
</div>
