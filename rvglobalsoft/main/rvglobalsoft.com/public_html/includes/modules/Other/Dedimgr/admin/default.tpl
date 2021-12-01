<script type="text/javascript" src="{$moduledir}java.js"></script>
<script type="text/javascript" src="{$moduledir}jquery.tooltip.min.js"></script>
<script type="text/javascript" src="templates/default/js/gui.elements.js"></script>

<link rel="stylesheet" href="templates/default/js/gui.elements.css" type="text/css" />
<link href="{$moduledir}style.css" rel="stylesheet"  type="text/css"/>


<input type="hidden" name="module_id" value="{$moduleid}" id="module_id" />
<div id="dedimgr">
    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li class="{if $do!='inventory' && $do!='vendors' && $do!='switches' && $do!='pdus' && $do!='configuration'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}"><span>Colocations</span></a>
                </li>
                <li class="{if $do=='inventory'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}&do=inventory"><span>Inventory</span></a>
                </li>
                <li class="{if $do=='vendors'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}&do=vendors"><span>Vendors</span></a>
                </li>
             {*  <li class="{if $do=='switches'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}&do=switches"><span>Switch control</span></a>
                </li>
                <li class="{if $do=='pdus'}active{/if}">
                    <a href="?cmd=module&module={$moduleid}&do=pdus"><span>PDU control</span></a>
                </li>
                *}
                <li class="{if $do=='configuration'}active{/if} last">
                    <a href="?cmd=module&module={$moduleid}&do=configuration"><span>Configuration</span></a>
                </li>
            </ul>
            <div class="modernfacebox left" style="position:relative;margin:6px 0px 0px 40px;" id="search_form_container2">
                <label>Search:</label>
                <input type="text" name="query" style="width:250px"  id="smarts2" autocomplete="off"/>
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
                    <li>
                        <a  href="?cmd=module&module={$moduleid}&do=viewlogs"><span>View logs</span></a></li>
                </ul>

            </div>
            {elseif $do=='floor'}<div class="subm1 haveitems" >
                <ul>
                    <li>
                        <a onclick="return addRack('{$floor.id}')" href="#"><span>Add new rack</span></a>
                    </li>
                </ul>
            </div>
            {elseif $do=='inventory'}
            <div class="subm1 haveitems" >
                <ul>
                    <li {if !$subdo || $subdo=='category'}class="picked"{/if}>
                        <a  href="?cmd=module&module={$moduleid}&do=inventory"><span>Item categories</span></a>
                    </li>
                    <li {if  $subdo=='fieldtypes'}class="picked"{/if}>
                        <a  href="?cmd=module&module={$moduleid}&do=inventory&subdo=fieldtypes"><span>Item Fields</span></a>
                    </li>
                </ul>
            </div>
            {elseif $do=='viewlogs'}
            <div class="subm1 haveitems" >
                <ul>
                    <li >
                        <a onclick="return confirm('Are you sure?');" href="?cmd=module&module={$moduleid}&do=viewlogs&clearlogs=true"><span style="color:red">Clear logs</span></a>
                    </li>
                </ul>
            </div>
            {/if}

        </div>

    </div>
    <div style="background:#F5F9FF;padding:10px" >
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

        {else}

            {include file="`$newtemplates`colocations.tpl"}


        {/if}


    </div>

</div>