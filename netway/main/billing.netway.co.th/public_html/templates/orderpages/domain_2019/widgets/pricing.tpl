<section class="domain-price mt-4">
    <h2>{$lang.domainprices}</h2>
    <div class="table-responsive table-borders table-radius">
        <table class="table position-relative stackable">
            <thead>
            <tr>
                <th width="25%" class="bg-primary text-white">{$lang.tld}</th>
                <th width="25%" class="bg-primary text-white">{$lang.register}</th>
                <th width="25%" class="bg-primary text-white">{$lang.transfer}</th>
                <th width="25%" class="bg-primary text-white">{$lang.renew}</th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$cart.category.products item=tld}
                <tr>
                    <td class="font-weight-bold">{$tld.name}</td>
                    {foreach from=$tld.periods item=period}
                        {if $period.register != -1}
                            <td>
                                {if $period.register == 0}
                                    <span class="font-weight-bold price-amount free">{$lang.free}</span>
                                {else}
                                    <span class="font-weight-bold price-amount">{$period.register|price}</span>
                                {/if}
                            </td>
                            {break}
                        {/if}
                    {/foreach}
                    {foreach from=$tld.periods item=period}
                        {if $period.transfer != -1}
                            <td>
                                {if $period.transfer == 0}
                                    <span class="font-weight-bold price-amount free">{$lang.free}</span>
                                {else}
                                    <span class="font-weight-bold price-amount">{$period.transfer|price}</span>
                                {/if}
                            </td>
                            {break}
                        {/if}
                    {/foreach}
                    {foreach from=$tld.periods item=period}
                        {if $period.renew != -1}
                            <td class="price-renew" title="{$period.renew|price} {$period.title}">
                                {if $period.renew == 0}
                                    <span class="font-weight-bold price-amount free">{$lang.free}</span>
                                {else}
                                    <span class="font-weight-bold price-amount">{$period.renew|price}</span>
                                {/if}
                            </td>
                            {break}
                        {/if}
                    {/foreach}
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</section>