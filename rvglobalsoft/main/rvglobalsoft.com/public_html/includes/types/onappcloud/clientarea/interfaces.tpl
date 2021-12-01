{if $subdo=='addinterface'}
<div class="notice">{$lang.vmrebootnote}</div>
<form action="" method="post">
    <input type="hidden" name="make" value="addnewinterface">
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker">
        <tbody><tr>
                <td colspan="2">
                    <div>
                        <span class="slabel">{$lang.label}</span>
                        <input type="text" value="" class="styled" name="interface[label]"  size="30" style="min-width:250px;">

                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div>
                        <span class="slabel">{$lang.network}</span>
                        <select style="min-width:250px;" name="interface[network_join_id]" >
                            {foreach from=$networks item=n}
                            <option value="{$n.join_id}" >{$n.label}</option>
                            {/foreach}
                        </select>

                    </div>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <div class="input-with-slider">
                        <span class="slabel">{$lang.portspeed}</span>
                        <input type="text" id="rate_limit" value="1" class="styled" name="interface[rate_limit]" size="4">
                        Mbps
                        <div class='slider' max='{$limit}' total='{$limit}'  min='1' step='1' target='#rate_limit'></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="border:none">
                    <input type="submit" class="blue" value="{$lang.addnewnetwork}">
                </td>
            </tr>
        </tbody></table>
    {securitytoken} </form>
  {literal}<script type="text/javascript">

    $(document).ready(function(){
        init_sliders();
    });
</script>{/literal}
{elseif $subdo=='edit'}
<div class="notice">{$lang.vmrebootnote}</div>
<form action="" method="post">
    <input type="hidden" name="make" value="editinterface">
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker">
        <tbody><tr>
                <td colspan="2">
                    <div>
                        <span class="slabel">{$lang.label}</span>
                        <input type="text" value="{$interface.label}" class="styled" name="interface[label]"  size="30" style="min-width:250px;">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div>
                        <span class="slabel">{$lang.network}</span>
                        <select style="min-width:250px;" name="interface[network_join_id]" >
                            {foreach from=$networks item=n}
                            <option value="{$n.join_id}" {if $interface.network_join_id==$n.join_id}selected="selected"{/if}>{$n.label}</option>
                            {/foreach}
                        </select>

                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div>
                        <span class="slabel">{$lang.primary}</span>
                        <input type="checkbox" value="1" name="interface[primary]" {if $interface.primary=='true'}checked="checked"{/if}>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="input-with-slider">
                        <span class="slabel">{$lang.portspeed}</span>
                        <input type="text" id="rate_limit" value="{$interface.rate_limit}" class="styled" name="interface[rate_limit]" size="4">
                        Mbps
                        <div class='slider' max='{$interface.limit}' total='{$interface.rate_limit}'  min='1' step='1' target='#rate_limit'></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="border:none">
                    <input type="submit" class="blue" value="{$lang.savechanges}">
                </td>
            </tr>
        </tbody></table>
    {securitytoken} </form>
  {literal}<script type="text/javascript">

    $(document).ready(function(){
        init_sliders();
    });
</script>{/literal}
{else}
<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td width="50">{$lang.primary}</td>
            <td>{$lang.interface}</td>
            <td width="100">{$lang.portspeed}</td>
            <td width="120"></td>
        </tr>
    </thead>
    {foreach  from=$interfaces item=interface}
    <tr>
        <td align="center">{if $interface.primary=='true'}<img src="includes/types/onappcloud/images/icons/tick.png" alt="Primary"/>{else}{/if}</td>
        <td >{$interface.label}</td>
        <td>{if $interface.rate_limit=='0'}{$lang.unlimited}{else}{$interface.rate_limit} Mbps{/if}</td>
        <td>
          {if $o_sections.o_interfacemgmt} 
              <a class="small_control small_pencil fs11" href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=interfaces&do=edit&interface_id={$interface.id}" title="{$lang.edit}">{$lang.edit}</a>
                <a title="Delete"  href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&security_token={$security_token}&vpsdo=interfaces&do=deleteinterface&interface_id={$interface.id}" onclick="return  confirm('{$lang.suretoremoveinterface}')" class="small_control small_delete fs11">{$lang.delete}</a>
        {/if}
          </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="4">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>
{if $o_sections.o_interfacemgmt} 
<div style="padding:10px 0px;text-align:right">
    <input type="button" class="blue" onclick="window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=interfaces&vpsid={$vpsid}&do=addinterface'" value="{$lang.addnewnetwork}"/>
</div>
    {/if}
{/if}