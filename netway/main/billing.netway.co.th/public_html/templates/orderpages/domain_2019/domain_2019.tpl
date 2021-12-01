{* @@author:: HostBill team
@@name:: Domain Cart 2019
@@type:: domain
@@configfile:: config.yml
@@description:: Offers domain registration and transfer, in bulk and single mode.
@@thumb:: thumb.png
@@img:: preview.png
*}

{if !$opconfig.fullscreen}
    {include file="`$template_path`header.tpl"}
{else}
<!DOCTYPE html>
<html>
<head>
{php}
$templatePath   = $this->get_template_vars('template_path');
 include(dirname($templatePath) . '/orderpages/cart_neworderpage.tpl.php');
{/php}
    <base href="{$system_url}" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">

    <link rel="apple-touch-icon" sizes="72x72" href="{$template_dir}{themeconfig variable=favicon_apple_72 default="dist/favicons/favicon_apple_72.png"}">
    <link rel="apple-touch-icon" sizes="144x144" href="{$template_dir}{themeconfig variable=favicon_apple_144 default="dist/favicons/favicon_1apple_44.png"}">
    <link rel="apple-touch-icon" sizes="180x180" href="{$template_dir}{themeconfig variable=favicon_apple_180 default="dist/favicons/favicon_1apple_80.png"}">
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

    {literal}
    <script type="text/javascript">
        {/literal}{themeconfig variable=custom_js default=""}{literal}
    </script>
    {/literal}

    {*  Google Tag Manager Head Section  *}
    {themeconfig variable=gtm_head default=""}

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
            history: false, delay: 5000,
            buttons: {sticker: false},
            hide: true, sticker: false, icon: false
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
<body class="template_2019 {if $tpl_config}template_2019_custom{/if} {if $tpl_config.$sidebarstate_var === 'hidden'} sidenav-toggled {/if}">

{*  Google Tag Manager Body Section  *}
{themeconfig variable=gtm_body default=""}

<noscript>
{include file="`$template_path`badbrowser.tpl"}
</noscript>
{/if}













<link rel="stylesheet" type="text/css" href="{$orderpage_dir}domain_2019/css/domains.css?v={$hb_version}">
<script src="templates/common/js/cart.js?v={$hb_version}"></script>

<script src="{$orderpage_dir}domain_2019/js/autosize.js"></script>
<script src="{$orderpage_dir}domain_2019/js/handlebars.js"></script>
<script src="{$orderpage_dir}domain_2019/js/jquery.lazy.js"></script>
<script src="{$orderpage_dir}domain_2019/js/domains.js?v={$hb_version}"></script>

{literal}
<script type="text/javascript">
    var step = {/literal}{$step|default:0}{literal};
    HBCart.Lang = {
        "register": "{/literal}{$lang.register|default:'Register'}{literal}",
        "transfer": "{/literal}{$lang.transfer|default:'Transfer'}{literal}",
        "premium": "{/literal}{$lang.premium|default:'premium'}{literal}",
        "Unavailable": "{/literal}{$lang.Unavailable|default:'Unavailable'}{literal}",
        "removefromcart": "{/literal}{$lang.removefromcart|default:'Remove from cart'}{literal}",
        "continue": "{/literal}{$lang.continue|default:'continue'}{literal}",
        "resultsfor": "{/literal}{$lang.resultsfor|default:'Results for'}{literal}",
        "Domain": "{/literal}{$lang.Domain|default:'Domain'}{literal}",
        "setup": "{/literal}{$lang.setup|default:'Setup'}{literal}",
        "price": "{/literal}{$lang.price|default:'price'}{literal}",
        "years": "{/literal}{$lang.years|default:'years'}{literal}",
        "domains": "{/literal}{$lang.domains|default:'domains'}{literal}",
        "show_details": "{/literal}{$lang.show_details|default:'Show details'}{literal}",
        "orderselecteddomains": "{/literal}{$lang.orderselecteddomains|default:'Order selected domains'}{literal}",
        "total_recurring": "{/literal}{$lang.total_recurring|default:'Total recurring'}{literal}",
        "total_today": "{/literal}{$lang.total_today|default:'Total today'}{literal}",
        "discount": "{/literal}{$lang.discount|default:'Discount'}{literal}",
        "credit": "{/literal}{$lang.credit|default:'Credit'}{literal}",
        "itemremoveconfirm": "{/literal}{$lang.itemremoveconfirm|default:'itemremoveconfirm'}{literal}",
        "addthiscontact": "{/literal}{$lang.addthiscontact|default:'addthiscontact'}{literal}",
        "loadmore": "{/literal}{$lang.loadmore|default:'Load more'}{literal}",
    }
    HBCart.init({/literal}{$cart|@json_encode}{literal}, {
        url: {/literal}'{$system_url}'{literal},
        categoryId: {/literal}'{$domain_cat}'{literal},
    })
</script>
{/literal}
<div class="orderpage orderpage-domain_2019 {if $opconfig.fullscreen}container my-3{/if}">
    <div id="orderpage">
        {if $is_cart_summary}
            {include file='domain_2019/cart_summary.tpl'}
        {elseif $step==4}
            {include file='domain_2019/cart4.tpl'}
        {elseif $step==2}
            {include file='domain_2019/cart2.tpl'}
        {elseif $step==0}
            {include file='domain_2019/cart0.tpl'}
        {/if}
    </div>
</div>

{if $logged!='1'}
    {include file="`$template_path`ajax.login.tpl" loginwidget=true}
{/if}

</body>
</html>