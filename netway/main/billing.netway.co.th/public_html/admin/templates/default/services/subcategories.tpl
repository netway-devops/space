{if $subcategories}
    <div id="addcategory" style="display: none;"></div>
    <form id="serializeit" method="post">
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
            <tbody>
            <tr>
                <th width="20"></th>
                <th width="20%">{$lang.Name}</th>
                <th width="150">{$lang.contains}</th>
                <th width="200">{$lang.Products}</th>
                <th>{$lang.ordertype}</th>
                <th width="160">&nbsp;</th>
            </tr>
            </tbody>
        </table>
        <ul id="grab-sorter" style="width:100%">
            {include file="services/ajax.categories.tpl" categories=$subcategories}
        </ul>
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
            <tbody>
            <tr>
                <th width="20"></th>
                <th>
                    <a class="btn btn-sm btn-success" href="?cmd=services&action=addcategory&parent_id={$category.id}">{$lang.addnewsubcategory}</a>
                </th>
            </tr>
            </tbody>
        </table>
        {securitytoken}
    </form>
{else}
    <div class="blank_state blank_services">
        <div class="blank_info">
            <h1>{$lang.orpage_blank_subcats}</h1>
            <div class="clear">{$lang.orpage_blank_subcats_desc}</div>
            <a class="new_add new_menu" href="?cmd=services&action=addcategory&parent_id={$category.id}" style="margin-top:10px">
                <span>{$lang.addnewsubcategory}</span></a>
            <div class="clear"></div>
        </div>
    </div>
{/if}