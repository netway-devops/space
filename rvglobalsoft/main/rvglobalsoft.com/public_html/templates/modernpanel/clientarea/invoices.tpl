{*

Browse invoices history

*}
<article>
    <h2><i class="icon-inv"></i> {$lang.invoices|capitalize}</h2>
    <p>{$lang.currentbalancestatus}</p>

    <div class="invoices-box clearfix">
        <ul id="invoice-tab" class="nav nav-tabs table-nav" data-filter="status">
            <li class="active">
                <a href="#tab1" data-toggle="tab" data-filter=""><div class="tab-left"></div> {$lang.all}<div class="tab-right"></div></a>
            </li>
            <li>
                <a href="#tab2" data-toggle="tab" data-filter="Unpaid"><div class="tab-left"></div> {$lang.Unpaid} <div class="tab-right"></div></a>
            </li>
            {if $enableFeatures.deposit!='off' }
                <li class="custom-tab">
                    <a href="{$ca_url}clientarea/addfunds/" ><div class="tab-left"></div> <i class="icon-add"></i> {$lang.addfunds} <div class="tab-right"></div></a>
                </li>
            {/if}
            {if $acc_balance && $acc_balance>0 && $enableFeatures.bulkpayments!='off'}
                <li class="custom-tab">
                    <a href="#" onclick="$(this).next().submit();return false;" ><div class="tab-left"></div> <i class="icon-pay-due"></i> {$lang.paynowdueinvoices} <div class="tab-right"></div></a>
                    <form method="post" action="index.php" class="no-margin form-inline">
                        <input type="hidden" name="action" value="payall"/>
                        <input type="hidden" name="cmd" value="clientarea"/>
                        {securitytoken}
                    </form>
                </li>
            {/if}
        </ul>
        <div class="tab-content">

            <!-- Tab #1 -->
            <div class="tab-pane active" id="tab1">
                    {*}{if $acc_balance && $acc_balance>0 }
                        <div class="right-btns">
                            {if $acc_balance && $acc_balance>0 && $enableFeatures.bulkpayments!='off'}
                                <form method="post" action="index.php" class="no-margin" style="display:inline-block; vertical-align:top">
                                    <input type="hidden" name="action" value="payall"/>
                                    <input type="hidden" name="cmd" value="clientarea"/>
                                    <button class="btn c-green-btn"><i class="icon-pay-due"></i> {$lang.paynowdueinvoices}</button>
                                    {securitytoken}
                                </form>
                            {/if}
                            </div>
                        {/if}
                        
                        <div class="detailed-info">
                            <span>3</span>
                            <p>{$lang.total}</p>
                        </div>
                        <div class="detailed-info">
                            <span class="Paid-label">1</span>
                            <p>{$lang.Paid}</p>
                        </div>
                        <div class="detailed-info">
                            <span class="Unpaid-label">2</span>
                            <p>{$lang.Unpaid}</p>
                        </div>
                        
                    </div>{*}
                    <a href="{$ca_url}clientarea/invoices/" id="currentlist" style="display:none" updater="#updater"></a>
                    <input type="hidden" id="currentpage" value="0" />
                    <table class="table styled-table">
                        <tr>
                            <th class="w10"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=status|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.status}</a></th>
                            <th ><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=id|ASC" class="sortorder"><i class="icon-sort"></i>{$lang.invoicenum}</a></th>
                            <th class="w15"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=total|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.total}</a></th>
                            <th class="w10"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=date|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.invoicedate}</a></th>
                            <th class="w10"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=duedate|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.duedate}</a></th>
                            <th class="w5"></th>
                        </tr>

                        {if $invoices}
                            <tbody id="updater">
                                {include file='ajax/ajax.invoices.tpl'}
                            </tbody>
                        {else}
                            {$lang.nothing}
                        {/if}

                    </table>
            </div>
        </div>

        <div class="pagination c-pagination clearfix">
            <ul rel="{$totalpages}">
                <li class="pull-left dis"><a href="#"><i class="icon-pagin-left"></i> {$lang.previous}</a></li>
                <li class="pull-right dis"><a href="#">{$lang.next} <i class="icon-pagin-right"></i></a></li>
            </ul>
        </div>
</article>