{if !$ajax}
<a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled table table-striped table-bordered">
<colgroup class="firstcol"></colgroup>

<colgroup class="alternatecol"></colgroup>
<colgroup class="firstcol"></colgroup>
<colgroup class="alternatecol"></colgroup>
<colgroup class="firstcol"></colgroup>
<colgroup class="alternatecol"></colgroup>
  <tbody>
    <tr>
      <th>{$lang.certificate}</th>
	<th >{$lang.domain}</th>
  

      <th >{$lang.expirydate}</th>
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
  <td align="center"><span class="{$service.status}">{if $service.status=='Pending'}{$lang.Pending}{elseif $service.cert_status!=''}{$service.cert_status}{else}{$lang[$service.status]}{/if}</span></td>
  <td align="center" class="fs11">
  {if $service.cert_status=='Certificate Issued'}<a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}&amp;edo=getCertificate" class="fs11">{$lang.dwdcert}</a> | {/if}
  
  {if $service.status!='Pending' && $service.cert_status=='Certificate Issued'}<a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}&amp;edo=reissue" class="fs11">{$lang.reissue}</a>{/if}
  {if $service.status=='Active' || $service.status=='Terminated'} {if $service.status!='Pending' && $service.cert_status=='Certificate Issued'}|{/if}<a href="?cmd=clientarea&amp;action=services&amp;cid={$cid}&amp;edo=renew&amp;domain={$service.domain}&amp;cat_id={$cid}&amp;pid={$service.product_id}&amp;cycle={$service.billingcycle}&amp;id={$service.id}" class="fs11 lmore">{$lang.renew}</a>{/if}
  </td>
</tr>
{/foreach}
{if !$ajax}
  </tbody>

</table>
{/if}