{if $transactions}
    <div class="related-transactions-container">
    <strong>{$lang.relatedtransactions}:</strong><br />

    <form action="" method="post" id="transform">
        <input type="hidden" name="make" value="edittrans" />
        <table class="table table-striped" width="100%" border="0" cellpadding="0" cellspacing="0">
            <thead>
            <tr>
                <th class="acenter">{$lang.Transactionid}</th>
                <th>{$lang.Date}</th>
                <th width="0"></th>
                <th class="acenter" width="10%">{$lang.Amount}</th>
                <th class="acenter" width="10%">{$lang.fees}</th>
                <th class="acenter" width="13%">{$lang.Gateway}</th>
                <th width="1%" class="acenter"></th>
                <th width="1%" class="acenter"></th>
            </tr>
           </thead>

            {foreach from=$transactions item=tran}
                <tr valign="top">

                    <td class="acenter">
                        <a href="?cmd=transactions&action=edit&id={$tran.id}" target="_blank">{$tran.trans_id}</a>
                        <input disabled="disabled" name="transaction[{$tran.id}][trans_id]" value="{$tran.trans_id}"  class="transeditor" {if ! isset($admindata.access.editTransactions)}disabled="disabled"{/if} />
                    </td>
                   
                    <td >
                        {$tran.date|dateformat:$date_format}
                        <input  disabled="disabled" name="transaction[{$tran.id}][date]" value="{$tran.date|dateformat:$date_format}" 
                        {if ! isset($admindata.access.editTransactions)}
                            disabled="disabled"
                        {/if} 
                        readonly="readonly" class="haspicker transeditor" />
                    </td>
                   
                    <td>
                        {if $tran.invoice_id != $invoice.id && $tran.invoice_id != $invoice.invoice_id}
                            <a href="?cmd=invoices&action=edit&id={$tran.invoice_id}">Invoice #{$tran.invoice_id}</a>
                        {/if}
                    </td>

                    <td class="acenter">
                        {$tran.amount|price:$tran.currency_id}
                        <input disabled="disabled" name="transaction[{$tran.id}][amount]" value="{$tran.amount}" size="7"  class="transeditor" {if ! isset($admindata.access.editTransactions)}disabled="disabled"{/if} />
                    </td>
                    
                    <td class="acenter">
                        {$tran.fee|price:$tran.currency_id}
                        <input disabled="disabled" name="transaction[{$tran.id}][fee]" value="{$tran.fee}" size="7" class="transeditor" {if ! isset($admindata.access.editTransactions)}disabled="disabled"{/if} />
                        {if $aTrans[$tran.id].fee_code != ''}<br />{$aTrans[$tran.id].fee_message}{/if}
                    </td>

                    <td class="acenter">
                        {if !$tran.module}{$lang.none}{else}
                            {foreach from=$gateways key=gatewayid item=paymethod}
                                {if $tran.module == $paymethod}{$paymethod}{break}{/if}
                            {/foreach}
                        {/if}
                        <select disabled="disabled" name="transaction[{$tran.id}][paymentmodule]" {if ! isset($admindata.access.editTransactions)}disabled="disabled"{/if} class="transeditor">
                            <option value="0" {if !$tran.module}selected="selected"{/if}>{$lang.none}</option>
                            {foreach from=$gateways key=gatewayid item=paymethod}
                                <option value="{$gatewayid}"{if $tran.module == $paymethod} selected="selected"{/if} >{$paymethod}</option>
                            {/foreach}
                        </select>
                        {if $aTrans[$tran.id].description != ''}<br />
                            {if $aTrans[$tran.id].description|strlen > 200}
                            {else}
                            {$aTrans[$tran.id].description}
                            {/if}
                        {/if}
                    </td>

                    <td class="acenter"><a href="?cmd=transactions&action=edit&id={$tran.id}" target="_blank" class="editbtn">{$lang.edit}</a></td>
                    <td class="acenter">
                        {if isset($admindata.access.deleteTransactions)}
                            <a href="?cmd=invoices&action=removetrans&id={$tran.id}" class="removeTrans"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a>
                        {/if}
                    </td>
                </tr>
            {/foreach}
        </table>
        {securitytoken}
    </form>
  </div>
{/if}