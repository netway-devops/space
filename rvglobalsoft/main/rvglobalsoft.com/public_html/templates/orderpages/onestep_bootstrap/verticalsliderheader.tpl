{counter name=slidercounter start=0 assign=sliders}
{counter name=hasprice start=0 assign=hasprice}
{foreach from=$custom item=cf}
    {if $sliders == $slideno && $cf.items && $cf.type == 'slider'}
        {foreach from=$cf.items item=cit}
            <div class="notable">{$cf.name}</div>
            <strong class="price" id="vertical_slider_price_{$cf.id}">
            {if $cart_contents[1]}	
                {foreach from=$cart_contents[1] item=cfc key=cfid}
                    {if $cfid == $cf.id}
                        {foreach from=$cfc item=cstom}
                            {if $cstom.total>0}
                                {if $cstom.price==0}
                                    {$lang.Free}
                                {elseif $cstom.prorata_amount}
                                    {$cstom.prorata_amount|price:$currency}
                                {else}
                                    {$cstom.price|price:$currency}
                                {/if} 
                            {/if}
                        {/foreach}
                        {counter name=hasprice}
                    {/if}
                {/foreach}
            {/if}
            {if !$hasprice}--{/if}
            </strong>
        {/foreach}
    {/if}
{counter name=slidercounter}
{/foreach}