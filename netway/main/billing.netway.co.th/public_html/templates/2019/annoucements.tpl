<section class="section-annoucements">
    {if ($action=='annoucement' || $action=='view') && $annoucement}
        <article class="news-view">
            <div class="pull-right">
                <a href="{$ca_url}news/" class="btn btn-default btn-small">
                    <i class="icon-chevron-left "></i>
                    {$lang.back}
                </a>
            </div>
            <h1>{$lang.annoucements|capitalize}: {$annoucement.title}</h1>
            <div class="date">
                <span>{$lang.published} <strong>{$annoucement.date|dateformat:$date_format}</strong></span>
            </div>
            <div class="news-body">
                <p>
                    {$annoucement.content|nl2br}
                </p>
            </div>
        </article>
    {elseif $action=='default'}
        <h1 class="mb-4">{$lang.annoucements|capitalize}</h1>
        <hr>
        <article>
            <h2></h2>
            <div class="clearfix p15">
                {if $annoucements}
                    {foreach from=$annoucements item=annoucement name=announ}
                        {if $smarty.foreach.announ.index != 0 }
                            <div class="separator-line"></div>
                        {/if}
                        <div class="news-container clearfix">
                            <div class="news-body">
                                <h4><a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/" class="roll-link"><span data-title="{$annoucement.title}">{$annoucement.title}</span></a></h4>
                                <p class="text-muted small">
                                    <span><i class="icon-time"></i> {$lang.published} <strong>{$annoucement.date|dateformat:$date_format}</strong></span>
                                </p>
                                <p>{$annoucement.content|truncate:150|nl2br}</p>
                            </div>
                            <div class="pull-right">
                                <a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/"  class="btn btn-primary btn-small">{$lang.readall|replace:"&raquo;":''} <i class="icon-chevron-right"></i> </a>
                            </div>
                        </div>
                        <hr>
                    {/foreach}
                {else}
                    {$lang.nothing}
                {/if}
            </div>
        </article>
    {/if}
</section>