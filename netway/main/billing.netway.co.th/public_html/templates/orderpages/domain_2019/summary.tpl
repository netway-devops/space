<div class="domain-search-summary domain-search-summary-sticky bg-transparent" id="domain-search-summary">
    <div class="bg-white shadow border p-2">
        <div class="domain-search-summary-details"></div>
        <div class="domain-search-summary-content d-flex flex-row align-items-center justify-content-between">
            <div class="w-0 w-md-auto mr-2 d-none d-md-inline-block">
                <span class="domain-search-summary-content-count">0</span>
                {$lang.domains}
            </div>
            <div class="w-100 w-md-auto d-flex flex-column flex-md-row align-items-center justify-content-between">
                <div class="mr-0 mr-md-3 mb-2 mb-md-0 d-flex flex-row align-items-center justify-content-between w-100">
                    <div class="domain-search-summary-total">
                        <div class="text-primary h2 mb-0 text-nowrap domain-search-summary-content-total"></div>
                    </div>
                    <a class="mx-0 mx-md-2 small domain-search-summary-details-btn" href="#">
                        <i class="d-none d-md-inline-block material-icons text-primary domain-tld-checkbox-icon">info</i>
                        <span>{$lang.show_details}</span>
                    </a>
                </div>
                <div class="domain-order w-100 w-md-auto">
                    <a class="btn btn-success w-100 p-2 px-md-3 py-md-2 btn-summary-continue"
                            {if $step == 0}
                        href="{$system_url}{$ca_url}cart/&cat_id=domains"
                            {elseif $step == 2}
                        href="#continue" onclick="$('#cart3').submit(); return false;"
                            {elseif $step == 3}
                        href="#continue" onclick="$('#cart3').submit(); return false;"
                            {elseif $step == 4}
                        href="#continue" onclick="$('#subbmitorder').submit(); return false;"
                            {/if}>
                        <i class="material-icons">shopping_cart</i>
                        {if $step == 0}
                            <span class="cart-order-txt">{$lang.orderselecteddomains}</span>
                        {else}
                            <span class="cart-order-txt">{$lang.continue}</span>
                        {/if}
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>