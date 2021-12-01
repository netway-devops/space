{if $action=='default'}
{if $tickets}
{foreach from=$tickets item=ticket name=foo}
<tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
    <td >
        <span class="label label-{$ticket.status}">{$lang[$ticket.status]}</span>
    </td>
    <td class="cell-border">
    </td>
    <td class="cell-border grey-c">{$ticket.deptname}</td>
    <td class="cell-border grey-c">{$ticket.date|date_format:'%d %b %Y'}</td>
</tr>
{/foreach}
{else}
<tr class="even">
    <td colspan="4">{$lang.nothing}</td>
</tr>     
{/if}
{elseif $action=='kbhint'}{if $replies}
<div style="margin-top:6px;margin-bottom:6px;"><strong>{$lang.kbhint}</strong><br />


		{foreach from=$replies item=reply}
    <div style="float:left;width:290px;padding:3px;"><a href='{$ca_url}knowledgebase/article/{$reply.id}/' target="_blank"><i class="icon-file"></i> {$reply.title}</a>
        <span  class="fits fs11">{$lang.match} {$reply.fits} %</span><br />
		{$reply.body}
    </div>
		{/foreach}
    <div class="clear"></div>
</div>
{/if}{/if}