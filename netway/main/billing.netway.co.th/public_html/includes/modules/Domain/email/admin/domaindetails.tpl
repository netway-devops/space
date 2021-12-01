<div style="margin:10px 0px;">
    <ul class="accor">
        <li>
            <a>Domain local details</a>
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#domreq-details" aria-expanded="false" aria-controls="domreq-details">
                                Show details
                            </a>
                        </h4>
                    </div>
                    <div id="domreq-details" class="panel-collapse collapse" role="tabpanel">
                        <div class="panel-body">
                            <pre style=" white-space: pre; font-size:8pt;">{$domain_details}</pre>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </ul>
</div>

<div style="margin:10px 0px;">
    <ul class="accor">
        <li>
            <a>Change requests (Pending: {$domain_changes_stats.Pending})</a>
            <div>
                <div class="form-check form-check-inline">
                    <input type="checkbox" class="form-check-input" id="domreq-checkbox-done">
                    <label class="form-check-label" for="domreq-checkbox-done">Show <b>Done</b> ({$domain_changes_stats.Done})</label>

                    <input type="checkbox" class="form-check-input" id="domreq-checkbox-canceled" style="margin-left: 30px;">
                    <label class="form-check-label" for="domreq-checkbox-canceled">Show <b>Canceled</b> ({$domain_changes_stats.Canceled})</label>
                </div>
                <hr>
                <table class="table table-hover table-domreq">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Created at</th>
                        <th>Updated at</th>
                        <th>What</th>
                        <th>Status</th>
                        <th>Old value</th>
                        <th>New value</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach from=$domain_changes item=req}
                        <tr class="domreq-{$req.status}" {if $req.status !== 'Pending'} style="display: none" {/if}>
                            <td width="3%">{$req.id}</td>
                            <td width="8%">{$req.created_at|dateformat:$date_format}</td>
                            <td width="8%">
                                {if $req.created_at !== $req.updated_at}
                                    {$req.updated_at|dateformat:$date_format}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td width="8%">
                                <b>
                                    {if $req.what === 'ns'} Nameservers
                                    {elseif $req.what === 'contacts'} Contacts
                                    {elseif $req.what === 'dns'} DNS
                                    {elseif $req.what === 'reglock'} Registrar lock
                                    {elseif $req.what === 'idprotection'} ID Protection
                                    {elseif $req.what === 'eppcode'} EPP code

                                    {elseif $req.what === 'register'} Register
                                    {elseif $req.what === 'transfer'} Transfer
                                    {elseif $req.what === 'renew'} Renew

                                    {else} {$req.what|ucfirst}

                                    {/if}
                                </b>
                            </td>
                            <td width="5%">
                                {if $req.status === 'Pending'}
                                    <div class="label label-warning">{$req.status}</div>
                                {elseif $req.status === 'Done'}
                                    <div class="label label-success">{$req.status}</div>
                                {else}
                                    <div class="label label-default">{$req.status}</div>
                                {/if}
                            </td>
                            <td valign="top">
                                <pre style=" white-space: pre; font-size:8pt; max-height: 200px; overflow-y: auto">{$req.display_old_value}</pre>
                            </td>
                            <td valign="top">
                                <pre style=" white-space: pre; font-size:8pt; max-height: 200px; overflow-y: auto">{$req.display_new_value}</pre>
                            </td>
                            <td width="150">
                                {if $req.status === 'Pending'}
                                    <a onclick="return confirm('Are you sure?');" href="?cmd=module&module={$moduleid}&action=submit&do=accept&domain_id={$details.id}&change_id={$req.id}&security_token={$security_token}" class="btn btn-sm btn-success">Done</a>
                                    <a onclick="return confirm('Are you sure?');" href="?cmd=module&module={$moduleid}&action=submit&do=cancel&domain_id={$details.id}&change_id={$req.id}&security_token={$security_token}" class="btn btn-sm btn-danger">Cancel</a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </li>
    </ul>
</div>

{literal}
    <script>
        $('#domreq-checkbox-done').on('change', function () {
            var en = $(this).is(":checked");
            $('.table-domreq tr.domreq-Done').toggle(en);
        });

        $('#domreq-checkbox-canceled').on('change', function () {
            var en = $(this).is(":checked");
            $('.table-domreq tr.domreq-Canceled').toggle(en);
        });
    </script>
{/literal}