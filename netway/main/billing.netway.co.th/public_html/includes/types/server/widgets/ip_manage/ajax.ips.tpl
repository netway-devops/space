{foreach from=$ips item=ip}
    <tr class="row-editIp_{$ip.id}">
        <td>{$ip.ipaddress}</td>
        <td class="ip_desc">{$ip.client_description|escape|default:"-"}</td>
        <td class="ip_rdns">{$ip.ptrcontent|default:"-"}</td>
        <td width="120">
            <a href="#" class="btn btn-primary btn-editIp" data-ip="{$ip.id}">{$lang.edit}</a>
        </td>
    </tr>
{/foreach}