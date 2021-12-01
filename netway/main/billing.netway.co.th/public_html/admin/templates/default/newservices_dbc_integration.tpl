{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'newservices_dbc_integration.tpl.php');
{/php}

{if $isActiveModuleDBCIntegration}

<tr>
    <td valign="top" align="right"><strong>DBC Item Code Name:</strong></td>
    <td>
<script language="JavaScript">
{literal}
function displayDimensionCodeBU ()
{
    $.post('?cmd=dbc_integration&action=genDimensionCodeBUByProdictID', { 
        p_id: '{/literal}{$product.id}{literal}', 
        revenue_group:  $('#revenue_group').val(),
        line_group: $('#line_group_id').val()
    }, function(rasponse, status) {
        if (rasponse.dimensionCodeBU != undefined) {
            $('#txt_dimension_code_bu').text(rasponse.dimensionCodeBU);
        } else {
            $('#txt_dimension_code_bu').text('N/A');
        }
    })
}

$(function() {
    $('#categorycodename').keyup(function(e) {
        this.value = this.value.replace(/[^a-zA-Z0-9]/, '').toUpperCase();
    });

    /// Injectable: #productedit on Submit 
    $('#productedit').off('submit').on('submit', function () {
        var uom =  $('#baseUnit :selected').val();
        var productCodename =  $('input[name="codeName"]').val();
        var dbcItemType =  $('input[name="dbcItemType"]:checked').val();
        var revenue_group =  $('#revenue_group :selected').val();
        var line_group_id =  $('#line_group_id').val();
        var params = {
            'pid': '{/literal}{$product.id}{literal}',
            'uom': uom,
            'revenue_group': revenue_group,
            'line_group_id': line_group_id
        };

        if (dbcItemType != undefined) {
            params['item_type'] = dbcItemType;
        }

        if (productCodename != undefined) {
            params['codename'] = productCodename;
        }

        $.post('?cmd=dbc_integration&action=updateDBCInfo2Product', params, function(rasponse, status) {

        });
    });

    displayDimensionCodeBU();
});
{/literal}
</script>
        <div class="org-content havecontrols">
            <span>{$product.category_detail.codeName}.{$product.id}.{if $product.codeName != ''}{$product.codeName}{else}<input value="{$product.codeName}" style="font-size: 16px !important; font-weight: bold;" class="inp" size="4" maxlength="4" name="codeName" />{/if}</span>
        </div>
    </td>
</tr>

<tr>
    <td valign="top" align="right"><strong>DBC Base Unit Of Measure</strong></td>
    <td>
        <label>
            <select name="baseUnit" id="baseUnit">
                <option value="">Select</option>
                {foreach from=$aUnitsOfMeasureList item="aValue" key="index"}
                <option value="{$aValue.id}" {if $product.baseUnitOfMeasureId == $aValue.id} selected {/if}>{$aValue.code}</option>
                {/foreach}
            </select>
        </label>
    </td>
</tr>

<tr>
    <td valign="top" align="right"><strong>DBC Item Type</strong></td>
    <td>
        {if !isset($product.dbcItemType) || $product.dbcItemType == ''}
        <label>
            <input type="radio" {if $product.dbcItemType == 'Inventory' || $product.dbcItemType == ''}checked{/if}
                name="dbcItemType" value="Inventory" data-toggle/>
            <strong>Inventory</strong>
        </label>
        <label>
            <input type="radio" {if $product.dbcItemType == 'Service'}checked{/if}
                name="dbcItemType" value="Service" data-toggle/>
            <strong>Service</strong>
        </label>
        {else}
            <span>{$product.dbcItemType}</span>
        {/if}
    </td>
</tr>

<tr>
    <td valign="top" align="right"><strong>Revenue Group</strong></td>
    <td>
        <label>
            <select name="revenue_group" id="revenue_group" onChange="displayDimensionCodeBU();">
                <option value="0">Select</option>
                <option value="1" {if $product.revenue_group == '1'} selected {/if}>1</option>
                <option value="2" {if $product.revenue_group == '2'} selected {/if}>2</option>
                <option value="3" {if $product.revenue_group == '3'} selected {/if}>3</option>
            </select>
        </label>
    </td>
</tr>

<tr>
    <td valign="top" align="right"><strong>Line Group</strong></td>
    <td>
        <label>
            <input type="number" id="line_group_id" name="line_group_id" min="0" max="99" maxlength="2" value="{$product.line_group_id}" onChange="displayDimensionCodeBU();">
        </label>
    </td>
</tr>

<tr>
    <td valign="top" align="right"><strong>Dimension code BU</strong></td>
    <td><span id="txt_dimension_code_bu"></span></td>
</tr>

{/if}