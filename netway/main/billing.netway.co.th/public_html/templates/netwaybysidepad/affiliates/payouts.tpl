        <div class="text-block clear clearfix">
        
            {include file='affiliates/summary.tpl'}
            
            <div class="clear clearfix">
                <div class="table-box">
                    <div class="table-header">
                        <p>{$lang.withdrawallogs}</p>
                    </div>
                    <table class="table table-striped table-hover">
                        <tr class="table-header-high">
                            <th class="w20">{$lang.date}</th>
                            <th class="w30 cell-border">{$lang.withdrawn}</th>
                            <th class="w50 cell-border">{$lang.note}</th>
                        </tr>
                    </table>
                    {if $logs}
                    <table>
           		 		{foreach from=$logs item=log name=logs}
                    	<tr>
                        	<td class="w20">{$log.date|date_format:'%d %b %Y'}</td>
                            <td class="w30 cell-border">{$log.amount|price:$affiliate.currency_id}</td>
                            <td class="w50 cell-border">{$log.note}</td>
                        </tr>
                        {/foreach}
                    </table>
                    {else}
                    <div class="no-results">
                        <p>{$lang.nothing}</p>
                    </div>
                    {/if}
                </div>
            </div>
        </div>


