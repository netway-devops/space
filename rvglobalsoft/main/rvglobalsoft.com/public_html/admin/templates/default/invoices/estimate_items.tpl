{foreach from=$estimate.items item=item}
    <tr id="line_{$item.id}">
        <td class="editline">
            <span class="line_descr">{$item.description|nl2br}</span>
            <span {if ! isset($admindata.access.editEstimates)}style="display:none;"{/if}> <a class="editbtn" {if ! isset($admindata.access.editEstimates)} style="display:none;" {/if}  href="#">{$lang.Edit}</a> </span>
            <div style="display:none" class="editor-line">
                <textarea name="item[{$item.id}][description]">{$item.description}</textarea>
                <a class="savebtn" href="#" >{$lang.savechanges}</a>
            </div>
        </td>
        <td class="acenter">
            <input name="item[{$item.id}][qty]" value="{$item.qty}"
                   size="8" class="foc invitem invqty" style="text-align:center" {if ! isset($admindata.access.editEstimates)}disabled="disabled"{/if}/>
        </td>
        <td class="acenter">
            <input type="hidden" name="item[{$item.id}][taxed]" value="{$item.taxed}" />
            <input type="text" name="item[{$item.id}][tax_rate]"
                   size="4" value="{$item.tax_rate}" class="invitem invtaxrate" style="text-align:right" {if ! isset($admindata.access.editEstimates)}disabled="disabled"{/if}/>
        </td>
        <td class="acenter">
            <input name="item[{$item.id}][amount]" value="{$item.amount}"
                   size="16" class="foc invitem invamount" style="text-align:right" {if ! isset($admindata.access.editEstimates)}disabled="disabled"{/if}/>
        </td>
        <td class="aright">
            {$currency.sign} <span id="ltotal_{$item.id}">{$item.linetotal|string_format:"%.2f"}</span>
            {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}
        </td>
        <td class="acenter">
            {if isset($admindata.access.editEstimates)}
                <a href="?cmd=estimates&action=removeline&id={$estimate.id}&line={$item.id}" class="removeLine">
                    <img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/>
                </a>
            {/if}
        </td>
    </tr>
{/foreach}