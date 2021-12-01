<div class="text-block clear clearfix">
    {if $action=='default'}
        <h5 style="float:none">{$lang.downloads|capitalize}</h5>
        <div class="pt15">
            {if $myfiles}
                <div class="divider"></div>
                <h3>{$lang.myfiles_down}</h3>
                <div class="well">
                    <table class="table table-striped fullscreen">
                        {foreach from=$myfiles item=i}
                            <tr>
                                <td>
                                    <h5 style="float:none"><a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="dw3">{$i.name}</a></h5>
                                        {if $i.description!=''}
                                        <p>{$i.description}</p>
                                    {/if}
                                </td>
                                <td width="300px">
                                    <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="btn btn-info">
                                        <i class="icon-download-alt icon-white"></i> 
                                        {$lang.download}
                                        {if $i.size>0}({$i.size} KB)
                                        {/if}
                                    </a>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                    <div class="clear"></div>
                </div>
            {/if}
            <div class="dotted-line"></div>
            {if $categories}

                <h5 class="s-title">{$lang.categories}</h5>
                <ul class="nav nav-list downloadable-list clear clearfix">
                    {foreach from=$categories item=i}
                        <li>
                            <i class="icon-tiny-arrow-r"></i>
                            <a href="{$ca_url}downloads/category/{$i.id}/{$i.slug}/" >{$i.name} <span class="fsize">({$i.files})</span> </a>
                        </li>
                    {/foreach}
                </ul>
            {else}
                <p>{$lang.nothing}</p>
            {/if}
            <div class="dotted-line"></div>
            {if $popular}
                <div class="divider"></div>
                <h5>{$lang.popular_down}</h5>

                <table class="table table-striped fullscreen">
                    {foreach from=$popular item=i}
                        <tr>
                            <td>
                                <h5 style="float:none"><a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="dw3">{$i.name}</a></h5>
                                    {if $i.description!=''}
                                    <p>{$i.description}</p>
                                {/if}
                            </td>
                            <td width="300px">
                                <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="btn btn-info">
                                    <i class="icon-download-alt icon-white"></i> 
                                    {$lang.download}
                                    {if $i.size>0}({$i.size} KB)
                                    {/if}
                                </a>
                            </td>
                        </tr>
                    {/foreach}
                </table>

            {/if}
        </div>
    {elseif $action=='category'}
        <h5 style="float:none">{$lang.downloads}: {$category.name}</h5>
        {if $category.description!=''}
            <p class="p19 pt0">{$category.description}</p>
        {/if}
        <div class="brcrm">
            <ul class="breadcrumb left">
                <li><a href="{$ca_url}downloads/">{$lang.downloads|capitalize}</a> <span class="divider">/</span></li>
                <li class="active">{$category.name}</li>
            </ul>
            <a class="btn right btn-mini" href="{$ca_url}downloads/"><i class="icon-chevron-left"></i> {$lang.back}</a>
            <div class="clear"></div>
        </div>

        <div class="pt15">
            <h5 class="mb15">{$lang.filesunder} {$category.name}</h5>
            <table class="table table-striped fullscreen">
                {foreach from=$files item=i}
                    <tr>
                        <td>
                            <h5 style="float:none"><a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="dw3">{$i.name}</a></h5>
                                {if $i.description!=''}
                                <p>{$i.description}</p>
                            {/if}
                        </td>
                        <td width="300px">
                            <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="btn btn-info">
                                <i class="icon-download-alt icon-white"></i> 
                                {$lang.download}
                                {if $i.size>0}({$i.size} KB)
                                {/if}
                            </a>
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div> 
    {/if}
</div>