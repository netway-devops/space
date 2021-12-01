<!--
<div class="notice">{$lang.networkrebuildnote}</div>
-->
<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.ipadd}</td>
            <td width="60"></td>
        </tr>
    </thead>
    {foreach from=$ips.public item=ip}
    <tr>
        <td >{$ip.address}</td>
     
        <td>&nbsp;
          {if $ip.floating} <a title="Delete"  href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}&do=deleteip&ipid={$ip.floating}&ip={$ip.address}&security_token={$security_token}" onclick="return  confirm('{$lang.suretodeleteip}?')" class="small_control small_delete fs11">{$lang.delete}</a> {/if}
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="2">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>

<div style="padding:10px 0px;text-align:right">

	
    {if $allowaddingip}
    <input type="button" class="blue" onclick="window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}&do=assignip&security_token={$security_token}'" value="{$lang.assign_new_ip}"/>
    <span class="text">{$lang.freeipleft1} <b>{$allowaddingip}</b> {$lang.freeipleft}</span>

    {/if}
</div>