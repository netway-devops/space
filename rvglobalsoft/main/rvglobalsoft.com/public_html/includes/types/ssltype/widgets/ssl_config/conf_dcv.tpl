
<h3>{$lang.cert_dcv_title}</h3>
<p>{$lang.cert_dcv_descr} </p>
<form action="" method="POST">
    <div id="dcv">
        <div class="form-group" id="dcv-method">
            <label for="ssl-dcv"><strong>{$lang.dcv_method}</strong></label>
            <select name="dcv" id="ssl-dcv">
                {foreach from=$dcvmethods item=dcv}
                    <option value="{$dcv.type}" {if $dcv_main == $dcv.type}selected{/if}>{$lang[$dcv.lang]}</option>
                {/foreach}
            </select>
        </div>
        {foreach from=$dcvmethods item=dcv}
            <div class="dcv dcv-{$dcv.type}">
                <p>{$lang[$dcv.descr_lang]}</p>
                {if $dcv.type == 'email'}
                    <hr />
                    {foreach from=$approveremails item=emails key=name}
                        <div class="form-group" >
                            <label>{$lang.approver_email_for|sprintf:$name}</label>
                            <select name="approval_email[{$name}]">	
                                {foreach from=$emails item=email}
                                    <option value="{$email}" {if $dcvdetails[$name] == $email}selected{/if}>{$email}</option>
                                {/foreach}			
                            </select>
                        </div>
                    {/foreach}
                {/if}
            </div>
        {/foreach}
        <hr />
    </div>

    {literal}
        <script>
            $(function () {
                $('#ssl-dcv').on('change', function () {
                    $('#dcv .dcv').hide().filter('.dcv-' + $(this).val()).show();
                }).trigger('change');
            })
        </script>
    {/literal}
    <div class="submit">
        {if $invoice}
            <div class="alert alert-warning">
                {$lang.cert_invoice_unpaid|sprintf:$invoicelink}
            </div>
        {/if}

        {if $edit || $invoice}
            <button type="submit" class="btn btn-success">{$lang.savechanges}</button>
        {else}
            <button type="submit" class="btn btn-success">{$lang.completeorder}</button>
        {/if}
    </div>
    {securitytoken}
</form>