<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>{$lang.cpanel_name}</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">

        <h2>
            <span class="spriteicon_img_mini" id="icon-ssl-manager_mini"></span>
            <span id="pageHeading">{$lang.cpanel_ssltls} </span>
        </h2>
        {if $act !='default'}
            {include file="`$widget_dir``$act`.tpl"}
        {else}
            <div class="body-content">
                <p class="description" id="descSSL">
                    {$lang.cpanel_ssltls_desc}
                </p>

                <h3 id="hdrPrivate">{$lang.cpanel_ssltls_private}</h3>
                <p><a href="{$widget_url}&act=keys" id="lnkPrivate">{$lang.cpanel_ssltls_private_desc}</a></p>

                <h3 id="hdrCSR">{$lang.cpanel_ssltls_req}</h3>
                <p><a href="{$widget_url}&act=csrs" id="lnkRequests">{$lang.cpanel_ssltls_req_desc}</a></p>

                <h3 id="hdrCRT">{$lang.cpanel_ssltls_crt}</h3>
                <p><a href="{$widget_url}&act=crts" id="lnkCRT">{$lang.cpanel_ssltls_crt_desc}</a></p>

                <h3 id="hdrInstall">{$lang.cpanel_ssltls_https}</h3>
                <p><a href="{$widget_url}&act=install" id="lnkInstall">{$lang.cpanel_ssltls_https_desc}</a></p>
            </div>
        {/if}
    </div>
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}