<div class="body-content">
    <h3 id="hdrManageHosts">
        Manage SSL Hosts
    </h3>

    <p class="description" id="descAboutCert">
        An SSL certificate can secure one or more domains; to create an SSL host for a domain, 
        you must have a certificate that secures that domain. Each SSL certificate has a matching 
        key file that must also be present to install the certificate. SSL certificates for production 
        use usually also require a <abbr class="initialism" title="Certificate Authority">CA</abbr> bundle, 
        which this page will automatically try to obtain from the server; in the event that the server 
        cannot find the required CA bundle, you will need to paste it here.
    </p>

    <div id="cjt_pagenotice_container" class="cjt-pagenotice-container cjt-notice-container">
        <div id="yui-gen9" class="yui-module cjt-notice cjt-pagenotice cjt-notice-info" style="display: block;">
            <div class="bd">
                <div class="cjt-notice-content">
                    You may only create SSL hosts for domains that are currently attached to your account.
                    Before you install an SSL certificate for a domain that is not listed below, you must attach the domain to your account.
                </div>
            </div>
        </div>
        <div id="yui-gen10" class="yui-module cjt-notice cjt-pagenotice cjt-notice-info" style="display: block;">
            <div class="bd">
                <div class="cjt-notice-content">
                    When SSL certificate is installed onto one of your domains, it also installs the same certificate onto that domain’s “<code>www</code>” subdomain, and vice-versa. Unless your certificate matches both domains, however, only one of the two domains will show as a secure site in a user’s web brow-fluidser.
                </div>
            </div>
        </div>
    </div>
    <br />
    <h3 id="hdrInstallWebsite">Install an SSL Website</h3>
    <div class="section">
        <form enctype="multipart/form-data" method="post" name="mainform" action="{$widget_url}&act=install" id="mainform">
            <input type="hidden" name="install" value="1" />
            <div class="control-group">
                <label for="ssldomain" id="lblSSLDomain">Domain</label>
                <div class="row-fluid">
                    <div class="span4">
                        <select class="form-control" name="domain" id="ssldomain">
                            <option value="">Select a Domain</option>
                            {foreach from=$domains item=domain}
                                <option value="{$domain}">{$domain}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="span5">
                        <button class="btn btn-primary btn-flat-primary" data-action="usecert">Browse Certificates</button>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="sslcrt" id="lblCrt">Certificate (CRT)</label>
                <div class="row-fluid">
                    <div class="span4">
                        <textarea dir="ltr" class="form-control" name="crt" id="sslcrt"></textarea>                   
                    </div>
                    <div class="span5">
                        <div class="help-block">The certificate may already be on your server. You can either paste the certificate here or try to retrieve it for your domain.</div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="sslkey" id="lblKey">Private Key (KEY)</label>
                <div class="row-fluid">
                    <div class="span4">
                        <textarea dir="ltr" name="key"class="form-control" id="sslkey"></textarea>
                    </div>
                    <div class="span5">
                        <div class="help-block">The private key may already be on your server. You can either paste the private key here or try to retrieve the matching key for your certificate.</div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="sslcab" id="lblCab">Certificate Authority Bundle </label>
                <div class="row-fluid">
                    <div class="span4">
                        <textarea dir="ltr" name="cabundle" class="form-control" id="sslcab"></textarea>

                    </div>
                    <div class="span5">
                        <div class="help-block">In most cases, you do not need to supply the CA bundle because the server will fetch it from a public repository during installation.</div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <input type="submit" title="Click to install the certificate on your site." class="btn btn-flat-primary btn-primary" value="Install Certificate" id="btnInstall">
                <input type="reset" id="sslreset" value="Reset" class="btn btn-default">
            </div>
            {securitytoken}
        </form>
    </div>
    <div style="display: none">
        <div class="modal hide fade" id="action-usecert">
            <div class="modal-header">
                <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                <h2 id="myModalLabel">SSL Certificate List</h2>
            </div>

            <div class="modal-body">
                <p>Choose a certificate to install. Certificates that do not 
                    have a domain associated with your account are not listed here.  
                    You can manage all of your saved certificates on the <a href="{$widget_url}&act=crts">“Certificates” page</a>.
                </p>

                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th></th>
                            <th>Domain</th>
                            <th>Expiration</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$list item=entry}
                            <tr class="">
                                <td>
                                    <input type="radio" name="sslcert" value="{$entry.host|escape}" />
                                </td>
                                <td>{$entry.issuer}</td>
                                <td>{$entry.expiredate}</td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td class="errors" colspan="3" id="nocertsErrorMsg">There are no certificates on the server.</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div> 
            <div class="modal-footer">
                <span class="pull-right">
                    <button type="submit" class="default btn btn-flat-primary btn-primary presetcert">Use Certificate</button>
                    <button type="button" class="default btn hide-modal">Cancel</button>
                </span>
            </div>
        </div>
    </div>

    <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
        <span class="fa fa-chevron-left"></span>
        Return to SSL Manager
    </a>
</div>
<script src="{$widgetdir_url}script.js" type="text/javascript"></script>