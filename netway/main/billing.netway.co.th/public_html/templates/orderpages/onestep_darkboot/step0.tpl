<div class="light-shadow center"></div>
<!-- Sliders -->
<div class="sliders clearfix">
    <ul class="levels-list left">
        <li>{$lang.maximum}</li>
        <li></li>
        <li class="small-line"></li>
        <li></li>
        <li class="small-line"></li>
        <li></li>
        <li class="small-line"></li>
        <li></li>
        <li class="small-line"></li>
        <li></li>
        <li class="small-line"></li>
        <li></li>
        <li class="small-line"></li>
        <li></li>
        <li class="small-line"></li>
        <li></li>
        <li>{$lang.minimum}</li>
    </ul>

    <!-- Slider #1 -->
    {include file="onestep_darkboot/verticalslider.tpl" slider_num=0}

    <!-- Slider #2 -->
    {include file="onestep_darkboot/verticalslider.tpl" slider_num=1}

    <!-- Slider #3 -->
    {include file="onestep_darkboot/verticalslider.tpl" slider_num=2}

</div>

<!-- Server Purpose & Billing -->
<div class="server-info clearfix">
    <div id="current_total" class="current-total">
        <span>{$lang.currenttotal}</span>
        <p>
        {if $tax}
            {if $tax.total>9999}{$tax.total|price:$currency:true:false:false:0}
            {else}{$tax.total|price:$currency:true:false:false|regex_replace:'/\d+$/':''}<small>{$tax.total|price:$currency:true:false:false:2|regex_replace:'/.*(\d\d)$/':'$1'}</small>
            {/if}
        {elseif $credit}
            {if $credit.total>9999}{$tax.total|price:$currency:true:false:false:0}
            {else}{$credit.total|price:$currency:true:false:false|regex_replace:'/\d+$/':''}<small>{$tax.total|price:$currency:true:false:false:2|regex_replace:'/.*(\d\d)$/':'$1'}</small>
            {/if}
        {else}
            {if $subtotal.total>9999}{$tax.total|price:$currency:true:false:false:0}
            {else}{$subtotal.total|price:$currency:true:false:false|regex_replace:'/\d+$/':''}<small>{$tax.total|price:$currency:true:false:false:2|regex_replace:'/.*(\d\d)$/':'$1'}</small>
            {/if}
        {/if}
        </p>
    </div>
    {counter name=billingcycles start=0 print=false assign=billingcycles}
    {foreach from=$product item=p_price key=p_cycle}
        {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
            {if $p_price > 0}
                {counter name=billingcycles}
            {/if}
        {/if}
    {/foreach}
    {if $billingcycles==2}
    <div class="billing-option">
        <p>{$lang.billoptions}</p>
        <div class="billing-slider">
            {counter name=cyclect start=0 print=false assign=cyclect}
            {foreach from=$product item=p_price key=p_cycle}
                {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                    {if $p_price > 0}
                        <div class="billing-mask{if $cyclect>0}-right{else}-left{/if}">
                            <div class="billing{if $cyclect>0}-right{else}-left{/if}-option {if $cycle==$p_cycle}active-billing{/if}" rel="{$p_cycle}">
                                <span class="text-center">{$lang.$p_cycle}</span>
                            </div>
                        </div>
                        {counter name=cyclect}
                    {/if}
                {/if}
            {/foreach}
        </div>
    </div>
    {/if}
</div>