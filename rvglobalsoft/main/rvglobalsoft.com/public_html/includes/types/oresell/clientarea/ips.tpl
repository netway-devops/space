<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.ipadd}</td>
            <td>{$lang.netmask}</td>
            <td>{$lang.gateway}</td>
            <td>{$lang.interface}</td>
            <td width="60"></td>
        </tr>
    </thead>
    {foreach item=ip from=$ips}
    <tr>
        <td >{$ip.address}</td>
        <td>{$ip.netmask} </td>
        <td>{$ip.gateway}</td>
        <td>{$ip.interface}</td>
        <td>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="4">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>

