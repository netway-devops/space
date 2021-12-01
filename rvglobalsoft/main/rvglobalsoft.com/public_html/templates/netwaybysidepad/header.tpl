{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'header.tpl.php');
{/php}
<!DOCTYPE html>
<!--[if IEMobile 7]><html class="no-js iem7 oldie"><![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js ie7 oldie" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js ie8 oldie" lang="en"><![endif]-->
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9" lang="en"><![endif]-->
<!--[if (IE 10)&!(IEMobile)]><html class="ie10" lang="en"><![endif]-->
<!--[if (gt IE 10)|(gt IEMobile 7)]><!--><html lang="en"><!--<![endif]-->
    <head>
<!--[if !IE]><!-->{literal}<script>if(/*@cc_on!@*/false){document.documentElement.className+=' ie10';}</script>{/literal}<!--<![endif]-->
        <base href="{$system_url}" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$aSeoMetaTag.title} {$business_name}</title>
        
        {if $aSeoMetaTag.keywords != ''}<meta name="keywords" content="{$aSeoMetaTag.keywords}" />{/if}
        
        {if $aSeoMetaTag.description != ''}<meta name="description" content="{$aSeoMetaTag.description}" />{/if}
        
        <link rel="shortcut icon" type="images/x-icon" href="{$template_dir}images/favicon.ico" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/main.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap.min.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/clientarea.css" />
        {*<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/jquery-ui-1.8.21.custom.css" />*}
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap-responsive.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/style.css?ver=110760" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/fonts.css" />
        
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/layout_resposive.css" />    
        <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        <link href='https://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">
        
        
        <!--[if lt IE 9]>
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/ie8.css" />
        <script type="text/javascript" src="{$template_dir}js/ie8.js"></script>
        <![endif]-->
        <script type="text/javascript" src="{$template_dir}js/jquery.js"></script>
        <script type="text/javascript" src="{$template_dir}js/bootstrap.min.js"></script>
        <script type="text/javascript" src="{$template_dir}js/common.min.js"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js"></script>
        <!--<script type="text/javascript" src="{$template_dir}js/jquery.toolbar.min.js"></script>-->
        <script type="text/javascript" src="{$template_dir}js/jquery.cookie.js"></script>
        <script type="text/javascript" src="{$template_dir}js/script.js"></script>
        <script type="text/javascript" src="{$template_dir}js/gototop.js"></script>
        <!--
        <script type="text/javascript" src="{$system_url}?cmd=hbchat&amp;action=embed"></script>
        -->
                
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}js/offcanvas.css" />
        <script type="text/javascript" src="{$template_dir}js/offcanvas.js"></script>
        {userheader}
        
        {literal}       
            <script>
              (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
              (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
              m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
              })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
                
                ga('create', 'UA-90549966-1', 'auto', {'allowLinker': true}); // set allowLinker to true
                ga('require', 'linker'); // setup linker plugin
                ga('linker:autoLink', ['rvglobalsoft.com', 'rvsitebuilder.com', 'rvskin.com', 'rvssl.com', 'rvlogin.technology'] );
                ga('send', 'pageview');
              
              {/literal}{if isset($ga_mode)}{literal}
                var APP_VERSION = '{/literal}{$ga_mode}{literal}';
                var PAGE_NAME = '{/literal}{$ga_request}{literal}';
                var DEVICE_TYPE = '{/literal}{$ga_os[0]}{literal}';
                var DEVICE_PLATFORM = '{/literal}{$ga_os[1]}{literal}';
                var DEVICE_VERSION = '{/literal}{$ga_os[2]}{literal}';
                var DEVICE = '{/literal}{$ga_device}{literal}';

                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','gao');
            
                try{
                    gao('create', 'UA-65722035-5', 'auto');
                    gao('set', 'screenName', APP_VERSION);
                    gao('send', {
                      hitType: 'pageview',
                      page: PAGE_NAME,
                      title: APP_VERSION
                    });
                    
                    gao('send', 'event', 'os', DEVICE_TYPE, DEVICE_VERSION, 1);
                    gao('send', 'event', 'device', 'Device', DEVICE, 1);
                    gao('send', 'event', 'screen', 'resolution', window.screen.width + 'x' + window.screen.height, 1);
                    
                } catch(err) {}
              {/literal}{/if}{literal}
            
            </script>
            <script type="text/javascript">
            var timeOut;
            function scrollToTop() {
              if (document.body.scrollTop!=0 || document.documentElement.scrollTop!=0){
                window.scrollBy(0,-50);
                timeOut=setTimeout('scrollToTop()',10);
              }
              else clearTimeout(timeOut);
            }
            </script>
             
        {/literal}
 

     
    </head>

    
