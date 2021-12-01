<table width="100%" cellpadding="0" cellspacing="0" class="table-status">
    <thead>
        <tr class="status-head">
            <td class="name" colspan="2">{$lang.domain}</td>
            <td class="status">{$lang.status}</td>
            <td class="period">{$lang.period}</td>
        </tr>
    </thead>
    <tbody>
        {foreach from=$check item=ccme name=foo}
            <tr class="status-row {if $smarty.foreach.foo.index%2 == 1}status-row-white{/if}">
                {include file="domains/ajax.namecheck.tpl"}
            </tr>
        {/foreach}
    </tbody>

    <tbody id="suggestions"> </tbody>

</table>

