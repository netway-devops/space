<div class="container-fluid clear tabs tab-synchronization" style="margin-top:10px;">
    <div class="row">
        <div class="col-md-12">
            <table style="margin-bottom: 20px;" width="100%" cellspacing="0" cellpadding="10">
                <tr class="bordme">
                    <td align="right" width="205"><strong>Enable Synchronization</strong></td>
                    <td>
                        <input name="configuration[EnableDomainSync]" type="radio" value="on" {if $configuration.EnableDomainSync == 'on'}checked{/if}> <strong>Yes</strong>
                        <br/>
                        <input name="configuration[EnableDomainSync]" type="radio" value="off" {if $configuration.EnableDomainSync != 'on'}checked{/if}> <strong>No</strong>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Module List</strong> <i class="vtip_description" title="Modules for which automatic synchronization will be performed. When the list is empty, synchronization will be performed for all modules"></i></td>
                    <td>
                        <select name="configuration[DomainModulesSync][]" class="chosenedge" multiple id="DomainModulesSync">
                            {foreach from=$modules item=module key=id}
                                <option value="{$id}" {if in_array($id, $configuration.DomainModulesSync)}selected{/if}>{$module}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Domain Statuses</strong> <i class="vtip_description" title="List of domain statuses for which synchronization will be performed. When the field is empty, the default value will be used. Default: Active"></i></td>
                    <td>
                        <select name="configuration[DomainStatusesSync][]" class="chosenedge" multiple id="DomainStatusesSync">
                            {foreach from=$statuses item=status}
                                <option value="{$status}" {if in_array($status, $configuration.DomainStatusesSync)}selected{/if}>{$status}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>For which domains</strong></td>
                    <td>
                        <input name="configuration[WhichDomainSync]" type="radio" value="all" {if $configuration.WhichDomainSync == 'all'}checked{/if}>
                        Synchronization performed for all domains
                        <br/>
                        <input name="configuration[WhichDomainSync]" type="radio" value="expiring" {if $configuration.WhichDomainSync != 'all'}checked{/if}>
                        Synchronization only for expiring domains
                    </td>
                </tr>
                <tr class="bordme expiring">
                    <td align="right" width="205"><strong>Days before expiration <i class="vtip_description" title="How many days before the domain expires. When the field is empty, the default value will be used. Default: 90"></i></strong></td>
                    <td>
                        <input name="configuration[DaysBeforeExpirationSync]" type="number" value="{$configuration.DaysBeforeExpirationSync|default:90}" class="inp" min="0" size="3"
                               {if $configuration.WhichDomainSync == 'all'}disabled{/if}/>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Synchronization limit <i class="vtip_description" title="Limit of synchronizations performed in a single cron task. When the field is empty, the default value will be used. Default: 10"></i></strong></td>
                    <td>
                        <input name="configuration[DomainSyncLimit]" type="number" value="{$configuration.DomainSyncLimit|default:10}" class="inp" min="1" size="3"/>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Synchronization interval <i class="vtip_description" title="Minimum synchronization interval for a single domain"></i></strong></td>
                    <td>
                        <input name="configuration[DomainSyncInterval]" type="number" value="{$configuration.DomainSyncInterval|default:1}" class="inp" min="1" size="3"/>
                        <select name="configuration[DomainSyncIntervalUnit]">
                            <option value="minute" {if $configuration.DomainSyncIntervalUnit == 'minute'}selected{/if}>Minute</option>
                            <option value="hour" {if $configuration.DomainSyncIntervalUnit == 'hour'}selected{/if}>Hour</option>
                            <option value="day" {if $configuration.DomainSyncIntervalUnit == 'day'}selected{/if}>Day</option>
                            <option value="week" {if $configuration.DomainSyncIntervalUnit == 'week'}selected{/if}>Week</option>
                        </select>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Transferred Out Detection <i class="vtip_description" title="Enter number of subsequent <b>failed</b> domain synchronisation attempts after which domain will be considered as transferred out. 0 to disable"></i></strong></td>
                    <td>
                        <input name="configuration[SyncTransferredOut]" type="number" value="{$configuration.SyncTransferredOut|default:5}" class="inp" min="0" size="3"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="nicerblu" style="text-align:center">
        <input type="submit" value="Save Changes" name="save[synchronization]" style="font-weight:bold" class="btn btn-primary">
    </div>
</div>
{literal}
<script>
    $(document).ready(function(){

        $(".chosenedge").chosenedge({
            width: "50%",
            disable_search_threshold: 5,
            allow_single_deselect: true,
            display_disabled_options: false,
            enable_split_word_search: true,
            search_contains: true
        });

        $('input[name^="configuration[WhichDomainSync]"]').on('change', function () {
            var disable = false;
            if ($(this).val() === 'all')
                disable = true;
            $('input[name="configuration[DaysBeforeExpirationSync]"]').prop('disabled', disable);
        })

    });
</script>{/literal}