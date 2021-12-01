{if $key}
    <div class="body-content">
        <div class="section">
            <h3 id="hdrViewKey">
                View Certificate 
            </h3>
            <p class="description">
                The encoded certificate is the portable format for the certificate. Please be sure to keep a copy of this certificate and the associated private key in a safe location. 
            </p>
        </div>
        <div class="section">
            <div class="control-group">
                <label for="domain" id="lblDomain">Domain:</label>
                <div class="row-fluid">
                    <div class="span6">
                        {$details.subject.cn}
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="encoded-key" id="lblEncodedKey">Encoded Certificate:</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="encoded-key">{$key}</pre>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="decoded-key" id="lblDecodedKey">Decoded Certificate:</label>
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
            <h3 id="hdrCertificates">
                SSL Certificates
            </h3>
            <p class="description" id="descSelfsigned">You can use a self-signed certificate or a trusted certificate from an SSL Certificate Authority. If you plan to use a self-signed certificate for one of your sites, you can generate it below. To use a trusted certificate, upload or provide the certificate below, after you have received the SSL certificate from your trusted provider.</p>

            <h3 id="hdrOnserver">Certificates on Server</h3>
            <table id="ssltable" class="sortable table table-striped">
                <thead>
                    <tr>
                        <th scope="col" class=" clickable">Domain</th>
                        <th scope="col" class=" clickable">Expiration (UTC)</th>
                        <th scope="col" class=" clickable">Key Size</th>
                        <th scope="col" class="sorttable_nosort">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$list item=entry}
                        <tr class="">
                            <td>{$entry.issuer}</td>
                            <td>{$entry.expiredate}</td>
                            <td>{$entry.data.public_key}</td>
                            </td>
                            <td class="actions-column">
                                <a href="{$widget_url}&act=crts&key={$entry.host|escape:'url'}" class="cp-btn" ><span class="fa fa-pencil"></span></a>
                                <a href="{$widget_url}&act=crts&del={$entry.host|escape:'url'}&security_token={$security_token}"
                                   class="cp-btn" onclick="return confirm('Do You really want to delete this entry?')"><span class="fa fa-trash"></span></a>
                            </td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td class="errors" colspan="5" id="nocertsErrorMsg">There are no certificates on the server.</td>
                        </tr>
                    {/foreach}


                </tbody>
                <tfoot></tfoot>
            </table>
        </div>

        <div class="section">


            <h3>Upload a New Certificate</h3>
            <p class="description" id="descUpload">
                Use this form to upload a certificate provided by a third-party Certificate Authority. You may either paste the body of the certificate or upload it from a “.crt” file.
            </p>

            <form enctype="multipart/form-data" method="post" id="paste" name="upload" action="{$widget_url}&act=crts">
                <input type="hidden" value="1" name="paste" />
                <div class="control-group">
                    <label for="crt" id="lblCrt">Paste your certificate below</label>
                    <div class="row-fluid">
                        <div class="span8">
                            <textarea title="The certificate should include the lines that contain BEGIN and END."  dir="ltr" id="crt" name="crt" class="form-control paste "></textarea>
                            <div class="textarea-parse" id="cert_parse" style="display: none;"></div>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <input type="submit" value="Save Certificate" class="btn btn-flat-primary btn-primary" id="save-certificate">
                </div>
                {securitytoken}
            </form>

            <div class="connector">
                or 
            </div>

            <form enctype="multipart/form-data" method="post" id="upload" name="upload" action="{$widget_url}&act=crts">
                <input type="hidden" value="1" name="upload" />
                <div class="control-group">
                    <label for="crtfile" id="lblCrtfile">Choose a certificate file (*.crt).</label>
                    <div class="row-fluid">
                        <div class="span6">
                            <input type="file" title="The certificate files usually have the “.crt” extension." id="crtfile" name="crtfile">
                        </div>
                        <div class="span6">
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <input type="submit" value="Upload Certificate" class="btn btn-flat-primary btn-primary" id="upload-certificate">
                </div>
                {securitytoken}
            </form>
        </div>

        <div class="section">
            <h3 id="hdrNewcert">Generate a New Certificate</h3>
            <p class="description" id="descNewcert">
                Use this form to generate a new, self-signed certificate for your domain. Typically, self-signed certificates are temporarily used until you receive a trusted SSL certificate from your SSL certificate authority.
            </p>
            <div class="cjt-pagenotice-container cjt-notice-container" id="cjt_pagenotice_container"></div>
            <form class="simple" id="mainform" name="mainform" method="post" action="{$widget_url}&act=crts">
                {include file="`$widget_dir`gencert.tpl"}
            </form>
        </div>
        <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            Return to SSL Manager
        </a>
    </div>
{/if}