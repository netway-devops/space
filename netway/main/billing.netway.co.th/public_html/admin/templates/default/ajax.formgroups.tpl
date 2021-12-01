{include file='formgroups/topnav.tpl'}

{if $action=='default' || $action=='form_groups'}
    <div id="listproducts">
        {if $groups}
            <form id="serializeit" method="post">
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th width="120">Forms</th>
                            <th width="30%">Description</th>
                            <th width="20%">Enabled flags</th>
                            <th width="100px">Type</th>
                            <th width="160px"></th>
                        </tr>
                    </thead>
                    <tbody>
                        {include file="formgroups/ajax.form_groups.tpl"}
                    </tbody>
                </table>
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                    <tbody>
                        <tr>
                            <th width="20"></th>
                            <th>
                                <a class="btn btn-sm btn-success" href="?cmd=formgroups&action=form_group">{$lang.addformgroup}</a>
                            </th>
                        </tr>
                    </tbody>
                </table>
                {securitytoken}
            </form>
        {else}
            <div class="blank_state blank_services">
                <div class="blank_info">
                    <h1>{$lang.formgroups}</h1>
                    <div class="clear">{$lang.formgroupsdesc}</div>
                    <a class="new_add new_menu" href="?cmd=formgroups&action=form_group" style="margin-top:10px">
                        <span>{$lang.addformgroup}</span>
                    </a>
                    <div class="clear"></div>
                </div>
            </div>
        {/if}
    </div>
{elseif $action=='default' || $action=='form_item_groups'}
    <div id="listproducts">
        {if $groups}
            <form id="serializeit" method="post">
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                    <thead>
                        <tr>
                            <th width="20%">Name</th>
                            <th width="120">Items</th>
                            <th width="30%">Description</th>
                            <th width="20%">Enabled flags</th>
                            <th width="160px"></th>
                        </tr>
                    </thead>
                    <tbody>
                    {include file="formgroups/ajax.form_item_groups.tpl"}
                    </tbody>
                </table>
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                    <tbody>
                    <tr>
                        <th width="20"></th>
                        <th>
                            <a class="btn btn-sm btn-success" href="?cmd=formgroups&action=form_item_group">{$lang.addformitemgroup}</a>
                        </th>
                    </tr>
                    </tbody>
                </table>
                {securitytoken}
            </form>
        {else}
            <div class="blank_state blank_services">
                <div class="blank_info">
                    <h1>{$lang.formitemgroups}</h1>
                    <div class="clear">{$lang.formitemgroupsdesc}</div>
                    <a class="new_add new_menu" href="?cmd=formgroups&action=form_item_group" style="margin-top:10px">
                        <span>{$lang.addformitemgroup}</span>
                    </a>
                    <div class="clear"></div>
                </div>
            </div>
        {/if}
    </div>
{elseif $action=='form_group'}
    <div id="mod_form_group">
        {include file="formgroups/ajax.form_group.tpl"}
    </div>
{elseif $action=='form_item_group'}
    <div id="mod_form_item_group">
        {include file="formgroups/ajax.form_item_group.tpl"}
    </div>
{/if}

{literal}
    <script>

    </script>
{/literal}
{literal}
    <style>
        select#forms option[disabled] {
            display: none;
        }
        #forms_chosen .disabled-result {
            display: none;
        }
    </style>
{/literal}
