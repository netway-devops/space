{foreach from=$domain_changes item=req}
    <tr class="domreq-{$req.status}">
        <td width="3%">{$req.id}</td>
        <td width="20%">
            <a href="?cmd=domains&action=edit&id={$req.domain_id}">
                <b>#{$req.domain_id} {$req.domain.name}</b>
            </a>
        </td>
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
        <td width="100">
            <a href="?cmd=domains&action=edit&id={$req.domain_id}" class="btn btn-sm btn-default">Go to domain</a>
        </td>
    </tr>
{foreachelse}
    <tr>
        <td colspan="7">Nothing to display</td>
    </tr>
{/foreach}