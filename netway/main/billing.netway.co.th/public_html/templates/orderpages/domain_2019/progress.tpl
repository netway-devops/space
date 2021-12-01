<div class="row mb-5">
    <div class="col-12 justify-content-center my-3">
        <div class="rounded d-flex flex-row justify-content-center align-items-center step-boxes shadow border-top border-left border-right mb-4">
            <a {if $step>1} href="{$ca_url}cart&step=1" {elseif $is_cart_summary || $step==4}href="{$ca_url}cart/{$category.slug}"{/if} class="d-flex flex-column w-33 justify-content-center align-items-center">
                <span  class="step-box w-100 py-3 py-md-4 step-box-arrow text-center border-bottom border-top-0 border-left-0 border-right-0 {if $step==1 && !$is_cart_summary}active text-primary border-primary{elseif $step>1 || $is_cart_summary}success text-success border-success{else}text-muted border-white{/if} ">
                    <span class="d-none d-md-inline-block material-icons mr-3">http</span>
                    {$lang.mydomains}
                </span>
            </a>
            <a {if $step>2} href="{$ca_url}cart&step=2" {elseif $is_cart_summary || $step==4}href="{$ca_url}cart&cart=edit&order=0"{/if} class="d-flex flex-column w-33 justify-content-center align-items-center">
                <span class="step-box w-100 py-3 py-md-4 step-box-arrow text-center border-bottom border-top-0 border-left-0 border-right-0 {if $step==2 && !$is_cart_summary}active text-primary border-primary{elseif $step>2 || $is_cart_summary}success text-success border-success{else}text-muted border-white{/if}">
                    <span class="d-none d-md-inline-block material-icons mr-3">dns</span>
                    {$lang.productconfig2}
                </span>
            </a>
            <div class="d-flex flex-column w-33 justify-content-center align-items-center">
                <div class="step-box w-100 py-3 py-md-4 text-center border-bottom border-top-0 border-left-0 border-right-0 {if $is_cart_summary || $step==4}active text-primary border-primary{else}text-muted border-white{/if}">
                    <span class="d-none d-md-inline-block material-icons mr-3">shopping_cart</span>
                    <span >{$lang.ordersummary}</span>
                </div>
            </div>
        </div>
    </div>
</div>