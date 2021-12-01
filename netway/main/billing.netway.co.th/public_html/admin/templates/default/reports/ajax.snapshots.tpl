{foreach from=$snapshots key=type item=sn name=snloop}
    <tr class="havecontrols  {if $smarty.foreach.snloop.index%2==0}even{/if}">
        <td>
            <a href="?cmd=reports&action=editsnapshot&id={$sn.id}">{$sn.name}</a>
        </td>
        <td>
            <a href="?cmd=reports&action=get&id={$sn.report_id}">{$sn.report_name}</a>
        </td>
        <td>
            {if $sn.frequency === 'Demand'}
                <span>On Demand</span>
            {elseif $sn.frequency === 'Daily'}
                <span>Daily at </span>
                <b>{$sn.time}</b>
            {elseif $sn.frequency === 'Weekly'}
                <span>Weekly on </span>
                <b>
                    {if $sn.day == 1} Monday
                    {elseif $sn.day == 2} Tuesday
                    {elseif $sn.day == 3} Wednesday
                    {elseif $sn.day == 4} Thursday
                    {elseif $sn.day == 5} Friday
                    {elseif $sn.day == 6} Saturday
                    {elseif $sn.day == 7} Sunday
                    {/if}
                </b>
                <span> at </span>
                <b>{$sn.time}</b>
            {elseif $sn.frequency === 'Monthly'}
                <span>Monthly every </span>
                <b>{$sn.day}</b>
                <span> day at </span>
                <b>{$sn.time}</b>
            {/if}
        </td>
        <td>
            {if $sn.target === 'None'}
                Just save report data to db
            {elseif $sn.target === 'Filesystem'}
                Save to filesystem
            {elseif $sn.target === 'Email'}
                Email to staff members
            {/if}
        </td>
        <td>
            {$sn.generated_count}
        </td>
        <td>
            {$sn.generated_at|dateformat:$date_format|default:'-'}
        </td>
        <td>
            {$sn.created_at|dateformat:$date_format}
        </td>
        <td width="50">
            {if 'acl:removeReportSnapshots'|checkcondition}
                <a href="?cmd=reports&action=removesnapshot&snapshot_id={$sn.id}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to remove this snapshot?');" class="delbtn">Delete</a>
            {/if}
        </td>
    </tr>
{/foreach}