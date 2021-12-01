
<article>
    <h2><i class="icon-dboard"></i> {$lang.affiliate}</h2>
    <p>{$lang.affiliate_description}</p>

    <div class="invoices-box clearfix">
        {include file='menus/affiliates.sub.tpl'}
        <div class="tab-content">        
            <div class="text-block clear clearfix">
                <div class="tab-pane active" id="tab1">
                    <div class="affiliates-box">
                        <h3>{$lang.withdrawallogs}</h3>
                        <div class="table-box m15 overflow-h">
                            <div class="table-header">
                            </div>
                            <table class="table table-header-fix table-striped p-td" style="width: 100%">
                                <tr>
                                    <th>{$lang.date}</th>
                                    <th>{$lang.withdrawn}</th>
                                    <th>{$lang.note}</th>
                                </tr>
                                {foreach from=$logs item=log name=logs}
                                    <tr>
                                        <td>{$log.date|dateformat:$date_format}</td>
                                        <td>{$log.amount|price:$affiliate.currency_id}</td>
                                        <td>{$log.note}</td>
                                    </tr>
                                {/foreach}
                            </table>
                            {if !$logs}
                                <div class="table-content">
                                    <p class="text-center">{$lang.nothing}</p>
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</article>
