{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax/ajax.services.tpl.php');
{/php}

{if $custom_template}
    {include file=$custom_template}
{elseif ($action=='services'  || $action=='reseller' || $action=='servers' || $action=='accounts') && $services}
    {foreach from=$services item=service name=foo}

        {assign var=serviceId value=$service.id}
        {if $isFreeDnsService}

            {if ! isset($serviceName) || $serviceName != $service.name}
            {if count($aFreeDnsServices[$serviceId])}
	        {assign var=$serviceName value=$service.name}
	        <tr>
	            <td colspan="6"><strong>{$service.name}</strong></td>
	        </tr>
	        {/if}
            {/if}
	
	        {if count($aFreeDnsServices[$serviceId])}
	        {foreach from=$aFreeDnsServices[$serviceId] key=k item=aDnsService}
	        <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
	            <td style="padding-left:50px;">
                <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={if $aDnsService.server_id == 3}{$aDnsService.domain_id}{else}{$aDnsService.domain}{/if}">{$aDnsService.domain}</a><br />
	            </td>
	            <td class="cell-border grey-c"><span class="label label-{$service.status}">{$lang[$service.status]}</span></td>
	            <td class="cell-border grey-c">{$service.total|price:$currency}</td>
	            <td class="cell-border grey-c">{$lang[$service.billingcycle]}</td>
	            <td class="cell-border grey-c">{if $service.next_due!=0}{$service.next_due|date_format:'%d %b %Y'}{else}-{/if}</td>
	            <td class="cell-border grey-c">&nbsp;</td>
	        </tr>
	        {/foreach}
	        {/if}

	        {continue}
        {/if}

        <tr>
            <td class="inline-row">
                <div class="service-name-labeled">
                    <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">
                        <span data-title="{$service.name}">{$service.name}</span>
                        <i class="serlabel-sl service_label_{$service.id}">{if $service.label} - {/if}</i>
                        <i class="serlabel-lb service_label_{$service.id}">{$service.label}</i>
                    </a>
                    <small class="text-danger serlabel-ed" data-id="{$service.id}" data-toggle="modal" href="#service_label_modal">{$lang.editlabel}</small>
                    {if $service.domain!=''}
                        <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" class="d-block text-secondary">
                            <small>({$service.domain})</small>
                        </a>
                    {/if}
                </div>
            </td>
            <td class="inline-row-right"><span class="badge badge-{$service.status}">{$lang[$service.status]}</span></td>
            {if "acl_user:billing.serviceprices"|checkcondition}
                <td data-label="{$lang.price}:">{$service.total|price:$currency}</td>
            {/if}
            <td data-label="{$lang.bcycle}:">{$lang[$service.billingcycle]}</td>
            <td data-label="{$lang.nextdue}:">{if $service.next_due!=0}{$service.next_due|dateformat:$date_format}{else}-{/if}</td>
            <td class="text-right noncrucial" style="width: 50px;" >
                <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">
                    <i class="material-icons icon-info-color">settings</i>
                </a>
            </td>
        </tr>
    {foreachelse}
        <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
    {/foreach}
    {include file='components/editlabel_modal.tpl'}

{elseif ($action=='vps') && $services}
    {foreach from=$services item=service name=foo}
        <tr>
            <td>
                <div>
                    <div class="left-row-side {$service.status}-row"></div>
                </div>
                <input type="checkbox">
            </td>
            <td>
                <div>
                    <a class="shared-hosting-title" href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">
                        {$service.name}
                        <i class="serlabel-sl service_label_{$service.id}">{if $service.label} - {/if}</i>
                        <i class="serlabel-lb service_label_{$service.id}">{$service.label}</i>
                    </a>
                    <small class="text-danger serlabel-ed" data-id="{$service.id}" data-toggle="modal" href="#service_label_modal">{$lang.editlabel}</small>
                </div>
            </td>
            <td class="badge badge-{$service.status} bold">{$lang[$service.status]}</td>
            <td><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" >{$service.domain}</a></td>
            <td>{$service.ip}</td>
            <td>{if $service.next_due!=0}{$service.next_due|dateformat:$date_format}{else}-{/if}</td>
            <td><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" class="view3">{$lang.view}</a></td>
        </tr>
    {foreachelse}
        <tr><td colspan="3">{$lang.nothing}</td></tr>
    {/foreach}

    {include file='components/editlabel_modal.tpl'}

{elseif  $customfile}
    {include file=$customfile}
{elseif $action=='customfn' && $customfn=='RebuildOS' && (!$RebuildOS.ignore || $RebuildOS.ignore.machine_id!=false)}
    <form action="" method="post">
        <div class="table-responsive table-borders table-radius">
            <table>
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
                        {else}
                            <input type="text" name="RebuildOS[os]"/>
                        {/if}
                    </td>
                    <td width="30%" valign="middle">
                        {if $RebuildOS.ignore.machine_id}
                            <input type="hidden" name="RebuildOS[machine_id]" value="{$RebuildOS.ignore.machine_id}" />
                        {/if}
                        <input type="hidden" name="customfn" value="RebuildOS" />
                        <input type="submit"  value="Rebuild OS" class="btn btn-info" onclick="$('#content').addLoader();"/>
                    </td>
                </tr>
                <tr><td colspan="3" style="color:red">{$lang.rebuild_warn}</td></tr>
                </tbody>
            </table>
        </div>
        {securitytoken}
    </form>
{elseif $action=='checkstatus' && $service}
    {if $call=='Start' || $call=='Stop' || $call=='Reboot' ||  $call=='GetStatus'}
        <div class="table-responsive table-borders table-radius">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table">
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

                {/if}
                {if $service.domain!=''}
                    <tr>
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
                    <tr>
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
                    <tr>
                        <td align="right"><h3>{$lang.memory}</h3></td>
                        <td>{$service.guaranteed_ram} {$lang.mb}</td>
                    </tr>   {/if}
                {if $service.burstable_ram && $service.burstable_ram!='0'}
                    <tr>
                        <td align="right"><h3>{$lang.burstable_ram}</h3></td>
                        <td>{$service.burstable_ram} {$lang.mb}</td>
                    </tr>   {/if}
                {if $service.vps_ip && $service.isvps}
                    <tr>
                        <td align="right"><h3>{$lang.ipadd}</h3></td>
                        <td>{$service.vps_ip}</td>
                    </tr>
                {else}
                    <tr>
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
        </div>
    {elseif $call=='ResetRootPassword'}
        {$lang.click|capitalize} <a href="#"  onclick="return process('ResetRootPassword',{$service.id}, '#_rootp')">{$lang.here}</a> {$lang.vm_toreset}
    {/if}
{/if}
