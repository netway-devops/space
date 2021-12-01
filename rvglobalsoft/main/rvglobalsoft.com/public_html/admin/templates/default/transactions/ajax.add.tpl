{if $action=='listclientinvoices'}

        {if $client_invoices}
            <select name="invoice_id" class="form-control ">

                <option ></option>
                {foreach from=$client_invoices item=invoice}
                    <option value="{$invoice.id}" data-balance="{$invoice.balance}" data-name="#{$invoice|@invoice}">#{$invoice|@invoice} - date: {$invoice.date|dateformat:$date_format} - balance: {$invoice.balance|price:$invoice.currency_id}</option>
                {/foreach}

            </select>
            {else}
            <input  name="invoice_id" value="0" type="hidden" />
            <p class="help-block">This client does not have unpaid invoices, to apply transaction to other invoice use "Add payment" option in invoice menu</p>
        {/if}

{/if}