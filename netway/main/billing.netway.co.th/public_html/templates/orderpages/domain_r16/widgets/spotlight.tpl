<div class="domain-spotlight">
    {foreach from=$cart.category.products item=tld}
        {if "featured"|in_array:$tld.tags}
            <div class="spotlight-product">
                <div class="spotlight-name">
                    <span>{$tld.name}</span>
                </div>
                <div class="spotlight-footer">
                    {foreach from=$tld.periods item=period}
                        {if $period.register != -1}
                            <span class="mode mode-register">
                                {if $period.register == 0}<span class="spotlight-price free">{$lang.free}</span>
                                {else}<span class="spotlight-price">{$period.register|price}</span>
                                {/if}
                                <span class="spotlight-period" >{$period.title}</span>
                            </span>
                            {break}
                        {/if}
                    {/foreach}
                    {foreach from=$tld.periods item=period}
                        {if $period.transfer != -1}
                            <span class="mode mode-transfer">
                                {if $period.transfer == 0}<span class="spotlight-price free">{$lang.free}</span>
                                {else}<span class="spotlight-price">{$period.transfer|price}</span>
                                {/if}
                                <span class="spotlight-period" >{$period.title}</span>
                            </span>
                            {break}
                        {/if}
                    {/foreach}
                </div>
            </div>
        {/if}
    {/foreach}
</div>