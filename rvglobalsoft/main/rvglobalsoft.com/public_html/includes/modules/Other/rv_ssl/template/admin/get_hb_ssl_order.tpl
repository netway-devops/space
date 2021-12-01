<script type="text/javascript" src="{$system_url}{$ca_url}templates/netwaybysidepad/js/jquery.datetimepicker.js"></script>
<link rel="stylesheet" type="text/css" href="{$system_url}{$ca_url}templates/netwaybysidepad/css/jquery.datetimepicker.css"/ >
<script type="text/javascript">
    {literal}
    $('document').ready(function(){
        $('.date-pick').datetimepicker();
    });
    {/literal}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td valign="top">
                <div id="bodycont" >
	                <div class="blu">
	                	<form action="#" method="POST">
                            <input type="hidden" name="maction" value="1" />
                            <table>
                                <tr>
                                    <td>From</td>
                                    <td>&nbsp;<input type="text" name="date_f" class="date-pick" value="{$from}"/></td>
                                </tr>
                                <tr>
                                    <td>To</td>
                                    <td>&nbsp;<input type="text" name="date_t" class="date-pick" value="{$to}"/></td>
                                </tr>
                                <tr>
                                    <td>With Netway order?</td>
                                    <td>&nbsp;<input type="checkbox" name="shownetway" value="1"/></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><br /><input type="submit" value="submit" /></td>
                                </tr>
                            </table>
                        </form>
			        </div>
			    </div>
            </td>
        </tr>
        {if isset($ssl_out_b64)}
        <tr>
        	<td></td>
        	<td>
        		<div id="bodycont" >
        			<div class="blu">
        				<strong>SSL</strong>
		        		<table width="100%">
		        			<col width="15%" />
		        			<col width="85%" />
		        			{if $ssl_data.count > 0}
		        			<tr>
		        				<td colspan="2">
		        					<table border="1" style="border-collapse: collapse; padding: 5px;">
		        						<tr><th style="padding: 5px;">Product</th><th style="padding: 5px;">Annually</th><th style="padding: 5px;">Biennially</th><th style="padding: 5px;">Triennially</th><th style="padding: 5px;">Income</th></tr>
					        			{foreach key=product item=data from=$ssl_data.product}
		        						<tr>
		        							<td style="padding: 5px;">{$product}</td>
		        							<td style="text-align: center; padding: 5px;">{if isset($data.Annually)}{$data.Annually}{else}-{/if}</td>
		        							<td style="text-align: center; padding: 5px;">{if isset($data.Biennially)}{$data.Biennially}{else}-{/if}</td>
		        							<td style="text-align: center; padding: 5px;">{if isset($data.Triennially)}{$data.Triennially}{else}-{/if}</td>
		        							<td style="text-align: right; padding: 5px;">$ {$data.incomes|number_format:2} USD</td>
		        						</tr>
					        			{/foreach}
		        					</table>
		        				</td>
		        			</tr>
		        			{/if}
		        			<tr>
		        				<td valign="top">
		        					TOTAL ORDERS :
		        				</td>
		        				<td>{$ssl_data.count}</td>
		        			</tr>
		        			{if $ssl_data.count > 0}
		        			<tr>
		        				<td valign="top">
		        					JSON RAW DATA :
		        				</td>
		        				<td>
		        					<form action="#" method="POST">
		        						<input type="hidden" name="s_action" value="download" />
		        						<input type="hidden" name="type" value="SSL" />
		        						<input type="hidden" name="data" value="{$ssl_out_b64}" />
		        						<input type="submit" value="DOWNLOAD" />
		        					</form>
		        				</td>
		        			</tr>
		        			{/if}
		        		</table>
        			</div>
        		</div>
        	</td>
        </tr>
        {/if}
        {if isset($license_out_b64)}
        <tr>
        	<td></td>
        	<td>
        		<div id="bodycont" >
        			<div class="blu">
        				<strong>License</strong>
		        		<table width="100%">
		        			<col width="15%" />
		        			<col width="85%" />
		        			{if $license_data.count > 0}
		        			<tr>
		        				<td colspan="2">
		        					<table border="1" style="border-collapse: collapse; padding: 5px;">
		        						<tr><th style="padding: 5px;">Product</th><th style="padding: 5px;">Monthly</th><th style="padding: 5px;">Quarterly</th><th style="padding: 5px;">Semi-Annually</th><th style="padding: 5px;">Annually</th><th style="padding: 5px;">Income</th></tr>
					        			{foreach key=product item=data from=$license_data.product}
		        						<tr>
		        							<td style="padding: 5px;">{$product}</td>
		        							<td style="text-align: center; padding: 5px;">{if isset($data.Monthly)}{$data.Monthly}{else}-{/if}</td>
		        							<td style="text-align: center; padding: 5px;">{if isset($data.Quarterly)}{$data.Quarterly}{else}-{/if}</td>
		        							<td style="text-align: center; padding: 5px;">{if isset($data.SemiAnnually)}{$data.SemiAnnually}{else}-{/if}</td>
		        							<td style="text-align: center; padding: 5px;">{if isset($data.Annually)}{$data.Annually}{else}-{/if}</td>
		        							<td style="text-align: right; padding: 5px;">$ {$data.incomes|number_format:2} USD</td>
		        						</tr>
					        			{/foreach}
		        					</table>
		        				</td>
		        			</tr>
		        			{/if}
		        			<tr>
		        				<td valign="top">
		        					TOTAL ORDERS :
		        				</td>
		        				<td>{$license_data.count}</td>
		        			</tr>
		        			{if $license_data.count > 0}
		        			<tr>
		        				<td valign="top">
		        					JSON RAW DATA :
		        				</td>
		        				<td>
		        					<form action="#" method="POST">
		        						<input type="hidden" name="s_action" value="download" />
		        						<input type="hidden" name="type" value="License" />
		        						<input type="hidden" name="data" value="{$license_out_b64}" />
		        						<input type="submit" value="DOWNLOAD" />
		        					</form>
		        				</td>
		        			</tr>
		        			{/if}
		        		</table>
        			</div>
        		</div>
        	</td>
        </tr>
        {/if}

    </tbody>
</table>
