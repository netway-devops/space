{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">

        <h2>
            <span class="spriteicon_img_mini" id="icon-ssl-manager_mini"></span>
            <span id="pageHeading">SSL/TLS</span>
        </h2>
        {if $act !='default'}
            {include file="`$widget_dir``$act`.tpl"}
        {else}
            <div class="body-content">
                <p class="description" id="descSSL">
                    The SSL/TLS Manager will allow you to generate SSL certificates, 
                    certificate signing requests, and private keys. These are all parts of using SSL to secure your website. 
                    SSL allows you to secure pages on your site so that information such as logins, 
                    credit card numbers, etc are sent encrypted instead of plain text. It is important to secure your site’s login areas, 
                    shopping areas, and other pages where sensitive information could be sent over the web.
                </p>

                <h3 id="hdrPrivate"> Private Keys (KEY)</h3>
                <p><a href="{$widget_url}&act=keys" id="lnkPrivate">Generate, view, upload, or delete your private keys.</a></p>

                <h3 id="hdrCSR">Certificate Signing Requests (CSR)</h3>
                <p><a href="{$widget_url}&act=csrs" id="lnkRequests">Generate, view, or delete SSL certificate signing requests.</a></p>

                <h3 id="hdrCRT">Certificates (CRT)</h3>
                <p><a href="{$widget_url}&act=crts" id="lnkCRT">Generate, view, upload, or delete SSL certificates.</a></p>

                <h3 id="hdrInstall">Install and Manage SSL for your site (HTTPS)</h3>
                <p><a href="{$widget_url}&act=install" id="lnkInstall">Manage SSL sites.</a></p>
            </div>
        {/if}
    </div>
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}