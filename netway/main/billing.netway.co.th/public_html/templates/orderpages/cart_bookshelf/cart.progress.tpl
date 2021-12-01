<div id="progress-indicator" class="clearfix">
    
    <div class="progress-line"><div></div></div>
    {if $step>0}<a href="{$ca_url}cart">{/if}
    <div class="step {if $step>0}progress-done{else}progress-active{/if}">
        <span class="circle"><span>{counter}</span></span><span class="header">{$lang.planselect}</span>
    </div>
    {if $step>0}</a>{/if}
    {if $step>1}<a href="{$ca_url}cart&step=1">{/if}
    <div class="step {if $step>1}progress-done{elseif $step == 1}progress-active{/if}">
        <span class="circle"><span>{counter}</span></span><span class="header">{$lang.mydomains}</span>
    </div>
    {if $step>1}</a>{/if}
    {if $step>2}<a href="{$ca_url}cart&step=2">{/if}
    <div class="step {if $step>2}progress-done{elseif $step == 2}progress-active{/if}">
        <span class="circle"><span>{counter}</span></span><span class="header">{$lang.productconfig2}</span>
    </div>
    {if $step>2}</a>{/if}
    {if $step>3}<a href="{$ca_url}cart&step=3">{/if}
    <div class="step {if $step>3}progress-done{elseif $step == 3}progress-active{/if}">
        <span class="circle"><span>{counter}</span></span><span class="header">{$lang.productconfig}</span>
    </div>
    {if $step>3}</a>{/if}
    <div class="step {if $step>4}progress-done{elseif $step == 4}progress-active{/if}">
        <span class="circle"><span>{counter}</span></span><span class="header">{$lang.ordersummary}</span>
    </div>
    <div class="step {if $step>5}progress-done{elseif $step == 5}progress-active{/if}">
        <span class="circle"><span>{counter}</span></span><span class="header">{$lang.checkout}</span>
    </div>
</div>