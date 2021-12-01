
{if ($action=='annoucement' || $action=='view') && $annoucement}
    <article class="news-view">
        <div class="pull-right">
            <a href="{$ca_url}news/"class="btn c-white-btn"><i class="icon-back"></i> {$lang.back}</a>
        </div>

        <h1>{$lang.annoucements|capitalize}: {$annoucement.title}</h1>
        <div class="date">
            <i class="icon-large-date"></i>
            <span>{$lang.published} <strong>{$annoucement.date|dateformat:$date_format}</strong></span>
        </div>
        <div class="news-body">
            <p>
                {$annoucement.content|nl2br}
            </p>
        </div>
    </article>

{elseif $action=='default'}
    <article>
        <h2><i class="icon-lastest-news"></i> {$lang.annoucements|capitalize}</h2>
        <div class="clearfix p15">
            {if $annoucements}
                {foreach from=$annoucements item=annoucement name=announ}
                    {if $smarty.foreach.announ.index != 0 }
                        <div class="separator-line"></div>
                    {/if}
                    <div class="news-container clearfix">
                        <div class="date">
                            <p class="day">{$annoucement.date|date_format:"%d"}</p>
                            <p>{$annoucement.date|date_format:"%b"}</p>
                            <p>{$annoucement.date|date_format:"%Y"}</p>
                        </div>
                        <div class="news-body">
                            <h4><a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/">{$annoucement.title}</a></h4>

                            <p>{$annoucement.content}</p>
                        </div>
                        <div class="pull-right">
                            <a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/"  class="btn c-white-btn">{$lang.readall} <i class="icon-single-arrow"></i> </a>
                        </div>
                    </div>
                {/foreach}
            {else}
                {$lang.nothing}
            {/if}
        </div>
    </article>

{/if}


</div>

