<article>
    <h2><i class="icon-supp"></i> {$lang.tickets|capitalize}</h2>
    <p>{$lang.mytickets_desc}</p>

    <div class="invoices-box clearfix">
        <ul id="support-tab" class="nav nav-tabs table-nav" data-filter="status">
            <li class="active"><a href="#support1" data-toggle="tab" data-filter=""><div class="tab-left"></div> {$lang.all}<div class="tab-right"></div></a></li>
            <li><a href="#support2" data-toggle="tab" data-filter="Open"><div class="tab-left"></div> {$lang.Open} <div class="tab-right"></div></a></li>
            <li><a href="#support3" data-toggle="tab" data-filter="Answered"><div class="tab-left"></div> {$lang.Answered} <div class="tab-right"></div></a></li>
            <li class="custom-tab"><a href="{$ca_url}tickets/new/"><div class="tab-left"></div> <i class="icon-add"></i> {$lang.createnew} <div class="tab-right"></div></a></li>
        </ul>
        <div class="tab-content support-tickets-tab">

            <!-- Tab #1 -->
            <div class="tab-pane active" id="support1">
                {*<div class="table-details">
                    <div class="right-btns">
                        <a href="#" class="btn c-orange-btn"><i class="icon-reply"></i> {$lang.submitreply}</a>
                        <a href="#" class="btn c-white-btn"><i class="icon-close-issue"></i> {$lang.closeissue}</a>
                    </div>
                    <div class="detailed-info">
                        {foreach from=$tickets item=ticket name=foo}{break}{/foreach}
                        <span>{$smarty.foreach.foo.total}</span>
                        <p>{$lang.total}</p>
                    </div>
                    <div class="detailed-info">
                        <span class="Open-label">{$open_tickets}</span>
                        <p>{$lang.tickets_opened}</p>
                    </div>
                    <div class="detailed-info">
                        <span class="Closed-label">{$closed_tickets}</span>
                        <p>{$lang.tickets_closed}</p>
                    </div>
                </div>*}

                <a href="{$ca_url}tickets/" id="currentlist" style="display:none" updater="#updater"></a>
                <input type="hidden" id="currentpage" value="0" />
                <table class="table styled-table fixed-table">
                    <tr>
                        <th style="width: 20px">{*<input type="checkbox">*}</th>
                        <th style="width: 12%"><a href="{$ca_url}tickets/&orderby=status|ASC" class="sortorder"><i class="icon-sort"></i> {$lang.status}</a></th>
                        <th style="width: 45%"><a href="{$ca_url}tickets/&orderby=subject|ASC" class="sortorder"><i class="icon-sort"></i> {$lang.subject}</a></th>
                        <th><a href="{$ca_url}tickets/&orderby=name|ASC" class="sortorder"><i class="icon-sort"></i> {$lang.department}</a></th>
                        <th><a href="{$ca_url}tickets/&orderby=date|ASC" class="sortorder"><i class="icon-sort"></i>{$lang.date}</a></th>
                        <th></th>
                    </tr>
                    <tbody id="updater">
                        {include file='ajax.tickets.tpl'}
                    </tbody>
                </table>
                {securitytoken}

            </div>
        </div>
    </div>
    {if $totalpages}
        <div class="pagination c-pagination clearfix">
            <ul rel="{$totalpages}">
                <li class="pull-left dis"><a href="#"><i class="icon-pagin-left"></i> {$lang.previous}</a></li>
                <li class="pull-right dis"><a href="#">{$lang.next} <i class="icon-pagin-right"></i></a></li>
            </ul>
        </div>
    {/if}
</article>