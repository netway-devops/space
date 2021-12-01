{*

This file is rendered on main HostBill screen when browsed by user

*}
<h1>{$lang.welcome}</h1>


<div class="p15">
    <div class="root-item">
        <a href="{$ca_url}cart/">
            <div class="root-item-bg">
                <i class="icon-root-bag"></i>
            </div>
            <div class="item-info">
                <h3>{$lang.placeorder|capitalize}</h3>
                <p>{$lang.placeorder_desc}</p>
            </div>
        </a>
    </div>

    <div class="root-item">
        <a href="{$ca_url}clientarea/">
            <div class="root-item-bg">
                <i class="icon-root-cog"></i>
            </div>
            <div class="item-info">
                <h3>{$lang.clientarea|capitalize}</h3>
                <p>{$lang.clientarea_desc}</p>
            </div>
        </a>
    </div>

    <div class="root-item">
        <a href="{if $logged=='1'}{$ca_url}support{elseif $enableFeatures.kb!='off'}{$ca_url}knowledgebase{else}{$ca_url}tickets/new{/if}/">
            <div class="root-item-bg">
                <i class="icon-root-support"></i>
            </div>
            <div class="item-info">
                <h3>{$lang.support|capitalize}</h3>
                <p>{$lang.support_desc}</p>
            </div>
        </a>
    </div>
</div>

<div class="shadow"></div>

{if $enableFeatures.news!='off' && $annoucements}

    <h3>{$lang.annoucements}</h3>
    <div class="clearfix p15">
        {foreach from=$annoucements item=annoucement name=announ}
            <div class="news-container">
                <div class="date">
                    <p class="day">{$annoucement.date|date_format:"%d"}</p>
                    <p>{$annoucement.date|date_format:"%b"}</p>
                    <p>{$annoucement.date|date_format:"%Y"}</p>
                </div>
                <div class="news-body">
                    <h4><a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/">{$annoucement.title}</a></h4>
                    <p>
                        {$annoucement.content}
                    </p>
                </div>
            </div>
        {/foreach}
        <div class="news-btns">
            <a href="{$ca_url}news/" class="btn c-green-btn">{$lang.newsarchive}</a>
            <a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/" class="btn c-white-btn">{$lang.readall} <i class="icon-single-arrow"></i></a>
        </div>
    </div>
{/if}