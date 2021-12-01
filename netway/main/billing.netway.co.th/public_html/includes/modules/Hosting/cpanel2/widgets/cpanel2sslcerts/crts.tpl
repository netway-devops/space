{if $key}
    <div class="body-content">
        <div class="section">
            <h3 id="hdrViewKey">
                {$lang.cpanel_view_certificate}
            </h3>
            <p class="description">
                {$lang.cpanel_view_certificate_desc}
            </p>
        </div>
        <div class="section">
            <div class="control-group">
                <label for="domain" id="lblDomain">{$lang.cpanel_ssl_domain}</label>
                <div class="row-fluid">
                    <div class="span6">
                        {$details.subject.cn}
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="encoded-key" id="lblEncodedKey">{$lang.cpanel_ssl_encoded_cert}</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="encoded-key">{$key}</pre>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="decoded-key" id="lblDecodedKey">{$lang.cpanel_ssl_decoded_cert}</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="decoded-key">{$keydecoded}</pre>
                    </div>
                </div>
            </div>
        </div>
        <a href="{$widget_url}&act=keys" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            {$lang.cpanel_ssl_go_back}
        </a>
    </div>
{else}

    <div class="body-content">

        <div class="section">
            <h3 id="hdrCertificates">
                {$lang.cpanel_ssl_certificates}
            </h3>
            <p class="description" id="descSelfsigned">{$lang.cpanel_ssl_certificates_desc}</p>

            <h3 id="hdrOnserver">{$lang.cpanel_ssl_cert_to_server}</h3>
            <table id="ssltable" class="sortable table table-striped">
                <thead>
                    <tr>
                        <th scope="col" class=" clickable">{$lang.cpanel_domain}</th>
                        <th scope="col" class=" clickable">{$lang.cpanel_ssl_expiration}</th>
                        <th scope="col" class=" clickable">{$lang.cpanel_ssl_key_size}</th>
                        <th scope="col" class="sorttable_nosort">{$lang.cpanel_actions}</th>
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
                                   class="cp-btn" onclick="return confirm('{$lang.cpanel_delete_entry_q}')"><span class="fa fa-trash"></span></a>
                            </td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td class="errors" colspan="5" id="nocertsErrorMsg">{$lang.cpanel_ssl_no_certs}</td>
                        </tr>
                    {/foreach}


                </tbody>
                <tfoot></tfoot>
            </table>
        </div>

        <div class="section">


            <h3>{$lang.cpanel_ssl_upload_cert}</h3>
            <p class="description" id="descUpload">
                {$lang.cpanel_ssl_upload_cert_desc}
            </p>

            <form enctype="multipart/form-data" method="post" id="paste" name="upload" action="{$widget_url}&act=crts">
                <input type="hidden" value="1" name="paste" />
                <div class="control-group">
                    <label for="crt" id="lblCrt">{$lang.cpanel_ssl_paste_cert}</label>
                    <div class="row-fluid">
                        <div class="span8">
                            <textarea title="{$lang.cpanel_ssl_paste_title}"  dir="ltr" id="crt" name="crt" class="form-control paste "></textarea>
                            <div class="textarea-parse" id="cert_parse" style="display: none;"></div>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <input type="submit" value="{$lang.cpanel_ssl_save_cert}" class="btn btn-flat-primary btn-primary" id="save-certificate">
                </div>
                {securitytoken}
            </form>

            <div class="connector">
                {$lang.cpanel_ssl_or}
            </div>

            <form enctype="multipart/form-data" method="post" id="upload" name="upload" action="{$widget_url}&act=crts">
                <input type="hidden" value="1" name="upload" />
                <div class="control-group">
                    <label for="crtfile" id="lblCrtfile">{$lang.cpanel_ssl_choose_cert}</label>
                    <div class="row-fluid">
                        <div class="span6">
                            <input type="file" title="{$lang.cpanel_ssl_choose_cert_title}" id="crtfile" name="crtfile">
                        </div>
                        <div class="span6">
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <input type="submit" value="{$lang.cpanel_ssl_upload_certificate}" class="btn btn-flat-primary btn-primary" id="upload-certificate">
                </div>
                {securitytoken}
            </form>
        </div>

        <div class="section">
            <h3 id="hdrNewcert">{$lang.cpanel_ssl_generate_cert}</h3>
            <p class="description" id="descNewcert">
                {$lang.cpanel_ssl_generate_cert_desc}
            </p>
            <div class="cjt-pagenotice-container cjt-notice-container" id="cjt_pagenotice_container"></div>
            <form class="simple" id="mainform" name="mainform" method="post" action="{$widget_url}&act=crts">
                {include file="`$widget_dir`gencert.tpl"}
            </form>
        </div>
        <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            {$lang.cpanel_csrs_return}
        </a>
    </div>
{/if}