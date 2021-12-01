{if 'config:ShopingCartMode'|checkcondition}
    <div class="pull-right cart-list">
    <div class="lang-bg">
        <div class="btn-group">
            <a href="{$ca_url}cart/" class="clearstyle btn dropdown-toggle cart-popover"{if $shoppingcart}data-toggle="dropdown"{/if}>
                {$lang.cart}
                {if $shoppingcart}<span class="caret"></span>{/if}
            </a>
            {if $shoppingcart}
                <ul class="dropdown-menu">
                    <li class="header">Items in cart</li>
                    {foreach from=$shoppingcart item=order key=k}
                        {if $order.product}
                            <li>
                                <a href="{$ca_url}cart&cart=edit&order={$k}">
                                    <span class="pull-right">{$order.total.total|price:$currency}</span>
                                    <div>
                                        {$order.product.category_name} - {$order.product.name}
                                        {if $order.product.domain}({$order.product.domain})
                                        {/if}
                                    </div>
                                </a> 

                            </li>           
                        {elseif $order.domains }
                            {foreach from=$order.domains item=domenka key=kk}
                                <li>
                                    <a href="{$ca_url}cart&cart=edit&order={$k}">
                                        <span class="pull-right">{$domenka.price|price:$currency}</span>
                                        <div>
                                            {if $domenka.action=='register'}{$lang.domainregister}
                                            {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                            {elseif $domenka.action=='renew'}{$lang.domainrenewal}
                                            {/if}
                                            - {$domenka.name} - {$domenka.period} {$lang.years}</div>
                                    </a> 
                                </li>           
                            {/foreach}
                        {/if}
                    {/foreach}

                </ul>
            {/if}
        </div>
    </div>
</div>
        {/if}