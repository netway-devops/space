{include file="services/service_upgrades.tpl"}

{if $custom_template}
    {include file=$custom_template}
{elseif $widget.replacetpl}
    <div class="widget">
    {include file=$widget.replacetpl}
    </div>
{else}
    <article>
        <div class="pull-right">
            <a href="{$ca_url}clientarea/services/{$service.slug}/" class="btn c-white-btn"><i class="icon-back"></i>{$lang.back}</a>
        </div>
        <h2>{$service.name}</h2>
        <p class="no-icon">{if $service.domain}{$service.domain}{else}{$service.catname}{/if}</p>


        <div class="shared-wrapper clearfix">
            {include file='services/service_sidemenu.tpl'}

            <section class="shosting-container">
                <div class="header">
                    <p>{$lang.mydetails}</p>
                </div>
                <div class="padding">
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

                            <table class="table table-striped table-aff-center p-top">

                                {if $service.bw_limit!='0'}
                                    <tr>
                                        <td>{$lang.bandwidth}</td>
                                        <td>{$service.bw_limit} {$lang.gb}</td>
                                    </tr>
                                {/if} 
                                {if $service.disk_limit!='0'}
                                    <tr>
                                        <td>{$lang.disk_limit}</td>
                                        <td>{$service.disk_limit} {$lang.gb}</td>
                                    </tr>
                                {/if}
                                {if $service.guaranteed_ram!='0'}
                                    <tr>
                                        <td>{$lang.memory}</td>
                                        <td>{$service.guaranteed_ram} {$lang.mb}</td>
                                    </tr>   
                                {/if}
                                {if $service.burstable_ram!='0'}
                                    <tr>
                                        <td>{$lang.burstable_ram}</td>
                                        <td>{$service.burstable_ram}  {$lang.mb}</td>
                                    </tr>   
                                {/if}

                                <tr>
                                    <td><strong>{$lang.ipadd}</strong></td>
                                    <td>{if $service.vpsip}{$service.vpsip}{else}{$service.ip}{/if}</td>
                                </tr>
                                {if $service.additional_ip}
                                    <tr>
                                        <td valign="top" ><strong>{$lang.additionalip}</strong></td>
                                        <td>{foreach from=$service.additional_ip item=ip}{$ip}<br />{/foreach}</td>
                                    </tr>
                                {/if}
                            </table>
                        {/if}

                        {include file='services/service_forms.tpl'}

                        {if $addons || $haveaddons}
                            <div class="separator-line"></div>
                            <h3>{$lang.accaddons|capitalize}</h3>
                            <table class="table table-striped table-aff-center p-top">
                                <tr>
                                    <th class="w30">{$lang.addon}</th>
                                        {if $service.showbilling} 
                                        <th>{$lang.price}</th>
                                        <th>{$lang.nextdue}</th>
                                        <th >{$lang.status}</th>
                                        {/if}
                                </tr>
                                {foreach from=$addons item=addon name=foo}
                                    <tr>
                                        <td>
                                            {$addon.name} 
                                            {if $addon.info && $addon.status == 'Active'}
                                                <a href="" onclick="showAddonInfo(this,{$addon.id});
                                                        return false;" style="color: red; font-size: 11px">
                                                    {$lang.moreinfo}
                                                </a>
                                            {/if}
                                        </td>
                                        {if $service.showbilling}
                                            <td>{$addon.recurring_amount|price:$currency}</td>
                                            <td align="center">{$addon.next_due|dateformat:$date_format}</td>
                                            <td align="center" ><span class="label label-{$addon.status}">{$lang[$addon.status]}</span></td>
                                            {/if}
                                    </tr>
                                    {if $addon.info && $addon.status == 'Active'}
                                        <tr class="addoninfo_r{$addon.id}" style="display:none">
                                            <td colspan="4"> 
                                                <div style="padding: 10px">
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
                            </table>
                            {if $service.status!='Fraud' && $service.status!='Cancelled' && $service.status!='Terminated'}
                                {$service.id|string_format:$lang.clickaddaddons}
                            {/if}
                        {/if}
                    {/if}
                </div>
            </section>
        </div>
    </article>
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