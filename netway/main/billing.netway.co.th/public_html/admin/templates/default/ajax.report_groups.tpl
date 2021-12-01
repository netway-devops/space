<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
<div class="nicerblu">
    <table border="0" cellspacing="0" cellpadding="6" width="100%">
        <tr>
            <td width="33%" valign="top">
                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable" >
                    <tbody>
                    <tr>
                        <th align="left" colspan="2"><b>Current report groups</b></th>
                    </tr>
                    </tbody>
                </table>

                <form id="serializeit" action="" method="post">
                    <input type="hidden" name="make" value="sortorder" />
                    <ul id="grab-sorter">
                        {foreach from=$groups item=group name=scloop}
                            {if !($status.options & 4)}
                                <li>
                                    <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd; border-top:none;" class="whitetable">
                                        <tr >
                                            <td width="20">
                                                <a class="sorter-handle">move</a><input type="hidden" value="{$group.name}" name="sort[]">
                                            </td>
                                            <td>
                                                <span class="group_span span_{$group.name|replace:' ':''}">{$group.name}</span>
                                                {if ($group.options & 1)}
                                                    <input style="display: none;" class="group_name group_{$group.name|replace:' ':''}" type="text" max="32" value="{$group.name}" name="name" required disabled>
                                                {/if}
                                            </td>
                                            <td width="52" class="lastitm">
                                                {if ($group.options & 1)}
                                                    <div class="btn-group">
                                                        <a onclick="return editGroup(this, '{$group.name}')" style="min-width: 23px;"
                                                           class="btn btn-xs btn-primary" href="#"><i class="fa fa-pencil"></i></a>
                                                        <a onclick="return confirm('Do you really want to delete this group?')" class="btn btn-xs btn-danger" style="min-width: 23px;"
                                                           href="?cmd=reports&action=groups&make=delete&security_token={$security_token}&group={$group.name}"><i class="fa fa-times"></i></a>
                                                    </div>
                                                {/if}
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                    {securitytoken}
                </form>
            </td>
            <td valign="top">
                <div class="blank_state blank_news" id="blank_state" style="padding:0px 0px">
                    <div class="blank_info">
                        <h1>Add report group</h1>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="p6" id="new_status">
                    <div class="content">
                        <form id="serializeit" action="" method="post" style="padding: 20px;">
                            <input type="hidden" name="make" value="addgroup" />
                            <div class="form-group">
                                <label>Group name</label>
                                <input type="text" max="32" class="form-control" name="name" required>
                            </div>
                            <input type="submit" class="submitme add btn btn-sm btn-success" value="Create new group">
                            {securitytoken}
                        </form>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>

{literal}
<script type="text/javascript">
    $("#grab-sorter").dragsort({dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>"});
    function saveOrder() {
        var sorts = $('#serializeit').serialize();
        ajax_update('?cmd=reports&action={/literal}{$action}{literal}&' + sorts, {});
    }
    function editGroup(self, name) {
        var div_name = name.replace(/\s+/g, ''),
            group = $('.group_' + div_name);
        if ($(self).hasClass('btn-success')) {
            $(self).parents('form').first().addLoader();
            $.post('?cmd=reports&action=groups&make=edit', {
                old_name: name,
                new_name: group.val()
            }, function (result) {
                parse_response(result);
                $('.sectioncontent').html(result);
            })
        }
        group.prop('disabled', false).show();
        $('.span_' + div_name).hide();
        $(self).removeClass('btn-primary').addClass('btn-success');
        $(self).find('i').first().removeClass('fa-pencil').addClass('fa-check')
    }
</script>
{/literal}