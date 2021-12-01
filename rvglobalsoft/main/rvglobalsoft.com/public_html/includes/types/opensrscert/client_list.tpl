{if !$ajax}
<a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
	<colgroup class="firstcol"></colgroup>

	<colgroup class="alternatecol"></colgroup>
	<colgroup class="firstcol"></colgroup>
	<colgroup class="alternatecol"></colgroup>
	<colgroup class="firstcol"></colgroup>
	<colgroup class="alternatecol"></colgroup>
	<tbody>
		<tr>
			<th>Certificate</th>
			<th>{$lang.domain}</th>
			<th>{$lang.expirydate}</th>
			<th>{$lang.status}</th>
			<th ></th>
		</tr>
	</tbody>
	<tbody id="updater">
{/if}
		{foreach from=$services item=service name=foo}
			<tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
				<td><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}"><strong>{$service.name}</strong> </a>
				</td>
				<td><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}" style="text-decoration:none">{$service.domain}</a> 

				</td>


				<td align="center">{if $service.cert_expires!=0}{$service.cert_expires|dateformat:$date_format}{else}-{/if}</td>
				<td align="center"><span class="{$service.status}">
						{if $service.status=='Pending'}
							{$lang.Pending}
						{elseif $service.status=='Active' && $service.cert_status=='awaiting-approval' && $noapprove}
							{$lang.certprocesed}
						{elseif $service.status=='Active' && $service.cert_status!=''}
							{$service.cert_status|capitalize}
						{else}
							{$lang[$service.status]}
						{/if}</span>
				</td>
				<td align="center" class="fs11">
					{if $service.status=='Active'}
					<a href="?cmd={$cmd}&action={$action}&cid={$opdetails.id}&cert={$service.id}&amp;edo=Synchronize{*
					?cmd=clientarea&amp;action={$action}&amp;service={$service.id}&amp;edo=Synchronize*}" class="fs11 lmore">Synchronize</a>
				{*		{if $service.cert_status=='active'}
							<a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}&amp;edo=getCertificate" class="fs11 lmore">{$lang.resendcert}</a>
						{/if}
						{if $service.cert_status=='awaiting-approval' && !$noapprove}
							<a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}&amp;edo=reissue" class="fs11 lmore">{$lang.resendapprove}</a>
						{/if}*}
					{/if} 
				</td> 
			</tr>
		{/foreach}
{if !$ajax}
	</tbody>

</table>
{/if}