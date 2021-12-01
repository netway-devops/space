<h1 class="mb-5">
    {$lang.checkoffersphrase}
</h1>
<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3">
    {foreach from=$categories item=cat name=loop}
        <div class="col mb-4">
            <div class="card h-100 shadow shadow-sm border-0">
                <div class="card-body d-flex flex-row">
                    {if $tpl_config.orderpages[$cat.id].icon}
                        <div class="mr-3 product-icon">
                            {include file="`$template_path`dist/images/products/`$tpl_config.orderpages[$cat.id].icon`"}
                        </div>
                    {/if}
                    <div>
                        <a href="{$system_url}{$cat.slug}" class="card-title h3 text-primary">{$cat.name}</a>
                        {if $cat.description}
                            <p class="card-text small text-muted">{$cat.description}</p>
                        {/if}
                    </div>
                </div>
                <div class="card-footer bg-transparent d-flex flex-row justify-content-between align-items-center">
                    <!--<span>{if $cat.min_price}{$lang.from|ucfirst} <b class="text-primary">{$cat.min_price|price:$currency:true:true}</b>{/if}</span>-->
                    <a href="{$system_url}{$cat.slug}" class="btn btn-primary">{$lang.select|default:"Select"}</a>
                </div>
            </div>
        </div>
    {/foreach}
</div>