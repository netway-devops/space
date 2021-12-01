<link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css" />
<link rel="stylesheet" href="{$template_dir}js/tree/jqtree.css?v={$hb_version}">
<script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tree/tree.jquery.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/theme_config.js"></script>

{literal}
<style>
    .colorpicker-parent {
        display: flex;
        flex-direction: row;
    }
    .colorpicker-box {
        position: relative;
        display: flex;
        flex-direction: row;
        align-items: center;
        margin-right: 20px;
        max-width: 260px;
    }
    .colorpicker-box-input {
        max-width: 160px;
    }
    .colorpicker-box-picker {
        cursor:pointer;
        height:18px;
        margin:6px 0 5px 8px;
        width:18px;
        border-radius:50%;
        box-shadow:0 2px 4px rgba(100,100,100,.4);
        position: absolute;
        right: 10px;
        top: 0;
        bottom: 0;
    }
    .colorpicker-box-picker:hover {
        box-shadow:0 2px 6px rgba(100,100,100,.4);
    }
    #vtip {
        max-width: 700px;
    }
    img.vtip_preview {
        max-width: 660px;
    }
    .tc_li_table {
        width: 100%;
    }
    .tc_li_table_section {
        width: 100%;
    }
    .tc_li_table_item {
        margin: 10px 0;
    }
    .tc_li_table_item tr {
        border: 1px solid #eee;
    }
    .tc_li_table tr td {
        padding: 10px;
    }
    #leftmenu-tree,
    #footer-tree {
        padding: 15px 0;
    }
    ul.jqtree-tree .jqtree-element .jqtree-element-link {
        margin-left: 5px;
    }
