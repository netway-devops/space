        <div class="text-block clear clearfix ">
        
            {include file='affiliates/summary.tpl'}
            
            <div class="clear clearfix">
                <div class="table-box">
                    <div class="table-header">
                        <h6>{$lang.yreferrals}</h6>
                        <p class="inline-block header-p">{$lang.referals_t}</p>
                    </div>
                    <table class="table table-striped table-hover">
                        <tr class="table-header-high">
                            <th class="w30">{$lang.signupdate}</th>
                            <th class="w15">{$lang.services}</th>
                            <th class="w15 cell-border">{$lang.total}</th>
                            <th class="w10 cell-border">{$lang.commission}</th>
                            <th class="w15 cell-border">{$lang.status}</th>
                        </tr>
                    </table>
                        	{if $orders}
                            <table class="table table-striped table-hover">
        						{foreach from=$orders item=order name=orders}
                        			<tr>
                                    	<td>{$order.date_created|date_format:'%d %b %Y'}</td>
                                        <td>
                                            {if $order.acstatus}
                                            {$lang.Account}: {$order.pname}
                                            {/if}
                                            {if $order.domstatus}
                                            <br />{$lang.Domain}: {$order.domain}
                                            {/if}
                                        </td>
                                        <td>{$order.total|price:$order.currency_id}</td>
                                        <td>{$order.commission|price:$affiliate.currency_id}</td>
                                        <td><strong>{if $order.paid=='1'}{$lang.approved}{else}{$lang.Pending}{/if}</strong></td>
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
 