<section class="domain-spotlight mt-4">
    <div class="row">
        {foreach from=$cart.category.products item=tld}
            {if "featured"|in_array:$tld.tags}
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card text-center mb-3 shadow border-0">
                        <div class="card-body">
                            <h3 class="card-title">{$tld.name}</h3>
                        </div>
                        <div class="card-footer bg-primary text-white">
                            {foreach from=$tld.periods item=period}
                                {if $period.register != -1}
                                    <span class="mode mode-register">
                                        {if $period.before && $period.before != -1}
                                            <span class="font-weight-normal mr-2 text-light">
                                                <span class="spotlight-price"><del>{$period.before|price}</del></span>
                                            </span>
                                        {/if}
                                        <span class="font-weight-bold">
                                            {if $period.register == 0}
                                                <span class="spotlight-price free">{$lang.free}</span>
                                            {else}
                                                <span class="spotlight-price">{$period.register|price}</span>
                                            {/if}
                                        </span>
                                    </span>
                                    {break}
                                {/if}
                            {/foreach}
                            {foreach from=$tld.periods item=period}
                                {if $period.transfer != -1}
                                    <span class="mode mode-transfer">
                                        <span class="font-weight-bold">
                                            {if $period.transfer == 0}
                                                <span class="spotlight-price free">{$lang.free}</span>
                                            {else}
                                                <span class="spotlight-price">{$period.transfer|price}</span>
                                            {/if}
                                        </span>
                                    </span>
                                    {break}
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/if}
        {/foreach}
    </div>
</section>