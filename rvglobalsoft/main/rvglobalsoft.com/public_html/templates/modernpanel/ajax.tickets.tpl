{if $action=='default'}
    {if $tickets}
        {foreach from=$tickets item=ticket name=foo}
            <tr class="styled-row">
                <td>
                    <div class="td-rel">
                        <div class="left-row-side {$ticket.status}-row"></div>
                    </div>
                    {*}<input type="checkbox">{*}
                </td>
                <td class="bold {$ticket.status}-label overflow-elipsis">
                    {$lang[$ticket.status]}
                </td>

                <td class="invoice-c overflow-elipsis">
                    <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/" >
                        <div class="ticket-hover {if $ticket.client_read=='0'}bold{/if}" id="t{$ticket.id}">
                            {$ticket.subject|escape:'html':'utf-8'}
                        </div>
                    </a>
                </td>
                <td>{$ticket.deptname}</td>
                <td>{$ticket.date|dateformat:$date_format}</td>
                <td>
                    <div class="td-rel">
                        <div class="right-row-side"></div>
                    </div>
                    <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/" class="icon-link"><i class="icon-single-arrow"></i></a>
                </td>
            </tr>
            <tr class="empty-row">
            </tr>
        {/foreach}
        <script type="text/javascript">tickets_hover_box()</script>
    {else}
        <tr>
            <td colspan="3">{$lang.nothing}</td>
        </tr>   
    {/if}
{elseif $action=='view'}
    <div class="ticket-hover-box">
        <div class="header">
            <div class="pull-right">
                <span class="ticket-date"><i class="icon-date"></i> {$ticket.date|dateformat:$date_format}</span>
                <span class="label {$ticket.status}-f">{$lang[$ticket.status]}</span>
            </div>
            <p class="t-subject">{$lang.subject}</p>
            <h3>{$ticket.subject|wordwrap:40:"\n":true}</h3>
            <div class="msg-body">
                {$ticket.body|truncate:500|httptohref|nl2br}
            </div>

            {foreach from=$replies_rev item=reply}
                <div class="separator-line"></div>
                <p class="t-subject">{$lang.lastestanswer}</p>

                <div class="msg-answer">

                    <div class="avatar"><img src="http://{if $is_https}secure{else}www{/if}.gravatar.com/avatar/{$reply.email|trim|md5}.jpg?d=mm&s=45" /></div>
                    <div class="bg">
                        <div class="pull-right">
                            <span class="ticket-date"><i class="icon-date"></i> {$reply.date|dateformat:$date_format}</span>
                        </div>
                        <p>{$reply.name}: </p>

                        <p class="msg-txt">
                            {$reply.body|truncate:500|httptohref|nl2br}
                        </p>
                    </div>

                </div>
                {break}
            {/foreach}
        </div>
    </div>
{elseif $action=='kbhint'}
    {if $replies}
        {foreach from=$replies item=reply}
            <li>
                <div class="bg-fix"></div>
                <a href='{$ca_url}knowledgebase/article/{$reply.id}/' target="_blank">
                    <p title="{$lang.match} {$reply.fits|escape:'html':'utf-8'} %">{$reply.title|truncate}</p>
                    <span><i class="icon-date"></i> {$reply.date|dateformat:$date_format}</span>
                </a>
            </li>
        {/foreach}
    {else}
        <li>
            <div class="bg-fix"></div>
            <a href='#' onclick="return false;">
                <p>{$lang.nothing}</p>
            </a>
        </li>
    {/if}
{/if}