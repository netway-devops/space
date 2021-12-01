<div class="body-content">
    <h3 id="hdrManageHosts">
        {$lang.cpanel_install_manage}
    </h3>

    <p class="description" id="descAboutCert">
        {$lang.cpanel_install_manage_desc1}
    </p>

    <div id="cjt_pagenotice_container" class="cjt-pagenotice-container cjt-notice-container">
        <div id="yui-gen9" class="yui-module cjt-notice cjt-pagenotice cjt-notice-info" style="display: block;">
            <div class="bd">
                <div class="cjt-notice-content">
                    {$lang.cpanel_install_manage_desc2}
                </div>
            </div>
        </div>
        <div id="yui-gen10" class="yui-module cjt-notice cjt-pagenotice cjt-notice-info" style="display: block;">
            <div class="bd">
                <div class="cjt-notice-content">
                    {$lang.cpanel_install_manage_desc3}
                </div>
            </div>
        </div>
    </div>
    <br />
    <h3 id="hdrInstallWebsite">{$lang.cpanel_install_ssl}</h3>
    <div class="section">
        <form enctype="multipart/form-data" method="post" name="mainform" action="{$widget_url}&act=install" id="mainform">
            <input type="hidden" name="install" value="1" />
            <div class="control-group">
                <label for="ssldomain" id="lblSSLDomain">{$lang.cpanel_domain}</label>
                <div class="row-fluid">
                    <div class="span4">
                        <select class="form-control" name="domain" id="ssldomain">
                            <option value="">{$lang.cpanel_install_select_domain}</option>
                            {foreach from=$domains item=domain}
                                <option value="{$domain}">{$domain}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="span5">
                        <button class="btn btn-primary btn-flat-primary" data-action="usecert">{$lang.cpanel_install_browse_cert}</button>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="sslcrt" id="lblCrt">{$lang.cpanel_install_crt}</label>
                <div class="row-fluid">
                    <div class="span4">
                        <textarea dir="ltr" class="form-control" name="crt" id="sslcrt"></textarea>                   
                    </div>
                    <div class="span5">
                        <div class="help-block">{$lang.cpanel_install_crt_desc}s</div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="sslkey" id="lblKey">{$lang.cpanel_install_key}</label>
                <div class="row-fluid">
                    <div class="span4">
                        <textarea dir="ltr" name="key"class="form-control" id="sslkey"></textarea>
                    </div>
                    <div class="span5">
                        <div class="help-block">{$lang.cpanel_install_key_desc}</div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="sslcab" id="lblCab">{$lang.cpanel_install_cert_auth}</label>
                <div class="row-fluid">
                    <div class="span4">
                        <textarea dir="ltr" name="cabundle" class="form-control" id="sslcab"></textarea>

                    </div>
                    <div class="span5">
                        <div class="help-block">{$lang.cpanel_install_cert_auth_desc}</div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <input type="submit" title="{$lang.cpanel_install_certificate_title}" class="btn btn-flat-primary btn-primary" value="{$lang.cpanel_install_certificate}" id="btnInstall">
                <input type="reset" id="sslreset" value="{$lang.cpanel_install_reset}" class="btn btn-default">
            </div>
            {securitytoken}
        </form>
    </div>
    <div style="display: none">
        <div class="modal hide fade" id="action-usecert">
            <div class="modal-header">
                <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                <h2 id="myModalLabel">{$lang.cpanel_install_ssl_list}</h2>
            </div>

            <div class="modal-body">
                <p>
                    {$lang.cpanel_install_ssl_list_desc}
                </p>

                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th></th>
                            <th>{$lang.cpanel_domain}</th>
                            <th>{$lang.cpanel_install_expiration}</th>
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
                                <td class="errors" colspan="3" id="nocertsErrorMsg">{$lang.cpanel_install_no_cert}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div> 
            <div class="modal-footer">
                <span class="pull-right">
                    <button type="submit" class="default btn btn-flat-primary btn-primary presetcert">{$lang.cpanel_install_use_cert}</button>
                    <button type="button" class="default btn hide-modal">{$lang.cpanel_cancel}</button>
                </span>
            </div>
        </div>
    </div>

    <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
        <span class="fa fa-chevron-left"></span>
        {$lang.cpanel_csrs_return}
    </a>
</div>
<script src="{$widgetdir_url}script.js" type="text/javascript"></script>