<div class="container-fluid clear tabs tab-client-interface" style="margin-top:10px;">
    <div class="row">
        <div class="col-md-12">
            <table style="margin-bottom: 20px;" width="100%" cellspacing="0" cellpadding="10">
                <tr class="bordme">
                    <td align="right" width="205">
                        <strong>Clientarea Layout</strong>
                        <i class="vtip_description" title="Decide how client area will look like. Note that this option works only on latest HostBill themes and may be overridden by provisioning module theme"></i></td>
                    <td>
                        <select name="configuration[DomainClientareaLayout]" class="chosenedge">
                            <option {if $configuration.DomainClientareaLayout === 'left'}selected="selected"{/if} value="left">Left menu</option>
                            <option {if $configuration.DomainClientareaLayout === 'right'}selected="selected"{/if} value="right">Right menu</option>
                            <option {if $configuration.DomainClientareaLayout === 'top'}selected="selected"{/if} value="top">Top menu</option>
                        </select>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Cancellation requests</strong>
                        <i class="vtip_description" title="Allow clients to do domain cancellation request "></i></td>
                    <td>
                        <input name="configuration[DomainCancellationRequest]" type="radio" value="on" {if $configuration.DomainCancellationRequest === 'on'}checked{/if}> <strong>Yes</strong>
                        <br/>
                        <input name="configuration[DomainCancellationRequest]" type="radio" value="off" {if $configuration.DomainCancellationRequest !== 'on'}checked{/if}> <strong>No</strong>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Client domain notifications</strong>
                    <td>
                        <input name="configuration[DomainRenewalNotifications]" type="radio" value="single" {if $configuration.DomainRenewalNotifications === 'single' || $configuration.DomainRenewalNotifications}checked{/if}>
                        <strong>single</strong> - customer will receive separate emails about each domain
                        <br/>
                        <input name="configuration[DomainRenewalNotifications]" type="radio" value="bulk" {if $configuration.DomainRenewalNotifications === 'bulk'}checked{/if}>
                        <strong>bulk</strong> - customer will receive max 1 email a day for all his domains
                    </td>
                </tr>

                <tr class="bordme">
                    <td align="right" width="205"><strong>Staff domain notifications</strong>
                    <td>
                        <input name="configuration[StaffFailedDomainNotifications]" type="radio" value="off" {if $configuration.StaffFailedDomainNotifications === 'off' || !$configuration.DomainRenewalNotifications}checked{/if}>
                        <strong>all</strong> -  staff will receive all domain automation notifications
                        <br/>
                        <input name="configuration[StaffFailedDomainNotifications]" type="radio" value="on" {if $configuration.StaffFailedDomainNotifications === 'on'}checked{/if}>
                        <strong>failed only</strong> - staff will receive only failed domain automation notifications
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="nicerblu" style="text-align:center">
        <input type="submit" value="Save Changes" name="save[clientarea_layout]" style="font-weight:bold" class="btn btn-primary">
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
    });
</script>
{/literal}