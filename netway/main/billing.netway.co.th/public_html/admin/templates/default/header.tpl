<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes"/>
        <title>{$theme_vars.AdminCustomTitle}{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <script type="text/javascript">
            var picked = [];
            var lang = [];
            lang['edit'] = "{$lang.Edit}";
            Date.format = '{$js_date}';
            var startDate = '{$js_start}';
            var ts = new Date();
            var ss = ts.getMinutes();
            if (ss < 10)
                ss = "0" + ss;
            var s = ts.getHours().toString() + ':' + ss;
            var uiSettings = {$uiSettings|@json_encode};
        </script>
        <script type="text/javascript" src="{$template_dir}dist/js/hostbill{if !$DEV}.min{/if}.js?v={$hb_version}"></script>
        <link href="{$template_dir}dist/stylesheets/application.css?v={$hb_version}" rel="stylesheet" media="all" />
        <link href="?cmd=clients&action=groupcolors&lightweight=1&v={$hb_version}" rel="stylesheet" media="all" />
        <link href="{$template_dir}dist/stylesheets/font-awesome.min.css?v={$hb_version}" rel="stylesheet" media="all" />


        <link href="{$template_dir}css/tipTip.css?v={$hb_version}" rel="stylesheet" media="all" />
        <script type="text/javascript" src="{$template_dir}js/jquery.tipTip.minified.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.blockUI.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.jeditable.mini.js?v={$hb_version}"></script>
        
        <script type="text/javascript" src="{$template_dir}js/script.js?v={$hb_version}"></script>

        {literal}
        <style type="text/css">
            body {
                //background-image: url('{/literal}{$template_dir}{literal}img/logo.jpg');
                background-repeat: no-repeat;
                background-position: 15px 15px;
            }
        </style>
        {/literal}

        {if $theme_vars.AdminFavicon}
            <link rel="icon" href="{$theme_vars.AdminFavicon}"  type="image/png">
        {/if}

        {adminheader}

        {literal}

            <script>
                function is_touch_device() {
                    var prefixes = ' -webkit- -moz- -o- -ms- '.split(' ');
                    var mq = function(query) {
                        return window.matchMedia(query).matches;
                    };
                    if (('ontouchstart' in window) || window.DocumentTouch && document instanceof DocumentTouch) {
                        return true;
                    }
                    var query = ['(', prefixes.join('touch-enabled),('), 'heartz', ')'].join('');
                    return mq(query);
                }
                $(document).ready(function () {
                    $('.mainer > li > a').click(function (e) {
                        if (is_touch_device()) {
                            e.preventDefault();
                        }
                    });
                });
            </script>

        {/literal}


        <script type="text/javascript">
            var infos = {$info|@json_encode};
            var errors = {$error|@json_encode};
            {literal}
            $(document).ready(function () {
                $.each(infos, function(index, item) {
                    $('#taskMGR').taskMgrAddInfo(item);
                });
                $.each(errors, function(index, item) {
                    $('#taskMGR').taskMgrAddError(item);
                });
            });
            function parse_response_json (respose) {
                if (respose.hasOwnProperty('data')) {
                    if (respose.data.hasOwnProperty('info')) {
                        $('#taskMGR').taskMgrAddInfo(respose.data.info);
                    }
                    if (respose.data.hasOwnProperty('error')) {
                        $('#taskMGR').taskMgrAddError(respose.data.error);
                    }
                }
            }
            {/literal}
        </script>
    </head>

    <body class="{$language} cmd-{$cmd}">
        <div id="topbar">
            <div class="left">
                <div id="taskMGR">
                    <div class="toper">
                        <span class="small-load" style="display:none;"></span>
                        <span class="progress" id="pb1" style="display:none;"></span>
                        <div id="numerrors"  style="display:none;">0</div>
                        <div id="numinfos"  style="display:none;">0</div>
                    </div>
                    <a class="showlog right" href="#">{$lang.showlog}</a>
                    <div id="outer">
                        <ul id="iner"></ul>
                    </div>
                </div>
            </div>
            <div class="right">
                <span class="hidden-xs">{$lang.loggedas}:</span> <a href="?action=myaccount"><strong>{$admindata.username}</strong></a>  |<span class="hidden-xs"> <a href="{$system_url}">{$lang.clientarea}</a> | <a href="?action=myaccount">{$lang.myaccount}</a> |</span> <a href="?cmd=configuration">{$lang.Configuration}</a> |  <a href="?action=logout">{$lang.Logout}</a></div>
            <div class="clear"></div>

        </div>


        <div id="body-content">
            <table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:10px;" width="100%">
                <tr>
                    <td class="logoLeftNav"><a href="index.php"><img src="{$system_url}{$theme_vars.AdminLogoPath}"  alt="" id="hostbill-logo"/></a></td>
                    <td valign="middle" style="background:#354a5f;">
                        <div class="menushelf row no-gutter" id="menushelf">

                            <div class="col-sm-1 col-xs-6 collapse-container">
                                <button type="button" class="hidden-xs visible-sm-block navbar-toggle collapsed sm-control pull-left" data-toggle="collapse" data-target=".leftNav" aria-expanded="false">
                                    <span class="sr-only">Toggle left menu</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <button type="button" class=" navbar-toggle collapsed  pull-left" data-toggle="collapse" data-target=".leftNav" aria-expanded="false">
                                    <span class="sr-only">Toggle left menu</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                                <div class="col-xs-6">
                                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse-target" aria-expanded="false">
                                        <span class="sr-only">Toggle right menu</span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </button>
                                </div>

                            <div class="col-md-8 col-xs-12 col-sm-9">

                                   <div class="collapse navbar-collapse navbar-collapse-target">
                                        <ul class="mainer" id="mmcontainer" style="overflow:hidden" >
                                            <li class="home">
                                                <a href="index.php" >
                                                    <span class="second home">{$lang.Home}</span>

                                                </a>
                                            </li>

                                            <li class="clients">
                                                <a class="mainmenu" href="?cmd=clients">
                                                    <span class="second clients">{$lang.Clients}</span>
                                                    <span class="fourth"></span>
                                                </a> 
                                                <ul class="submenu megadropdown">
                                                    <li ><a href="?cmd=clients">{$lang.manageclients}</a></li>
                                                    <li ><a href="?cmd=newclient">{$lang.registernewclient}</a></li>
                                                    <li ><a href="?cmd=sendmessage">{$lang.notifyclients}</a></li>
                                                    <li ><a href="?cmd=affiliates">{$lang.Affiliates}</a></li>
                                                    <li >
                                                        <a href="?cmd=clients&action=groups">{$lang.clientgroups}</a>
                                                    </li>
                                                    <li >
                                                        <a href="?cmd=clients&action=fields">{$lang.customerfields}</a>
                                                    </li>
                                                    {foreach from=$HBaddons.clients_menu item=ad}
                                                        <li >
                                                            <a href="?cmd=module&module={$ad.id}">{$ad.name}</a>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </li>

                                            <li class="support"><a class="mainmenu" href="https://pdi-netway.zendesk.com/agent" target="_blank" data-href="?cmd=tickets">
                                                    <span class="second support">{$lang.Support}</span>
                                                    <span class="fourth"></span>
                                                </a> 
                                                <ul class="submenu megadropdown">
                                                    {if $enableFeatures.support}
                                                        <li ><a href="https://pdi-netway.zendesk.com/agent" target="_blank" data-href="?cmd=tickets" class="hassub">{$lang.supptickets}</a>
                                                            <div  class="topnav-popover">
                                                                <div class="topnav-popover-content">
                                                                    <ul class="subbmenu">
                                                                        <li ><a href="?cmd=tickets">All tickets</a></li>
                                                                        <li ><a href="?cmd=tickets&list=all&showall=true&assigned=true">My tickets</a></li>
                                                                        <li ><a href="?cmd=tickets&list=Open&showall=true">Open tickets</a></li>
                                                                        <li ><a href="?cmd=tickets&list=Client-Reply&showall=true">Client-Reply tickets</a></li>
                                                                        <li ><a href="https://pdi-netway.zendesk.com/agent/filters" target="_blank" data-href="?cmd=tickets&action=new" >Open New Ticket</a></li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    {/if}
                                                    {if $enableFeatures.chatmodule=='on'}
                                                        <li ><a href="?cmd=hbchat">{$lang.LiveChat}</a></li>
                                                        {/if}
                                                    <li ><a href="?cmd=annoucements">{$lang.News}</a></li>
                                                    <li ><a href="?cmd=knowledgebase">{$lang.Knowledgebase}</a></li>
                                                        {if $enableFeatures.support}
                                                        <li ><a href="?cmd=ticketdepts">{$lang.ticketdepts}</a></li>
                                                        <li ><a href="?cmd=predefinied">{$lang.ticketmacros}</a></li>
                                                        {/if}
                                                    <li ><a href="?cmd=editadmins">{$lang.Administrators}</a></li>
                                                        {foreach from=$HBaddons.support_menu item=ad}
                                                        <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                                        {/foreach}
                                                </ul>
                                            </li>

                                            <li class="payments"><a class="mainmenu" href="?cmd=invoices">
                                                    <span class="second payments">{$lang.Payments}</span>
                                                    <span class="fourth"></span>
                                                </a> 
                                                <ul class="submenu megadropdown">

                                                    <li ><a href="?cmd=invoices"  class="hassub">{$lang.Invoices}</a><div  class="topnav-popover">
                                                            <div class="topnav-popover-content">
                                                                <ul class="subbmenu">
                                                                    <li ><a href="?cmd=invoices&amp;list=paid&amp;showall=true">Paid Invoices</a></li>
                                                                    <li ><a href="?cmd=invoices&amp;list=unpaid&amp;showall=true">UnPaid Invoices</a></li>
                                                                    <li ><a href="?cmd=invoices&amp;list=refunded&amp;showall=true">Refunded Invoices</a></li>

                                                                </ul>
                                                            </div></li>
                                                    <li ><a href="?cmd=invoices&list=recurring">{$lang.Recurringinvoices}</a></li>

                                                    <li ><a href="?cmd=estimates">{$lang.Estimates}</a></li>
                                                    <li><a href="?cmd=transactions">{$lang.Transactions}</a></li>
                                                    <li><a href="?cmd=gtwlog">{$lang.Gatewaylog}</a></li>
                                                        {foreach from=$HBaddons.payment_menu item=ad}
                                                        <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                                        {/foreach}
                                                </ul>
                                            </li>

                                            <li class="orders"><a class="mainmenu" href="?cmd=orders">
                                                    <span class="second orders">{$lang.ordersandaccounts}</span>
                                                    <span class="fourth"></span>
                                                </a> 
                                                <ul class="submenu megadropdown">

                                                    <li ><a href="?cmd=orders"  class="hassub">{$lang.Orders}</a>
                                                        <div  class="topnav-popover">
                                                            <div class="topnav-popover-content">
                                                                <ul class="subbmenu">
                                                                    <li ><a href="?cmd=orders&amp;list=active" >Active Orders</a></li>
                                                                    <li ><a href="?cmd=orders&amp;list=pending">Pending Orders</a></li>
                                                                    <li ><a href="?cmd=orders&amp;list=fraud">Fraud Orders</a></li>
                                                                    <li ><a href="?cmd=orders&action=createdraft">Create Order</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li ><a href="?cmd=accounts"  class="hassub">{$lang.Accounts}</a>
                                                        <div  class="topnav-popover">
                                                            <div class="topnav-popover-content">
                                                                <ul class="subbmenu">
                                                                    <li ><a href="?cmd=accounts&amp;list=all_active" >Active </a></li>
                                                                    <li ><a href="?cmd=accounts&amp;list=all_pending" >Pending </a></li>
                                                                    <li ><a href="?cmd=accounts&amp;list=all_suspended" >Suspended </a></li>
                                                                        {if $HBaddons.orders_accounts}
                                                                            {foreach from=$HBaddons.orders_accounts item=ad}
                                                                                {assign var="descr" value="_hosting"}
                                                                                {assign var="baz" value="$ad$descr"}
                                                                            <li><a href="?cmd=accounts&list={$ad}" >{if $lang.$baz}{$lang.$baz}{else}{$ad}{/if}</a></li>
                                                                            {/foreach}
                                                                        {/if}

                                                                </ul>
                                                            </div>
                                                    </li>
                                                    <li ><a href="?cmd=domains"  class="hassub">{$lang.Domains}</a><div  class="topnav-popover">
                                                            <div class="topnav-popover-content">
                                                                <ul class="subbmenu">
                                                                    <li ><a href="?cmd=domains&amp;list=active" >Active </a></li>
                                                                    <li ><a href="?cmd=domains&amp;list=pending" >Pending </a></li>
                                                                    <li ><a href="?cmd=domains&amp;list=expired" >Expired </a></li>
                                                                    <li ><a href="?cmd=domains&action=sync" >Synchronize </a></li>

                                                                </ul>
                                                            </div></li>
                                                            {foreach from=$HBaddons.orders_menu item=ad}
                                                        <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                                        {/foreach}
                                                </ul>
                                            </li>

                                            <li class="configuration"><a class="mainmenu" href="?cmd=configuration">
                                                    <span class="second configuration">{$lang.Configuration}</span>
                                                    <span class="fourth"></span>
                                                </a> 
                                                <ul class="submenu megadropdown">
                                                    <li ><a href="?cmd=configuration"  class="hassub">System Settings</a>
                                                        <div  class="topnav-popover">
                                                            <div class="topnav-popover-content">
                                                                <ul class="subbmenu">
                                                                    <li><a href="?cmd=configuration">{$lang.generalconfig}</a></li>
                                                                    <li><a href="?cmd=configuration&amp;action=cron">Task List</a></li>
                                                                    <li><a href="?cmd=whoisservers">{$lang.domainsettings}</a></li>
                                                                    <li><a href="?cmd=dns_automation">{$lang.dnssettings}</a></li>

                                                                    <li ><a href="?cmd=security">{$lang.securitysettings}</a></li>
                                                                    <li><a href="?cmd=langedit">Language settings</a></li>
                                                                </ul>
                                                            </div>
                                                    </li>
                                                    <li ><a href="?cmd=managemodules">{$lang.Modules}</a></li>
                                                    <li ><a href="?cmd=services">{$lang.productsandservices}</a></li>
                                                    <li ><a href="?cmd=productaddons">{$lang.productaddons}</a></li>
                                                    <li ><a href="?cmd=emailtemplates">{$lang.emailtemplates}</a></li>
                                                    <li ><a href="?cmd=servers">{$lang.manapps}</a></li>
                                                </ul>
                                            </li>

                                            <li class="extras"><a class="mainmenu" href="?cmd=managemodules">
                                                    <span class="second extras">{$lang.Extras}</span>
                                                    <span class="fourth"></span>
                                                </a>
                                                <ul class="submenu megadropdown  extrasdropdown">
                                                    <li ><a href="?cmd=managemodules&action=other"   {if $HBaddons.extras_menu|@count gt 4}class="hassub"{/if}>{$lang.Plugins}</a>
                                                      {if $HBaddons.extras_menu|@count gt 4}<div  class="topnav-popover">
                                                            <div class="topnav-popover-content">
                                                                <ul class="subbmenu">
                                                                    {foreach from=$HBaddons.extras_menu item=ad}
                                                                        <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                                                    {/foreach}
                                                                </ul>
                                                            </div>
                                                        </div>{/if}
                                                    </li>
                                                    <li ><a href="?cmd=stats">{$lang.systemstatistics}</a></li>
                                                    <li ><a href="?cmd=logs">{$lang.systemlogs}</a></li>
                                                    <li ><a href="?cmd=notifications">{$lang.Notifications}</a></li>
                                                    <li ><a href="?cmd=importaccounts">{$lang.impaccounts}</a></li>
                                                    <li ><a href="?cmd=infopages">{$lang.infopages}</a></li>
                                                    <li class="relative">
                                                        <a href="?cmd=coupons" class="hassub">{$lang.promotions}</a>
                                                        <div  class="topnav-popover">
                                                            <div class="topnav-popover-content">
                                                                <ul class="subbmenu">
                                                                    <li><a href="?cmd=coupons">{$lang.promocodes}</a></li>
                                                                    <li><a href="?cmd=creditvouchers">Credit Vouchers</a></li>
                                                                    <li><a href="?cmd=productoffer">Free Products</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li ><a href="?cmd=downloads">{$lang.Downloads}</a></li>
                                                    {if $HBaddons.extras_menu|@count lt 5}
                                                        {foreach from=$HBaddons.extras_menu item=ad}
                                                        <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                                        {/foreach}
                                                    {/if}
                                                </ul>
                                            </li>

                                            <li class="zendesk">
                                                <a class="mainmenu" href="?cmd=zendeskagentssohandle&amp;action=sso">
                                                <span class="second extras">Zendesk</span>
                                                </a>
                                            </li>

                                        </ul>
                                        </div>


                                <div class="clear"></div>
                                        </div>

                                        <div id="search_form_container" class="search_form_container collapse in navbar-collapse-target col-md-4 col-xs-12 col-sm-2">

                                            <input name="query" id="smarts" autocomplete="off" placeholder="{$lang.smartsearch}" type="text" data-settings="{$searchsettings|@json_encode|escape}"/>
                                            <a href="#" id="search_submiter" class="search_submiter"><i class="fa fa-search"></i></a>

                                        </div>



                        </div>
                    </td>
                </tr>
            </table>

    {adminwidget module="any" section="beforecontent"}