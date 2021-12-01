{foreach from=$invoice.items item=item key=pos}
{assign var=itemId value=$item.id}
    <tr {if $item.id}id="line_{$item.id}" data-item-id="{$item.id}"{/if} data-line="{$pos}">
        <td class="acenter">
            <input type="checkbox" name="invoice_item_id[]"
                   value="{$item.id}" {if !$item.id}disabled{/if}
                   class="invitem_checker"/>
            {if !$item.id}
                <input type="hidden" name="item[{$pos}][item_id]"
                       value="{$item.item_id}"
                       class="invitem_checker"/>
                <input type="hidden" name="item[{$pos}][type]"
                       value="{$item.type}"
                       class="invitem_checker"/>
            {/if}
        </td>
        <td class="editor-line">
            <div class="editor-line-description">
                {if isset($aInvoiceItems.$itemId) && $aInvoiceItems.$itemId.is_shipped}
                <span style="color:red; font-weight:bold;">&nbsp; Shipped &nbsp;</span>
                {/if}
                {if $item.type=='Hosting' && $item.item_id!='0'}
                    <a href="?cmd=accounts&action=edit&id={$item.item_id}&list=all" class="line_descr">{$item.description|nl2br}</a>
                {elseif ($item.type=='Domain Register' || $item.type=='Domain Transfer' || $item.type=='Domain Renew') && $item.item_id!='0'}
                    <a href="?cmd=domains&action=edit&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
                {elseif $item.type=='Invoice' && $item.item_id!='0'}
                    <a href="?cmd=invoices&action=edit&id={$item.item_id}&list=all" class="line_descr">{$item.description|nl2br}</a>
                {elseif $item.type=='Support' && $item.item_id!='0'}
                    <a href="?cmd=tickettimetracking&action=item&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
                {elseif $item.type=='Order' && $item.item_id!='0'}
                    <a href="?cmd=orders&action=edit&id={$item.item_id}" class="line_descr">{$item.description|nl2br}</a>
                {else}
                    <span class="line_descr">{$item.description|nl2br}</span>
                {/if}
                {if !$block_invoice}
                    {if !$item.readonly}
                        <a class="editbtn" style="display:none;"  href="#">{$lang.Edit}</a>
                    {/if}
                {/if}
            </div>
            <div class="editor-line-form row">
                <div class="col-sm-10">
                    <textarea class="foc invitem invdescription"
                              name="item[{$pos}][description]"
                              rows="10" style="width: 100%"
                              >{$item.description}</textarea>
                </div>
                <div class="col-sm-2">
                    <a class="editbtn" href="#">{$lang.Cancel}</a>
                </div>
            </div>
        </td>

        <td class="acenter">
            {if $item.quantity}{$item.quantity}{else}{$item.qty}{/if}
            <!--ปิดไม่ให้แก้ไข quantity-->
            <div style="display: none;">
                <a href="Javascript:void(0);" onclick="$('#invoiceQuantityEditA{$item.id}').show();$('#invoiceQuantity{$item.id}').attr('type','text');" style="color: #D0CCC9;">แก้ไข</a>
            </div>
            <span id="invoiceQuantityEditA{$item.id}" style="color: #FF0000; display: none;"><small>(ระวังแก้ไขข้อมูล จะ update ทันที)</small><br /></span>
            <input type="hidden" id="invoiceQuantity{$item.id}" alt="{$item.id}"
                name="item[{$item.id}][quantity]"
                value="{if $item.quantity}{$item.quantity}{else}{$item.qty}{/if}"
                size="2" class="foc quantityVal"
                style="text-align:center;" />

        </td>
        <td class="acenter">

            {if $item.quantity_text}{$item.quantity_text}{/if}
            <!-- ปิดไม่ให้แก้ไข quantity_text-->
            <div style="display: none;">
                <a href="Javascript:void(0);" onclick="$('#invoiceQuantityTextEdit{$item.id}').show();$('#invoiceQuantityText{$item.id}').attr('type','text');" style="color: #D0CCC9;">แก้ไข</a>
            </div>
            <div id="invoiceQuantityTextEdit{$item.id}" style="color: #FF0000; display: none;">
                <small>(ระวังแก้ไขข้อมูล จะ update ทันที)</small><br />
            </div>
            <input type="hidden" id="invoiceQuantityText{$item.id}" alt="{$item.id}"
                name="item[{$item.id}][quantity_text]"
                value=" {if $item.quantity_text}{$item.quantity_text}{/if}"
                size="7" class="foc quantityText"
                style="text-align:center;" />

        </td>
        <td class="aright">
            {if $item.unit_price > 0}
                {$item.unit_price|string_format:"%.2f"}
            {else}
                {$item.amount|string_format:"%.2f"}
            {/if}
            <!-- ปิดไม่ให้แก้ไข unit_price-->
                <div style="display: none;">
                    <a href="Javascript:void(0);" onclick="$('#unitPriceEditA{$item.id}').show();$('#unitPrice{$item.id}').attr('type','text');" style="color: #D0CCC9;">แก้ไข</a>
                </div>
                <div id="unitPriceEditA{$item.id}" style="color: #FF0000; display: none;">
                    <small>(ระวังแก้ไขข้อมูล จะ update ทันที)</small><br />ราคา
                </div>
                <input type="hidden" id="unitPrice{$item.id}" alt="{$item.id}"
                    name="item[{$item.id}][unit_price]"
                    value="{if $item.unit_price > 0}{$item.unit_price|string_format:"%.2f"}{else}{$item.amount|string_format:"%.2f"}{/if}"
                    size="7" class="foc unitPrice"
                    style="text-align:right;" {if ! isset($admindata.access.editInvoices)}disabled="disabled"{/if} />

        </td>
        <td class="acenter" style="display:none">
            <input name="item[{$pos}][qty]" value="{$item.qty}"
                   size="8" class="foc invitem invqty"
                   readonly
                   {if $item.readonly}readonly{/if}
                   style="text-align:center" {if $block_invoice}disabled{/if} disabled/>
        </td>
        <td class="acenter" >
            <div class="input-group input-combo isForbidAccess">
                <input type="hidden" name="item[{$pos}][taxed]" value="{$item.taxed}"
                       class="invitem invtaxed" />
                <input type="text" name="item[{$pos}][tax_rate]"
                       {if $invoice.taxexempt || $block_invoice}disabled{/if}
                        {if $item.readonly}readonly{/if} size="3"
                       value="{if $item.taxed}{$item.tax_rate}{else}{$lang.nontax}{/if}"
                       class="invitem invtaxrate _search text-right" data-toggle="dropdown"
                />
                <span class="caret"></span>
                <ul class="tax-rates dropdown-menu dropdown-menu-right" role="menu">
                    <li><a data-value="{$lang.nontax}" data-notax>{$lang.nontax}</a></li>
                    {foreach from=$tax_rates item=taxr}
                        <li><a data-value="{$taxr}">{$taxr}%</a></li>
                    {/foreach}
                </ul>
            </div>
        </td>
        <td class="acenter" style="display:none">
            <input name="item[{$pos}][amount]" value="{$item.amount}" size="16"
                   class="foc invitem invamount _search text-right"
                   readonly
                   {if $item.readonly}readonly{/if} {if $block_invoice}disabled{/if}
                   />
        </td>
        <td class="aright">
        	<input type="text" id="discountPrice{$item.id}" alt="{$item.id}"
        		name="item[{$item.id}][discount_price]"
        		value="{if $item.discount_price != 0}{$item.discount_price|string_format:"%.2f"}{else}0.00{/if}"
        		size="7" class="foc discountPrice" style="text-align:right"
        		title="{$item.discount_price}" {if ! isset($admindata.access.editInvoices)}readonly{/if} /><!--check staff permission edit Invoice-->
        </td>
        <td class="aright">
            {$currency.sign}
            <span id="ltotal_{$pos}">{$item.linetotal|string_format:"%.2f"}</span>
            {if $currency.code}
                {$currency.code}
            {else}{$currency.iso}
            {/if}
        </td>
        <td class="acenter">
            {if !$item.readonly}
                <a href="?cmd=invoices&action=removeline&id={$invoice.id}&line={$pos}"
                   class="btn btn-xs btn-default removeLine {if $block_invoice}disabled{/if}">
                    {if $item.id}
                        <i class="fa fa-trash"></i>
                    {else}
                        <i class="fa fa-close"></i>
                    {/if}
                </a>
            {/if}
        </td>
    </tr>
{/foreach}
<script type="text/javascript">
{literal}
$(document).ready(function(){
  // we call the function
  forbidAccessBlock();
});
 {/literal}
</script>