
 {if $info}   <div id="infos"  style="display:block">

            <div class="alert alert-info">
                {if $info}
                {foreach from=$info item=infos}{$infos}<br/>{/foreach}
                {/if}
            </div>
        </div>{/if}
          {if $error}
        <div id="errors" style="display:block">
            <div class="alert alert-error">
                {if $error}
                {foreach from=$error item=blad}{$blad}<br/>{/foreach}
                {/if}                </div>

        </div>{/if}
        <form action="" method="post" onsubmit="return submit_debitd(this,'{$invoice_id}');">
        <div class="cfitm">
            <label for="dd_bank_account">{$lang.dd_bank_account} *</label>
            <input type="text" id="dd_bank_account" class="styled" name="iban" style="width: 90%;" value="{$iban}"  />
        </div>
        {if $require_confirmation}
        <div class="cfitm">
            <label for="dd_bank_account">{$lang.dd_bank_account_repeat} *</label>
            <input type="text" id="dd_bank_account" class="styled" name="iban2" style="width: 90%;"   />
        </div>
        {/if}
        {if $require_bank_name}
        <div class="cfitm">
            <label for="dd_bank_name">{$lang.dd_bank_name} *</label>
            <input type="text" id="dd_bank_account" class="styled" name="bank_name" style="width: 90%;" value="{$iban}"  />
        </div>
        {/if}
        {if $require_bic}
        <div class="cfitm">
            <label for="bic_label">{$bic_label} *</label>
            <input type="text" id="bic_label" class="styled" name="bic" style="width: 90%;" value="{$bic}"  />
        </div>
        <input class="btn btn-primary  btn-large" type="submit" value="{$lang.submit}" />
        {/if}
{securitytoken}
</form>

{literal}
<script>
    function submit_debitd(form,iid) {
        $.post('?cmd=direct_debit&action=pay&make=save&invoice_id='+iid,$(form).serialize(),function(data) {
            $('#facebox .content').html(data);
        });
        return false;
    }

</script>
{/literal}