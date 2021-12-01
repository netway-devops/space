{if $custom_template}
    {include file=$custom_template}
{elseif ($action=='services'  || $action=='reseller' || $action=='servers' || $action=='accounts') && $services}
    {foreach from=$services item=service name=foo}
        <tr class="styled-row">
            <td class="w0">
                <div class="td-rel">
                    <div class="left-row-side {$service.status}-row"></div>
                </div>
            </td>
            {if $service.domain!=''}
                <td class="p2 overflow-elipsis">
                    <div>
                        <a class="shared-hosting-title" href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">{$service.name}</a>
                        {if $service.domain!=''}<a class="shared-link" href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">{$service.domain}</a>
                        {/if}
                    </div>
                </td>
            {else}
                <td class="overflow-elipsis">
                    <a class="bold" href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">{$service.name}</a>
                </td>
             {/if}
            <td class="{$service.status}-label bold">{$lang[$service.status]}</td>
            <td>{$service.total|price:$currency}</td>
            <td>{$lang[$service.billingcycle]}</td>
            <td>{if $service.next_due!=0}{$service.next_due|dateformat:$date_format}{else}-{/if}</td>
            <td class="btn-col">
                <div class="td-rel">
                    <div class="right-row-side"></div>
                </div>
                {if $service.status=='Active' }
                    <div class="btn-group">
                        <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" data-toggle="dropdown" class="btn dropdown-toggle">
                            <i class="icon-cog"></i> 
                            <span class="caret" style="padding:0"></span>
                        </a>
                        <ul class="dropdown-menu align-l dropdown-left">
                            <div class="dropdown-padding">
                                <li><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" style="color:#737373">{$lang.servicemanagement}</a></li>
                                <li><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/&cancel" style="color:#737373">{$lang.cancelrequest}</a></li>
                            </div>
                        </ul>
                    </div>
                {else}
                    <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" class="btn pull-right">
                        <i class="icon-cog"></i>
                    </a>
                {/if}			
            </div>
        </td>
    </tr>
    <tr class="empty-row">
    </tr>
{foreachelse}
    <tr><td colspan="3">{$lang.nothing}</td></tr>
{/foreach}

{elseif ($action=='vps') && $services}
    {foreach from=$services item=service name=foo}
        <tr class="styled-row">
            <td>
                <div class="td-rel">
                    <div class="left-row-side {$service.status}-row"></div>
                </div>
                <input type="checkbox">
            </td>
            <td class="p2">
                <div>
                    <a class="shared-hosting-title" href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">{$service.name}</a>
                </div>
            </td>
            <td class="{$service.status}-label bold">{$lang[$service.status]}</td>
            <td><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" >{$service.domain}</a></td>
            <td>{$service.ip}</td>
            <td>{if $service.next_due!=0}{$service.next_due|dateformat:$date_format}{else}-{/if}</td>
            <td><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" class="view3">{$lang.view}</a></td>
        </tr>
        <tr class="empty-row">
        </tr>
    {/foreach}
{elseif  $customfile}

    {include file=$customfile}

{elseif $action=='customfn' && $customfn=='RebuildOS' && (!$RebuildOS.ignore || $RebuildOS.ignore.machine_id!=false)}
    <form action="" method="post">
        <table cellspacing="6" cellpadding="" border="0" width="80%">
            <tbody><tr>
                    <td width="40%" valign="middle">
                {if $RebuildOS && $RebuildOS|is_array}{$lang.rebuild_choose}{else}{$lang.rebuild_enter}{/if}
            </td>

            <td  valign="middle">
                {if $RebuildOS && $RebuildOS|is_array}
                    <select name="RebuildOS[os]">
                        {foreach from=$RebuildOS item=plan key=kk}
                            {if !($plan|is_array)}
                                <option >{$plan}</option>
                            {elseif $kk!=="ignore"}
                                <option  value="{$plan[0]}">{$plan[1]}</option>
                            {else} {$kk}
                            {/if}
                        {/foreach}
                    </select>
            {else}<input type="text" name="RebuildOS[os]"/>{/if}
        </td>
        <td width="30%" valign="middle">
        {if $RebuildOS.ignore.machine_id}<input type="hidden" name="RebuildOS[machine_id]" value="{$RebuildOS.ignore.machine_id}" />{/if}
        <input type="hidden" name="customfn" value="RebuildOS" />
        <input type="submit"  value="Rebuild OS" class="btn btn-info" onclick="$('#content').addLoader();"/>

    </td>
