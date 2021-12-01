<!DOCTYPE html>
{if $language=='arabic'} {assign var=html_lang value="ar"}
{elseif $language=='bulgarian'} {assign var=html_lang value="bg"}
{elseif $language=='chinese'} {assign var=html_lang value="zh"}
{elseif $language=='croatian'} {assign var=html_lang value="hr"}
{elseif $language=='czech'} {assign var=html_lang value="cs"}
{elseif $language=='danish'} {assign var=html_lang value="da"}
{elseif $language=='dutch'} {assign var=html_lang value="nl"}
{elseif $language=='estonian'} {assign var=html_lang value="et"}
{elseif $language=='finnish'} {assign var=html_lang value="fi"}
{elseif $language=='french'} {assign var=html_lang value="fr"}
{elseif $language=='georgian'} {assign var=html_lang value="ka"}
{elseif $language=='german'} {assign var=html_lang value="de"}
{elseif $language=='greek'} {assign var=html_lang value="el"}
{elseif $language=='indonesian'} {assign var=html_lang value="id"}
{elseif $language=='italian'} {assign var=html_lang value="it"}
{elseif $language=='japanese'} {assign var=html_lang value="ja"}
{elseif $language=='kazakh'} {assign var=html_lang value="kk"}
{elseif $language=='korean'} {assign var=html_lang value="ko"}
{elseif $language=='macedonian'} {assign var=html_lang value="mk"}
{elseif $language=='nederlands'} {assign var=html_lang value="nl"}
{elseif $language=='moldavian'} {assign var=html_lang value="mo"}
{elseif $language=='norwegian'} {assign var=html_lang value="no"}
{elseif $language=='portuguese-br'} {assign var=html_lang value="pt"}
{elseif $language=='portuguese-pt'} {assign var=html_lang value="pt"}
{elseif $language=='polish'} {assign var=html_lang value="pl"}
{elseif $language=='romanian'} {assign var=html_lang value="ro"}
{elseif $language=='russian'} {assign var=html_lang value="ru"}
{elseif $language=='serbian'} {assign var=html_lang value="sr"}
{elseif $language=='slovenian'} {assign var=html_lang value="sl"}
{elseif $language=='spanish'} {assign var=html_lang value="es"}
{elseif $language=='swedish'} {assign var=html_lang value="sv"}
{elseif $language=='turkish'} {assign var=html_lang value="tr"}
{elseif $language=='ukrainian'} {assign var=html_lang value="uk"}
{elseif $language=='uzbek'} {assign var=html_lang value="uz"}
{elseif $language=='vietnamese'} {assign var=html_lang value="vi"}
{else} {assign var=html_lang value="en"}
{/if}

