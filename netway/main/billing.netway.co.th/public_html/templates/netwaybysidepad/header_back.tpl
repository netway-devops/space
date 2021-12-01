<!DOCTYPE html>
<!--[if IEMobile 7]><html class="no-js iem7 oldie"><![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js ie7 oldie" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js ie8 oldie" lang="en"><![endif]-->
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9" lang="en"><![endif]-->
<!--[if (gt IE 9)|(gt IEMobile 7)]><!--><html lang="en"><!--<![endif]-->
    <head>
        <base href="{$system_url}" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/main.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap.min.css" />
        <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/clientarea.css" />
        {*<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/jquery-ui-1.8.21.custom.css" />*}
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
        <script type="text/javascript" src="{$system_url}?cmd=hbchat&amp;action=embed"></script>
        {userheader}
    </head>
    
<body class="{$language|capitalize} tpl_sidepadtheme">    
<div class="bg-color"></div>
<div class="noise">
<div class="bg-shadow"></div>
</div>
<div class="page">
    <!--Header -->
    <header class="p-header clearfix">
        	<div class="pull-right">
            	<div class="account-bg">
                	<div class="btn-group">
                    	<div class="user-img">
                        	<div class="user-icon"></div>
                        </div>
                    	<a class="clearstyle btn dropdown-toggle" data-toggle="dropdown" href="#">
                        {if $logged=='1'}
                            {$login.firstname} {$login.lastname}
                        {else}
                            {$lang.login}    
                        {/if}
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                        	<div class="dropdown-padding">
                            {if $logged!='1'}
                                <li><a href="{$ca_url}signup/">{$lang.createaccount}</a><span></span></li>
                                <li><a href="{$ca_url}clientarea/">{$lang.login}</a><span></span></li>
                            {else}
                                <li><a href="{$ca_url}clientarea/details/">{$lang.manageaccount}</a><span></span></li>
                                <li><a href="">{$lang.logout}</a><span></span></li>
                            {/if}
                            {if $adminlogged}
                                <li class="divider"></li>
                                <li><a  href="{$admin_url}/index.php{if $login.id}?cmd=clients&amp;action=show&amp;id={$login.id}{/if}">{$lang.adminreturn}</a><span></span></li>
                            {/if}
                            </div>
                        </ul>
                    </div>
                </div>
            </div>
        
        	<!-- Lang box -->
            {if $languages}
         	<div class="pull-right">
            	<div class="lang-bg">
					<div class="btn-group">
                    	{foreach from=$languages item=ling}{if  $language==$ling}
                    	<a class="clearstyle btn dropdown-toggle" data-toggle="dropdown" href="#">
                        	{$ling|capitalize}
                        {/if}{/foreach}
                        	<span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                        	<div class="dropdown-padding">
                            {foreach from=$languages item=ling}
                                <li id="lang_{$ling|capitalize}"><a href="{$ca_url}{$cmd}&action={$action}&languagechange={$ling|capitalize}">
                                	{$lang[$ling]|capitalize}
                                    <span></span>
                                    </a><span class="active-lang"></span></li>
                            {/foreach}
                            </div>
                        </ul>
                    </div>
                </div>
            </div>
            {/if}
            
            <!-- Search Box -->
				{include file="search_field.tpl"}
            
            <!-- Website Title/Slogan -->
            <h3>{$business_name}</h3>
        </header>
        <!-- End of Header -->
        
        <!-- Main Section -->
        <div class="row-c">
        
        <section class="span12 container-bg{if $cmd=='cart'} overlay-nav cart_ {$cart_template}{/if}{if $logged=='1'} not-logged-page{/if}">
                
        {include file="mainmenu.tpl"}
        
        <!-- Right Column (Main Container) -->
        
    <article class="main-container {if $logged=='1'}not-logged-pag{/if}{if $hb} pbh{/if}">

    <div class="main-container-header-bg">
    <div class="main-container-header">
        <div class="top-right-buttons">
            <div class="btn-group">
                <a class="top-btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-add"></i>
                </a>
                <ul class="dropdown-menu">
                    <div class="dropdown-padding">
                        <li><a href="{$ca_url}cart/">{$lang.order}</a><span></span></li>
                    </div>
                </ul>
            </div>
        </div>
        {if $logged == '1'}
            {if $cmd == 'knowledgebase' || ($cmd == 'tickets' && $action == 'default') || ($cmd == 'support' && $action == 'default')}
                {include file='submenu/support.submenu.tpl'}
            {elseif $action == 'domains' || $action == 'services'}
                {include file='submenu/domain.submenu.tpl'}
            {elseif $cmd == 'affiliates'}
                {include file='submenu/affiliates.submenu.tpl'}
            {else}
                <h2>{$lang.clientarea}</h2>
            {/if}
        {else}
            {if ($cmd=='root' || $cmd=='page') && $infopages}
                {include file='menus/menu.infopages.tpl'}
            {/if}
        {/if}
    </div>
</div>
{include file="notifications.tpl"}
{if $cmd!='cart' && ($cmd!='tickets' || $action!='view') && ($cmd!='clientarea' || $action!='services' || !$service || $custom_template || in_array('types',$tpl_path) ) && ($action!='domains' || !$edit) }<div class="content-wrapper">{/if}
    
	{if $cmd=='cart'}{include file="../orderpages/cart.sidemenu.tpl"}
        <div id="cont" {if  $step>0 && $step<4}class="left"{/if}>{/if}