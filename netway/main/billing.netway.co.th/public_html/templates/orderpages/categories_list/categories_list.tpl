{*
@@author:: HostBill team
@@name:: Categories List
@@description::
@@thumb:: thumb.png
@@img:: preview.png
@@type:: categories
@@configfile:: config.yml
*}

<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}categories_list/css/style.css"/>

<section class="orderpage orderpage-categories_list">
    <div class="clearfix">
        <h1 class="my-5">{$opconfig.headertext}</h1>
        <h4 class="my-5">{$opconfig.subheadertext}</h4>
    </div>
    {if $category.description}<h5 class="my-5">{$category.description}</h5>{/if}
    <div class="row">
        {foreach from=$subcategories item=cat name=loop}
            <div class="col-12 d-flex align-items-stretch py-2">
                <div class="card w-100">
                    <div class="card-body d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between">
                        <div class="mb-3 mb-md-0">
                            <a href="{$ca_url}cart/{$cat.slug}/" class="h2 mb-0 text-primary">{$cat.name}</a>
                            {if $cat.description}
                                <p class="mt-2 card-text">{$cat.description}</p>
                            {/if}
                        </div>
                        <div>
                            <a class="btn btn-success w-100" href="{$ca_url}cart/{$cat.slug}/">{$lang.browseprod}</a>
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
</section>