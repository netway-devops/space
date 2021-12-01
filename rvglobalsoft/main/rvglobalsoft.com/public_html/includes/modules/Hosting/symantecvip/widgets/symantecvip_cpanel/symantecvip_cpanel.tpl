<strong>Server Management</strong>

<br /><br /> <!-- <pre>
 {$aServer|@print_r}  
</pre>-->
<table cellpadding="3" cellspacing="0" width="100%" style=" font-size:14px;">
		<tr bgcolor="#91b0c1">
			<th width="20%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;"><div align="center">Server Name</div></th>
			<th width="20%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;"><div align="center">VIP Account</div></th>
		</tr>		
	 	{foreach from=$aServer key=k item=i}
		<tr>
			<td>{$i->hostname}</td>
			<td>{$i->cnt_vip_acct}</td>

		</tr>
		{/foreach}
</table>

