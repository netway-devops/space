<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="{if $action=='default'}active{/if} picked">
                <a href="?cmd=services"><span class="ico money">{$lang.orpages}</span></a>
            </li>
            <li class="{if $action=='addcategory'}active{/if} ">
                <a href="?cmd=services&action=addcategory"><span class="ico formn">{$lang.addneworpage}</span></a>
            </li>

            <li class="{if $action=='bulkupdate'}active{/if} last">
                <a href="?cmd=services&action=bulkupdate"><span class="ico formn">Bulk update</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2" style="min-height: 15px;">
        {if $action=='default'}
            <div class="subm1 haveitems">
                <ul>
                    <li>
                        <a href="#archived" onclick="return HBServices.showArcived(), false">Show Archived Categories <span id="count_archived"></span></a>
                    </li>
                </ul>
            </div>
        {/if}
    </div>
</div>

<div id="addcategory" style="{if $action!='addcategory'}display:none{/if}">
    <div class="nicerblu">
        {include file="services/category_add_edit.tpl"}
    </div>
</div>
<div id="listproducts" {if $action!='default'}style="display:none"{/if}>
    {if $categories}
        <form id="serializeit" method="post">

            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tbody>
                    <tr>
                        <th width="20"></th>
                        <th width="20%">{$lang.Name}</th>
                        <th width="120">{$lang.Products}</th>
                        <th>{$lang.ordertype}</th>
                        <th width="160">&nbsp;</th>
                    </tr>
                </tbody>
            </table>
            <ul id="grab-sorter" style="width:100%">
                {include file="services/ajax.categories.tpl"}
            </ul>
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tbody>
                    <tr>
                        <th width="20"></th>
                        <th>
                            <a class="btn btn-sm btn-success"
                               href="?cmd=services&action=addcategory">{$lang.addneworpage}</a>
                            <a class="btn btn-default btn-sm bulk-update" href="?cmd=services&action=bulkupdate">Bulk update</a>
                        </th>

                    </tr>
                </tbody>
            </table>
            {securitytoken}
        </form>
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>{$lang.orpage_blank1}</h1>
                <div class="clear">{$lang.orpage_blank1_desc}</div>

                <a class="new_add new_menu" href="?cmd=services&action=addcategory" style="margin-top:10px">
                    <span>{$lang.addneworpage}</span></a>

                <div class="clear"></div>

            </div>
        </div>
    {/if}
</div>