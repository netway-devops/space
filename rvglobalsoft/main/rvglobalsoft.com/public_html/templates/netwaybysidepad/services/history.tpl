{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/history.tpl.php');
{/php}

<h3>License history</h3>

{if $aHistory.lists|count}

<div class="row" style="padding: 20px;">
    
    <table class="table table-hover">
    <tbody>
    {foreach from=$aHistory.lists item=aList}
    <tr valign="top">
        <td width="100">{$aList.date|date_format}</td>
        <td><span class="label">{$aList.event}</span> {if $aList.detail == 'Array '} - {else}{$aList.detail}{/if}</td>
    </tr>
    {/foreach}
    </tbody>
    </table>

</div>

<div class="row">&nbsp;</div>

<div class="row">
    <ul class="pager">
        <li class="{if $page == 1}disabled{/if}">
            {assign var=previous value=$page-1}
            <a {if $page == 1}onclick="return false;"{/if} href="{$ca_url}clientarea/services/licenses/{$service.id}/&widget={$widgetName}&wid={$widgetId}&p={$previous}">&larr; Previous</a>
        </li>
        <li class="{if $aHistory.pages == $page}disabled{/if}">
            {assign var=next value=$page+1}
            <a {if $aHistory.pages == $page}onclick="return false;"{/if} href="{$ca_url}clientarea/services/licenses/{$service.id}/&widget={$widgetName}&wid={$widgetId}&p={$next}">Next &rarr;</a>
        </li>
    </ul>
</div>

{else}

<div class="row" style="padding: 20px;">
    <div class="alert alert-info">
        <p align="center">
            <blockquote>No license history to list.</blockquote>
        </p>
    </div>
</div>

{/if}
