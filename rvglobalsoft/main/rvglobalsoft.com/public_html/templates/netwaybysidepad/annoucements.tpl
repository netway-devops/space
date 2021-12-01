
{if ($action=='annoucement' || $action=='view') && $annoucement}

<div class="text-block clear clearfix">
            <h5 class="h-width">{$lang.annoucements|capitalize}: {$annoucement.title}</h5>
            <div class="clear clearfix">
                <div class="table-box news-m">
                    <div class="table-header">
                    <div class="right-btns-l">
                    <a href="{$ca_url}news/" class="pull-right clearstyle btn grey-custom-btn l-btn"><i class="icon-back"></i>{$lang.back}</a>
                    </div>
                    
                        <p class="inline-block small-txt"><i class="icon-ticket-date"></i> <strong>{$lang.published}</strong> {$annoucement.date|date_format:'%d %b %Y'}</p>
                        
                    </div>
                    <div class="news-content">
                    <p>{$annoucement.content|nl2br}</p>
                    </div>
                </div>
            </div>
</div>



{elseif $action=='default'}



{if $annoucements}

<div class="text-block clear clearfix">
    <h5><i class="icon-news-archive"></i>{$lang.annoucements|capitalize}</h5>
    <div class="line-separaotr"></div>
    
    {foreach from=$annoucements item=annoucement name=announ}
    {if $smarty.foreach.announ.index != 0 }
    <div class="dotted-line-m"></div>
    {/if}
    <div class="not-logged-news clear clearfix">
        <h6><a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/">{$annoucement.title}</a></h6>
        <span>{$lang.published} {$annoucement.date|date_format:'%d %b %Y'}</span>
        <p>{$annoucement.content}</p>
        <div class="pull-right btn-margin">
            <a href="{$ca_url}news/view/{$annoucement.id}/{$annoucement.slug}/" class="clearstyle btn green-custom-btn l-btn">{$lang.readall} <i class="icon-submit-arrow"></i> </a>
        </div>
    </div>
    {/foreach}
    
  
</div>



{else}

{$lang.nothing}

{/if}
{/if}


</div>

