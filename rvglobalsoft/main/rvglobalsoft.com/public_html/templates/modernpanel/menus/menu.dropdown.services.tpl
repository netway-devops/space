<div class="dropdown-menu submenu">
    <div class="wrapper">
        <h3>{$lang.my_services}</h3>
        <ul class="nav nav-pills nav-stacked submenu-nav">
            {foreach from=$offer item=offe}
                {if $offe.total>0}
                    <li><a href="{$ca_url}clientarea/services/{$offe.slug}/">{$offe.name} <span class="pull-right">{$offe.total}</span></a></li>
                {/if}
            {/foreach}
            {if $offer_domains}
                <li><a href="{$ca_url}clientarea/domains/">{$lang.domains}  <span class="pull-right">{$offer_domains}</span></a></li>
            {/if}
        </ul>
        <div class="submenu-services-bg"></div>
    </div>
</div>