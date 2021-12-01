<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.dd_bank_details}</strong>
    </div>
    <div class="wbox_content ccform">
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
        {/if}



        <div class="clear"></div>



    </div>
</div>
