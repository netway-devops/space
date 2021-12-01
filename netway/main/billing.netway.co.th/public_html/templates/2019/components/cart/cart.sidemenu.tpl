{if $step!=5 && $step!=0 && $step!=4 && !$has_own_ajax}
    <div id="floater" class="cart-summary-floater">
        <div class="card">
            <div class="card-header">{$lang.cartsum1}</div>
            <div class="card-body text-small" id="cartSummary">
                {include file='../orderpages/ajax.cart.summary.tpl'}
            </div>
        </div>
    </div>
{/if}
