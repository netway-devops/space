{*

Browse credit logs related to client

*}
<h1 class="invoices2">{$lang.creditlogs}</h1>
{if $logs}
    <p align="right"> {$lang.page}
        <select name="page" id="currentpage">
            {section name=foo loop=$totalpages}
                <option value='{$smarty.section.foo.iteration-1}'>{$smarty.section.foo.iteration}</option>
            {/section}
        </select> of:<strong> {$totalpages}</strong> </p>

    <a href="{$ca_url}clientarea&action=creditlogs" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>

        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>

        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>
        <tbody>
        <tr>
            <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=date|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.date}</a></th>
            <th class="w60"><a href="{$ca_url}clientarea&action=creditlogs&orderby=description|ASC" class="sortorder"><i class="icon-sort"></i>{$lang.Description}</a></th>
            <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=in|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.increase}</a></th>
            <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=out|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.decrease}</a></th>
            <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=balance|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.creditafter}</a></th>
            <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=invoice_id|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.related_invoice}</a></th>
        </tr>
        </tbody>
        <tbody id="updater">
        {include file='ajax.creditlogs.tpl'}
        </tbody>

    </table>
    <br />
{else}
    <div>{$lang.nothing}</div>
{/if}