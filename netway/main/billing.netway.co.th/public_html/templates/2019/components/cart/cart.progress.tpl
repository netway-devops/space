<div class="row">
    <div class="col-12">
        {if $step!=5 && $step!=0}
            {if $step>2 && (!$cart_contents[2] || $cart_contents[2][0].action == 'hostname')}
                {assign var='pclass' value='asw3'}
            {elseif $step==1 || $cart_contents[2]}
                {assign var='pclass' value='asw5'}
            {/if}
            <ul id="progress" class="cart-progress d-none d-lg-flex">
                {if $pclass=='asw5'}
                    <li class="progress-dot {if $step==1}active{elseif $step>1}completed{/if}">
                        {if $step>1}<a href="{$ca_url}cart&step=1">{$lang.mydomains}</a>
                        {else}{$lang.mydomains}
                        {/if}
                    </li>
                    <li class="progress-dot {if $step==2}active{elseif $step>2}completed{/if}">
                        {if $step>2}<a href="{$ca_url}cart&step=2">{$lang.productconfig2}</a>
                        {else}{$lang.productconfig2}
                        {/if}
                    </li>
                {/if}
                <li class="progress-dot {if $step==3}active{elseif $step>3}completed{/if}">
                    {if $step>3}<a href="{$ca_url}cart&step=3">{$lang.productconfig}</a>
                    {else}{$lang.productconfig}
                    {/if}
                </li>
                <li class="progress-dot {if $step==4}active{elseif $step>3}completed{/if}">
                    {$lang.ordersummary}
                </li>
                <li class="progress-dot">
                    {$lang.checkout}
                </li>
            </ul>
        {/if}
    </div>
</div>