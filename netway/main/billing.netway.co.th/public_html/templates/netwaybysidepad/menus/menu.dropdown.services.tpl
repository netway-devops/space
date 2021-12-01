
<div class="submenu">
    <div class="submenu-header">
        <h4>{$lang.my_services}</h4>
        {if $offer_total>0}
            <p>{$lang.my_servicesinfo}</p>
        </div>
        <!-- First box with links-->
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    {foreach from=$offer item=offe}
                        {if $offe.total>0}
                            <li><a href="{$ca_url}clientarea/services/{$offe.slug}/">{$offe.name} ({$offe.total})<span></span></a></li>
                            {/if}
                        {/foreach}
                        {if $offer_domains}
                        <li><a href="{$ca_url}clientarea/domains">{$lang.domains} ({$offer_domains})<span></span></a></li>
                        {/if}
                </ul>
            </div>
        </div>
    {else}
        <p>{$lang.servicesintroduction}</p>
    </div>
    <div class="center-btn">
        <a href="index.php?/cart/" class="btn support-btn l-btn">
            <i class="icon-support-home"></i>
            {$lang.proceedtocart}
        </a>
    </div>
{/if}
</div>