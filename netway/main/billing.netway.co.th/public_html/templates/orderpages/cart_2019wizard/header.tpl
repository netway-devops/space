{if $step!=5 && $step!=0}
    <div class="row mb-5">
        <div class="col-12 justify-content-center my-3">
            <div class="d-flex flex-row justify-content-center align-items-center step-boxes shadow border-top border-left border-right mb-4">
                {if $step>2 && (!$cart_contents[2] || $cart_contents[2][0].action == 'hostname')}
                    {assign var='pclass' value='asw3'}
                {elseif $step==1 || $cart_contents[2]}
                    {assign var='pclass' value='asw5'}
                {/if}
                {if $pclass=='asw5'}
                    <a {if $step>1} href="{$ca_url}cart&step=1"{/if} class="d-flex flex-column w-25 justify-content-center align-items-center">
                        <span  class="step-box w-100 py-4 step-box-arrow text-center border-bottom border-top-0 border-left-0 border-right-0 {if $step==1}active text-primary border-primary{elseif $step>1}success text-success border-success{else}text-muted border-white{/if} ">
                            <span class="material-icons mr-3">http</span>
                            {$lang.mydomains}
                        </span>
                    </a>
                    <a {if $step>2} href="{$ca_url}cart&step=2"{/if} class="d-flex flex-column w-25 justify-content-center align-items-center">
                        <span class="step-box w-100 py-4 step-box-arrow text-center border-bottom border-top-0 border-left-0 border-right-0 {if $step==2}active text-primary border-primary{elseif $step>2}success text-success border-success{else}text-muted border-white{/if}">
                            <span class="material-icons mr-3">dns</span>
                            {$lang.productconfig2}
                        </span>
                    </a>
                {/if}
                <a {if $step>3} href="{$ca_url}cart&step=3"{/if} class="d-flex flex-column {if $pclass=='asw5'}w-25{else}w-50{/if} justify-content-center align-items-center">
                    <span class="step-box w-100 py-4 step-box-arrow text-center border-bottom border-top-0 border-left-0 border-right-0 {if $step==3}active text-primary border-primary{elseif $step>3}success text-success border-success{else}text-muted border-white{/if}">
                        <span class="material-icons mr-3">build</span>
                        {$lang.productconfig}
                    </span>
                </a>
                <div class="d-flex flex-column {if $pclass=='asw5'}w-25{else}w-50{/if} justify-content-center align-items-center">
                    <div class="step-box w-100 py-4 text-center border-bottom border-top-0 border-left-0 border-right-0 {if $step==4}active text-primary border-primary{elseif $step>3}success text-success border-success{else}text-muted border-white{/if}">
                        <span class="material-icons mr-3">shopping_cart</span>
                        <span >{$lang.ordersummary}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}