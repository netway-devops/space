{if $enableFeatures.kb!='off' || $enableFeatures.downloads!='off'}

    <h1 class="mb-3">
        {if $enableFeatures.kb!='off' && $enableFeatures.downloads!='off'}
            {$lang.knowledgebase} & {$lang.downloads}
        {elseif $enableFeatures.downloads!='off'}
            {$lang.downloads}
        {else}
            {$lang.knowledgebase}
        {/if}
    </h1>

    <section class="section-support">
        <div class="row">
            {if $enableFeatures.kb!='off'}
                {if $topkb}
                    <div class="col-lg-6 col-md-6 col-xs-12 col-12 mt-4">
                        <div class="d-flex flex-row justify-content-between align-items-center">
                            <h4>{$lang.popularcategories}</h4>
                            <a href="{$ca_url}knowledgebase/" class="btn btn-sm btn-secondary btn-view-all">
                                {$lang.viewall}
                                <i class="material-icons ml-2 size-sm icon-btn-color">chevron_right</i>
                            </a>
                        </div>
                        <div class="card w-100 my-3">
                            <ul class="list-group list-group-flush">
                                {foreach from=$topkb item=kb}
                                    <a href="{$ca_url}knowledgebase/category/{$kb.id}/" class="list-group-item">
                                        <i class="material-icons icon-info-color mr-3">subject</i>
                                        <span class="text-small">{$kb.name|truncate:50:"..."}</span>
                                    </a>
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                {else}
                    {$lang.nothing}
                {/if}
            {/if}
            {if $enableFeatures.downloads!='off'}
                {if $topdw}
                    <div class="col-lg-6 col-md-6 col-xs-12 col-12 mt-4">
                        <div class="d-flex flex-row justify-content-between align-items-center">
                            <h4>{$lang.popular_down}</h4>
                            <a href="{$ca_url}downloads/" class="btn btn-sm btn-secondary btn-view-all">
                                {$lang.viewall}
                                <i class="material-icons ml-2 size-sm icon-btn-color">chevron_right</i>
                            </a>
                        </div>
                        <div class="card w-100 my-3">
                            <ul class="list-group list-group-flush">
                                {foreach from=$topdw item=kb}
                                    <a href="{$ca_url}downloads/category/{$kb.id}/" class="list-group-item">
                                        <i class="material-icons icon-info-color mr-3">subject</i>
                                        <span class="text-small">{$kb.name|truncate:50:"..."}</span>
                                    </a>
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                {else}
                    {$lang.nothing}
                {/if}
            {/if}
        </div>
    </section>
{/if}

<h1 class="mt-5 mb-3">{$lang.tickets|capitalize}</h1>
<section class="section-tickets">
    <div class="nav-tabs-wrapper">
        <ul class="nav nav-tabs d-flex justify-content-between align-items-center flex-wrap" role="tablist">
            <li>
                <ul class="nav nav-slider">
                    <li class="nav-item active"><a class="nav-link nav-link-slider" href="#" data-sorter="filter[status]">{$lang.all}</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-slider" href="#Open" data-sorter="filter[status]">{$lang.Open}</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-slider" href="#Answered" data-sorter="filter[status]">{$lang.Answered}</a></li>
                </ul>
            </li>
            <li>
                <ul class="nav">
                    <li>
                        <a class="btn btn-success btn-sm pull-right" href="{$ca_url}tickets/new/">{$lang.createnew}</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>

    <a href="{$ca_url}tickets/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table tickets-table position-relative stackable">
            <thead>
            <tr>
                <th><a href="{$ca_url}tickets/&orderby=id|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.Ticket} #</a></th>
                <th><a href="{$ca_url}tickets/&orderby=subject|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.subject}</a></th>
                <th><a href="{$ca_url}tickets/&orderby=status|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.status}</a></th>
                <th><a href="{$ca_url}tickets/&orderby=name|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.department}</a></th>
                <th><a href="{$ca_url}tickets/&orderby=date|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.date}</a></th>
                <th width="100"></th>
            </tr>
            </thead>
            <tbody id="updater">
                {include file='ajax.tickets.tpl' action="default" tickets=$openedtickets}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>
