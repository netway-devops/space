{include file="$tplPath/admin/header.tpl"}
{assign var=dataRowStyle value="background-color:#fff;"}

<script language="JavaScript">
var call_ajaxurl = "?cmd=dbc_integration&action=update_product_to_DBC";
{literal}
function updateProductToDBC(id)
{
    return new Promise(async(resolve, reject) => {
        try {
            $.get(call_ajaxurl + '&pid=' + id, function(rasponse, status){
                if (rasponse.data.message !== undefined) {
                    alert(rasponse.data.message);
                }
                resolve(data)
            });
        } catch(error) {
            reject(error)
        }
    })
}
{/literal}
</script>


<table cellpadding="2" cellspacing="2" border="1" width="100%">
    <tr style="text-align:center;">
        <th style="text-align:center;" colspan="2">Hostbill</th>
        <th style="text-align:center;" colspan="6">Microsoft Dynamics 365 Business Central</th>
        <th style="text-align:center;" rowspan="2">Actions</th>
    </tr>
    <tr style="text-align:center;">
        <th style="text-align:center;" width="5%">Product ID</th>
        <th style="text-align:center;" width="20%">Product Name</th>

        <th style="text-align:center;" width="20%">Item ID</th>
        <th style="text-align:center;" width="10%">Item Number</th>
        <th style="text-align:center;" width="10%">Category Number</th>
        <th style="text-align:center;" width="5%">Item Type</th>
        <th style="text-align:center;" width="5%">Inventory</th>
        <th style="text-align:center;" width="10%">Unit Of Measure</th>

    </tr>
    {foreach from=$aProductList item="aValue" key="index"}
    <tr style="{$dataRowStyle}">
        <td style="text-align:right; padding: 0 10px 0 10px;">{$aValue.id} <a style="padding: 0 2px;" class="btn btn-sm" href="?cmd=services&action=product&id={$aValue.id}" target="_blank" title="Goto Product: {$aValue.name}"><i class="fa fa-external-link" aria-hidden="true"></i></a></td>
        <td style="text-align:left; padding: 0 10px 0 10px;">{$aValue.catName} - {$aValue.name}</td>
        <td style="text-align:center;">{$aValue.dbcItemId}</td>
        <td style="text-align:center;">{$aValue.catCodeName}.{$aValue.id}.{$aValue.codeName}</td>
        <td style="text-align:center;">{$aValue.catCodeName} <a style="padding: 0 2px;" class="btn btn-sm" href="?cmd=services&action=editcategory&id={$aValue.category_id}" target="_blank" title="Gotp Order Page: {$aValue.catName}"><i class="fa fa-external-link" aria-hidden="true"></i></a></td>
        <td style="text-align:center;">{$aValue.dbcItemType}</td>
        <td style="text-align:center;">
            {if $aValue.stock == 1}{$aValue.qty}{else}0{/if}
        </td>
        <td style="text-align:right; padding: 0 10px 0 10px;">{$aValue.baseUnitOfMeasureCode}</td>
        <td>{if $aValue.dbcItemId != ""}<button class="btn btn-primary" type="submit" onclick="updateProductToDBC('{$aValue.id}');">Update</button>{/if}</td>
    </tr>
    {if $dataRowStyle == "background-color:#fff;"}
        {assign var=dataRowStyle value="background-color:#f4f4f4;"}
    {else}
        {assign var=dataRowStyle value="background-color:#fff;"}
    {/if}
    {/foreach}
</table>
{include file="$tplPath/admin/footer.tpl"}