<h1 class="text-center my-5">{$lang.Welcome}</h1>

<section class="row card-deck my-5 root-boxes">
    <a class="col-12 col-xs-6 col-md-4 card mb-3 d-flex flex-column align-items-center justify-content-center root-box" href="{$ca_url}cart/">
        <i class="text-primary material-icons mb-4 md-48">shopping_cart</i>
        <h4 class="">{$lang.placeorder|capitalize}</h4>
        <span>{$lang.placeorder_desc}</span>
    </a>
    <a class="col-12 col-xs-6 col-md-4 card mb-3 d-flex flex-column align-items-center justify-content-center root-box" href="{$ca_url}clientarea/">
        <i class="text-primary material-icons mb-4 md-48">settings</i>
        <h4 class="">{$lang.clientarea|capitalize}</h4>
        <span>{$lang.clientarea_desc}</span>
    </a>
    <a class="col-12 col-xs-6 col-md-4 card mb-3 d-flex flex-column align-items-center justify-content-center root-box" href="{if $logged=='1'}{$ca_url}support{elseif $enableFeatures.kb!='off'}{$ca_url}knowledgebase{else}{$ca_url}tickets/new{/if}/">
        <i class="text-primary material-icons mb-4 md-48">help</i>
        <h4 class="">{$lang.support|capitalize}</h4>
        <span>{$lang.support_desc}</span>
    </a>
</section>


{if $enableFeatures.news!='off' && $annoucements}
    <h2 class="text-center my-5">{$lang.annoucements}</h2>

    <section class="my-5 root-news">
        <div class="d-flex flex-row justify-content-end align-items-center">
            <a href="{$ca_url}news/" class="btn btn-sm btn-primary btn-view-all mr-3">
                {$lang.newsarchive}
            </a>
        </div>
        <div class="card w-100 my-4">
            <ul class="list-group list-group-flush">
                {foreach from=$annoucements item=annoucement name=announ}
                    <div class="list-group-item d-flex flex-row align-items-start align-content-stretch"  href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/" >
                        <i class="material-icons icon-info-color mr-3">subject</i>
                        <div class="w-100">
                            <a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/" class="h3 text-primary">{$annoucement.title}</a>
                            <div class="mt-2">
                                <small class="text-muted">{$annoucement.content|truncate:120|nl2br}</small>
                            </div>
                        </div>
                        <div class="d-flex justify-content-end">
                            <small class="pull-right badge badge-primary">{$annoucement.date}</small>
                        </div>
                    </div>
                {foreachelse}
                    <span class="list-group-item">
                        <span class="text-small text-center">{$lang.nothing}</span>
                    </span>
                {/foreach}
            </ul>
        </div>
    </section>
{/if}

<div id="tweets" class="my-5"></div>