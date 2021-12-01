<!DOCTYPE html>
<!--[if IEMobile 7]><html class="no-js iem7 oldie"><![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js ie7 oldie" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js ie8 oldie" lang="en"><![endif]-->
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9" lang="en"><![endif]-->
<!--[if (gt IE 9)|(gt IEMobile 7)]><!--><html lang="en"><!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <base href="{$system_url}" />
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/main.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}style.css" />
        <script type="text/javascript" src="{$template_dir}js/jquery.js"></script>{literal}<style>body {
                background: #F6F6F6;
}</style>{/literal}
    </head>
    <body class="{$language|capitalize}">
        {if $error}
        <div id="errors" style="display:block">
            <div class="alert alert-error">
                {if $error}
                {foreach from=$error item=blad}{$blad}<br/>{/foreach}
                {/if}                </div>

        </div>
        {literal} <script>
        window.onload = function() {
                parent.rebindform();
            }</script>
 {/literal}
        {/if}
        {if $info}   <div id="infos"  style="display:block">

            <div class="alert alert-info">
                {if $info}
                {foreach from=$info item=infos}{$infos}<br/>{/foreach}
                {/if}
            </div>
        </div>{/if}
    </body>
</html>