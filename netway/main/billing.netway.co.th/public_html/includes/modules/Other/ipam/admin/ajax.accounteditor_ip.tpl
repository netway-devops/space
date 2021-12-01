<li style="background:#ffffff" class="power_row" data_1="{$ip.item_id}" data_2="{$ip.port_id}" >
    <div style="border-bottom:solid 1px #ddd;">
        {if $ip.main}
            <input type="hidden" name="ip" value="{$i}" class="ipam_ips"  />
        {else}
            <input type="hidden" name="additional_ip[]" value="{$i}" class="ipam_ips" />
        {/if}
        <table width="100%" cellspacing="0" cellpadding="5" border="0" {if $ip.status == 'reserved'}style="background: #efefef"{/if}>
            <tbody>
            <tr>
                <td width="120" valign="top">
                    <div style="padding:10px 0px;">
                        {if $ip.id}
                            <a onclick="return advEdit('{$ip.id}')" title="Edit details"
                               class="menuitm menu-auto" href="#"><i class="fa fa-pencil"></i>
                            </a>
                        {/if}
                        <a onclick="return unassignIP('{$i}', '{$ip.listid}')" title="delete"
                           class="menuitm menu-auto" href="#"><i class="fa fa-trash-o"></i> Unassign
                        </a>
                    </div>
                </td>
                <td width="200">
                    <b>
                        {$i}
                        {if $ip.main }<span style="font-weight: normal">(Main IP)</span>{/if}
                        {if $ip.status == 'reserved'}<span style="font-weight: normal">({$ip.client_description|escape|default:"-"})</span>{/if}
                    </b>
                </td>
                <td width="150">
                    {$ip.ptrcontent|default:"-"}
                </td>
                {if $ip.domains}
                    <td width="150">
                        <dl>
                            <dd>Hostname</dd>
                            <dt>{$ip.domains}</dt>
                        </dl>
                    </td>
                {/if}
                {if $ip.rdns}<td width="150">
                    <dl>
                        <dd>rDNS</dd>
                        <dt><b>{$ip.rdns}</b></dt>
                    </dl>
                    </td>{/if}
                {if $ip.descripton}<td width="150">
                    <dl>
                        <dd>Notes</dd>
                        <dt><b>{$ip.descripton}</b></dt>
                    </dl>
                    </td>
                {/if}
                <td></td>
                <td width="160" >
                    {if $ip.vlan} VLAN: <b>{$ip.vlan}</b> {/if}
                </td>
                <td width="160" > {if $ip.inipam} IPAM list: <a class="external" target="_blank" href="?cmd=module&module=ipam&group={$ip.listid}"><b>{$ip.listname}</b></a> {/if}</td>
            </tr>
            </tbody>
        </table>
    </div>
</li>