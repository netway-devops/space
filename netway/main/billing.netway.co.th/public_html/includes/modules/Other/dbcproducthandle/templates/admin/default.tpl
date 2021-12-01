{include file="$tplPath/admin/header.tpl"}

<div class="box-body">

<div>
    <a href="https://netway365-my.sharepoint.com/:x:/g/personal/jaruwan_netway_co_th/EQ-eKM8RnRBMtIxNi6SjAh4Bw51dRTUErRalEJ-ie-WgyQ?rtime=GKk0EWAk10g" target="_blank">อ้างอิงเอกสาร DBC Product</a>
</div>

<div>
    <i class="fa fa-check-circle" style="color: green;" title="Show"></i> show
    <i class="fa fa-eye-slash" style="color: blue;" title="Hide"></i> Hide
    <i class="fa fa-ban" style="color: gray;" title="Archived"></i> Archived
</div>
<br />

<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table whitetable">
<thead>
<tr>
    <th>#</th>
    <th>Item</th>
    <th>Price</th>
    <td></td>
</tr>
</thead>
<tbody>
{foreach from=$aCategory item=aCat key=catId}
<tr>
    <td colspan="2"><b>{$aCat.name}</b></td>
    <td></td>
</tr>
{foreach from=$aCat.aProducts item=aProduct key=productId}
<tr valign="top">
    <td style="vertical-align: top;">
        {if $aCat.visible == 1}
        <i class="fa fa-check-circle" style="color: green;" title="Show"></i>
        {elseif $aCat.visible == 0}
        <i class="fa fa-eye-slash" style="color: blue;" title="Hide"></i>
        {else}
        <i class="fa fa-ban" style="color: gray;" title="Archived"></i>
        {/if}
    </td>
    <td style="padding-left: 20px; vertical-align: top;">
        
        {$aProduct.name} / 
        <a href="https://netway.co.th/7944web/?cmd=services&action=product&id={$productId}" target="_blank">{$productId}</a> <br />
        {if isset($aProducts[$productId].aDbcProduct)}
            {assign var="aDbcProduct" value=$aProducts[$productId].aDbcProduct}
            <div style="color: black;">
                <b>{$aDbcProduct.dbc_description}</b> / {$aDbcProduct.dbc_item_category_code}  / 
                <a href="{$dbcProductUrl}&filter='No.'%20IS%20'{$aDbcProduct.dbc_no}'" target="_blank">
                {$aDbcProduct.dbc_no}
                </a>
            </div>
        {/if}
        
    </td>
    <td style="width: 400px; ">
        
        {if isset($aProducts[$productId].aPrice)}
        {assign var="aPrice" value=$aProducts[$productId].aPrice.Product}
        <table style="border: 1px dotted black;">
        {foreach from=$aPrice item=aValue key=type}
        {if $aValue.price > 0}
            <tr>
                <td  style=" {if $aValue.error} background-color:#F99D27; {/if} width: 100px;" >
                    {if $type == 'm'} Monthly
                    {elseif $type == 'q'} Quarterly
                    {elseif $type == 's'} Semi-Annually
                    {elseif $type == 'a'} Annually
                    {elseif $type == 'b'} Biennially
                    {elseif $type == 't'} Triennially
                    {else}
                        {$type}
                    {/if}
                </td>
                <td style=" width: 100px;" >{$aValue.price} </td>
                <td style=" width: 100px;" >{$aValue.unit_code} &nbsp;</td>
                <td style=" width: 100px;" >{$aValue.price_dbc} </td>
            </tr>
        {/if}
        {/foreach}
        </table>
        {/if}
        
    </td>
    <td></td>
</tr>
{/foreach}
{/foreach}
</tbody>
</table>
</div>

{include file="$tplPath/admin/footer.tpl"}

