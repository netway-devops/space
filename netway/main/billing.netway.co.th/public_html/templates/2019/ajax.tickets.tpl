{if $action=='default'}
    {foreach from=$tickets item=ticket name=foo}
        <tr>
            <td class="inline-row">
                <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/">
                    #{$ticket.ticket_number}
                </a>
            </td>
            <td class="inline-row">
                <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/">
                    {$ticket.subject|escape:'html':'utf-8'}
                </a>
            </td>
            <td class="overflow-elipsis inline-row-right">
                <span class="badge badge-{$ticket.status}">{$lang[$ticket.status]}</span>
            </td>
            <td data-label="{$lang.department}: ">{$ticket.deptname}</td>
            <td data-label="{$lang.date}: ">{$ticket.date|dateformat:$date_format}</td>
            <td class="noncrucial">
                <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/" class="icon-info-color "><i class="material-icons icon-info-color">insert_link</i></a>
            </td>
        </tr>
    {foreachelse}
        <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
    {/foreach}
{elseif $action=='view'}
    {include file="support/ajax.viewticket.tpl"}
{elseif $action=='kbhint'}
    {if $replies}
        <div class="card w-100 my-3">
            <ul class="list-group list-group-flush">
                {foreach from=$replies item=reply}
                    <a href="{$ca_url}knowledgebase/article/{$reply.id}/{$reply.slug}/" target="_blank" class="list-group-item">
                        <i class="material-icons icon-info-color mr-3">subject</i>
                        <span class="text-small" title="{$lang.match} {$reply.fits|escape:'html':'utf-8'} %">{$reply.title|truncate}</span>
                        <small class="pull-right badge badge-primary">{$reply.date|dateformat:$date_format}</small>
                    </a>
                {/foreach}
            </ul>
        </div>
        <br/>
    {/if}
{/if}