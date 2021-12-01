<link media="all" type="text/css" rel="stylesheet" href="templates/common/cloudhosting/styles.css" />
<script type="text/javascript" src="templates/common/cloudhosting/js/scripts.js"></script>

{literal}
    <style>
        ul#vm-menu{
            height: auto;
            margin: 0;
        }
        ul#vm-menu::after{
            content: "";
            display: table;
            clear: both;
        }
        ul#vm-menu li{
            margin: 5px
        }
        ul#vm-menu li a {
            width: auto;
            min-width: 70px;
            padding: 5px;
        }

        ul#vm-menu li img {
            display: inline-block;
            height: 24px;
            line-height: 32px;
            margin: 8px;
            padding: 0;
            vertical-align: middle;
            width: 24px;
        }
    </style>
{/literal}
<div class="cloud">
{if $widget.appendtpl }
    {include file=$widget.appendtpl}
{/if}
{cloudservices
section='header'
include="../common/cloudhosting/tpl/header.tpl"}
    <div id="nav-onapp">
        <h1 class="left os-logo {if $VMDetails}{$VMDetails.guest.os_version.distro}{elseif $vmdistro}{$vmdistro}{/if}">{if $VMDetails}{$VMDetails.name_label}{else}{$vmhostname}{/if}</h1>
        <ul class="level-1">
            <li class="{if $vmsection=='vmdetails'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><span class="list-servers">{$lang.Overview}</span></a></li>

            <li class="{if $vmsection=='billing'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=billing&vpsid={$vpsid}"><span class="addserver">{$lang.Billing}</span></a></li>
        </ul> <div class="clear"></div>
    </div>

{/cloudservices}
<div class="clear"></div>
<div id="content-cloud">
