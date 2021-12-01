{if $do=='get_support_summary'}
{if $precheck=='1'}
    You dont have any support departments defined yet, go to Support->Ticket departments and add it first

 {elseif $precheck=='2'}

    There was no tickets opened yet
{else}

Tickets closed ({$summary.totals.closed}) 
{foreach from=$summary.closed item=su}
{$system_url}admin/?cmd=tickets&action=view&list=all&num={$su}
{/foreach}



Tickets replied ({$summary.totals.replied})
{foreach from=$summary.replied item=su}
{$system_url}admin/?cmd=tickets&action=view&list=all&num={$su}
{/foreach}



Tickets unread ({$summary.totals.unread})
{foreach from=$summary.unread item=su}
{$system_url}admin/?cmd=tickets&action=view&list=all&num={$su}
{/foreach}

{if $summary.totals.replied==0 && $summary.totals.closed==0 && $summary.totals.unread==0}
(No replies/tickets since last report)
{/if}

{/if}

{elseif $do=='get_server_list'}

{foreach from=$servers item=server}
{$server.gname} - {$server.name} ({if $server.host}{$server.host}{else}{$server.ip}{/if})
{foreachelse}
There are no Apps defined yet, to create go to Settings->Apps
{/foreach}
{/if}