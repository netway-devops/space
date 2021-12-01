{php}
    $templatePath   = $this->get_template_vars('template_path');
    include($templatePath . 'services/service_details.tpl.php');
{/php}

{if $custom_template}
    {include file="services/service_upgrades.tpl"}
    {include file=$custom_template}
{elseif $widget.replacetpl}
    <div class="widget">
        {include file=$widget.replacetpl}
    </div>
{else}
    <section class="d-flex flex-row flex-wrap align-items-center mb-3">
        <p class="mb-0">
            <i class="material-icons icon-info-color">cloud</i>
            <span class="h2 mb-0 pb-0 ml-3 align-middle">{$service.name}</span>
            {if $service.label!=''}
                <span class="ml-3 badge badge-secondary badge-styled">{$service.label}</span>
            {/if}
            <span class="ml-3 badge badge-{$service.status}">{$lang[$service.status]}</span>
        </p>
    </section>

    <div class="font-weight-normal m-0 p-0">
        <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
            {if $service.domain}
                {$service.domain}
            {else}
                {$service.catname}
            {/if}
        </a>
    </div>

    <section class="section-account section-account-service row {if $service.layout === 'right'} flex-row-reverse {/if}">
            {if $service.layout === 'left' || $service.layout === 'right'}
                <div class="px-0 col-12 col-md-3">
                    <div class="mb-5 {if $service.layout === 'left'}pr-md-3{elseif $service.layout === 'right'}pl-md-5{/if}">
                        <ul class="leftnavigation-box nav flex-column">
                            {include file='services/left_nav_service.tpl' widget_group='sidemenu'}
                        </ul>
                    </div>
                </div>
                <hr class="d-block d-md-none border-light">
            {/if}
            <div class="px-0 col-12 {if $service.layout === 'top'}{else}col-md-9{/if}">
                <div class="w-100">
                    <div class="mb-2 mt-1 cloud d-flex flex-row justify-content-between position-relative align-items-center">
                        {if !$widget.appendtpl}
                            <h4>{$lang.servicedetails}</h4>
                        {else}
                            <div></div>
                        {/if}
                        <ul class="position-relative service-header-menu d-fle flex-row align-items-center" id="vm-menu">
                            {if $service.layout === 'top'}
                                {include file='services/left_nav_service.tpl' widget_group='all'}
                            {else}
                                {include file='services/left_nav_service.tpl' widget_group='apps'}
                            {/if}
                        </ul>
                    </div>
                    {include file="services/service_upgrades.tpl"}
                    {if $widget.appendtpl}
                        <div class="widget">
                            {include file=$widget.appendtpl}
                        </div>
                    {else}
                        {include file='services/service_billing2.tpl'}
                        {if $custom_clientarea}
                            {include file=$custom_clientarea}
                        {/if}
                        {if $service.isvpstpl}
                            {include file="services/services.vps.tpl"}
                        {elseif $service.isvps && !$service.isvpstpl}
                            <section class="bordered-section mt-2 service-details">
                                {if $service.bw_limit!='0'}
                                    <div class="service-details-line p-4">
                                        <small class="d-block font-weight-bold mb-2">{$lang.bandwidth}</small>
                                        <span class="text-small break-word">{$service.bw_limit} {$lang.gb}</span>
                                    </div>
                                {/if}
                                {if $service.disk_limit!='0'}
                                    <div class="service-details-line p-4">
                                        <small class="d-block font-weight-bold mb-2">{$lang.disk_limit}</small>
                                        <span class="text-small break-word">{$service.disk_limit} {$lang.gb}</span>
                                    </div>
                                {/if}
                                {if $service.guaranteed_ram!='0'}
                                    <div class="service-details-line p-4">
                                        <small class="d-block font-weight-bold mb-2">{$lang.memory}</small>
                                        <span class="text-small break-word">{$service.guaranteed_ram} {$lang.mb}</span>
                                    </div>
                                {/if}
                                {if $service.burstable_ram!='0'}
                                    <div class="service-details-line p-4">
                                        <small class="d-block font-weight-bold mb-2">{$lang.burstable_ram}</small>
                                        <span class="text-small break-word">{$service.burstable_ram}  {$lang.mb}</span>
                                    </div>
                                {/if}

                                {if $ipam_ips}
                                    {foreach from=$ipam_ips.servers item=serv}
                                        <div class="service-details-line p-4">
                                            <small class="d-block font-weight-bold mb-2">{$lang.ips}</small>
                                            <div class="table-responsive">
                                                <table class="table position-relative stackable">
                                                    <tr>
                                                        <td style="padding-left: 0" width="50%"><b>{$lang.ip_subnet}:</b></td>
                                                        <td width="50%">{$serv.subnet}</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-left: 0" width="50%"><b>{$lang.ip_gateway}:</b> </td>
                                                        <td width="50%">{$serv.gateway}</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-left: 0" width="50%"><b>{$lang.main_ip}:</b></td>
                                                        <td width="50%">{$ipam_ips.main_ip}</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-left: 0" width="50%"><b>{$lang.additionalip}:</b></td>
                                                        <td width="50%">{foreach from=$serv.ips_ranges item=ip}{$ip}<br />{/foreach}</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    {/foreach}
                                {else}
                                    <div class="service-details-line p-4">
                                        <small class="d-block font-weight-bold mb-2">{$lang.ipadd}</small>
                                        <span class="text-small break-word">{if $service.vpsip}{$service.vpsip}{else}{$service.ip}{/if}</span>
                                    </div>
                                    {if $service.additional_ip}
                                        <div class="service-details-line p-4">
                                            <small class="d-block font-weight-bold mb-2">{$lang.additionalip}</small>
                                            <span class="text-small break-word">{foreach from=$service.additional_ip item=ip}{$ip}<br />{/foreach}</span>
                                        </div>
                                    {/if}
                                {/if}
                                {if $service.extra_details.ipmi}
                                    <!-- ipmi data -->
                                    <div class="service-details-line p-4">
                                        {if $service.extra_details.ipmi.vnc}
                                            <div class="mb-3">
                                                <small class="d-block font-weight-bold mb-2">{$lang.urlKVM}</small>
                                                    <span class="text-small break-word">
                                                    <a href="{$service_url}&make=openipmi" target="_blank">{$lang.urlKVM}</a>
                                                </span>
                                            </div>
                                        {else}
                                            <div class="mb-3">
                                                <small class="d-block font-weight-bold mb-2">{$lang.urlKVM}</small>
                                                <span class="text-small break-word">{if $service.extra_details.ipmi.ipmiweburl}{$service.extra_details.ipmi.ipmiweburl}{else}{$service.extra_details.ipmi.ipmiweburl}{/if}</span>
                                            </div>
                                            <div class="mb-3">
                                                <small class="d-block font-weight-bold mb-2">{$lang.ipaddressKVM}</small>
                                                <span class="text-small break-word">{if $service.extra_details.ipmi.ipmiip}{$service.extra_details.ipmi.ipmiip}{else}{$service.extra_details.ipmi.ipmiip}{/if}</span>
                                            </div>
                                        {/if}
                                        <div class="mb-3">
                                            <small class="d-block font-weight-bold mb-2">{$lang.usernameKVM}</small>
                                            <span class="text-small break-word">{if $service.extra_details.ipmiuser}{$service.extra_details.ipmiuser}{else}{$service.extra_details.ipmiuser}{/if}</span>
                                        </div>
                                        <div class="mb-3">
                                            <small class="d-block font-weight-bold mb-2">{$lang.passwordKVM}</small>
                                            <span class="text-small break-word"><span style="display:none" id="showpassword">{$service.password}</span> <a href="#" onclick="$(this).hide();$('#showpassword').show();return false;" class="fs11">{$lang.revealpassword}</a></span>
                                        </div>
                                    </div>
                                {/if}
                            </section>
                        {/if}
                        {include file='services/service_forms.tpl'}
                        {if $addons || $haveaddons}
                            <div class="d-flex flex-row justify-content-between align-items-center mt-5 mb-3">
                                <h4 class="">{$lang.accaddons|capitalize}</h4>
                                <span>
                            {if $service.status!='Fraud' && $service.status!='Cancelled' && $service.status!='Terminated'}
                                <a href="?cmd=cart&cat_id=addons&account_id={$service.id}" class="btn btn-success btn-sm"><i class="material-icons size-sm">add</i> {$lang.addaddons}</a>
                            {/if}
                        </span>
                            </div>
                            <div class="table-responsive table-borders table-radius">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="w-25">{$lang.addon}</th>
                                        {if $service.showbilling}
                                            {if "acl_user:billing.serviceprices"|checkcondition}
                                                <th>{$lang.price}</th>
                                            {/if}
                                            <th>{$lang.nextdue}</th>
                                            <th >{$lang.status}</th>
                                        {/if}
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach from=$addons item=addon name=foo}
                                        <tr>
                                            <td>
                                                {$addon.name}
                                                {if $addon.info && $addon.status == 'Active'}
                                                    <a class="text-danger text-small" href="" onclick="showAddonInfo(this,{$addon.id}); return false;">
                                                        {$lang.moreinfo}
                                                    </a>
                                                {/if}
                                            </td>
                                            {if $service.showbilling}
                                                {if "acl_user:billing.serviceprices"|checkcondition}
                                                    <td>{$addon.recurring_amount|price:$currency}</td>
                                                {/if}
                                                <td align="center">{$addon.next_due|dateformat:$date_format}</td>
                                                <td align="center" ><span class="badge badge-{$addon.status}">{$lang[$addon.status]}</span></td>
                                            {/if}
                                        </tr>
                                        {if $addon.info && $addon.status == 'Active'}
                                            <tr class="addoninfo_r{$addon.id}" style="display:none">
                                                <td colspan="4">
                                                    <div class="pt-2 pb-2">
                                                        {$addon.info|replace:'"':"'"|nl2br}
                                                    </div>
                                                </td>
                                            </tr>
                                        {/if}
                                        {foreachelse}
                                        <tr>
                                            <td colspan="4">{$lang.nothing}</td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        {/if}
                    {/if}
                </div>
            </div>
        </section>
    {literal}
        <script type="text/javascript">
            function showAddonInfo(elem, id) {
                if ($('.addoninfo_r' + id).hasClass('shown')) {
                    $('.addoninfo_r' + id).removeClass('shown').hide();
                    $(elem).html('{/literal}{$lang.moreinfo}{literal}');
                }
                else {
                    $('.addoninfo_r' + id).addClass('shown').show();
                    $(elem).html('{/literal}{$lang.hide}{literal}');
                }
            }
        </script>
    {/literal}
{/if}