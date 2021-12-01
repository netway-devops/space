{if 'config:ShopingCartMode'|checkcondition}
<div class="dropdown cart-dropdown">
    <button class="btn btn-success dropdown-toggle cart-dropdown-grp" data-toggle="dropdown">
        <i class="icon icon-shopping-cart icon-white"></i> {$lang.cart}
        <span class="caret"></span>
    </button>
    <div class="dropdown-menu">
        <div class="cntn"><div class="row">
                <div class="span8">
                    <div class="row ">
                        <div class="span5">
                            <ul class="span5">
                                {if $shoppingcart}
                                    <li class="nav-header span5">{$lang.itemscart}</li>
                                        {foreach from=$shoppingcart item=order key=k}
                                            {if $order.product}
                                            <li>
                                                <a href="{$ca_url}cart&cart=edit&order={$k}">
                                                    <span class="counter">{$order.total.total|price:$currency:true:true}</span>
                                                    <span class="text-overflow">
                                                        {$order.product.category_name} - {$order.product.name}
                                                        {if $order.product.domain}({$order.product.domain})
                                                        {/if}
                                                    </span>
                                                </a> 
                                            </li>           
                                        {elseif $order.domains }
                                            {foreach from=$order.domains item=domenka key=kk}
                                                <li>
                                                    <a href="{$ca_url}cart&cart=edit&order={$k}">
                                                        <span class="counter">{$domenka.price|price:$currency:true:true}</span>
                                                        <span class="text-overflow">
                                                            {if $domenka.action=='register'}{$lang.domainregister}
                                                            {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                                            {elseif $domenka.action=='renew'}{$lang.domainrenewal}
                                                            {/if}
                                                            - {$domenka.name} - {$domenka.period} {$lang.years}
                                                        </span>
                                                    </a> 
                                                </li>           
                                            {/foreach}
                                        {/if}

                                    {/foreach}
                                {else}
                                    <li class="nav-header span5">{$lang.yourcartisempty}</li>
                                    <li class="span5">&nbsp;</li>
                                    <li class="span5"><button class="btn btn-success" href="{$ca_url}cart/"><i class="icon-shopping-cart icon-white"></i> {$lang.placeorder}</button></li>
                                    {/if}
                            </ul>
                        </div>
                        <div class="span3">
                            <center>
                                <div class="iconwrap"><span class="iconfont-price-tag iconfont-size5 silver" style=""></span><br></div>
                                    {if $shoppingcart}
                                    <p class="silver"></p>
                                    <button class="btn btn-success" href="{$ca_url}cart/"><i class="icon-shopping-cart icon-white"></i> {$lang.proceedtocart}</button>
                                {/if}
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>        
    </div>
</div>
{/if}