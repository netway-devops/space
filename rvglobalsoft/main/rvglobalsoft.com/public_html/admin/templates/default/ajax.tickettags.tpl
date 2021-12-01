{if !$ajax}
<link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css"/>
    <script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js?v={$hb_version}"></script>
    <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-1">
            <ul>
                <li class="{if $action=='default'}active{/if}">
                    <a href="?cmd=tickettags"><span>Current tags</span></a>
                </li>
                <li class="{if $action=='archived'}active{/if}">
                    <a href="?cmd=tickettags&action=archived"><span>Archived tags</span></a>
                </li>
            </ul>
        </div>
    </div>
<div style="padding:10px ;">
    <div class="box box-primary no-padding">
        <div class="box-body">
            <a href="?cmd=tickettags&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="whitetable hover">
                <thead>
                <tr>
                    <th width="50%"><a href="?cmd=tickettags&action={$action}&orderby=tag|ASC" class="sortorder">Tag</a></th>
                    {if $action == 'default'}
                        <th width="30%"><a href="?cmd=tickettags&action={$action}&orderby=usage|ASC" class="sortorder">Usage</a>
                    {elseif $action == 'archived'}
                        <th width="15%"><a href="?cmd=tickettags&action={$action}&orderby=who|ASC" class="sortorder">Archived by</a>
                        <th width="15%"><a href="?cmd=tickettags&action={$action}&orderby=date|ASC" class="sortorder">Date</a>
                    {/if}
                    </th>
                    <th width="200" align="right"></th>
                </tr>
                </thead>
                <tbody id="updater">
                {/if}
                {foreach from=$tags item=tag}
                    <tr>
                        {if $action == 'default'}
                            <td>
                                <div class="tag-list">
                                    <span class="" style="background-color:{$tag.color};">
                                        <a href='?cmd=tickets&list=all&filter[tag]="{$tag.tag}"' target="_blank">{$tag.tag}</a>
                                    </span>
                                </div>
                            </td>
                            <td>
                                <a href='?cmd=tickets&list=all&filter[tag]="{$tag.tag}"' target="_blank">{$tag.usage}</a>
                            </td>
                            <td style="width: 180px;" align="right">
                                <a href="#" onclick="editTag({$tag.id}, '{$tag.tag}', '{$tag.color}');return false;" class="btn btn-default btn-sm">Edit</a>
                                <a href="#" onclick="archiveTag({$tag.id});return false;" class="btn btn-default btn-sm" style="color: red;">Archive</a>
                            </td>
                        {elseif $action == 'archived'}
                            <td><div class="tag-list"><span class="" style="background-color:{$tag.color};">{$tag.tag}</span></div></td>
                            <td>{$tag.who}</td>
                            <td>{$tag.date}</td>
                            <td style="width: 200px;" align="right">
                                <a href="#" onclick="unarchiveTag({$tag.id});return false;" class="btn btn-primary btn-sm">Restore</a>
                                <a href="#" onclick="deleteTag({$tag.id});return false;" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        {/if}
                    </tr>
                    {foreachelse}
                    <tr>
                        <td colspan="7">Nothing to display</td>
                    </tr>
                {/foreach}
                {if !$ajax}
                </tbody>
                <tbody id="psummary">
                <tr>
                    <th colspan="100%">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                    </th>
                </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</div>
{literal}
    <style>
        .tagNav {
            visibility: hidden;
        }
    </style>
{/literal}
{if $action == 'default'}
    <div class="modal fade" tabindex="-1" role="dialog" id="tag-edit">
        <form method="post" onsubmit="editTagSave();return false;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Edit tag</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="colorSelectorID"/>
                        <div class="form-group">
                            <label for="">Tag name</label>
                            <input type="text" id="tagName" class="form-control" placeholder="" value=""/>
                        </div>
                        <div class="form-group">
                            <label for="">Tag color</label>
                            <div class="colorpicker-box">
                                <input type="text" id="colorSelectorINP" class="form-control" placeholder="" value=""/>
                                <div class="colorpicker-box-picker" id="colorSelector"
                                     onclick="$('#colorSelectorINP').click()"></div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Sumbit</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    {literal}
        <style>
            .colorpicker {
                z-index: 10000;
            }

            .colorpicker-box {
                position: relative;
            }

            .colorpicker-box-picker {
                cursor: pointer;
                height: 18px;
                margin: 6px 0 5px 8px;
                width: 18px;
                border-radius: 50%;
                box-shadow: 0 2px 4px rgba(100, 100, 100, .4);
                position: absolute;
                right: 10px;
                top: 0;
                bottom: 0;
            }

            .colorpicker-box-picker:hover {
                box-shadow: 0 2px 6px rgba(100, 100, 100, .4);
            }
        </style>
    {/literal}

    {literal}
        <script>
            var _token = {/literal}'{$security_token}'{literal};
            $('#colorSelector').ColorPicker({
                onSubmit: function (hsb, hex, rgb, el) {
                    $(el).val('#' + hex).ColorPickerHide();
                },
                onChange: function (hsb, hex, rgb) {
                    $('#colorSelector').css('backgroundColor', '#' + hex);
                    $('#colorSelectorINP').val('#' + hex);
                },
                livePreview: true,
            });
            $('#colorSelectorINP').on('input', function () {
                var val = $(this).val();
                $('#colorSelector').css('backgroundColor', val).ColorPickerSetColor(val);
            });
            function editTag(id, name, oldcolor) {
                $('#tag-edit').modal('show');
                $('#tagName').val(name);
                $('#colorSelectorID').val(id);
                $('#colorSelectorINP').val(oldcolor);
                $('#colorSelector').css('backgroundColor', oldcolor).ColorPickerSetColor(oldcolor);
            }
            function editTagSave() {
                $('#updater').addLoader();
                var nm = $('#tagName').val();
                var cl = $('#colorSelectorINP').val();
                var id = $('#colorSelectorID').val();
                $.ajax({
                    type: 'POST',
                    url: '?cmd=tickettags&action=default&make=edit&security_token=' + _token,
                    data: {
                        color: cl,
                        tag: nm,
                        id: id
                    },
                    success: function (data) {
                        parse_response(data);
                        $('#updater').html(data);
                        $('#tag-edit').modal('hide');
                    }
                });
            }
            function archiveTag(tag_id) {
                if (!confirm('Are you sure?'))
                    return false;
                $('#updater').addLoader();
                $.ajax({
                    type: 'POST',
                    url: '?cmd=tickettags&action=default&make=archive&security_token=' + _token,
                    data: {
                        id: tag_id
                    },
                    success: function (data) {
                        parse_response(data);
                        $('#updater').html(data);
                    }
                });
            }
        </script>
    {/literal}
{elseif $action == 'archived'}
    {literal}
        <script>
            var _token = {/literal}'{$security_token}'{literal};
            function unarchiveTag(tag_id) {
                if (!confirm('Are you sure?'))
                    return false;
                $('#updater').addLoader();
                $.ajax({
                    type: 'POST',
                    url: '?cmd=tickettags&action=archived&make=unarchive&security_token=' + _token,
                    data: {
                        id: tag_id
                    },
                    success: function (data) {
                        parse_response(data);
                        $('#updater').html(data);
                    }
                });
            }
            function deleteTag(tag_id) {
                if (!confirm('Are you sure?'))
                    return false;
                $('#updater').addLoader();
                $.ajax({
                    type: 'POST',
                    url: '?cmd=tickettags&action=archived&make=delete&security_token=' + _token,
                    data: {
                        id: tag_id
                    },
                    success: function (data) {
                        parse_response(data);
                        $('#updater').html(data);
                    }
                });
            }
        </script>
    {/literal}
{/if}
{/if}