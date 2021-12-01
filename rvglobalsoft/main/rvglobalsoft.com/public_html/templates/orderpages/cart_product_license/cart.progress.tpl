{if $step>0 && $step<4}
<style type="text/css">
{literal}
#cont {
    width:58% !important;
}
/* ulli+description display fix*/
ul li dl dd, #product_description ol{
    display:none;
}
{/literal}
</style>
{/if}

{if $step!=5 && $step!=0}

    {if $step>2 && (!$cart_contents[2] || $cart_contents[2][0].action == 'hostname')}
    {assign var='pclass' value='asw3'}
    {elseif $step==1 || ($cart_contents[2] && $cart_contents[2][0].action!='own')} 
    {assign var='pclass' value='asw5'}
    {elseif $step>1 && $cart_contents[2][0].action=='own'} 
    {assign var='pclass' value='asw4'}
    {/if}
    
    <center>
        <ul id="progress">
            
            
            {if $pclass!='asw3'}        
            <li class="firstone {if $step>1}fison2{/if} {$pclass}">         
                {$lang.mydomains}
            {elseif $pclass=='asw3'}
            <li class="firstone {if $step>3}fison2{/if}  {$pclass}">        
                    {$lang.productconfig}
            {/if}
            </li>
            
            
            
            {if $pclass=='asw5'}    
                <li class="{$pclass} {if $step==2}ison1{elseif $step>2}ison2{/if}">             
                {$lang.productconfig2}
                </li>
            {elseif $pclass=='asw4'}            
                <li class="{$pclass} {if $step==3}ison1{elseif $step>3}ison2{/if} ">                
                {$lang.productconfig}
                </li>                       
            {/if}
                
        {if $pclass=='asw5'}    
            <li class="{if $step==3}ison1{elseif $step>3}ison2{/if} {$pclass}">             
                {$lang.productconfig}
                </li>                       
            {/if}
            
            
            
            
            <li class="{$pclass} {if $step==4}ison1{elseif $step>3}ison2{/if}">
            {$lang.ordersummary}
            </li>
            
            <li class="lastone {$pclass}">
            {$lang.checkout}
            </li>
            
            
        
        </ul>
    <div class="clear"></div> 
    </center>

{/if}

