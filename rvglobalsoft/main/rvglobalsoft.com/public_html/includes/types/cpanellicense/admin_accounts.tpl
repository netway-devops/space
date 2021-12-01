{if $layer && $customfile}
    {if $vpsdo=='metered_history'}
        {include file="`$cpanelmanagedir`metered_table.tpl"}
    {elseif $vpsdo=='metered_addusage'}
        <div id="formloader" style="background:#fff;padding:10px" class="form">
            <form method="post" action="?cmd=accounts&action=edit&id={$account_id}&vpsdo=metered_addusage_store" id="subform1"><input type="hidden" name="account_id" value="{$account_id}"/>
                <input type="hidden" name="variable_id" value="{$variable.id}"/>
                <h3 style="margin:5px 0px 15px;">Add usage: {$variable.name}</h3>
                <label>
                    Used
                    <small>{$variable.unit_name}</small>
                </label><input type="text" name="qty" class="w250" style="width:50px"/>
                <div class="clear"></div>
                <label>Notes</label><textarea name="output" class="w250"></textarea>
                <div class="clear"></div>
                <input type="submit" style="display:none"/>
            </form>
        </div>
        <div class="dark_shelf dbottom">
            <div class="right">
                <span class="bcontainer "><a onclick="$('#subform1').submit();return false" href="#" class="new_control greenbtn"><span>Add usage</span></a></span>
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
                    <td><a href="#" class="fs11 editbtn editgray" onclick="return metteredBillingentry_cpanelmanage('{$m.id}');">Usage log</a></td>
                    <td><a href="#" class="fs11 editbtn " onclick="return metteredBillingusage_cpanelmanage('{$m.id}');">Add usage</a></td>
                </tr>
            {/foreach}
        {else}
            <tr>
                <td colspan="5" align="center"> No data to display</td>
            </tr>
        {/if}
    {/if}
{/if}