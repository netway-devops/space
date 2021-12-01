{if $transactions}
    <div class="related-transactions-container">
    <strong>{$lang.relatedtransactions}:</strong><br />


        <table class="table table-striped" width="100%" >

           <thead>
           <tr>
                <th class="acenter">{$lang.Transactionid}</th>
                <th>{$lang.Date}</th>
                <th width="0"></th>
                <th  width="10%">{$lang.Amount}</th>
                <th  width="10%">{$lang.fees}</th>
                <th width="13%">{$lang.Gateway}</th>
               <th width="1%" class="acenter"></th>
                <th width="1%" class="acenter"></th>
            </tr>
           </thead>

            {foreach from=$transactions item=tran}
                <tr>

                    <td class="acenter"><a href="?cmd=transactions&action=edit&id={$tran.id}" target="_blank">{$tran.trans_id}</a></td>
                    <td >{$tran.date|dateformat:$date_format}</td>
                    <td>
                        {if $tran.invoice_id != $invoice.id && $tran.invoice_id != $invoice.invoice_id}
                            <a href="?cmd=invoices&action=edit&id={$tran.invoice_id}">Invoice #{$tran.invoice_id}</a>
                        {/if}
                    </td>
                    <td>{$tran.amount|price:$tran.currency_id}</td>
                    <td>{$tran.fee|price:$tran.currency_id}</td>

                    <td >
                        {if !$tran.module}{$lang.none}{else}
                            {foreach from=$gateways key=gatewayid item=paymethod}{if $tran.module == $paymethod}{$paymethod}{break}{/if}{/foreach}
                        {/if}
                        {*if $aTrans[$tran.id].description != ''}<br />{$aTrans[$tran.id].description}{/if*}
                    </td>

                    <td class="acenter"><a href="?cmd=transactions&action=edit&id={$tran.id}" target="_blank" class="editbtn">{$lang.edit}</a></td>
                    <td class="acenter"><a href="?cmd=invoices&action=removetrans&id={$tran.id}" class="removeTrans"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a></td>
                </tr>
            {/foreach}
        </table>
    </div>
{/if}