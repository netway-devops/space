{if $enableFeatures.kb!='off' || $enableFeatures.downloads!='off'}
    <article>
        <h2><i class="icon-dboard"></i> 
            {if $enableFeatures.kb!='off' && $enableFeatures.downloads!='off'}
                {$lang.knowledgebase} & {$lang.downloads}
            {elseif $enableFeatures.downloads!='off'}
                {$lang.downloads}
            {else}
                {$lang.knowledgebase}
            {/if}
        </h2>
        <p>
            {if $enableFeatures.kb!='off' && $enableFeatures.downloads!='off'}
                {$lang.knowledgebase_desc} {$lang.downloads_desc}
            {elseif $enableFeatures.downloads!='off'}
                {$lang.downloads_desc}
            {else}
                {$lang.kbwelcome}
            {/if}

        </p>

        <div class="invoices-box clearfix no-height">
            <ul id="invoice-tab" class="nav nav-tabs table-nav">
                {if $enableFeatures.kb!='off'}
                    <li class="active"><a href="#tab1" data-toggle="tab"><div class="tab-left"></div> {$lang.knowledgebase} <div class="tab-right"></div></a></li>
                        {/if}
                        {if $enableFeatures.downloads!='off'}
                    <li><a href="#tab2" data-toggle="tab"><div class="tab-left"></div> {$lang.downloads} <div class="tab-right"></div></a></li>
                        {/if}
            </ul>
            <div class="tab-content support-tab no-p ">
                {if $enableFeatures.kb!='off'}
                    <!-- Tab #1 -->
                    <div class="tab-pane active" id="tab1">
                        <div class="tab-header">
                            <p>{$lang.popularcategories}</p>
                        </div>
                        <ul class="support-nav">
                            {foreach from=$topkb item=kb}
                                <li><a href="{$ca_url}knowledgebase/category/{$kb.id}/">{$kb.name}</a></li>
                                {foreachelse}
                                <li>{$lang.nothing}</li>
                                {/foreach}
                        </ul>
                        <div class="pull-right support-nav-back">
                            <a href="{$ca_url}knowledgebase/" class="btn c-white-btn">{$lang.more}<i class="icon-single-arrow"></i></a>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <!-- End of Tab #1 -->
                {/if}
                {if $enableFeatures.downloads!='off'}
                    <!-- Tab #2 -->
                    <div class="tab-pane" id="tab2">
                        <div class="tab-header">
                            <p>{$lang.popular_down}</p>
                        </div>
                        <ul class="support-nav">
                            {foreach from=$topdw item=kb}
                                <li>
                                    <a href="{$ca_url}downloads/category/{$kb.id}/">
                                        {$kb.name} <span>{$kb.size}</span>
                                    </a>
                                </li>
                            {foreachelse}
                                <li>
                                    {$lang.nothing}
                                </li>
                            {/foreach}
                        </ul>
                        <div class="pull-right support-nav-back">
                            <a href="{$ca_url}downloads/" class="btn c-white-btn">{$lang.more}<i class="icon-single-arrow"></i></a>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <!-- End of Tab #2 -->
                {/if}
            </div>
        </div>
    </article>
{/if}

<!-- Support Tickets -->
<article>
    <h2><i class="icon-supp"></i> {$lang.tickets} </h2>
    <p>{$lang.ticketsfromehere}</p>

    <div class="invoices-box clearfix no-height">
        <ul id="support-tab" class="nav nav-tabs table-nav">
            <li class="active"><a href="#" data-toggle="tab"><div class="tab-left"></div> {$lang.all} <div class="tab-right"></div></a></li>
            <li><a href="#Open" data-toggle="tab"><div class="tab-left"></div> {$lang.Open} <div class="tab-right"></div></a></li>
            <li><a href="#Answered" data-toggle="tab"><div class="tab-left"></div> {$lang.Answered} <div class="tab-right"></div></a></li>
            <li class="custom-tab"><a href="{$ca_url}tickets/new/"><div class="tab-left"></div> <i class="icon-add"></i> {$lang.createnew} <div class="tab-right"></div></a></li>
        </ul>
        <div class="tab-content">

            <!-- Tab #1 -->
            <div class="tab-pane active" id="support1">
                {*<div class="table-details">
                    
                    <div class="right-btns">
                        <a href="#" class="btn c-orange-btn"><i class="icon-reply"></i> Submit reply</a>
                        <a href="#" class="btn c-white-btn"><i class="icon-close-issue"></i> {$lang.closeissue}</a>
                    </div>
                    <div class="detailed-info">
                        <span>3</span>
                        <p>{$lang.total}</p>
                    </div>
                    <div class="detailed-info">
                        <span class="Open-label">1</span>
                        <p>{$lang.Open}</p>
                    </div>
                    <div class="detailed-info">
                        <span class="Answered-label">2</span>
                        <p>{$lang.Answered}</p>
                    </div>
                   
                </div> *}
                <table class="table styled-table">
                    <tr>
                        <th>{*<input type="checkbox">*}</th>
                        <th class="w15">{*<i class="icon-sort"></i>*} {$lang.status}</th>
                        <th class="w60">{*<i class="icon-sort"></i>*} {$lang.subject}</th>
                        <th>{*<i class="icon-sort"></i>*} {$lang.department}</th>
                        <th></th>
                    </tr>
                    {foreach from=$openedtickets item=ticket name=foo}
                        <tr class="styled-row">
                            <td>
                                <div class="td-rel">
                                    <div class="left-row-side {$ticket.status}-row"></div>
                                </div>
                                {*<input type="checkbox">*}
                            </td>
                            <td class="bold {$ticket.status}-label">
                                {$lang[$ticket.status]}
                            </td>
                            <td class="invoice-c">{$ticket.subject}</td>
                            <td>{$ticket.deptname}</td>
                            <td>
                                <div class="td-rel">
                                    <div class="right-row-side"></div>
                                </div>
                                <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/" class="icon-link"><i class="icon-single-arrow"></i></a></td>
                        </tr>
                        <tr class="empty-row">
                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="3">{$lang.nothing}</td>
                        </tr>
                    {/foreach}
                </table>
            </div>
            <!-- End of Tab #1 -->
        </div>
    </div>
</article>
<!-- End of Support Tickets -->

{if $enableFeatures.netstat!='off'}
    <!-- Server Status -->
    {include file="netstat.tpl"}
    <script type="text/javascript">ajax_update('{$ca_url}netstat/', null, '#netstat_update');</script>
    <!-- End of Server Status -->
{/if}