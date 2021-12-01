{if $cert}
    <ul class="accor white cert">
        <li>
            <a href="#">Certificate Information</a>
            <div class="sor" >
                <div id="csr">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            {foreach from=$cert.csr_data key=csrkey item=csrval}
                                <tr class="grid-6">
                                    <td width="200"><strong>{if isset($cert_lang[$csrkey])}{$cert_lang[$csrkey]}{else}{$csrkey}{/if}</strong></td>
                                    <td>{$csrval}</td>
                                </tr>
                            {/foreach}
                            <tr class="grid-6">
                                <td width="200"><strong>DCV Method</strong></td>
                                <td>{$cert.dcv|default:'N/A'|upper}</td>
                            </tr>
                        </table>
                    </div>
                </div>
                {if $dcv.details && ($dcv.type == 'http' || $dcv.type == 'https')}
                    <div class="row" style="margin-top: 15px;">
                        <hr />
                        <div class="col-md-12">
                            <p><strong>File Verification</strong></p>
                            <p>Files have to be publicly accessible trough HTTP(S) under those URL(s):</p>
                            {foreach from=$dcv.details item=dcvn key=dcvname}
                                <p>
                                    {if $dcvn.status}
                                        <span class="pull-right label label-default"
                                        >{$dcvn.status}</span>
                                    {/if}
                                    <strong>For {$dcvname}:</strong>
                                </p>
                                <pre>{$dcvn.url|escape}</pre>
                            {/foreach}
                            <p>Each file must contain this data:</p>
                            <pre>{$dcv.file_data|escape}</pre>
                        </div>
                    </div>
                {/if}
                {if $dcv.details && ($dcv.type == 'dns')}
                    <div class="row " style="margin-top: 15px;">
                        <hr />
                        <div class="col-md-12">
                            <p><strong>DNS Verification</strong></p>
                            <p>Records shown below have to be added to DNS zone</p>
                            {foreach from=$dcv.details item=dcvn key=dcvname}
                                <p>
                                    {if $dcvn.status}
                                        <span class="pull-right label label-default"
                                        >{$dcvn.status}</span>
                                    {/if}
                                    <strong>For {$dcvname}:</strong>
                                </p>
                                <pre>{$dcvn.name} 3600 IN {$dcvn.type} {$dcvn.content}</pre>
                            {/foreach}
                        </div>
                    </div>
                {/if}
                {if $dcv.type == 'email'}
                    <div class="row " style="margin-top: 15px;">
                        <div class="col-md-2"><strong>DCV Email Content</strong></div>
                        <div class="col-md-8">
                            {if $cert.cn}
                                <code>{$cert.approval_email[$cert.cn]}</code>
                            {else}
                                <code>{$cert.approval_email[$details.domain]}</code>
                            {/if}
                        </div>
                    </div>
                {/if}
            </div>
            <div class="row">
                <div class="col-sm-12">
                    {if $cert.csr_data}<button id="show-csr" class="btn btn-default btn-sm">Show CSR</button>{/if}
                    {if $cert.private_key}<button id="show-private-key" class="btn btn-default btn-sm">Show Private Key</button>{/if}
                    {if $cert_setup}
                        <button type="button" class="btn btn-sm btn-primary cert-btn" id="csr" onclick="showCertTab(this)">Change CSR</button>
                        {if $cert_options.dcv}
                            <button type="button" class="btn btn-sm btn-primary cert-btn" id="dcv" onclick="showCertTab(this)">Change DCV</button>
                        {/if}
                    {/if}
                    {if $cert.status == 'Awaiting Validation' && $cert_resend && $cert.dcv == 'email'}
                        <a id="show-csr" class="btn btn-default btn-sm" href="?cmd=accounts&action=edit&id={$details.id}&resetdcv=1">Resend Email / Reset DCV frequency</a>
                    {/if}
                </div>
            </div>
        </li>
    </ul>
    {if $cert_setup}
        <ul id="csr-content" class="accor white cert cert-content" style="display: none;">
            <li>
                <a href="#">Certificate Setup</a>
                <div class="sor" >
                    <div class="row">
                        <div class="col-sm-12">
                            <p>Certificate signing request (also CSR or certification request) is a message sent from an applicant to a certificate authority in order to apply for a digital identity certificate.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <p>It contains information that will be included in your certificate such as:</p>
                            <ul>
                                <li>Organization name</li>
                                <li>Common name (domain name)</li>
                                <li>Location</li>
                                <li>Country</li>
                            </ul>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <p>Paste your CSR in the form below, make sure to include the complete header and footer, "BEGIN" and "END" lines</p>
                        </div>
                    </div>
                    <form>
                        <div class="col-sm-12">
                            <label>CSR</label>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <textarea name="setup[csr]" style="min-width: 38em; min-height: 350px; font-family: monospace; font-size: 1em; resize: vertical;">{$cert.csr}</textarea>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label>Private Key</label>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <textarea name="setup[private_key]" style="min-width: 38em; min-height: 530px; font-family: monospace; font-size: 1em; resize: vertical;">{$cert.private_key}</textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label>Select server software:</label>
                                <select name="setup[software]">
                                    {foreach from=$csr_servers item=csr_server key=id}
                                        <option value="{$id}" {if $cert.software == $id || $cert.software == $csr_server}selected="selected"{/if}>{$csr_server}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {securitytoken}
                        <div class="row">
                            <div class="col-sm-12">
                               <button type="submit" name="setup[form]" value="csr" class="btn btn-sm btn-primary">Submit</button>
                            </div>
                        </div>
                    </form>
                </div>
            </li>
        </ul>
        {if $cert_options.dcv}
            <ul id="dcv-content" class="accor white cert cert-content" style="display: none;">
                <li>
                    <a href="#">Certificate Setup</a>
                    <div class="sor" >
                        <div class="row">
                            <div class="col-sm-12">
                                <p>Domain Control Validation (DCV)</p>
                                <p>DCV is a mechanism used to prove ownership or control of a registered domain name.</p>
                                <form action="" method="POST">
                                    <div id="dcv">
                                        <div class="form-group" id="dcv-method">
                                            <label for="ssl-dcv"><strong>Validation Method</strong></label>
                                            <select name="setup[dcv]" id="ssl-dcv">
                                                {foreach from=$cert_options.dcv item=dcv}
                                                    <option value="{$dcv}" {if $cert.dcv == $dcv}selected{/if}>
                                                        {if $dcv == 'email'}Email Validation{elseif $dcv == 'dns'}DNS-based validation {elseif in_array($dcv, array('http', 'https'))}HTTP-based validation{/if}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </div>

                                        <div class="dcv dcv-email">
                                            <p>You will receive an email with an unique link to approve the certificate and validate your domain ownership.</p>
                                            {foreach from=$approveremails item=emails key=name}
                                                <div class="form-group" >
                                                    <label>Approval email for {$name}</label>
                                                    <select name="setup[approval_email][{$name}]">
                                                        {foreach from=$emails item=email}
                                                            <option value="{$email}" {if $cert.approval_email[$name] == $email || $cert.approval_email == $email}selected{/if}>{$email}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            {/foreach}
                                        </div>
                                        <div class="dcv dcv-dns">
                                            <p>Validation by DNS implies that you have access to the DNS zone file of your domain, and can add a record to it. If you select this method, the record to be inserted into the zone will be available after order is completed.</p>
                                        </div>
                                        <div class="dcv dcv-http dcv-https">
                                            <p>HTTP validation method requires that you have access to the web server that hosts the website that the domain will point to. You will be provided with a file that has to be placed in the root directory of the website.</p>
                                        </div>
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
                                        <button type="submit" name="setup[form]" value="dcv" class="btn btn-sm btn-primary">Submit</button>
                                    </div>
                                    {securitytoken}
                                </form>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        {/if}
    {/if}
    {if $cert.san}
        <ul class="accor white cert">
            <li>
                <a href="#">Subject alternative Names (SAN)</a>
                <div class="sor" >
                    <div class="row">
                        <ul>
                            {foreach from=$cert.san item=san}
                                <li>{$san}</li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </li>
        </ul>
    {/if}
    <div id="csr-dialog" hidden>
        <strong>Certificate signing request</strong>
        <pre style="margin:auto;">{$cert.csr}</pre>
        {if $cert.csr_data}
            <hr />
            <div>
                <strong>CSR Details</strong>
                <table class="table table-striped">
                    {foreach from=$cert.csr_data item=csr key=key}
                        <tr>
                            <td>{if isset($cert_lang[$key])}{$cert_lang[$key]}{else}{$key}{/if}</td>
                            <td>{$csr}</td>
                        </tr>
                    {/foreach}
                </table>
            </div>
        {/if}
    </div>
    <div id="private-key-dialog" hidden>
        <strong>Private Key</strong>
        <pre style="margin:auto;">{$cert.private_key}</pre>
    </div>
{/if}
{literal}
    <style>
        .cert .sor .row{
            margin-bottom: 10px;
        }
    </style>
    <script>
        $(function () {
            $('#show-csr').on('click', function () {
                bootbox.dialog({
                    message: $('#csr-dialog').html()
                });
                return false;
            });
            $('#show-private-key').on('click', function () {
                bootbox.dialog({
                    message: $('#private-key-dialog').html()
                });
                return false;
            });
        });

        function showCertTab(btn) {
            var id = $(btn).attr('id');
            $('.cert-content').slideUp();
            $('#' + id + '-content').slideDown();
            $('.cert-btn').prop('disabled', false);
            $(btn).prop('disabled', true);
        }
    </script>
{/literal}