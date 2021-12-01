<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td  class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td  valign="top" class="bordered">
                <div id="bodycont" >
                    <div class="blu">
                        <h1>Find Account(s) by Partner Order ID</h1>
                        <form action="?cmd={$cmd}&module={$module}&action=edit_recommend_price&security_token={$security_token}" method="post" id="find_partner_id" >


                        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                            <tbody>
                            	<tr>
                            		<th colspan="5"></th>
                            		<th colspan="3"><div align="center">SAN</div></th>
                            	</tr>
                                <tr>
                                    <th width="25%">SSL Name</th>
                                    <th width="10%">Pricing(USD)</th>
                                    <th width="10%">1 Year</th>
                                    <th width="10%">2 Year</th>
                                    <th width="10%">3 Year</th>
                                    <th width="10%">1 Year</th>
                                    <th width="10%">2 Year</th>
                                    <th width="10%">3 Year</th>
                                </tr>
                            </tbody>
                            <tbody id="updater">
                            {foreach from=$aSSLPriceDetails item=SSLPriceDetails}
                                <tr>
                                    <td rowspan="3"><b>{$SSLPriceDetails.ssl_name}</b></td>
                                    <th>Costs:</th>
                                    <td><font color="#0000FF">{$SSLPriceDetails.contract.12.costs}</font></td>
                                    <td><font color="#0000FF">{$SSLPriceDetails.contract.24.costs}</font></td>
                                    <td><font color="#0000FF">{$SSLPriceDetails.contract.36.costs}</font></td>
                                    <td><font color="#0000FF">{if isset($SSLPriceDetails.addon.12.costs)}{$SSLPriceDetails.addon.12.costs}{else}0.00{/if}</font></td>
                                    <td><font color="#0000FF">{if isset($SSLPriceDetails.addon.24.costs)}{$SSLPriceDetails.addon.24.costs}{else}0.00{/if}</font></td>
                                    <td><font color="#0000FF">{if isset($SSLPriceDetails.addon.36.costs)}{$SSLPriceDetails.addon.36.costs}{else}0.00{/if}</font></td>
                                </tr>
                                <tr>
                                    <th>Initial:</th>
                                    <td>{if $SSLPriceDetails.contract.12.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][12][initial_price]]" class="inp" size="4" value="{$SSLPriceDetails.contract.12.initial_price}" />
                                        {else}
                                            -
                                        {/if}
                                    </td>
                                    <td>{if $SSLPriceDetails.contract.24.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][24][initial_price]]" class="inp" size="4" value="{$SSLPriceDetails.contract.24.initial_price}" />
                                        {else}
                                        -
                                        {/if}
                                    </td>
                                    <td>{if $SSLPriceDetails.contract.36.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][36][initial_price]]" class="inp" size="4" value="{$SSLPriceDetails.contract.36.initial_price}" />
                                        {else}
                                        -
                                        {/if}
                                        </td>
                                    <td>{if isset($SSLPriceDetails.addon.12.costs) && $SSLPriceDetails.addon.12.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][12][addon][initial_price]]" class="inp" size="4" value="{$SSLPriceDetails.addon.12.initial_price}" />
                                        {else}
                                        -
                                        {/if}
                                        </td>
                                    <td>{if isset($SSLPriceDetails.addon.24.costs) && $SSLPriceDetails.addon.24.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][24][addon][initial_price]]" class="inp" size="4" value="{$SSLPriceDetails.addon.24.initial_price}" />
                                        {else}
                                        -
                                        {/if}
                                        </td>
                                    <td>{if isset($SSLPriceDetails.addon.36.costs) && $SSLPriceDetails.addon.36.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][36][addon][initial_price]]" class="inp" size="4" value="{$SSLPriceDetails.addon.36.initial_price}" />
                                        {else}
                                        -
                                        {/if}
                                        </td>
                                </tr>
                                <tr>
                                    <th>Renewal:</th>
                                    <td>{if $SSLPriceDetails.contract.12.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][12][renewal_price]]" class="inp" size="4" value="{$SSLPriceDetails.contract.12.renewal_price}" />
                                        {else}
                                            -
                                        {/if}
                                    </td>
                                    <td>{if $SSLPriceDetails.contract.24.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][24][renewal_price]]" class="inp" size="4" value="{$SSLPriceDetails.contract.24.renewal_price}" />
                                        {else}
                                        -
                                        {/if}
                                    </td>
                                    <td>{if $SSLPriceDetails.contract.36.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][36][renewal_price]]" class="inp" size="4" value="{$SSLPriceDetails.contract.36.renewal_price}" />
                                        {else}
                                        -
                                        {/if}
                                    </td>
                                    <td>{if isset($SSLPriceDetails.addon.12.costs) && $SSLPriceDetails.addon.12.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][12][addon][renewal_price]]" class="inp" size="4" value="{$SSLPriceDetails.addon.12.renewal_price}" />
                                        {else}
                                        -
                                        {/if}
                                        </td>
                                    <td>{if isset($SSLPriceDetails.addon.24.costs) && $SSLPriceDetails.addon.24.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][24][addon][renewal_price]]" class="inp" size="4" value="{$SSLPriceDetails.addon.24.renewal_price}" />
                                        {else}
                                        -
                                        {/if}
                                        </td>
                                    <td>{if isset($SSLPriceDetails.addon.36.costs) && $SSLPriceDetails.addon.36.costs != '0.00'}
                                        <input name="price[{$SSLPriceDetails.ssl_id}][36][addon][renewal_price]]" class="inp" size="4" value="{$SSLPriceDetails.addon.36.renewal_price}" />
                                        {else}
                                        -
                                        {/if}
                                        </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                        <div class="clear"></div>
                            <div class="blu">
                            <div class="right"><div class="pagination"></div></div>
                            <div class="left menubar"><b>Action:</b>
                                <input type="hidden" name="do_edit" value="do_edit" />
                                <input type="submit" name="submit" value="Submit" />  <input type="reset" name="reset" value="Reset" />
                            </div>
                            <div class="clear"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>