<!DOCTYPE html>
<!--[if IEMobile 7]><html class="no-js iem7 oldie"><![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js ie7 oldie" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js ie8 oldie" lang="en"><![endif]-->
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9" lang="en"><![endif]-->
<!--[if (IE 10)&!(IEMobile)]><html class="ie10" lang="en"><![endif]-->
<!--[if (gt IE 10)|(gt IEMobile 7)]><!--><html lang="en"><!--<![endif]-->
    <head>
<!--[if !IE]><!-->{literal}<script>if(!!window.MSStream){document.documentElement.className+=' ie10';}</script>{/literal}<!--<![endif]-->
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
        <script type="text/javascript" src="{$template_dir}js/common.js"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js"></script>
        <script type="text/javascript" src="{$template_dir}js/script.js"></script>
        <script type="text/javascript" src="{$system_url}?cmd=hbchat&amp;action=embed"></script>
        {userheader}
    </head>

    <body class="{$language|capitalize} tpl_sidepadtheme">    
        <!-- Header -->
        <header>
            <div class="center-area">
                <h1>{$business_name}</h1>

                <!-- Search -->
                <div class="search-bg">
                    <i class="icon-search icon-white"></i>
                    <div class="btn-group">
                        <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                            <span class="caret"></span>
                            {$lang.domains}
                        </a>
                        <ul class="dropdown-menu">
                            <div class="dropdown-padding top-style">
                                <li>
                                    <a href="{$ca_url}clientarea/domains/">{$lang.domains}</a>
                                    <form class="form-inline" action="{$ca_url}clientarea/domains/" method="post" style="display: none">
                                        <input type="hidden" class="search-field" name="filter[name]" >
                                    </form>
                                </li>
                                <li>
                                    <a href="{$ca_url}tickets">{$lang.tickets}</a>
                                    <form class="form-inline" action="{$ca_url}tickets" method="post" style="display: none">
                                        <input type="hidden" name="filter[subject]" class="search-field">
                                    </form>
                                </li>
                                <li>
                                    <a href="{$ca_url}knowledgebase/search/">{$lang.knowledgebase}</a>
                                    <form class="form-inline" action="{$ca_url}knowledgebase/search/" method="post" style="display: none">
                                        <input type="hidden" name="query" class="search-field">
                                    </form>
                                </li>
                            </div>
                        </ul>
                    </div>
                    <span class="search-block"><input type="text"></span>
                </div>
                <!-- End of Search -->

                <!-- Account -->
                <div class="account-box pull-right">
                    <div class="header-separator"></div>
                    <div class="btn-group">
                        <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                            {if $logged=='1'}
                                {$login.firstname} {$login.lastname}
                            {else}
                                {$lang.login}    
                            {/if}
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <div class="dropdown-padding top-style">
                                {if $logged!='1'}
                                    <li><a href="{$ca_url}signup/">{$lang.createaccount}</a><span></span></li>
                                    <li><a href="{$ca_url}clientarea/">{$lang.login}</a><span></span></li>
                                        {else}
                                    <li><a href="{$ca_url}clientarea/details/">{$lang.manageaccount}</a><span></span></li>
                                    <li><a href="?action=logout">{$lang.logout}</a><span></span></li>
                                        {/if}
                                        {if $adminlogged}
                                    <li class="divider"></li>
                                    <li><a  href="{$admin_url}/index.php{if $login.id}?cmd=clients&amp;action=show&amp;id={$login.id}{/if}">{$lang.adminreturn}</a><span></span></li>
                                        {/if}
                            </div>
                        </ul>
                       
                    </div>
                </div>
                <!-- End of Account -->
                {if $languages}
                    <!-- Lang -->
                    <div class="lang-box pull-right">
                        <div class="btn-group">
                            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                                {foreach from=$languages item=ling}
                                    {if  $language==$ling}
                                        {$ling|capitalize}{break}
                                    {/if}
                                {/foreach}
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <div class="dropdown-padding top-style">
                                    {foreach from=$languages item=ling}
                                        <li id="lang_{$ling|capitalize}">
                                            <a href="{$ca_url}{$cmd}&action={$action}&languagechange={$ling|capitalize}">
                                                {$lang[$ling]|capitalize}
                                                <span></span>
                                            </a>
                                            <span class="active-lang"></span>
                                        </li>
                                    {/foreach}
                                </div>
                            </ul>
                        </div>
                    </div>
                    <!-- End of Lang -->
                {/if}
                {include file="menus/menu.cart.tpl"}
            </div>
        </header>
        <!-- End of Header -->

        {include file="mainmenu.tpl"}

        {include file="menus/menu.sub.loc.tpl"}

        <!-- Main Container -->
        <div class="row center-area main-container">

            <div id="errors" {if $error}style="display:block"{/if}>
                <div class="alert alert-error">
                    <a class="close" >&times;</a>
                    {if $error}
                        {foreach from=$error item=blad}{$blad}<br/>
                        {/foreach}
                    {/if}                
                </div>
            </div>
            <div id="infos"  {if $info}style="display:block"{/if}>
                <div class="alert alert-info">
                    <a class="close" >&times;</a>
                    {if $info}
                        {foreach from=$info item=infos}{$infos}<br/>
                        {/foreach}
                    {/if}
                </div>
            </div>

            {include file="submenu.tpl"}
            
            <section {if $cmd=='root'}class="{$cmd}"{elseif $cmd=='cart'}id="cart"{elseif $cmd=='clientarea'}id="clientarea"{/if}>
                {*debug like=cmd output=ajax}
                {debug like=action output=ajax*}