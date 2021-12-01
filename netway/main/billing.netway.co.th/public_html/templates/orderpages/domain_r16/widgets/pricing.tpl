<div class="domain-price">
    <h2>{$lang.domainprices}</h2>

    <div class="price-list">
        <div class="price-row price-head">
            <div>{$lang.tld}</div>
            <div>{$lang.minperiod}</div>
            <div>{$lang.renew}</div>
        </div>
        <div class="price-view">
            {foreach from=$cart.category.products item=tld}
                <div class="price-row">
                    <div class="price-tld">{$tld.name}</div>
                    {foreach from=$tld.periods item=period}
                        {if $period.register != -1}
                            <div class="price-register mode mode-register"title="{$period.register|price} {$period.title}" >
                                {if $period.register == 0}<span class="price-amount free">{$lang.free}</span>
                                {else}<span class="price-amount">{$period.register|price}</span>
                                {/if}
                                <span class="price-period" title="{$period.title}">{$period.title}</span>
                            </div>
                            {break}
                        {/if}
                    {/foreach}
                    {foreach from=$tld.periods item=period}
                        {if $period.transfer != -1}
                            <div class="price-transfer mode mode-transfer" title="{$period.transfer|price} {$period.title}">
                                {if $period.transfer == 0}<span class="price-amount free">{$lang.free}</span>
                                {else}<span class="price-amount">{$period.transfer|price}</span>
                                {/if}
                                <span class="price-period" >{$period.title}</span>
                            </div>
                            {break}
                        {/if}
                    {/foreach}
                    {foreach from=$tld.periods item=period}
                        {if $period.renew != -1}
                            <div class="price-renew" title="{$period.renew|price} {$period.title}">
                                {if $period.renew == 0}<span class="price-amount free">{$lang.free}</span>
                                {else}<span class="price-amount">{$period.renew|price}</span>
                                {/if}
                                <span class="price-period" >{$period.title}</span>
                            </div>
                            {break}
                        {/if}
                    {/foreach}
                </div>
            {/foreach}
        </div>
    </div>
    {*}<table>
    <thead>
    <tr>
    <td>{$lang.tld}</td>
    <td>{$lang.minperiod}</td>
    <td>{$lang.register}</td>
    <td>{$lang.transfer}</td>
    <td>{$lang.renew}</td>
    </tr>
    </thead>

    <tbody>
    {foreach from=$prices item=price name=foo}
    <tr >
    <td>{$price.tld}</td>
    <td>{$price.period} {$lang.years}</td>
    <td>
    {if $price.register>0}
    {$price.register|price:$currency}
    {elseif $price.register==0}
    {$lang.free}
    {else}-
    {/if}

    </td>
    <td>
    {if $price.transfer>0}
    {$price.transfer|price:$currency}
    {elseif $price.transfer==0}
    {$lang.free}
    {else}-
    {/if}
    </td>
    <td>
    {if $price.renew>0}
    {$price.renew|price:$currency}
    {elseif $price.renew==0}
    {$lang.free}
    {else}-
    {/if}
    </td>
    </tr>
    {/foreach}
    </tbody>
    </table>
    {*}
</div>