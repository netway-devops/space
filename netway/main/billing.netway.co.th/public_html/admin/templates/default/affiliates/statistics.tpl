<div style="padding: 7px;">
    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
        <tbody>
        <tr>
            <th colspan="4" align="left">Available statistics/reports</th>
        </tr>
        {foreach from=$statistics item=statistic}
            <tr class="havecontrols even ">
                <td><a href="?cmd=reports&action=get&id={$statistic.id}">{$statistic.name}</a></td>
                {if !($statistic.options & 1)}
                    <td width="60">
                        <a href="?cmd=reports&action=delete&id={$statistic.id}&security_token={$security_token}" style="float: right" onclick="return confirm('Are you sure you wish to remove this report?');" class="delbtn">Delete</a>
                    </td>
                {else}
                    <td width="60">
                        <a href="?cmd=reports&action=customize&id={$statistic.id}&security_token={$security_token}" class="editbtn editgray">Customize</a>
                    </td>
                {/if}
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>