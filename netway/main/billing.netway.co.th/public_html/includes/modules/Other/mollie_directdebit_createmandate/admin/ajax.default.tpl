<!-- Single button -->
<div class="btn-group">
    <button type="button" class="btn btn-sm btn-default" >
        Mollie
    </button>
    <button type="button" class="btn btn-sm {if !$molliemandate}btn-info{else}btn-default{/if}"  onclick="return createmandatemollie()">
        {if !$molliemandate}Create mandate{else}{$molliemandate}{/if}
    </button>

</div>

<div id="SetMollieMandate" style="display:none;" bootbox data-title="Create New Mollie Mandate"
     data-formaction="?cmd=mollie_directdebit_createmandate&client_id={$client_id}&action=create"
     data-btntitle="Create" >
    <p>
        Use form below to create Direct Debit mandate for customer in Mollie.<br/>
        {if !$molliemandate}Customer profile not created in Mollie yet. It will be created during mandate creation {else}Mollie customer ID: <a href="https://www.mollie.com/dashboard/customers/{$molliemandate}" target="_blank" rel="noreferrer nofollow noopener" class="external">{$molliemandate}</a>{/if}
    </p>



    <div class="form-group">
        <label>IBAN</label>
        <input class="form-control" name="mollie_consumerAccount" type="text" />
    </div>

    <div class="form-group">
        <label>BIC</label>
        <input class="form-control" name="mollie_consumerBic" type="text" />
    </div>
    <div class="form-group">
        <label>Mandate Reference</label>
        <input class="form-control" name="mollie_mandateReference" value="{$mr}-{$client_id}" type="text" />
    </div>

    <div class="form-group">
        <label>Signature date</label>
        <div class="datepicker">
            <input type="text" name="mollie_signatureDate" class="form-control haspicker" style="width: 100%" value="{$now|dateformat:$date_format}"/>
        </div>
    </div>

    {securitytoken}
</div>
{literal}
<script>
    function createmandatemollie() {
        $('#SetMollieMandate').bootboxform().trigger('show');;

        return false;
    };
</script>{/literal}