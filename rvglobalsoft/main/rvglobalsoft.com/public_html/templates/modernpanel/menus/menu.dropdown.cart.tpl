<div class="dropdown-menu submenu">
    <div class="wrapper">
        <h3>{$lang.placeorder}</h3>
        {*<p>{$lang.checkoffersphrase}</p>*}
        <ul class="nav nav-pills nav-stacked submenu-account-nav">
            {foreach from=$orderpages item=op name=loop}
                {if $smarty.foreach.loop.index % 2 == 0}
                <li>
                    <a href="{$ca_url}cart/{$op.slug}/">{$op.name}</a>
                </li>
                {/if}
            {/foreach}
        </ul>
        <ul class="nav nav-pills nav-stacked submenu-account-nav">
            {foreach from=$orderpages item=op name=loop}
                {if $smarty.foreach.loop.index % 2 == 1}
                <li>
                    <a href="{$ca_url}cart/{$op.slug}/">{$op.name}</a>
                </li>
                {/if}
            {/foreach}
        </ul>
        <div class="cart-pos">
            <a href="{$ca_url}cart/" class="btn c-cart-btn"><i class="icon-c-cart"></i>{$lang.proceedtocart}</a>
        </div>
        <div class="submenu-order-bg"></div>
    </div>
</div>