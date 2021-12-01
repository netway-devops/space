        <div class="text-block clear clearfix">
        
            {include file='affiliates/summary.tpl'}
            
            <div class="clear clearfix">
                <div class="table-box">
                    <div class="table-header">
                        {if $payout}
                        <div class="right-btns">
                            <a href="{$ca_url}tickets/new/" class="clearstyle green-custom-btn btn"><i class="icon-success"></i> {$lang.payout}</a>
                        </div>
                        {/if}
                        <h6>{$lang.affiliate}</h6>
                        <p class="inline-block header-p">{$lang.Statistics}</p>
                    </div>
                    <table class="table table-striped table-hover">
                        <tr>
                            <td>{$lang.Commissions}:</td>
                            <td><strong>{$stats.monthly_commision}</strong> / <strong>{$stats.total_commision}</strong> ({$lang.thismonth} / {$lang.total})</td>
                        </tr>
                        <tr class="even">
                            <td>{$lang.referred}</td>
                            <td class="cell-border">{$stats.monthly_visits} / {$stats.total_visits} ({$lang.thismonth} / {$lang.total})</td>
                        </tr>
                        <tr >
                            <td>{$lang.singupreferred}</td>
                            <td class="cell-border">{$stats.monthly_singups} / {$stats.total_singups} ({$lang.thismonth} / {$lang.total})</td>
                        </tr>
                        <tr class="even">
                            <td>{$lang.curbalance}</td>
                            <td class="cell-border">{$affiliate.balance|price:$affiliate.currency_id}</td>
                        </tr>
                    </table>
                </div>
                {if $integration_code!=''}
                  <div class="row">
                  <div class="span6">
                  <h3>{$lang.intcodes}</h3>
                  <pre class="prettyprint linenums">{$integration_code|escape}</pre>
                  </div>
                  <div class="span6">
                  
                  
                  <h3>{$lang.preview}</h3>
                  {$integration_code}
                  </div>
                  <div class="clear"></div>
                  </div>
                
                {/if}
            </div>
        </div>
