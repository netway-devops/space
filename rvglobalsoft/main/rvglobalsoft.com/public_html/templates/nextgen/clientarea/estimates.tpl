<div class="bordered-section article">
    <h2>{$lang.estimates|capitalize}</h2>
    {if $estimates}
        <a href="{$ca_url}clientarea&amp;action=estimates" id="currentlist" style="display:none" updater="#updater"></a>
        <input type="hidden" id="currentpage" value="0" />
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table table-striped  fullscreen">
            {if $enableFeatures.bulkpayments!='off'}<colgroup class="firstcol"></colgroup>{/if}
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>

            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>

            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <tbody>
            <tr>
                <th class="w10"><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=status|ASC"  data-sorter="orderby" class="sortorder"><i class="icon-sort"></i>{$lang.status}</a></th>
                <th ><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=id|ASC" data-sorter="orderby"  class="sortorder"><i class="icon-sort"></i>{$lang.Estimate}</a></th>
                <th class="w15"><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=total|ASC"  data-sorter="orderby" class="sortorder"><i class="icon-sort"></i>{$lang.total}</a></th>
                <th class="w10"><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=date_expires|ASC"  data-sorter="orderby" class="sortorder"><i class="icon-sort"></i>{$lang.expiration_date}</a></th>
                <th class="w5"></th>
            </tr>
            </tbody>
            <tbody id="updater">
            {include file='ajax/ajax.estimates.tpl'}
            </tbody>

        </table>

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
    {else}
        <h3 class="p19">{$lang.nothing}</h3>
    {/if}
</div>