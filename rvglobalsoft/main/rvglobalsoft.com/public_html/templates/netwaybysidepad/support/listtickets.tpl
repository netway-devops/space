

<div class="text-block clear clearfix">
    <h5 class="h-width">{$lang.tickets|capitalize}</h5>
    {if $tickets || $currentfilter}
        <form style="margin:0px" id="testform" href="{$ca_url}tickets/" method="post">
            <div class="input-bg pull-right search-shadow">
                <input type="text" size="16" name="filter[subject]" class="search-field" value="{$currentfilter.subject}" placeholder="{$lang.filtertickets}" id="d_filter"  />
                <button type="submit" class="clearstyle" ><i class="icon-search"></i></button>     
            </div>
        </form>
    {/if}
    <p class="header-desc">{$lang.mytickets_desc}
    </p>
    <div class="clear clearfix">

        <div class="table-box">
            <div class="table-header">
                <div class="right-btns-l">
                    <a href="{$ca_url}tickets/new/" class="pull-right clearstyle btn green-custom-btn l-btn"><i class="icon-envelope icon-white"></i> {$lang.openticket}</a>
                </div>

                <p class="inline-block small-txt">{$lang.newticket_desc}</p>

            </div>
            <div class="tickets-archive">
                <div class="pull-left">{$lang.ticketarchive}</div>
                <div class="pull-right small-info">{$lang.tickets_closed} <span>{$closed_tickets}</span></div>
                <div class="pull-right small-info">{$lang.tickets_opened} <span class="active">{$open_tickets}</span></div>
            </div>
            <form action="" method="post" id="testform" style="margin:0;">
                <a href="{$ca_url}tickets" id="currentlist" style="display:none" updater="#updater"></a>
                <table class="table table-striped table-hover tb-tickets">
                    <tr class="table-header-row">
                        <th class="w15"><a href="{$ca_url}tickets&amp;orderby=status|ASC"  class="sortorder">{$lang.status}</a></th>
                        <th class="w50"><a href="{$ca_url}tickets&amp;orderby=subject|ASC"  class="sortorder">{$lang.subject}</a></th>
                        <th class="w15 cell-border"><a href="{$ca_url}tickets&amp;orderby=name|ASC" class="sortorder">{$lang.department}</a></th>
                        <th class="w20 cell-border"><a href="{$ca_url}tickets&amp;orderby=date|ASC"  class="sortorder">{$lang.date}</a></th>
                    </tr>
                    <tbody id="updater">
                        {include file='ajax.tickets.tpl'}
                    </tbody>
                </table>
        </div>
        {if $totalpages>1}
            <div class="clear"></div>
            <div class="right p19 pt0">
                <div class="pagelabel left ">{$lang.page}</div>
                <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
                    {section name=foo loop=$totalpages}
                        <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
                    {/section}
                </div>
                <input type="hidden" id="currentpage" value="0" />


            </div>
            <div class="clear"></div>
        {/if}
        {securitytoken}
        </form>

    </div>
</div>
