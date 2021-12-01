{if $service.status=='Active'}
    <section class="bordered-section mt-3">
        <div class="row">
            {if $commands.GetStatus}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2"><strong>{$lang.status}</strong></small>
                        <span ><a href="#" onclick="return process('GetStatus',{$service.id})">{$lang.get_status}</a></span>
                    </div>
                </div>
            {/if}
            {if $service.domain!=''}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.hostname}</small>
                        <span ><a target="_blank" href="http://{$service.domain}">{$service.domain}</a></span>
                    </div>
                </div>
            {/if}
            {if $service.extra.showlocation && isset($service.extra.showlocation.value) && $service.extra.showlocation.value == '1'}
                <div class="col-md-6">
                    <div class="p-4" >
                        <small class="d-block font-weight-bold mb-2">{$lang.Location}</small>
                        <span >{$service.node}</span>
                    </div>
                </div>
            {/if}
            {if $commands.Reboot || $commands.Start || $commands.Stop}
                <div class="col-md-6">
                    <div class="p-4" >
                        <small class="d-block font-weight-bold mb-2">{$lang.actions}</small>
                        <span >{if $commands.Start}<a href="#" onclick="return process('Start',{$service.id})">{$lang.start}</a>{/if} {if $commands.Stop}<a href="#" onclick="return process('Stop',{$service.id})">{$lang.stop}</a>{/if} {if $commands.Reboot}<a href="#" onclick="return process('Reboot',{$service.id})">{$lang.reboot}</a>{/if}</span>
                    </div>
                </div>
            {/if}
            {if $service.bw_limit!='0'}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.bandwidth}</small>
                        <span >{$service.bw_limit} {$lang.gb}</span>
                    </div>
                </div>
            {/if} {if $service.disk_limit!='0'}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.disk_limit}</small>
                        <span >{$service.disk_limit} {$lang.gb}</span>
                    </div>
                </div>
            {/if}
            {if $service.guaranteed_ram!='0'  && $service.guaranteed_ram!=''}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.memory}</small>
                        <span >{$service.guaranteed_ram} {$lang.mb}</span>
                    </div>
                </div>
            {/if}
            {if $service.burstable_ram!='0' && $service.burstable_ram!=''}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.burstable_ram}</small>
                        <span >{$service.burstable_ram}  {$lang.mb}</span>
                    </div>
                </div>
            {/if}
            {if $service.vps_ip && $service.isvps}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.ipadd}</small>
                        <span >{$service.vps_ip}</span>
                    </div>
                </div>
            {/if}
            {if $service.additional_ip && $service.isvps}
                <div class="col-md-6">
                    <div class="p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.additionalip}</small>
                        <span >{foreach from=$service.additional_ip item=ip}{$ip}<br />{/foreach}</span>
                    </div>
                </div>
            {/if}
        </div>
    </section>
    {if $commands.FastStat}
        <div id="fstat"></div>
        <script type="text/javascript">
            var iid ={$service.id};{literal}
            ajax_update('?cmd=clientarea&action=customfn&val=FastStat&id=' + iid, {}, '#fstat');
            {/literal}
        </script>
    {/if}
{/if}