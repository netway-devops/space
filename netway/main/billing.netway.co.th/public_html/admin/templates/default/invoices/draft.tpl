
{include file='invoices/invoice_actions.tpl'}

<div id="ticketbody" >
    <div id="invoice-draft">
        {include file='invoices/draft_details.tpl'}
    </div>
    {include file='invoices/items_form.tpl'}
    <div id="invoice-actions">
        <a class="btn btn-sm btn-success" href="#convert" >Issue Invoice</a>
        {if $itemqueue}
            <a class="btn btn-sm btn-success" href="#itemqueue" ><span>Add items from queue</span></a>
        {/if}
        

    </div>

</div>


{include file='invoices/invoice_actions.tpl' type='bottom'}

{if $ajax}
    <script type="text/javascript">
        bindEvents();
        bindInvoiceEvents();
    </script>
{/if}

