<link media="all" type="text/css" rel="stylesheet" href="templates/common/cloudhosting/styles.css"/>
<link media="all" type="text/css" rel="stylesheet" href="templates/common/cloudhosting/css/responsive.css"/>
<script type="text/javascript" src="templates/common/cloudhosting/js/scripts.js"></script>
<div class="cloud">

    {if $widget.appendtpl }
        {include file=$widget.appendtpl}
    {/if}

    {cloudservices
    section='header'
    include="../common/cloudhosting/tpl/header.tpl"}

    {if $vpsid || $provisioning_type=='single'}
        <div class="cloud-top">
            <div class="cloud-header">
                <h1 class="left os-logo {if $s_vm}{$s_vm.distro}{/if}">{$s_vm.hostname}</h1>
                {if $provisioning_type!='single'}
                    <a href="{$service_url}" class="left apeded">
                        &laquo; {$lang.allservers}
                    </a>
                {/if}
            </div>
            <div class="cloud-nav">
                <ul class="level-1">
                    <li class="menu-item {if $vmsection=='vmdetails'}current-menu-item{/if}">
                        <a href="{$service_url}&vpsdo=vmdetails&vpsid={$vpsid}">
                            <span class="list-servers">{$lang.Overview}</span>
                        </a>
                    </li>
                    <li class="menu-item dropdown {if $vmsection=='usage'}current-menu-item{/if}">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">{$lang.Usage} <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li class="{if $vpsdo=='network'}active{/if}">
                                <a href="{$service_url}&vpsdo=usage&vpsid={$vpsid}#network" >
                                    {$lang.networkusage}
                                </a>
                            </li>
                            <li class="{if $vpsdo=='cpu'}active{/if}">
                                <a href="{$service_url}&vpsdo=usage&vpsid={$vpsid}#cpu" >
                                    {$lang.cpuusage}
                                </a>
                            </li>
                            <li class="{if $vpsdo=='memory'}active{/if}">
                                <a href="{$service_url}&vpsdo=usage&vpsid={$vpsid}#memory" >
                                    {$lang.memory}
                                </a>
                            </li>
                            <li class="{if $vpsdo=='memory'}active{/if}">
                                <a href="{$service_url}&vpsdo=usage&vpsid={$vpsid}#disk" >
                                    {$lang.diskcharts|default:'Disk Usage'}
                                </a>
                            </li>

                        </ul>
                    </li>
                    <li class="menu-item {if $vmsection=='billing'}current-menu-item{/if}">
                        <a href="{$service_url}&vpsdo=billing&vpsid={$vpsid}">
                            <span class="addserver">{$lang.Billing}</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
    {else}
        <div class="cloud-top">
            <div class="cloud-header">
                <h1 class="left os-logo">{$service.name}</h1>
            </div>
            <div class="cloud-nav">
                <ul class="level-1">
                    {if $provisioning_type=='cloud'}
                        <li class="menu-item {if !$vpsdo}current-menu-item{/if}">
                            <a href="{$service_url}"><span
                                        class="list-servers">{$lang.ListServers}</span>
                            </a>
                        </li>
                    {/if}
                    <li class="menu-item {if $vmsection=='resources'}current-menu-item{/if}">
                        <a href="{$service_url}&vpsdo=resources">
                            <span class="resources">{$lang.reslabel}</span>
                        </a>
                    </li>
                    <li class="menu-item {if $vpsdo=='billing'}current-menu-item{/if}">
                        <a href="{$service_url}&vpsdo=billing">
                            <span class="billing">{$lang.Billing}</span>
                        </a>
                    </li>
                    {if $provisioning_type=='cloud'}
                        <li class="menu-item {if $vpsdo=='createvm'}current-menu-item{/if}">
                            <a href="{$service_url}&vpsdo=createvm">
                                <span class="addserver">{$lang.addservernote}</span>
                            </a>
                        </li>
                    {/if}
                </ul>
            </div>
            <div class="clear"></div>
        </div>
    {/if}
    {/cloudservices}
    <div class="clear"></div>
    <div id="content-cloud">