</tr>
<tr><td colspan="3" style="color:red">{$lang.rebuild_warn}</td></tr>
</tbody></table>
{securitytoken}</form>
{elseif $action=='checkstatus' && $service}
    {if $call=='Start' || $call=='Stop' || $call=='Reboot' ||  $call=='GetStatus'}


    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table table-striped">
        {if $status}
            <tr >
                <td width="160" align="right"><h3>{$lang.status}</h3></td>
                <td>{if $status} {$status} <a href="#" onclick="return process('GetStatus',{$service.id})"><img src="{$template_dir}img/arrow_refresh_small.gif" alt="refresh" /></a>{else}{$lang.unknown}<a href="#" onclick="return process('GetStatus',{$service.id})">{$lang.get_status}</a>{/if}</td>
            </tr>
        {elseif $commands.GetStatus}
            <tr >
                <td width="160" align="right"><h3>{$lang.status}</h3></td>
                <td><a href="#" onclick="return process('GetStatus',{$service.id})">{$lang.get_status}</a></td>
            </tr>

        {/if}{if $service.domain!=''}
            <tr class="even">
                <td  width="160" align="right"><h3>{$lang.hostname}</h3></td>
                <td><a target="_blank" href="http://{$service.domain}">{$service.domain}</a></td>
            </tr>
        {/if}
        {if $commands.Reboot || $commands.Start || $commands.Stop}
            <tr >
                <td align="right"><h3>{$lang.actions}</td>
                <td>{if $commands.Start && $status!='Active' && $status!='Running' && $status!='online'}<a href="#" onclick="return process('Start',{$service.id})">{$lang.start}</a>{/if}
                {if (!$status && $commands.Stop) || ($commands.Stop && ($status=='Active' || $status=='Running'  || $status=='online'))}<a href="#" onclick="return process('Stop',{$service.id})">{$lang.stop}</a>{/if}
            {if $commands.Reboot}<a href="#" onclick="return process('Reboot',{$service.id})">{$lang.reboot}</a>{/if}</td>
    </tr>

{/if}
{if $service.bw_limit!='0'}
    <tr class="even">
        <td align="right"><h3>{$lang.bandwidth}</h3></td>
        <td>{$service.bw_limit} {$lang.gb}</td>
    </tr>
{/if} {if $service.disk_limit!='0'}
    <tr>
        <td align="right"><h3>{$lang.disk_limit}</h3></td>
        <td>{$service.disk_limit} {$lang.gb}</td>
    </tr>
{/if}
{if $service.guaranteed_ram && $service.guaranteed_ram!='0'}
    <tr class="even">
        <td align="right"><h3>{$lang.memory}</h3></td>
        <td>{$service.guaranteed_ram} {$lang.mb}</td>
    </tr>   {/if}
    {if $service.burstable_ram && $service.burstable_ram!='0'}
        <tr>
            <td align="right"><h3>{$lang.burstable_ram}</h3></td>
            <td>{$service.burstable_ram} {$lang.mb}</td>
        </tr>   {/if}
        {if $service.vps_ip && $service.isvps}
            <tr class="even">
                <td align="right"><h3>{$lang.ipadd}</h3></td>
                <td>{$service.vps_ip}</td>
            </tr>
        {else}
            <tr class="even">
                <td align="right"><h3>{$lang.ipadd}</h3></td>
                <td>{$service.ip}</td>
            </tr>
        {/if}

        {if $service.additional_ip}
            <tr>
                <td align="right" valign="top"><h3>{$lang.additionalip}</h3></td>
                <td>{foreach from=$service.additional_ip item=ip}{$ip}<br />{/foreach}</td>
            </tr>
        {/if}
    </table>
{elseif $call=='ResetRootPassword'}
    {$lang.click|capitalize} <a href="#"  onclick="return process('ResetRootPassword',{$service.id}, '#_rootp')">{$lang.here}</a> {$lang.vm_toreset}
{/if}  {/if}
