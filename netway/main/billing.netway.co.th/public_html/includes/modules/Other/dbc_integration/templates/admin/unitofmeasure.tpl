{include file="$tplPath/admin/header.tpl"}
{assign var=dataRowStyle value="background-color:#fff;"}

<table cellpadding="2" cellspacing="2" border="1" width="80%">
    <tr style="text-align:center;">
        <th style="text-align:center;"  width="20%">Row ID</th>
        <th style="text-align:center;" width="30%">Code</th>
        <th style="text-align:center;">Display Name</th>
    </tr>
    {foreach from=$aUnitsOfMeasureList item="aValue" key="index"}
    <tr style="{$dataRowStyle}">
        <td>{$aValue.id}</td>
        <td style="text-align:center;">{$aValue.code}</td>
        <td style="text-align:center;">{$aValue.displayName}</td>
    </tr>
    {if $dataRowStyle == "background-color:#fff;"}
        {assign var=dataRowStyle value="background-color:#f4f4f4;"}
    {else}
        {assign var=dataRowStyle value="background-color:#fff;"}
    {/if}
    {/foreach}
</table>


{include file="$tplPath/admin/footer.tpl"}