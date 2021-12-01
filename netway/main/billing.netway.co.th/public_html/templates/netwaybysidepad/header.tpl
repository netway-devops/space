{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'header.tpl.php');
{/php}
<!DOCTYPE html>
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9" lang="en"><![endif]-->
<!--[if (IE 10)&!(IEMobile)]><html class="ie10" lang="en"><![endif]-->
<!--[if (gt IE 10)|(gt IEMobile 7)]><!--><html lang="en"><!--<![endif]-->
    <head>
<!--[if !IE]><!-->{literal}<script>if(!!window.MSStream){document.documentElement.className+=' ie10';}</script>    {/literal}<!--<![endif]-->
       
      {literal}   
         <!-- Facebook Pixel Code -->
        <script>
          !function(f,b,e,v,n,t,s)
          {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
          n.callMethod.apply(n,arguments):n.queue.push(arguments)};
          if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
          n.queue=[];t=b.createElement(e);t.async=!0;
          t.src=v;s=b.getElementsByTagName(e)[0];
          s.parentNode.insertBefore(t,s)}(window, document,'script','https://connect.facebook.net/en_US/fbevents.js');
          fbq('init', '1573095142808415');
          fbq('track', 'PageView');
        </script>
         <!-- end Facebook Pixel Code -->
       {/literal}
       
       {userheader} 
		<base href="{$system_url}" />

        <title>{$aSeoMetaTag.title}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
        <meta http-equiv="current-page" content="{$currentPage}" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="dns-prefetch" href="https://assets.zendesk.com">
        <link rel="dns-prefetch" href="https://pdi-netway.zendesk.com">
        <link rel="dns-prefetch" href="https://static.addtoany.com">
        <link rel="dns-prefetch" href="https://fonts.googleapis.com">        
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        
		
		{if $smarty.server.HTTP_HOST == 'netway.co.th'}
		
		<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}dist/mix.min.css?v={$webpackVersion}" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}share/css/top-style-temp.css?v={$webpackVersion}" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}share/css/footer-style-temp.css?v={$webpackVersion}" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}dist/mix1.min.css?v={$webpackVersion}" />
        
        
         
        <script type="text/javascript" src="{$template_dir}dist/mix.min.js?v={$webpackVersion}"></script>
        <script type="text/javascript" src="{$template_dir}dist/mix1.min.js?v={$webpackVersion}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery-ui-1.9.2.custom.min.js?v={$webpackVersion}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.validate.min.js?v={$webpackVersion}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.maskedinput.min.js?v={$webpackVersion}"></script>
		
		{else}
		
		<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/main.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/clientarea.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/smoothness/jquery-ui-1.9.2.custom.min.css" />
		<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap-responsive.css" />
		
		<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/style-temp.css" />
		<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}share/css/top-style-temp.css" />
		<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}share/css/footer-style-temp.css" />
		<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/fonts-temp.css" />   
	
        <link type="text/css" href="{$template_dir}js/bxslide/jquery.wsbxslider.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="{$template_dir}js/sample/styles/style.css" />
        <link rel="stylesheet" href="{$template_dir}css/font-awesome/css/style.css" />
        <link rel="stylesheet" type="text/css" href="{$template_dir}js/accordion/styles.css" />
        <link href="{$template_dir}js/bxslide/jquery.smbxslider.css" rel="stylesheet" type="text/css" />
        <link type="text/css" rel="stylesheet" href="{$template_dir}share/js/fancybox/jquery.fancybox.css">
       
		  
        <!--[if lt IE 9]>
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/ie8.css" />
        <script type="text/javascript" src="{$template_dir}js/ie8.js"></script>
        <![endif]-->
        <script type="text/javascript" src="{$template_dir}js/jquery.js"></script>
        <script type="text/javascript" src="{$template_dir}js/bootstrap.min.js"></script>
        <script type="text/javascript" src="{$template_dir}js/common.min.js"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery-ui-1.9.2.custom.min.js"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.validate.min.js"></script>
		<script type="text/javascript" src="{$template_dir}js/jquery.maskedinput.min.js"></script>
        <!--<script type="text/javascript" src="{$template_dir}js/jquery.toolbar.min.js"></script>-->
        <script type="text/javascript" src="{$template_dir}js/jquery.cookie.js"></script>
        <script type="text/javascript" src="{$template_dir}js/script.js"></script>
        <!-- <script type="text/javascript" src="{$system_url}?cmd=hbchat&amp;action=embed"></script> -->
       
        <script type="text/javascript" src="{$template_dir}js/tabs.js" ></script>   
        <script type="text/javascript" src="{$template_dir}js/bxslide/jquery.bxslider.js"></script>
        <script type="text/javascript" src="{$template_dir}js/sample/wowslider.js"></script>
        <script type="text/javascript" src="{$template_dir}js/sample/script.js"></script>
        <script src="{$template_dir}js/accordion/main.js" type="text/javascript"></script>
        <script type="text/javascript" src="{$template_dir}js/bxslide/jquery.smbxslider.js"></script>
        <script type="text/javascript" src="{$template_dir}share/js/fancybox/jquery.fancybox.js?v=2.1.4"></script>
        <script type="text/javascript" src="{$template_dir}share/js/fancybox/fancybox.js"></script> 
        <script type='text/javascript' src='{$template_dir}js/readmore.js'></script>
        
      
        {/if}

        {literal}

        <!-- Google Tag Manager -->
        <script>(function(w,d,s,l,i){
            w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});
            var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';
            j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','GTM-K5JBBX2');
      </script>
        <!-- End Google Tag Manager -->

        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-90664309-1"></script>
        <script>
             window.dataLayer = window.dataLayer || [];
             function gtag(){dataLayer.push(arguments);}
             gtag('js', new Date());
            {/literal}    
            {if isset($aClient.id) && $aClient.id != ''}
            
            {literal}gtag('set',{'user_id':'{/literal}{$aClient.email}{literal}'});{/literal}
            {/if}   
            {literal}
            
            
                gtag('config', 'UA-90664309-1', { 
                    'linker': {
                        'domains': ['netway.co.th', 'netway.cloud', 'netway.academy', 'netwaystore.in.th', 'siamdomain.com', 'siaminterhost.com', 'ssl.in.th', 'thaidomainnames.com', 'thaimailgroup.com', 'blog.netway.co.th', 'netway.services', 'support.netway.co.th']
                    }
                    ,'custom_map': {'dimension1': 'Admin'}
                });
            {/literal}
    
            {if isset($aAdmin.id) && $aAdmin.id != ''}
            {literal}            
                gtag('event', 'admin_dimension1', {'Admin': 1});
            {/literal} 
            {/if} 
            
            {literal}
        
        </script>
        <!-- end Global site tag (gtag.js) - Google Analytics -->

        {/literal}


        
        <link href="https://fonts.googleapis.com/css?family=Prompt|Kanit|Oswald" rel="stylesheet">

        <link rel="stylesheet" href="{$template_dir}css/font-awesome/css/style.css">
        <!--<link type="text/css" rel="stylesheet" media="screen" href="{$template_dir}css/font-awesome/css/style.css" />-->

        <link rel="stylesheet" type="text/css" href="{$template_dir}css/horizontalDropDownMenu/component.css" />
        <link rel="stylesheet" type="text/css" href="{$template_dir}css/horizontalDropDownMenu/default.css" />

</head>

    
<body class="{$language|capitalize} tpl_sidepadtheme">  

<div id="wrapper" class="expo">
    

    <!-- *************** Start Top Bar *******************-->
    {include file="share/header-corporate-temp.tpl"}
    <!-- *************** End Top Bar *******************-->
    
    <div class="expo">

    <!-- *************** Start mainmenu Bar *******************-->
    {include file="mainmenu.tpl"}
    <!-- *************** End  mainmenu Bar *******************-->
        

    {include file="notifications.tpl"}


{if $cmd!='cart' && ($cmd!='tickets' || $action!='view') && ($cmd!='clientarea' || $action!='services' || !$service || $custom_template || in_array('types',$tpl_path) ) && ($action!='domains' || !$edit) }<div class="content-wrapper"style="padding: 0px";>{/if}
    
	{if $cmd=='cart'}
	<div class="container {if $step==0}container-cart{/if}">
	{include file="../orderpages/cart.sidemenu.tpl" has_own_ajax="0"}
	{/if}
    <div id="cont" {if  $step>0 && $step<4}class="left"{/if}>

