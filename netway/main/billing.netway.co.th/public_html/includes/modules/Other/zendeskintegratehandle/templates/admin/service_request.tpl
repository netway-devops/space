{include file="$tplPath/admin/header.tpl"}

<a class="menuitm" href="?cmd=zendeskintegratehandle&action=syncServiceRequest" onclick="return confirm('Confirm ? ');" style="margin-right: 10px;font-weight:bold;"><span>Sync</span></a>

<table>
<thead>
<tr>
    <th colspan="6" align="left">Category</th>
</tr>
<tr>
    <th>&nbsp;</th>
    <th colspan="5" align="left">Section</th>
</tr>
<tr>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th align="left">Article (Service request)</th>
    <th align="left">Hostbill (Service catalog)</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
</tr>
</thead>
<tbody>
{foreach from=$aCategory item=aCat key=catId}
<tr>
    <td colspan="6"><a href="{$aCat.html_url}" target="_blank">{$aCat.name}</a></td>
</tr>
    {foreach from=$aCat.section item=aSection key=sectionId}
    {if ! $aSection.isServiceRequest}
        {continue}
    {/if}
    <tr>
        <td width="50">&nbsp;</td>
        <td colspan="5"><a href="{$aSection.html_url}" target="_blank">{$aSection.name}</a></td>
    </tr>
        {foreach from=$aArticle[$sectionId] item=aData key=articleId}
        <tr>
            <td width="50">&nbsp;</td>
            <td width="50">&nbsp;</td>
            <td nowrap="nowrap"><a href="{$aData.html_url}" target="_blank">{$articleId} : {$aData.title}</a></td>
            <td bgcolor="#FFFFFF" nowrap="nowrap">{if $aCatalog[$articleId].id}<a href="?cmd=servicecataloghandle&action=view&id={$aCatalog[$articleId].id}" target="_blank">{$aCatalog[$articleId].id} : {$aCatalog[$articleId].pathway} :: {$aCatalog[$articleId].title}</a>{/if}</td>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
        </tr>
        {/foreach}
    {/foreach}
{/foreach}
</tbody>
</table>

{include file="$tplPath/admin/footer.tpl"}
