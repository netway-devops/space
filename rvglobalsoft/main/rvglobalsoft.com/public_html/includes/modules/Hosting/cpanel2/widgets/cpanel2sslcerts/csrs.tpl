{if $key}
    <div class="body-content">
        <div class="section">
            <h3 id="hdrViewKey">
                View Certificate Signing Request
            </h3>
            <p class="description">
                You are viewing the CSR you selected. 
                To purchase a trusted certificate, 
                you must copy the Encoded CSR below and send it to the Certificate Authority. 
                Follow the instructions provided by your certificate authority. 
            </p>
        </div>
        <div class="section">
            <div class="control-group">
                <label for="domain" id="lblDomain">Domain:</label>
                <div class="row-fluid">
                    <div class="span6">
                        {$name}
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="encoded-key" id="lblEncodedKey">Encoded CSR:</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="encoded-key">{$key}</pre>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="decoded-key" id="lblDecodedKey">Decoded CSR:</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="decoded-key">{$keydecoded}</pre>
                    </div>
                </div>
            </div>
        </div>
        <a href="{$widget_url}&act=keys" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            Go Back
        </a>
    </div>
{else}

    <div class="body-content">
        <div class="section">
            <h3 id="hdrCsr">
                SSL Certificate Signing Request
            </h3>
            <p class="description" id="descCsr">
                If you obtain a certificate from a trusted SSL provider, you must complete the 
                Certificate Signing Request form to provide the information needed to 
                generate your SSL certificate.
            </p>
            <h3 id="hdrCsrOnserver">Certificate Signing Requests on Server</h3>
            <table id="ssltable" class="sortable table table-striped">
                <thead>
                    <tr>
                        <th class=" clickable">Domain</th>
                        <th style="width: 60px;" >Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$list item=entry}
                        <tr class="">
                            <td class="name-column">
                                <div title="test" class="name-column column">{$entry.host|escape}</div>
                            </td>

                            </td>
                            <td class="actions-column">
                                <a href="{$widget_url}&act=csrs&key={$entry.host|escape:'url'}" class="cp-btn" ><span class="fa fa-pencil"></span></a>
                                <a href="{$widget_url}&act=csrs&del={$entry.host|escape:'url'}&security_token={$security_token}"
                                   class="cp-btn" onclick="return confirm('Do You really want to delete this entry?')"><span class="fa fa-trash"></span></a>
                            </td>
                        </tr>
                    {foreachelse}

                        <tr>
                            <td class="errors" colspan="4" id="nocsrErrorMsg">There are no certificate signing requests on the server.</td>
                        </tr>

                    {/foreach}
                </tbody>
            </table>
        </div>

        <div class="section">
            <h3 id="hdrGenerateCsr">Generate a New Certificate Signing Request (CSR)</h3>
            <div class="cjt-pagenotice-container cjt-notice-container" id="cjt_pagenotice_container"></div>
            <p class="description" id="descNewsrc">
                Use this form to generate a new certificate signing request for your domain. 
                Your SSL certificate authority (CA) will ask for a certificate 
                signing request to complete the certificate purchase. 

                Your CA may require specific information in the form below. 
                Check with the CA’s CSR requirements for the Apache web server.
            </p>
            <form name="csrform" id="csrform" method="post" action="{$widget_url}&act=csrs">
                {include file="`$widget_dir`gencert.tpl"}
            </form>
        </div>


        <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            Return to SSL Manager
        </a>

    </div>
{/if}