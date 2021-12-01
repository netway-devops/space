{if $customfn=='ReverseDNS'}
	
		<div class="wbox">
			<div class="wbox_header">Reverse DNS</div>
			<div class="wbox_content">
			{if $ReverseDNS}
				<center>
					<table width="50%">
						<tr>
							<th>IP</th>
							<th>Record</th>							
						</tr>
						{foreach from=$ReverseDNS item=record}
							<tr>
								<td>{$record[0]}</td>
								<td>{$record[1]}</td>
							</tr>
						{/foreach}
					</table>
				</center>
				{else}
				You dont have any Reverse DNS records available at a time{/if}
			
			</div>
		
		</div>

{elseif $customfn=='FastStat' && $FastStat}
<table class="checker" width="100%">
	<tr >
		<td width="160" align="right">Hostname</td>
		<td>{$FastStat.hostname}</td>
	</tr>
	<tr >
		<td width="160" align="right">Root Password</td>
		<td>{$FastStat.rootpass}</td>
	</tr>

	<tr >
		<td width="160" align="right">Mac Address</td>
		<td>{$FastStat.macaddress}</td>
	</tr>
	<tr >
		<td width="160" align="right">Processor</td>
		<td>{$FastStat.proc}</td>
	</tr>
	<tr >
		<td width="160" align="right">Operating System</td>
		<td>{$FastStat.os}</td>
	</tr>
	<tr >
		<td width="160" align="right">Cabinet / U-space</td>
		<td>{$FastStat.cab} / {$FastStat.cab_u}</td>
	</tr>

	<tr >
		<td width="160" align="right">HDD #1</td>
		<td>{$FastStat.d1}</td>
	</tr>
	{if $FastStat.d2!='None'}<tr >
		<td width="160" align="right">HDD #1</td>
		<td>{$FastStat.d2}</td>
	</tr>{/if}
	{if $FastStat.d3!='None'}<tr >
		<td width="160" align="right">HDD #3</td>
		<td>{$FastStat.d3}</td>
	</tr>{/if}
	{if $FastStat.d4!='None'}<tr >
		<td width="160" align="right">HDD #4</td>
		<td>{$FastStat.d4}</td>
	</tr>{/if}
	
	
</table>


	
{/if}