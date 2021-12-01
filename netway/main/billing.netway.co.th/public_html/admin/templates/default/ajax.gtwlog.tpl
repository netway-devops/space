{if $action=='default'}
    {foreach from=$logs item=log}
        <tr>
            <td>{$log.id}</td>
            <td>{$log.date|dateformat:$date_format}</td>
            <td><strong>{$log.module}</strong></td>
            <td width="60%">
                {*			<a href="#" onclick="$(this).hide().next().show();return false">{$lang.showdetails}</a>						*}
                <div style="max-height:100px; overflow:auto">
                    <div style="{*display:none;*} white-space: pre; font-size:8pt;">{$log.output}</div>
                </div>
            </td>
            <td><span class="{$log.result}">{$lang[$log.result]}</span></td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="5">{$lang.nothingtodisplay}</td>
        </tr>
    {/foreach}
{elseif $action=='getadvanced'}

    <a href="?cmd=gtwlog&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=gtwlog" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>

{/if}
