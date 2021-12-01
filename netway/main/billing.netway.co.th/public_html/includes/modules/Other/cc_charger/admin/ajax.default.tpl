<form method="post" action="?cmd=cc_charger&action=chargecc">
    <input type="hidden" name="invoice_id" value="{$invoice_id}"/>
    <div class="form-group">
        <label>Credit Card</label>
        <select class="form-control" name="make">
            {if $current_cc}
                <option value="chargecurrent">Credit card on file ({$current_cc})</option>
            {/if}
            <option value="chargenew">New credit card</option>
        </select>
    </div>
    <div class="new-card">
        <div class="form-group">
            <label>Card Type</label>
            <select class="form-control" name="cc[cardtype]">
                <option>Visa</option>
                <option>MasterCard</option>
                <option>Discover</option>
                <option>American Express</option>
                <option>Laser</option>
                <option>Maestro</option>
            </select>
        </div>
        <div class="form-group">
            <label>Card number</label>
            <input type="text" name="cc[cardnum]" size="25" maxlength="32" autocomplete="off" class="form-control">
        </div>
        <div class="form-row">
            <label>Expiration date</label>
            <div style="display: flex; margin-bottom: 7px;">
                <input type="text" name="cc[expirymonth]" size="2" maxlength="2" autocomplete="off" class="form-control" style="max-width: 60px;"><b style="margin: 7px;">/</b>
                <input type="text" name="cc[expiryyear]" size="2" maxlength="2" autocomplete="off" class="form-control" style="max-width: 60px;"><b style="margin: 7px;">(MM/YY)</b>
            </div>
            <div style="clear: both;"></div>
        </div>
        <div class="form-group">
            <label>CVV</label>
            <input type="password" name="cvv" size="5" minlength="3" maxlength="5" autocomplete="off" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label>Amount</label>
        <select class="form-control" name="amount">
            <option value="invoice">Invoice due amount</option>
            <option value="custom">Enter custom amount</option>
        </select>
    </div>
    <div class="form-group custom-amount">
        <label>Custom amount</label>
        <input type="number" name="custom[amount]" step="0.01" min="0" {if $invoice_total}max="{$invoice_total}"{/if} autocomplete="off" class="form-control">
    </div>

    {literal}<script>
        $(function () {
            var make = $('select[name=make] option:selected').val(),
                amount =  $('select[name=amount] option:selected').val();
            if (make !== 'chargenew')
                $('.new-card').hide();
            if (amount !== 'custom')
                $('.custom-amount').hide();
        });
        $('select[name=make]').on('change', function () {
           if ($(this).val() === 'chargenew')
               $('.new-card').slideDown();
           else
               $('.new-card').slideUp();
        });

        $('select[name=amount]').on('change', function () {
            if ($(this).val() === 'custom')
                $('.custom-amount').slideDown();
            else
                $('.custom-amount').slideUp();
        });

    </script>{/literal}
    {securitytoken}
</form>