<html lang="{$html_lang}" dir="{$language_direction}" class="loading">
<head>
    <base href="{$system_url}" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">

    <link rel="apple-touch-icon" sizes="72x72" href="{$template_dir}{themeconfig variable=favicon_apple_72 default="dist/favicons/favicon_apple_72.png"}">
    <link rel="apple-touch-icon" sizes="144x144" href="{$template_dir}{themeconfig variable=favicon_apple_144 default="dist/favicons/favicon_apple_144.png"}">
    <link rel="apple-touch-icon" sizes="180x180" href="{$template_dir}{themeconfig variable=favicon_apple_180 default="dist/favicons/favicon_apple_180.png"}">
    <link rel="icon" type="image/png" sizes="16x16" href="{$template_dir}{themeconfig variable=favicon_16 default="dist/favicons/favicon_16.png"}">
    <link rel="icon" type="image/png" sizes="32x32" href="{$template_dir}{themeconfig variable=favicon_32 default="dist/favicons/favicon_32.png"}">
    <link rel="icon" type="image/png" sizes="96x96" href="{$template_dir}{themeconfig variable=favicon_96 default="dist/favicons/favicon_96.png"}">
    <link rel="icon" type="image/png" sizes="192x192"  href="{$template_dir}{themeconfig variable=favicon_192 default="dist/favicons/favicon_192.png"}">

    <link rel="stylesheet" type="text/css" href="{$template_dir}{themeconfig section=css variable=file_css default="dist/css/app.min.css"}">

    {literal}
        <style>
            {/literal}{themeconfig variable=custom_css default=""}{literal}
        </style>
    {/literal}

    {literal}
        <script type="text/javascript">
            var jsLang = {
                yes: {/literal}"{$lang.yes}"{literal},
                no: {/literal}"{$lang.no}"{literal},
                search: {
                    error: {
                        source: {/literal}"{$lang.search_source}"{literal},
                        noResultsHeader: {/literal}"{$lang.search_noResultsHeader}"{literal},
                        noResults: {/literal}"{$lang.search_noResults}"{literal},
                        noEndpoint: {/literal}"{$lang.search_noEndpoint}"{literal},
                        serverError: {/literal}"{$lang.search_serverError}"{literal}
                    }
                },
                more: {/literal}"{$lang.more}"{literal},
            };
        </script>
    {/literal}

    <script type="text/javascript" src="{$template_dir}dist/js/main.min.js"></script>

    {*  Google Tag Manager Head Section  *}
    {themeconfig variable=gtm_head default=""}

    {include file="`$template_path`header_script.tpl"}
    
   
    <script type="text/javascript">

        var infos = {$info|@json_encode};
        var errors = {$error|@json_encode};
        var pos_popups = "{themeconfig variable="position-popups" default=""}";

        {literal}
            var pnotify_stack = {
                topleft: {"dir1": "down", "dir2": "right", "push": "top"},
                bottomleft: {"dir1": "right", "dir2": "up", "push": "top"},
                bottomright: {"dir1": "up", "dir2": "left", "firstpos1": 25, "firstpos2": 25},
                modal: {"dir1": "down", "dir2": "right", "push": "top", "modal": true, "overlay_close": true},
            };
            var pntf_opts = {
                history: false,
                buttons: {sticker: false},
                hide: false, sticker: false, icon: false
            };
            switch (pos_popups) {
                case "topleft":
                    pntf_opts.stack = pnotify_stack.topleft;
                    pntf_opts.addclass = "stack-topleft";
                    break;
                case "topcenter":
                    pntf_opts.stack = pnotify_stack.modal;
                    pntf_opts.addclass = "stack-modal stack-topcenter";
                    $("<style type='text/css'>.ui-pnotify-modal-overlay{visibility: hidden}</style>").appendTo("head");
                    break;
                case "bottomleft":
                    pntf_opts.stack = pnotify_stack.bottomleft;
                    pntf_opts.addclass = "stack-bottomleft";
                    break;
                case "bottomright":
                    pntf_opts.stack = pnotify_stack.bottomright;
                    pntf_opts.addclass = "stack-bottomright";
                    break;
                case "modal":
                    pntf_opts.stack = pnotify_stack.modal;
                    pntf_opts.addclass = "stack-modal";
                    break;
            }
            $(document).ready(function () {
                setTimeout(function () {
                    $.each(infos, function(index, item) {
                        pntf_opts.text = item;
                        pntf_opts.type = 'info';
                        new PNotify(pntf_opts);
                    });
                    $.each(errors, function(index, item) {
                        pntf_opts.text = item;
                        pntf_opts.type = 'error';
                        new PNotify(pntf_opts);
                    });
                }, 300);
            });
        {/literal}
    </script>
    {userheader}
</head>
{assign var="sidebarstate_var" value="sidebar-state"}
<body class="template_2019 {$language_direction} {if $tpl_config}template_2019_custom{/if} {if $tpl_config.$sidebarstate_var === 'hidden'} sidenav-toggled {/if}">

{*  Google Tag Manager Body Section  *}
{themeconfig variable=gtm_body default=""}

    {include file="`$template_path`header_body.tpl"}

<div class="pageloader-wrapper">
    <div class="pageloader-item" style="display: none;">
        <i class='pageloader-layer'></i>
        <i class='pageloader-layer'></i>
        <i class='pageloader-layer'></i>
    </div>
</div>

<noscript>
    {include file="`$template_path`badbrowser.tpl"}
</noscript>

{if $logged=='1'}
    {include file="`$template_path`menus/menu.top.logged.tpl"}
{else}
    {include file="`$template_path`menus/menu.top.notlogged.tpl"}
{/if}
{include file="`$template_path`menus/menu-sub.top.tpl"}


{if $tpl_config.menu.left_menu}
    {include file="`$template_path`menus/menu.left.custom.tpl" menu=$tpl_config.menu.left_menu}
{elseif $logged=='1'}
    {include file="`$template_path`menus/menu.left.logged.tpl"}
{else}
    {include file="`$template_path`menus/menu.left.notlogged.tpl"}
{/if}
    <div class="main-overlay"></div>
    <div class="body-content">
        <section class="section-main {if $service.layout}service-layout-{$service.layout}{/if}">
