{if !$ajax}
<style type="text/css">
{literal}

.vpstable {
background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/under-nav-bar-wide2.gif") no-repeat scroll 0 0 transparent;
}

.vpstable thead tr {
height:27px;
}
.vpstable td {
padding:5px;}
.vpstable thead td {
background:none repeat scroll 0 0 transparent;
border:medium none;
color:#005BB8;
font-size:90%;
font-weight:bold;
text-transform:uppercase;
height:17px;}
.vpstable tbody td {
border:none;
border-bottom:solid 1px #dddddd;
border-right:solid 1px #dddddd;
}
.vpstable tbody td.firsta {
border-left:solid 1px #dddddd;
} 
.vpstable tbody tr:hover td {
background:#FFF5BD;
}



{/literal}
</style>

<a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="vpstable">

  <thead>
    <tr>
      <td>{$lang.service}</td>   
	  <td>{$lang.hostname}</td>		 
	   <td >{$lang.ipadd}</td>
	 

      <td>{$lang.status}</th>
      <td width="20"></td>
    </tr>
  </thead>
  <tbody id="updater">
{/if}
  {foreach from=$services item=service name=foo}
 <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
  <td class="firsta"><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}"><strong>{$service.name}</strong> </a>

     </td>
  <td width="20%"><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}" style="text-decoration:none">{$service.domain}</a> </td>
  <td width="20%" align="center">{if $service.ip!='0.0.0.0'}{$service.ip}{else}-{/if}</td>
  <td width="20%" align="center"><span class="{$service.status}">{$lang[$service.status]}</span></td>
  <td  align="center" width=40><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}" class="view3">view</a></td>
</tr>
{/foreach}
{if !$ajax}
  </tbody>

</table>
  {/if}