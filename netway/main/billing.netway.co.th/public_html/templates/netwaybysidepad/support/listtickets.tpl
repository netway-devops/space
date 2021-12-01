

<div class="text-block clear clearfix">
    <h5 class="h-width">{$lang.tickets|capitalize}</h5>
    {if $tickets || $currentfilter}
    {/if}
    <p class="header-desc">{$lang.mytickets_desc}
    </p>
    <div class="clear clearfix">

        <div class="table-box">
            <div class="table-header">
                <div class="right-btns-l">
                </div>

                <p class="inline-block small-txt">{$lang.newticket_desc}</p>

            </div>
            <div class="tickets-archive">
                <div class="pull-left">{$lang.ticketarchive}</div>
                <div class="pull-right small-info">{$lang.tickets_closed} <span>{$closed_tickets}</span></div>
                <div class="pull-right small-info">{$lang.tickets_opened} <span class="active">{$open_tickets}</span></div>
            </div>
            <form action="" method="post" id="testform" style="margin:0;">
                <table class="table table-striped table-hover tb-tickets">
                    <tr class="table-header-row">
                        <th class="w15"></th>
                        <th class="w50"></th>
                        <th class="w15 cell-border"></th>
                        <th class="w20 cell-border"></th>
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
