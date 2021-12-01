<form action="#" method="POST">
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
	            <td  valign="top">
	                <div id="bodycont" >
	                    <div class="blu">
	                        <h1>Cron update status log</h1>
	                        <br />
	                        Limit <input type="text" name="limit-edit" value="{$limit}" style="text-align:right;" size="2"/> <button type="submit">Save</button>
	                        <table class="glike hover" width="100%">
	                            <tr>
	                                <th><div align="center">Account ID</div></th>
	                                <th><div align="center">Order ID</div></th>
	                                <th><div align="center">Client Name</div></th>
	                                <th><div align="center">Account Status</div></th>
	                                <th><div align="center">Common Name</div></th>
	                                <th><div align="center">Symantec Status</div></th>
	                                <th><div align="center">Certificate Status</div></th>
	                                <th><div align="center">Last Run</div></th>
	                            </tr>
	                            {assign var="i" value="0"}
	                            {foreach from=$aData item=eData}
	                            {if $i < $limit}
	                            	{assign var="style" value=" style='background-color: #6ffc9e;'"}
	                            {elseif $i%($limit*2) >= $limit}
	                            	{assign var="style" value=" style='background-color: #dddddd;'"}
	                            {else}
	                            	{assign var="style" value=""}
	                            {/if}
	                            <tr>
	                                <td{$style}><div align="center"><a href="{$admin_url}/?cmd=accounts&action=edit&id={$eData.account_id}" target="_blank">{$eData.account_id}</a></div></td>
	                                <td{$style}><div align="center">{$eData.order_id}</div></td>
	                                <td{$style}><div align="center">{$eData.firstname} {$eData.lastname}</div></td>
	                                <td{$style}><div align="center">{$eData.status}</div></td>
	                                <td{$style}><div align="center">{$eData.commonname}</div></td>
	                                <td{$style}><div align="center">{$eData.symantec_status}</div></td>
	                                <td{$style}><div align="center">{$eData.cert_status}</div></td>
	                                <td{$style}><div align="center">{$eData.last_updated|date_format:"%d %b %Y %R:%S"} GMT+0</div></td>
	                            </tr>
	                            {assign var="i" value=$i+1}
	                            {/foreach}
	                        </table>
	                        <br>
							&nbsp;&nbsp;&nbsp;&nbsp;<font size="2"><b>Total {$aData|@count} order{if $aData|@count > 1}s{/if}</b></font>
	                    </div>
	                </div>
	            </td>
	        </tr>
	        <tr><td>&nbsp;</td></tr>
	        <tr><td>&nbsp;</td></tr>
	        <tr>
	        	<td></td>
	        	<td>
	        	<div id="bodycont" >
	                <div class="blu">
	                	<h1>Cron Tasks table</h1>
	                    <br />
			        	<table border="1" style="border-collapse: collapse;" with="100%">
			        		<tr>
			        			<th width="50%">Task Name</th>
			        			<th width="50%">Last Run</th>
			        		</tr>
			        		{foreach from=$cronTask item=eachTask}
			        		<tr>
					            <td align='left' class='thright' >{$eachTask.name}</td>
					            <td align='center' style='padding-bottom:10px'>{$eachTask.lastrun} GMT+0</td>
					        </tr>
				            {/foreach}
			        	</table>
			        </div>
	            </td>
	        </tr>
	    </tbody>
	</table>
</form>