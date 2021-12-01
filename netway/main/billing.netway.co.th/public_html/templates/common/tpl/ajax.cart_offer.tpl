{if $cart_offer_active}
    <div class="clearfix cart-offer active">
        <div class="cart-offer-act pull-right">
            <a href="{$ca_url}cart/{if $step}&step={$step}{/if}&action=offer&disable"
               class="btn btn-xs btn-small btn-danger">{$lang.disable_offer}</a>
        </div>
        <div class="cart-offer-title">
            <strong>{$cart_offer.name}</strong>
        </div>
        {if $cart_offer.cartcode}
            <div class="cart-offer-body">
                {$cart_offer.cartcode}
            </div>
        {/if}
        <div class="cart-offer-items">
            {foreach from=$cart_offer.items item=item}
                <div class="cart-offer-item well card">
                    <div class="offer-item-body card-body">
                        <div class="offer-item-title">
                            {if $item.offer_type == 'domain'}
                                {$lang.offer_free_domain|sprintf:$item.name}
                            {elseif $item.offer_type == 'tld'}
                                {$lang.offer_free_tld|sprintf:$item.name}
                            {else}
                                {$lang.offer_free_product|sprintf:$item.name}
                            {/if}
                        </div>
                        <a href="{$ca_url}cart/{if $step}&step={$step}{/if}&action=claim&item={$item.offer_key}"
                           class="btn btn-primary">{$lang.offer_claim_item}</a>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
{else}
    {foreach from=$cart_offers item=cart_offer name="offer"}
        {if !$smarty.foreach.offer.first}
            <hr/>
        {/if}
        <div class="cart-offer clearfix">
            <div class="cart-offer-act pull-right">
                <a href="{$ca_url}cart/&action=offer&enable={$cart_offer.token}"
                   data-token="{$cart_offer.token}"
                   class="btn btn-primary">{$lang.enable_offer}</a>
            </div>
            <div class="cart-offer-title">
                <strong>{$cart_offer.name}</strong>
            </div>
            {if $cart_offer.cartcode}
                <div class="cart-offer-body">
                    {$cart_offer.cartcode}
                </div>
            {/if}
        </div>
    {/foreach}
{/if}
