{if $layer && $customfile}
{if $vpsdo=='metered_history'}

                   {include file="`$cloudstackdir`metered_table.tpl"}
{elseif $vpsdo=='clientsvms'}
<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td></td>
            <td>Label</td>
            <td>Hostname</td>
            <td>IP Address</td>
            <td>Disk Space</td>
            <td>Memory</td>
            <td></td>
            <td></td>
        </tr>
    </thead>
    <tbody>
        {if $MyVMs}
        {foreach from=$MyVMs item=vm name=foo}
        <tr >
            <td class="power-status">{if $vm.power=='true'}<span class="yes">Yes</span>{else}<span class="no">No</span>{/if}</td>
            <td ><strong>{$vm.label}</strong></td>
            <td>{$vm.hostname}</td>
            <td>{foreach from=$vm.ip item=ipp name=ssff}{$ipp}{if !$smarty.foreach.ssff.last},{/if} {/foreach}</td>

            <td>{$vm.disk} GB</td>
            <td>{$vm.memory} MB</td>
            <td >{if $vm.built=='true'}{if $vm.power=='true'}

                <a  onclick="return power_cloudstack($(this).attr('href'),'off')"  href="?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=clientsvms&security_token={$security_token}&machine_id={$vm.id}&do=power" class="power off-inactive" >OFF</a>
                <a class="power on-active">ON</a>

                {else}
                <a class="power off-active">OFF</a>
                <a  class="power on-inactive" onclick="return power_cloudstack($(this).attr('href'),'on')"  href="?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&security_token={$security_token}&vpsdo=clientsvms&machine_id={$vm.id}&do=power">ON</a>

                {/if}{else}<a class="power pending">{$lang.Pending}</a>{/if}

            </td>
            <td class="fs11">
                <a  href="?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&security_token={$security_token}&vpsdo=clientsvms&machine_id={$vm.id}&do=destroy" onclick="return  destroyVM_cloudstack($(this).attr('href'))" class="delbtn">{$lang.delete}</a>

            </td>
        </tr>
        {/foreach}
        {else}
        <tr>
            <td style="text-align: center; font-size: 100%; width: 100%;" colspan="8">
                This client dont have any machines created yet
            </td>
        </tr>
        {/if}
    </tbody>
</table>
{elseif $vpsdo=='metered_addusage'}
<div id="formloader" style="background:#fff;padding:10px" class="form">
    <form method="post" action="?cmd=accounts&action=edit&id={$account_id}&vpsdo=metered_addusage_store" id="subform1"><input type="hidden" name="account_id" value="{$account_id}" />
        <input type="hidden" name="variable_id" value="{$variable.id}" />
        <h3 style="margin:5px 0px 15px;">Add usage: {$variable.name}</h3>
        <label>Used <small>{$variable.unit_name}</small></label><input type="text" name="qty" class="w250" style="width:50px"/>
        <div class="clear"></div>
        <label>Notes</label><textarea name="output" class="w250"></textarea>
        <div class="clear"></div><input type="submit" style="display:none" />
    </form>
</div>
<div class="dark_shelf dbottom">
    <div class="right">
        <span class="bcontainer "><a onclick="$('#subform1').submit(); return false" href="#" class="new_control greenbtn"><span>Add usage</span></a></span>
        <span>{$lang.Or}</span>
        <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
    </div>
    <div class="clear"></div>
</div>
{elseif $vpsdo=='metered_details'}
{if $metered}
{foreach from=$metered item=m}
<tr>
    <td>{$m.name}</td>
    <td>{$m.usage} {$m.unit_name}</td>
    <td>{$m.charge|price:$currency}</td>
    <td ><a href="#" class="fs11 editbtn editgray" onclick="return metteredBillingentry_cloudstack('{$m.id}');">Usage log</a></td>
    <td ><a href="#" class="fs11 editbtn "  onclick="return metteredBillingusage_cloudstack('{$m.id}');">Add usage</a></td>
</tr>{/foreach}
{else}
<tr>
    <td colspan="5" align="center"> No data to display</td>
</tr>
{/if}

{/if}

{/if}