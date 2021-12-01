<div class="bordered-section article"><h2>{$lang.creditreceipts|capitalize}</h2>
    {if ($acc_balance && $acc_balance>0) ||  $enableFeatures.deposit!='off' }
        <div class="ribbon form-horizontal">
            <div class="control-group">
                <label for="appendedPrependedInput" class="control-label left" style="width:auto">{$lang.curbalance}:  <b>{$acc_balance|price:$currency}</b></label>
                {if $enableFeatures.deposit!='off' }
                    <div class="right" style="margin-left:10px">
                        <a href="{$ca_url}clientarea&action=addfunds" class="btn btn-info btn-large">{$lang.addfunds}</a>
                    </div>
                {/if}
                {if $acc_balance && $acc_balance>0 && $enableFeatures.bulkpayments!='off'}
                    <div class="right" style="margin-left:10px">
                        <form method="post" action="index.php" id="payall">
                            <input type="hidden" name="action" value="payall"/>
                            <input type="hidden" name="cmd" value="clientarea"/>
                            <button class="btn btn-success btn-large">
                                <i class="icon-ok-sign icon-white"></i> <b class="payall-all">{$lang.paynowdueinvoices}</b>
                                <b class="payall-selected">{$lang.payselectedinvoices}</b>
                            </button>
                            {securitytoken}
                        </form>
                    </div>
                {/if}
            </div>
        </div>
        <div class="ribbon-shadow-l"></div>
        <div class="ribbon-shadow-r"></div>
        <div class="divider"></div>
    {/if}
    {if $receipts}
        <a href="{$ca_url}clientarea&amp;action=creditreceipts" id="currentlist" style="display:none" updater="#updater"></a>
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table table-striped  fullscreen">
            <colgroup class="firstcol"></colgroup>
            {if $enableFeatures.bulkpayments!='off'}<colgroup class="firstcol"></colgroup>{/if}
            <colgroup class="alternatecol"></colgroup>

            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>

            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <tbody>
            <tr>
                {if $enableFeatures.bulkpayments!='off'}<th width="20"></th>{/if}
                <th width="70"><a href="{$ca_url}clientarea&amp;action=creditreceipts&amp;orderby=status|ASC"  class="sortorder">{$lang.status}</a></th>
                <th><a href="{$ca_url}clientarea&amp;action=creditreceipts&amp;orderby=id|ASC" class="sortorder">{$lang.invoicenum}</a></th>
                <th width="120"><a href="{$ca_url}clientarea&amp;action=creditreceipts&amp;orderby=total|ASC"  class="sortorder">{$lang.total}</a></th>
                <th width="120"><a href="{$ca_url}clientarea&amp;action=creditreceipts&amp;orderby=date|ASC"  class="sortorder">{$lang.invoicedate}</a></th>
                <th width="120"><a href="{$ca_url}clientarea&amp;action=creditreceipts&amp;orderby=duedate|ASC"  class="sortorder">{$lang.duedate}</a></th>
                <th width="20"/>
            </tr>
            </tbody>
            <tbody id="updater">
                {include file='ajax/ajax.creditreceipts.tpl'}
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
{if $enableFeatures.bulkpayments!='off'}
    <script type="text/javascript">
        {literal}
        var checks = $('input[name="selected[]"]'),
            pay = $('#payall');

        checks.change(function(){
            if(checks.filter(':checked').length){
                pay.find('.payall-selected').show();
                pay.find('.payall-all').hide();
            }else{
                pay.find('.payall-selected').hide();
                pay.find('.payall-all').show();
            }
        }).change();
        pay.submit(function(){
            if(checks.filter(':checked').length){
                var a = checks.serializeArray();
                for(var i = 0; i < a.length; i++){
                    pay.append('<input type="hidden" name="selected[]" value="'+a[i].value+'" />');
                }
            }
        });
        {/literal}
    </script>
{/if}