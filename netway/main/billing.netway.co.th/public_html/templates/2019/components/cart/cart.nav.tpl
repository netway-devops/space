<section class="section-cart-categories my-5">
    <div class="category-list d-flex flex-wrap flex-row">
        {foreach from=$categories item=i name=categories name=cats}
            <div class="category mr-4 my-2">
                {if $i.id == $current_cat}
                    <span class="font-weight-bold text-primary">{$i.name}</span>
                {else}
                    <a class="text-secondary font-weight-light" href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a>
                {/if}
            </div>
        {/foreach}
        {if $logged=='1'}
            <div class="category mr-4 my-2">
                {if $current_cat=='addons'}
                    <span class="font-weight-bold text-primary">{$lang.prodaddons}</span>
                {else}
                    <a class="text-secondary font-weight-light" href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a>
                {/if}
            </div>
        {/if}
    </div>

    {foreach from=$categories item=i name=categories name=cats}
        {if $i.id == $current_cat && $i.description!=''}
            <div class="category-description my-5 font-weight-light">{$i.description}</div>
        {/if}
    {/foreach}
</section>