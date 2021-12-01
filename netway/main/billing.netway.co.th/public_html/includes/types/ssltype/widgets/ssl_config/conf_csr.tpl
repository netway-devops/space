<p>{$lang.en_wtfdescr}</p>

<form action="" method="post">
    <div class="sslcert-section">            
        <div class="form-group">
            <label>{$lang.cert_csr_guide}</label>
            <div>
                <textarea class="styled csr-textarea" name="csr">{$cert.csr}</textarea>
            </div>
        </div>

        {if $csr_servers}
            <div class="form-group">
                <label>{$lang.en_servsoft}</label>
                <div>
                    <select id="servers_types" name="software">
                        {if $csr_servers}
                            {foreach from=$csr_servers item=server key=pos}
                                <option {if $cert.software == $pos}selected="selected"{/if} value="{$pos}">{$server}</option>
                            {/foreach}
                        {/if}
                    </select>
                </div>
            </div>
        {/if}
    </div>
    <button type="subbmit" class="btn btn-primary">{$lang.submit}</button>
    {securitytoken}
</form>