<ul class="accor">
	<li><a href="#">Voucher</a>
		<div class="sor">
			<table width="100%" cellspacing="0" cellpadding="2" border="0" >
				<tr>
					<td width="150">Code</td>
					<td>{if $details.status!='Pending'}<input readonly="readonly" type="text"  value="{$details.extra_details.option1}"  />{else}N/A{/if}</td>
				</tr>
				<tr>
					<td>Ip range from</td>
					<td>{if $details.status=='Pending'}<input name="extra_details[option2]"  value="{$details.extra_details.option2}" type="text"/> {else} {if $details.extra_details.option2}{$details.extra_details.option2}{else}None{/if}{/if}</td>
				</tr>
				<tr>
					<td>Ip range to</td>
					<td>{if $details.status=='Pending'}<input name="extra_details[option3]"  value="{$details.extra_details.option3}" type="text"/>{else} {if $details.extra_details.option3}{$details.extra_details.option3}{else}None{/if}{/if}</td>
				</tr>
			</table>
		</div>
	</li>
</ul>