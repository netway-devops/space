{if $step!=5 && $step!=0}
    {if $step>2 && (!$cart_contents[2] || $cart_contents[2][0].action == 'hostname')}
        {assign var='pclass' value='asw3'}
    {elseif $step==1 || $cart_contents[2]} 
        {assign var='pclass' value='asw5'}  
    {/if}
    <ul id="progress" class="{$pclass}">
        {if $pclass=='asw5'}        
            <li class="firstone {if $step>1}fison2{/if} {$pclass}">         
                {if $step>1}<a href="{$ca_url}cart&step=1">{$lang.mydomains}</a>
                {else}{$lang.mydomains}
                {/if}
            </li>
            <li class="{$pclass} {if $step==2}ison1{elseif $step>2}ison2{/if}"> 
                {if $step>2}<a href="{$ca_url}cart&step=2">{$lang.productconfig2}</a>
                {else}{$lang.productconfig2}
                {/if}
            </li>                   

            <li class="{if $step==3}ison1{elseif $step>3}ison2{/if} {$pclass}"> 
                {if $step>3}<a href="{$ca_url}cart&step=3">{$lang.productconfig}</a>
                {else}{$lang.productconfig}
                {/if}
            </li>   
        {elseif $pclass=='asw3'}
            <li class="firstone {if $step>3}fison2{/if}  {$pclass}">
                {if $step>3}<a href="{$ca_url}cart&step=3">{$lang.productconfig}</a>
                {else}{$lang.productconfig}
                {/if}
            </li>
        {/if}

        <li class="{$pclass} {if $step==4}ison1{elseif $step>3}ison2{/if}">
            {$lang.ordersummary}
        </li>

        <li class="lastone {$pclass}">
            {$lang.checkout}
        </li>
    </ul>

{/if}

{if $step>0 && $step<4}
    <style type="text/css">
        {literal}
            #cont {
                width:50% !important;
            }
            #progress a{
                color: inherit
            }
            /* ulli+description display fix*/
            ul li dl dd, #product_description ol{
                display:none;
            }
        {/literal}
    </style>
{/if}