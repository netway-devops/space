{foreach from=$orderpages item=cat}{if $cat.ctype=='domain' && $cat.template=='single'}{assign var=domaincat value=$cat.slug }{break}{/if}{/foreach}
{if ( $enableFeatures.kb && $enableFeatures.kb!='off' )
    || ($enableFeatures.domains && $enableFeatures.domains!='off' && $domaincat)
    || ($enableFeatures.support && $enableFeatures.support!='off')
}
<div class="pull-right">
    <div class="search-bg">
        <div class="input-prepend">
            <form id="ca_search" class="form-inline" action="{$ca_url}" method="POST" >
                <span class="add-on"><button type="submit" class="clearstyle"><i class="icon-c-search"></i></button></span>
                <input class="span2" type="text" name="query">
            </form>
            <div class="btn-group">
                <span class="search-separator">|</span>
                <a class="clearstyle btn dropdown-toggle" data-toggle="dropdown" href="#">{if $domaincat}{$lang.domains}{else}{$lang.knowledgebase}{/if}
                <span class="caret"></span>
                </a>
                <input type="hidden" value="{if $domaincat}{$domaincat}{else}knowledgebase{/if}" />
                <ul class="dropdown-menu">
                    <div class="dropdown-padding">
                        {if $enableFeatures.domains && $enableFeatures.domains!='off' && $domaincat}<li><a href="#{$domaincat}">{$lang.domains}</a><span></span></li>{/if}
                        {if $enableFeatures.kb && $enableFeatures.kb!='off'}<li><a href="#knowledgebase">{$lang.knowledgebase}</a><span></span></li>{/if}
                        {if $enableFeatures.support && $enableFeatures.support!='off'}<li><a href="#tickets">{$lang.tickets}</a><span></span></li>{/if}
                    </div>
                </ul>
            </div>
        </div>
    </div>
</div>
{/if}