</style>
    <script>
        $(function () {
            $('.withloader').click(function () {
               $('.theme_config_section').addLoader()
            });
            $('.withloader_confirm').click(function (e) {
                if (confirm('Are you sure? This configuration will be activated and the previous configuration will be deactivated')) {
                    $('.theme_config_section').addLoader();
                    return true;
                } else {
                    e.preventDefault();
                }
            });
        });
    </script>
{/literal}

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td>
            <h3>Theme editor</h3>
        </td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration" class="tstyled">General Settings</a>
            <a href="?cmd=theme_config" class="tstyled selected">Theme editor</a>
        </td>
        <td valign="top" class="bordered" rowspan="2">
            <div id="bodycont">
                {literal}
                    <script>
                        $(document).ready(function () {
                            $('#newshelfnav').TabbedMenu({
                                elem: '.sectioncontent',
                                picker: '.list-2-links li',
                                aclass: 'active'
                            });
                        });
                    </script>
                {/literal}
                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            <li>
                                Template:
                                <select name="" id="" style="margin-right: 20px;" onchange="if (this.value) window.location.href='?cmd=theme_config&action=selecttemplate&template='+this.value">
                                    <option disabled="disabled" selected="selected">-- None --</option>
                                    {foreach from=$templates item=t}
                                        <option {if $selected_template==$t}selected="selected"{/if}>{$t}</option>
                                    {/foreach}
                                </select>
                            </li>
                            <li class="{if $action == 'default'}active{/if}">
                                <a href="?cmd=theme_config">Configurations</a>
                            </li>
                            {if $config.id}
                                <li class="active">
                                    <a href="#">{$config.name}</a>
                                </li>
                            {/if}
                        </ul>
                        <ul class="right" style="height: 40px;">
                            <li>
                                <small style="color: #aaa">
                                    <span style="font-weight: normal;">Theme path:</span>
                                    <b>{$path_template}</b>
                                </small>
                            </li>
                        </ul>
                    </div>

                    <div class="list-2" {if $action!='config' && $action!='default'}style="display: none;" {/if}>
                        <div class="subm1 haveitems" style="display: block; height: 20px;">
                            {if $action == 'config'}
                                <ul class="list-2-links">
                                    {foreach from=$config.configuration.sections key=section_var item=section}
                                        <li data-id="{$section_var}">
                                            <a href="#">{$section.name}</a>
                                        </li>
                                    {/foreach}
                                </ul>
                                {if $config.active == 1}
                                    <div class="pull-right">
                                        <div class="label label-success">Active</div>
                                    </div>
                                {elseif $config.active == -1}
                                    <div class="pull-right">
                                        <div class="label label-warning">Active, changes not applied</div>
                                    </div>
                                {/if}
                            {elseif $action == 'default'}
                                <ul>
                                    <li>
                                        <form style="display: none;" method="POST" enctype="multipart/form-data" class="theme_config_import_form" action="?cmd=theme_config&action=import">
                                            <input accept=".json" name="config" type="file" onchange="$('.theme_config_import_form').submit()"/>
                                            <input type="hidden" name="action" value="import">
                                            {securitytoken}
                                        </form>
                                        <a href="#" onclick="$('.theme_config_import_form input').trigger('click');return false;">Import from file</a>
                                        <a href="?cmd=theme_config&action=setdefault&security_token={$security_token}" onclick="return confirm('Are you sure?');">Use default configuration</a>
                                    </li>
                                </ul>
                            {/if}
                        </div>
                    </div>
                </div>
                {if $action == 'results'}
                    <div class="container-fluid" style="margin: 10px 0">
                        <p>
                            Theme compilation is running in a background task, you can track progress of it below
                        </p>
                        {include file="queue/progress.tpl" embedded=true}
                    </div>
                {elseif $action == 'config'}
                    <div style="padding:15px;" class="theme_config_section">
                        {foreach from=$config.configuration.sections key=section_var item=section}
                            <div class="sectioncontent" style="display:none">
                                <form method="post" id="theme_config_form" action="?cmd=theme_config&action=config&id={$config.id}">
                                    <table class="table-settings" style="width: 100%">
                                        <tbody>
                                        {if $section_var == 'left_menu'}
                                            {include file="theme_config/_menu.tpl"}
                                        {elseif $section_var == 'footer'}
                                            {include file="theme_config/_footer.tpl"}
                                        {elseif $section_var == 'overrides'}
                                            {include file="theme_config/_overrides.tpl"}
                                        {elseif $section_var == 'orderpages'}
                                            {include file="theme_config/_orderpages.tpl"}
                                        {else}
                                            {include file="theme_config/_fields.tpl"}
                                        {/if}
                                        </tbody>
                                    </table>
                                    <div class="clearfix"></div>
                                    <div class="col-md-12" style="margin-top: 30px;">
                                        {securitytoken}
                                        <button class="withloader btn btn-success" type="submit">Save configuration</button>
                                        <button class="withloader_confirm btn btn-success" type="submit" name="apply" value="1">Save & apply configuration</button>
                                        <div class="pull-right">
                                            <a href="?cmd=theme_config&action=config&id={$config.id}&make=export&security_token={$security_token}" class="btn btn-default">Export</a>
{*                                            <a href="#" class="btn btn-default withloader">Preview</a>*}
                                        </div>
                                        <input type="hidden" name="id" value="{$config.id}">
                                        <input type="hidden" name="make" value="save">
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                        {/foreach}
                    </div>
                {else}
                    <div>
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>{$lang.Name}</th>
                                <th>Version</th>
                                <th>Updated</th>
                                <th width="250"></th>
                                <th width="250" align="right"></th>
                            </tr>
                            </thead>
                            <tbody id="updater">
                                {foreach from=$configs item=config}
                                    <tr>
                                        <td>
                                            <a href="?cmd=theme_config&action=config&id={$config.id}">{$config.id}</a>
                                        </td>
                                        <td><a href="?cmd=theme_config&action=config&id={$config.id}">{$config.name}</a></td>
                                        <td>{$config.configuration.version}</td>
                                        <td>{$config.updated_at} ({$config.updated_by})</td>
                                        <td>
                                            {if $config.active}
                                                <div class="label label-success" style="margin-left: 10px">Active</div>
                                            {/if}
                                        </td>
                                        <td align="right">
                                            <a href="?cmd=theme_config&action=config&id={$config.id}" class="btn btn-sm btn-default">Edit</a>
                                            <a href="?cmd=theme_config&action=config&id={$config.id}&make=duplicate&security_token={$security_token}" onclick="return confirm('Are you sure you wish to duplicate this configuration?');"  class="btn btn-sm btn-default">Duplicate</a>
                                            <a href="?cmd=theme_config&action=config&id={$config.id}&make=delete&security_token={$security_token}" onclick="return confirm('Are you sure you wish to remove this configuration?');" class="btn btn-sm btn-default"><span style="color: red;">Remove</span></a>
                                        </td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="100%">Nothing found </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                {/if}
            </div>
        </td>
    </tr>
</table>