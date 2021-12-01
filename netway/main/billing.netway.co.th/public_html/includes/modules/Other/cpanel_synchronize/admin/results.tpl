{include file='header.tpl'}

<div class="lighterblue" style="padding: 20px;">
    <div style="margin-bottom: 20px">

        <div class="alert alert-info" >
            <h1>Synchronization results for WHM Connection: <a href="?cmd=servers&action=edit&id={$server_info.id}" target="_blank">#{$server_info.id} {$server_info.group} - {$server_info.name}</a></h1>
            <div style="">
                <label class="label label-success">{$summary.overview.success}</label> accounts of <label class="label label-success">{$summary.overview.total}</label> were successfully synchronized. <br />
                <label class="label label-info">{$summary.overview.not_exists}</label> were not found on the servers. <br/>
                <label  class="label label-warning">{$summary.overview.wrong_domain}</label> have different domain.<br/>
                <label class="label label-danger">{$summary.overview.not_in_hb}</label> do not exist in the HostBill.<br/>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    {if !empty($summary.connection_error)}
        <div style="padding: 20px; color: #CC0000">
            <h3>Connection errors: </h3>
            <ul>
                {foreach from=$summary.connection_error item=conerr}
                    {if $singleServer}
                        <li>Connection Failed ({$conerr.ip}): {$conerr.error}</li>
                    {else}
                        <li><strong>Server <a href="?cmd=servers&amp;action=edit&amp;id={$conerr.id}">#{$conerr.id}</a> {$conerr.name}</strong> ({$conerr.ip}): {$conerr.error}</li>
                    {/if}
                {/foreach}
            </ul>
        </div>
    {/if}
    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
        <tbody>
        <tr>
            <th width="15%">Client</th>
            <th width="10%">Username</th>
            <th width="10%">Domain</th>
            <th width="25%"></th>
            <th width="20%">Account</th>
            <th>Status</th>
        </tr>
        {foreach from=$summary.accounts item=acc_list key=status}
            {foreach from=$acc_list item=acc}
                {if $status == 'success'}
                    <tr>
                        <td style="background-color:#e4ffe4;"><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
                        <td style="background-color:#e4ffe4; font-weight: bold">{if $acc.username != ''}{$acc.username}{else}<em>(empty)</em>{/if}</td>
                        <td style="background-color:#e4ffe4;">{if $acc.domain != ''}{$acc.domain}{else}<em>(empty)</em>{/if}</td>
                        <td style="background-color:#e4ffe4; font-weight: bold">{$acc.result}</td>
                        <td style="background-color:#e4ffe4; font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}" target="_blank">Manage Account #{$acc.id}</a></td>
                        <td style="background-color: #e4ffe4;color:#00CC00; font-weight: bold">OK</td>
                    </tr>

                {else}
                    <tr>
                        <td style="background-color:#ffe4e4;"><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
                        <td style="background-color:#ffe4e4; font-weight: bold">{if $acc.username != ''}{$acc.username}{else}<em>(empty)</em>{/if}</td>
                        <td style="background-color:#ffe4e4;">{if $acc.domain != ''}{$acc.domain}{else}<em>(empty)</em>{/if}</td>
                        <td style="background-color:#ffe4e4; font-weight: bold">{$acc.result}</td>
                        <td style="background-color:#ffe4e4; font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}" target="_blank">Manage Account #{$acc.id}</a></td>
                        <td style="background-color: #ffe4e4;color:#CC0000; font-weight: bold">Failed</td>
                    </tr>
                {/if}
            {/foreach}
        {/foreach}
        {if !empty($summary.accounts_notinhb)}
            <tr><th colspan="7" style="padding: 5px;">Accounts not found in HostBill</th></tr>
            {foreach from=$summary.accounts_notinhb item=acc}
                <tr>
                    <td>-</td>
                    <td style="font-weight: bold">{$acc.username}</td>
                    <td>{$acc.domain}</td>
                    <td></td>
                    <td></td>
                    <td><em>Not found</em></td>
                </tr>
            {/foreach}
            <tr>
                <td colspan="6" align="center" style="text-align: center">

                    <a href="?cmd=importaccounts&server_id={$server_info.id}&security_token={$security_token}" class="btn btn-success btn-lg">Select packages & accounts to import</a>

                </td>
            </tr>
        {/if}
        </tbody>
    </table>

</div>