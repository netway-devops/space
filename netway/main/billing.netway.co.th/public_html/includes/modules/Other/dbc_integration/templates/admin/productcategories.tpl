{include file="$tplPath/admin/header.tpl"}
{assign var=dataRowStyle value="background-color:#fff;"}

<script language="JavaScript">
var url_update_cateroty = "?cmd=dbc_integration&action=update_cateroty_to_DBC";
{literal}
function updateCaterotyToDBC(id)
{
    return new Promise(async(resolve, reject) => {
        try {
            $.get(url_update_cateroty + '&catid=' + id, function(data, status){
                resolve(data)
            });
        } catch(error) {
            reject(error)
        }
    })
}
{/literal}
</script>

<div class="gbox1" style="padding: 5px 10px 0 10px;">
    <p><b>Displays only items whose code name is NOT null.</b></p>
</div>

<table cellpadding="2" cellspacing="2" border="1" width="90%">
    <tr style="text-align:center;">
        <th style="text-align:rigth;" width="10%">Cateroty ID</th>
        <th style="text-align:center;" width="25%">Cateroty Name</th>
        <th style="text-align:center;" width="25%">Code Name</th>
        <th style="text-align:center;" width="25%">DBC Row ID</th>
        <th style="text-align:center;">Actions</th>
    </tr>
    {foreach from=$aProductCategoriesList item="aValue" key="index"}
    <tr style="{$dataRowStyle}">
        <td style="text-align:right; padding: 0 10px 0 10px;">{$aValue.id} <a style="padding: 0 2px;" class="btn btn-sm" href="?cmd=services&action=editcategory&id={$aValue.id}" target="_blank" title="Open Order Pages: {$aValue.name}"><i class="fa fa-external-link" aria-hidden="true"></i></a></td>
        <td style="text-align:left; padding: 0 10px 0 10px;">{$aValue.name}</td>
        <td style="text-align:center;">{$aValue.codeName}</td>
        <td style="text-align:center;">{$aValue.dbcCategoryId}</td>
        <td>{if $aValue.dbcCategoryId != ""}<button class="btn btn-primary" type="submit" onclick="updateCaterotyToDBC('{$aValue.id}');">Update</button>{/if}</td>
    </tr>
    {if $dataRowStyle == "background-color:#fff;"}
        {assign var=dataRowStyle value="background-color:#f4f4f4;"}
    {else}
        {assign var=dataRowStyle value="background-color:#fff;"}
    {/if}
    {/foreach}
</table>



{include file="$tplPath/admin/footer.tpl"}