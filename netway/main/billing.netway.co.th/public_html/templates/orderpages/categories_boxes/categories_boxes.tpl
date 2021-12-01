{*
@@author:: HostBill team
@@name:: Categories Boxes
@@description::
@@thumb:: thumb.png
@@img:: preview.png
@@type:: categories
@@configfile:: config.yml
*}

<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}categories_boxes/css/style.css"/>

<section class="orderpage orderpage-categories_list">
    {if !$selected_cat}
        <div>
            <h1 class="my-5">{$opconfig.headertext}</h1>
            <h4 class="my-5">{$opconfig.subheadertext}</h4>
        </div>
        {if $category.description}<h5 class="my-5">{$category.description}</h5>{/if}
    {/if}

    <div class="row">
        {foreach from=$subcategories item=cat name=loop}
            <div class="col-12 span6 col-sm-6 col-md-4 col-lg-3">
                <a {if $cat.id == $selected_cat}onclick="return false;"{else}href="{$ca_url}{$cat.slug}{/if}" class="mb-4 p-3 rounded media cart-category {if $cat.id == $selected_cat} selected {/if}">
                    {if $cat.opconfig.country_flag && $cat.opconfig.country_flag!=='none'}
                        <img class="mr-3 d-block shadow border-light flag-icon" src="{$orderpage_dir}categories_boxes/flags/4x3/{$cat.opconfig.country_flag}.svg" alt="">
                    {/if}
                    <div class="media-body d-flex flex-column justify-content-center">
                        <div class="h3 mb-0 text-primary">{$cat.name}</div>
                        {if $cat.description}
                            <div class="mt-1 text-muted small">{$cat.description}</div>
                        {/if}
                    </div>
                </a>
            </div>
        {/foreach}
    </div>
</section>