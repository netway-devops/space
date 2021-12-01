<strong>Apps Management</strong>


<br /><br />

<table cellpadding="3" cellspacing="0" width="100%" style=" font-size:14px;">
		<tr bgcolor="#91b0c1">
			<th width="20%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;"><div align="center">Apps Name</div></th>
			<th width="20%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;"><div align="center">URL</div></th>
			<th width="20%" style="color:#fff; padding:4px; font-weight:bold;border-right:1px solid #ffffff; border-bottom:1px solid #ffffff; text-align:center;"><div align="center">Account Number</div></th>
		</tr>		
	 	{foreach from=$aLog key=k item=i}
		<tr>
			<td>{$i->log_date_format}</td>
			<td>{$i->vip_acct_name}</td>
			<td>{$i->vip_acct_name}</td>
		</tr>
		{/foreach}
</table>