<body class="{$language|capitalize} tpl_sidepadtheme">  

        <div id="wrapper-outer">
            <!-- *************** Start Top Bar *******************-->
            {include file="share/header-corporate.tpl"}
            <!-- *************** End Top Bar *******************-->
            
            <!-- *************** Start mainmenu Bar *******************-->
                {include file="mainmenu.tpl"}
            <!-- *************** End  mainmenu Bar *******************-->

{if !$service && $action == 'services' && $cid == 1}
<aside style="width: 170px; min-width:170px;">
<div class="wrapper-bg">
<div class="services-box">
    <ul class="nav nav-list">

<li class="nav-header" >
    <div class="table-header" style=""><div style="padding-left: 29px; padding-top: 15px">SSL Certificate</div></div>
</li>
<li style="background-color: #e6e6e6; margin-top: -12px">
    <ul style="list-style-type:none;">
        <!--<li>All ({$count_ssl.all})</li>
        <li>Incomplete ({$count_ssl.incomplete})</li>
        <li>Processing ({$count_ssl.processing})</li>
        <!--<li>Reissue ({$count_ssl.reissue})</li>-->
        <!--<li>Active ({$count_ssl.active})</li>
        <li>Expired ({$count_ssl.expired})</li>
        <li>Cancelled ({$count_ssl.cancellend})</li>
        <li>Unpaid ({$count_ssl.unpaid})</li>
        <li>Pending ({$count_ssl.pending})</li>
        <li>Rejected ({$count_ssl.rejected})</li>
        -->
        <li><a href="{if $count_ssl.all > 0}{$system_url}{$ca_url}clientarea/services/ssl" style="cursor: pointer;"{else}javascript:void(0);" style="cursor: default;"{/if}>All ({$count_ssl.all})</a></li>
        <li><a href="{if $count_ssl.active > 0}{$system_url}{$ca_url}clientarea/services/ssl&sort=active" style="cursor: pointer;"{else}javascript:void(0);" style="cursor: default;"{/if}>Active ({$count_ssl.active})</a></li>
        <li><a href="{if $count_ssl.expire > 0}{$system_url}{$ca_url}clientarea/services/ssl&sort=expire" style="cursor: pointer;"{else}javascript:void(0);" style="cursor: default;"{/if}>Expires Soon ({$count_ssl.expire})</a></li>
        <li><a href="{if $count_ssl.incomplete > 0}{$system_url}{$ca_url}clientarea/services/ssl&sort=incomplete" style="cursor: pointer;"{else}javascript:void(0);" style="cursor: default;"{/if}>Incomplete ({$count_ssl.incomplete})</a></li>
        <li><a href="{if $count_ssl.unpaid > 0}{$system_url}{$ca_url}clientarea/services/ssl&sort=unpaid" style="cursor: pointer;"{else}javascript:void(0);" style="cursor: default;"{/if}>Unpaid ({$count_ssl.unpaid})</a></li>
        <li><a href="{if $count_ssl.terminate > 0}{$system_url}{$ca_url}clientarea/services/ssl&sort=terminate" style="cursor: pointer;"{else}javascript:void(0);" style="cursor: default;"{/if}>Terminated ({$count_ssl.terminate})</a></li>
    </ul>
</li>
</ul>
</div>
</div>
</aside>
{/if}

    <article class="main-container not-logged-pag">
    <div>
        <div {if $logged=='1'}class="{if $cid != 1}container{/if} body-client"{/if}{if $cid==1}style="overflow-x: auto; width: 100% ! important;"{/if}>
        <div {if $cmd == 'cart'}class="container"{/if}>

{include file="notifications.tpl"}
{if $cmd!='cart' && ($cmd!='tickets' || $action!='view') && ($cmd!='clientarea' || $action!='services' || !$service || $custom_template || in_array('types',$tpl_path) ) && ($action!='domains' || !$edit) }<div class="content-wrapper sixteen columns">{/if}
    
    {if $cmd=='cart'}{include file="../orderpages/cart.sidemenu.tpl" has_own_ajax="0"}{/if}
        <div id="cont" {if  $step>0 && $step<4}class="left"{/if}>
