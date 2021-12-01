<script type="text/javascript" src="{$moduledir}js/java.js"></script>
<script type="text/javascript" src="templates/default/js/gui.elements.js"></script>

<link rel="stylesheet" href="templates/default/js/gui.elements.css" type="text/css" />
<link href="{$moduledir}css/style.css" rel="stylesheet"  type="text/css"/>


<input type="hidden" name="module_id" value="{$moduleid}" id="module_id" />
<table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td width="20%" style="border-right:solid 1px #ccc;display: none;" valign="top" id="treecontainer">
            <div id="treecomponent" >
                {include file="`$newtemplates`treecomponent.tpl"}
            </div>
        </td>
        <td style="vertical-align: top">
            <div id="dedimgr">
                <div class="newhorizontalnav" id="newshelfnav">
                    <div class="list-1" style="    padding-left: 6px;">
                        <ul>
                            <li>
                                <a href="#" onclick="return treeToggle();">
                                    <span class="fa fa-bars" aria-hidden="true"></span>
                                </a>
                            </li>
                            <li class="{if $do!='inventory' && $do!='vendors' && $do!='switches' && $do!='pdus' && $do!='configuration' && $do!='viewlogs' && $do!='pools'}}active{/if}">
                                <a href="?cmd=dedimgr"><span>Colocations</span></a>
                            </li>
                            <li class="{if $do=='quickmanage'}active{/if}">
                                <a href="?cmd=dedimgr&do=quickmanage"><span>Quick Manage</span></a>
                            </li>
                            <li class="{if $do=='quickconnections'}active{/if}">
                                <a href="?cmd=dedimgr&do=quickconnections"><span>Connections</span></a>
                            </li>
                            <li class="{if $do=='configuration'}active{/if} last">
                                <a href="?cmd=dedimgr&do=configuration"><span>Configuration</span></a>
                            </li>
                            <li class="{if $do=='viewlogs'}active{/if} last">
                                <a href="?cmd=dedimgr&do=viewlogs"><span>Logs</span></a>
                            </li>
                        </ul>
                        <div class="right form-group" style="position:relative;margin:6px 0px 0px 40px;" id="search_form_container2">
                            <input type="text" name="query" style="width:250px"  id="smarts2" autocomplete="off" class="form-control" placeholder="Search"/>
                            <a href="#" id="search_submiter2" class="search_submiter"></a>
                        </div>
                        <div id="smartres2" class="smartres" style="display:none"><ul id="smartres-results2" class="smartres-results" ></ul></div>
                    </div>
                    <div class="list-2">
                        {if !$do}<div class="subm1 haveitems" >
                                <ul>
                                    <li>
                                        <a onclick="return addColocation();" href="#"><span><b>Add new colocation</b></span></a>
                                    </li>
                                    {*}<li>
                                    <a  href="?cmd=dedimgr&do=viewlogs"><span>View logs</span></a>
                                    </li>{*}
                                </ul>

                            </div>
                        {elseif $do=='floor'}
                            <div class="subm1 haveitems" >
                                <ul>
                                    <li>
                                        <a onclick="return addRack('{$floor.id}')" href="#"><span>Add new rack</span></a>
                                    </li>
                                </ul>
                            </div>
                        {elseif $do=='configuration' || $do=='inventory' || $do=='vendors' || $do=='pools'}
                            <div class="subm1 haveitems" >
                                <ul>
                                    <li {if $do=='configuration'}class="picked"{/if}>
                                        <a  href="?cmd=dedimgr&do=configuration"><span>Settings</span></a>
                                    </li>
                                    <li class="{if $do=='vendors'}active{/if}">
                                        <a href="?cmd=dedimgr&do=vendors"><span>Vendors</span></a>
                                    </li>
                                    <li class="{if $do=='pools'}active{/if}">
                                        <a href="?cmd=dedimgr&do=pools"><span>Pools</span></a>
                                    </li>
                                    <li {if $do=='inventory' && !$subdo || $subdo=='category'}class="picked"{/if}>
                                        <a  href="?cmd=dedimgr&do=inventory"><span>Item categories</span></a>
                                    </li>
                                    <li {if $do=='inventory' && $subdo=='fieldtypes'}class="picked"{/if}>
                                        <a  href="?cmd=dedimgr&do=inventory&subdo=fieldtypes"><span>Item Fields</span></a>
                                    </li>
                                    <li {if $do=='inventory' && $subdo=='fieldtypescat'}class="picked"{/if}>
                                        <a  href="?cmd=dedimgr&do=inventory&subdo=fieldtypescat"><span>Item Fields Categories</span></a>
                                    </li>
                                    <li {if $do=='inventory' && $subdo=='rackfields'}class="picked"{/if}>
                                        <a  href="?cmd=dedimgr&do=inventory&subdo=rackfields"><span>Rack Fields</span></a>
                                    </li>
                                </ul>
                            </div>
                        {elseif $do=='viewlogs'}
                            <div class="subm1 haveitems" >
                                <ul>
                                    <li >
                                        <a onclick="return confirm('Are you sure?');" href="?cmd=dedimgr&do=viewlogs&clearlogs=true"><span style="color:red">Clear logs</span></a>
                                    </li>
                                </ul>
                            </div>
                        {elseif $do=='quickmanage'}
                            <div class="subm1 haveitems" >
                                <ul>
                                    <li>
                                        <a onclick="return bootbox.alert('This page lists ALL your devices stored in colocation manager with quick access to important functions and informations. Click on item label to proceed to item details page');">What is this?</a>
                                    </li>
                                    <li>
                                        <a id="filter-items" href="#filter">Filter items</a>
                                    </li>
                                    <li>
                                        <a href="?cmd=dedimgr&do=quickmanage&resetfilter=1" {if !$currentfilter}style="display:none"{/if} class="freseter">{$lang.filterisactive}</a>
                                    </li>
                                </ul>
                            </div>
                        {/if}

                    </div>

                </div>
                <div class="dedimgr-view {if $do=='viewlogs' || $do=='itemeditor' || $do=='quickmanage' || $do=='quickconnections'}no-padding{/if}" >
                    {if $do=='inventory'}

                        {include file='inventory.tpl'}

                    {elseif $do=='floor'}

                        {include file="`$newtemplates`floor.tpl"}

                    {elseif $do=='vendors'}

                        {include file="`$newtemplates`vendors.tpl"}

                    {elseif $do=='floors'}

                        {include file="`$newtemplates`floors.tpl"}

                    {elseif $do=='switches'}

                        {include file="`$newtemplates`switches.tpl"}

                    {elseif $do=='pdus'}

                        {include file="`$newtemplates`pdus.tpl"}

                    {elseif $do=='rack'}

                        {include file='rackeditor.tpl'}

                    {elseif $do=='viewlogs'}

                        {include file="`$newtemplates`logs.tpl"}

                    {elseif $do=='configuration'}

                        {include file="`$newtemplates`configuration.tpl"}

                    {elseif $do=='itemeditor'}

                        {include file='edititem.tpl'}

                    {elseif $do=='itemconfigdiff'}

                        {include file='itemconfigdiff.tpl'}

                    {elseif $do=='itemconfigedit'}

                        {include file='itemconfigedit.tpl'}

                    {elseif $do=='pools'}

                        {include file='pools.tpl'}

                    {elseif $do=='quickmanage'}

                        {include file='quickmanage.tpl'}

                    {elseif $do=='quickconnections'}

                        {include file='quickconnections.tpl'}

                    {else}

                        {include file="`$newtemplates`colocations.tpl"}
                    {/if}


                </div>

            </div>

        </td>
    </tr>
</table>
