<table class="glike hover" border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
        <tr>
            <th>Subnet </th>
            <th> Client owned IPs count</th>
            <th class="lastelb">Description </th>
        </tr>
    </tbody>
    <tbody>
        {foreach from=$lists item=list}
        <tr>
            <td><a href="?cmd=ipam&action=details&group={$list.id}" target="_blank">{$list.name}</a></td>
            <td>{$list.owned}</td>
            <td>{$list.description}</td>
        </tr>
        {foreachelse}
            <tr><td colspan="3" style="text-align: center">No IPs assigned yet</td></tr>
        {/foreach}
    </tbody>
</table>