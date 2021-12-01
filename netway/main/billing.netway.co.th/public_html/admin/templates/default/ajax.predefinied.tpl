
{if $action == 'getmacros'}
    {if $replies}
        {foreach from=$replies item=reply key=k}
            <li><a href="{$reply.id}">{$reply.name|escape}</a></li>
        {/foreach}
    {/if}
{elseif $action=='getcat'}
    {if $category.name}
        <div class="hitarea collapsable-hitarea "></div>
        <a class="folder" href="?cmd=predefinied&action=getcat&cid={$category.id}">{$category.name|escape}</a>
        <a href="?cmd=predefinied&action=viewcat&cid={$category.id}" class="edit ">{$lang.Edit}</a>
        <a href="?cmd=predefinied&action=deletecat&cid={$category.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.removecategoryconfirm}')">{$lang.delete}</a>
        <ul>
            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable{/if}" id="folder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=predefinied&action=getcat&cid={$cat.id}">{$cat.name|escape}</a>
                    </li>
                {/foreach}
            {/if}

            {if $category.replies}
                {foreach from=$category.replies item=rep name=rechecklast}
                    <li class="{if $smarty.foreach.rechecklast.last}last{/if}">
                        <a class="file" href="?cmd=predefinied&action=view&id={$rep.id}">{$rep.name|escape}</a>
                        <a href="?cmd=predefinied&action=deletereply&id={$rep.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.removereplyconfirm}')">{$lang.delete}</a>
                        {$rep.reply}
                    </li>
                {/foreach}
            {/if}
        </ul>
        <script type="text/javascript">bindPredefinied();</script>
    {/if}
{elseif $action=='getcat2'}
    {if $category.name}
        <div class="hitarea collapsable-hitarea "></div>
        <a class="folder" href="?cmd=predefinied&action=getcat2&cid={$category.id}">{$category.name|escape}</a>
        <ul>
            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable{/if}" id="folder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=predefinied&action=getcat2&cid={$cat.id}">{$cat.name|escape}</a>
                    </li>
                {/foreach}
            {/if}

            {if $category.replies}
                {foreach from=$category.replies item=rep name=rechecklast}
                    <li class="{if $smarty.foreach.rechecklast.last}last{/if}">
                        <a class="file fil2" href="?cmd=predefinied&action=getmacro&id={$rep.id}">{$rep.name|escape}</a> {$rep.reply|escape}
                    </li>
                {/foreach}
            {/if}
        </ul>

        {literal}
        <script type="text/javascript">
            bindPredefinied();
            $('a.fil2','#suggestion').unbind('click').bind('click',function(){
                predef_macro(this);
                return false;
            });
        </script>
        {/literal}
    {/if}
{elseif $action=='getr'}{*
    *}{$reply}{*
*}{elseif $action=='new' || $action=='view'}
    {include file='support/macros/menu.tpl'}

{literal}
        <style>
            .action-label{
                display:block;
                padding: 0 0 4px;
            }
            .action-label span{

                float:left;
                width: 30%;
            }
        </style>
    {/literal}
    <form action="?cmd={$cmd}&action={$action}{if $action=='view'}&id={$reply.id}{/if}" method="post" >
        <input type="hidden" name="make" value="{if $action=='view'}update{else}add{/if}" />
    {if $reply.mine}
        <input type="hidden" value="1" name="mine" />
    {/if}
    <div class="nicerblu" style="padding:10px;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <div class="form-group">
                        <label>{$lang.Category}</label>
                        <select name="category_id" id="catpicker" class="form-control">
                            {foreach from=$categories item=cat}
                                <option value="{$cat.id}" {if $reply.category_id==$cat.id || $parent_category_id == $cat.id}selected="selected"{/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name|escape} </option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>{$lang.Name}</label>
                        <input type="text" name="name" value="{$reply.name|escape}" class="form-control"/>
                    </div>
                    <div class="form-group">

                        <input type="checkbox" id="add-reply" {if $reply.reply}checked="checked"{/if}>
                        <label>Add a reply to ticket</label>
                    </div>
                    <div class="form-group">
                        <label>Reply</label>
                        <textarea class="form-control" rows="12"  name="reply">{$reply.reply|escape}</textarea>
                    </div>
                    <div class="form-group">

                        <input type="checkbox" id="add-admin_note" {if $reply.admin_note}checked="checked"{/if}>
                        <label>Add a note to ticket</label>
                    </div>
                    <div class="form-group">
                        <label>Note</label>
                        <textarea class="form-control" rows="12"  name="admin_note">{$reply.admin_note|escape}</textarea>
                    </div>
                    <div class="form-group">
                        <label>Notifications</label>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="notify" value="1" {if $reply.notify}checked="checked"{/if}>
                                Send email notifications about Ticket reply
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="sub_notify" value="1" {if $reply.sub_email != 0}checked="checked"{/if}>
                                Send email to subscribed staff members
                            </label>
                        </div>
                        <div id="select-template">
                            <select name="sub_email" class="form-control chosen">
                                {foreach from=$email_templates item=template key=group}
                                    <optgroup label="{$group}">
                                        {foreach from=$template item=tpl}
                                            <option value="{$tpl.id}" {if $reply.sub_email == $tpl.id}selected{/if}>{$tpl.tplname}</option>
                                        {/foreach}
                                    </optgroup>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <label>{$lang.availactions}</label>

                    <div class="form-group">
                        <span>{$lang.changestatus}:</span>
                        <select name="status" class="form-control">
                            <option value="">{$lang.nochange}</option>
                            {foreach from=$statuses item=status}
                                <option value="{$status}"
                                        {if $status==$reply.status}selected="selected"{/if}>{$lang.$status}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group">
                        <label>{$lang.changepriority}</label>
                        <select name="priority" class="form-control">
                            <option value="">{$lang.nochange}</option>
                            <option {if $reply.priority == '0'}selected="selected"{/if} value="0">{$lang.Low}</option>
                            <option {if $reply.priority == '1'}selected="selected"{/if} value="1">{$lang.Medium}</option>
                            <option {if $reply.priority == '2'}selected="selected"{/if} value="2">{$lang.High}</option>
                        </select>

                    </div>

                    <div class="form-group">
                        <label>{$lang.changedept}</label>
                        <select name="deptid" class="form-control">
                            <option value="">{$lang.nochange}</option>
                            {foreach from=$depts item=dept}
                                {if $dept.id == '0' || !isset($dept.sorti)}{continue}{/if}
                                <option {if $reply.deptid == $dept.id}selected="selected"{/if} value="{$dept.id}">{$dept.name}</option>
                            {/foreach}
                        </select>

                    </div>

                    <div class="form-group">
                        <label>{$lang.assignto}</label>
                        <select name="owner" class="form-control">
                            <option value="">{$lang.nochange}</option>
                            {foreach from=$staff_members item=stfmbr}
                                <option {if $reply.owner == $stfmbr.id}selected="selected"{/if}
                                        value="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Add to subscriber list</label>
                        <select name="subscribers[]" class="form-control chosen" multiple>
                            {foreach from=$staff_members item=stfmbr}
                                <option {if in_array($stfmbr.id, $reply.subscribers)}selected="selected"{/if}
                                        value="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tags to add</label>
                        <div class="clearfix">
                            <div id="tagsInput" class="tag-form" data-tags="{$reply.tags|@json_encode|escape}"></div>
                            <div id="tags" style="display: none"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Tags to remove</label>
                        <div class="clearfix">
                            <div id="tagsInput2" class="tag-form" data-tags="{$reply.tags_rem|@json_encode|escape}"></div>
                            <div id="tags2" style="display: none"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="blu">
        <a href="?cmd={$cmd}"  class="tload2"><strong>&laquo; {$lang.backtolisting}</strong></a>
        <button type="submit" class="btn btn-success">{if $action=='view'}{$lang.savechanges}{else}{$lang.addmacro}{/if}</button>
        <span class="orspace">{$lang.Or}</span> <a class="editbtn"  href="?cmd=predefinied">{$lang.Cancel}</a>
    </div>
    {literal}
        <script type="text/javascript">
            $(function () {
                $('.tag-form').hbtags()
                    .on('tags.add', function (e,tag) {
                        var name = $(this).is('#tagsInput2') ? 'tags_rem' : 'tags';
                        $(this).next().append('<input type="hidden" name="'+name+'[]" value="' + tag + '" />')
                    })
                    .on('tags.rem', function (e,tag) {
                        $(this).next().find('input[value="' + tag + '"]').remove();
                    })

                $('#tagsBox').on('tag.update', function (ev, tags) {
                    $('.tag-form').each(function () {
                        $(this).data('hbtags').suggestions = tags.map(function (x) {
                            return x.tag;
                        })
                    })
                });
                add_textarea('reply',true);
                add_textarea('admin_note',true);
                add_sub_email(true);
            });
            function add_textarea(type = 'reply', ready) {
                var add = $('#add-'+type).prop('checked'),
                    textarea = $('textarea[name="'+type+'"]'),
                    reply = textarea.parents('div .form-group');
                if (add === true) {
                    reply.slideDown();
                    var value = textarea.data('value');
                    if (value)
                        textarea.val(textarea.data('value'));
                } else {
                    if (ready)
                        reply.hide();
                    reply.slideUp();
                    textarea.data('value', textarea.val());
                    textarea.val('');
                }
            }
            function add_sub_email(ready) {
                var checkbox = $('input[name="sub_notify"]').prop('checked'),
                    select = $('#select-template');
                if (checkbox === true) {
                    select.slideDown("fast");
                } else {
                    if (ready)
                        select.hide();
                    select.slideUp("fast");
                }
            }
            $('#add-reply').on('change', function () {
                add_textarea('reply', false);
            });
            $('#add-admin_note').on('change', function () {
                add_textarea('admin_note', false);
            });
            $('input[name="sub_notify"]').on('change', function () {
                add_sub_email(false);
            });

            $('.chosen').chosenedge({
                enable_split_word_search: true,
                search_contains: true,
            }).on('change', function (e, data) {
                var select = $(this),
                    values = select.val();
                select.val(values).trigger('chosen:updated');
            });
        </script>
    {/literal}
    {securitytoken}
</form>
{elseif $action=='get_tree' || $action == 'gettop' || $action=='browser'}
    {literal}
        <script>
            function macroTrigger(macro) {
                if (macro.errors != undefined){
                    //handle errors;
                }else{
                    if(macro.priority != undefined && macro.priority != null){
                        switch(macro.priority){
                            case '0': var prio = 'Low'; break;
                            case '1': var prio = 'Medium'; break;
                            case '2': var prio = 'High'; break;
                        }
                        $('#ticketbody h1').attr('class','').addClass('prior_'+prio);
                        $.post('?cmd=tickets&action=menubutton&make=setpriority',{id:$('#ticket_number').val(),priority:prio});
                    }
                    if (macro.deptid != undefined && macro.deptid != null) {
                        $.post('?cmd=tickets&action=menubutton&make=edit_ticket',{ticket_number:$('#ticket_number').val(),deptid:macro.deptid},function () {
                            var sel = $('select[name=deptid]');
                            sel.val(macro.deptid);
                            $('#ticket_dept').text(sel.find('option:selected').text());
                        });
                    }
                    if (macro.subscribers != undefined) {
                        $.each(macro.subscribers, function (i, value) {
                            $.post('?cmd=tickets&action=menubutton&make=assign',{tnum:$('#ticket_number').val(),id:value + ":1"})
                        });
                    }
                    if (macro.sub_email != 0) {
                        $.post('?cmd=predefinied&action=send_message',{ticket:$('#ticket_number').val(),macro:macro.id});
                    }
                    if(macro.status != undefined && macro.status != null){
                        $('select[name="status_change"]').val(macro.status);
                    }
                    if(macro.owner != undefined && macro.owner != null){
                        if($('select[name="owner"]').children('[value="'+macro.owner+'"]').length){
                            var txt = $('select[name="owner"]').children('[value="'+macro.owner+'"]').text();
                            $('select[name="owner"]').val(macro.owner).prev().text(txt);
                            $('#hd6 span').text('Assigned to '+txt)
                        }
                    }
                    if(macro.tags != undefined && macro.tags != null && macro.tags.length){
                        $('#tagsCont').each(function () {
                            //create ticket interface does not have #tagsCont
                            $(this).data('hbtags').insertTags(macro.tags)
                        });
                    }
                    if(macro.tags_rem != undefined && macro.tags_rem != null && macro.tags_rem.length){
                        $('#tagsCont').each(function () {
                            //create ticket interface does not have #tagsCont
                            $(this).data('hbtags').removeTags(macro.tags_rem);
                        });
                    }
                    if(macro.reply != undefined && macro.reply != null && macro.reply.length){
                        if(macro.note != undefined && macro.note != null && parseInt(macro.note) == 1){
                            $('a[name="notes"]').click();
                            var reply = $('#ticketnotesarea').val().length ? $('#ticketnotesarea').val()+ "\r\n"  : '';
                            $('#ticketnotesarea').val(reply + macro.reply).focus();
                        }else{
                            var reply = $('#replyarea').val().length ? $('#replyarea').val() + "\r\n": '';
                            $('#replyarea').val(reply + macro.reply).focus();
                        }
                    }
                    if(macro.admin_note != undefined && macro.admin_note != null && macro.admin_note.length) {
                        if ($('#ticketnotesarea').is(':hidden')) {
                            $('#LeaveNotes').click();
                        }
                        var note = $('#ticketnotesarea').val().length ? $('#ticketnotesarea').val()+ "\r\n"  : '';
                        $('#ticketnotesarea').val(note + macro.admin_note).focus();
                    }
                }
            }
        </script>
    {/literal}
    {if $action == 'gettop'}
        <div id="replybrocontainer">
            {if $replies}
                <div class="pull-right fs11" ><a href="?cmd=predefinied&action=myreplies" target="_blank" class="editbtn" >{$lang.manageyour}</a></div>
                {foreach from=$replies item=reply key=k}
                    <div class="replyget">
                        <a href="?cmd={$cmd}&action=getmacro&id={$reply.id}" title="{$reply.name|escape}" class="replyget-link">
                            <i class="fa fa-info"></i>
                            <span>{$reply.name|truncate:100|escape}</span>
                        </a>
                        <a href="?cmd=predefinied&action=view&id={$reply.id}" target="_blank" class="edit">edit</a>
                        <div class="replyget-description"><small>{$reply.reply|truncate:100|escape}</small></div>
                    </div>
                {/foreach}
            {else}
                <span class="text-center"> {$lang.blank_kb2} <a href="?cmd={$cmd}&action=myreplies" target="_blank" >{$lang.heretoadd}</a></span>
            {/if}
        </div>
        {literal}
            <style>
                .replyget {
                    background-color: transparent !important;
                    padding: 7px !important;
                    border-bottom: 1px solid #eee;
                }
                .replyget:hover {
                    background: #eee !important;
                }
                .replyget a {
                    display: inline-block !important;
                }
                .replyget a.replyget-link {
                    color: #1C4257;
                    text-decoration: none !important;
                }
                .replyget a.replyget-link i.fa {
                    border-bottom: none;
                    margin-right: .5em;
                    color: #333;
                    display: inline-block !important;
                    text-decoration: none;
                    vertical-align: middle;
                }
                .replyget a.edit {
                    margin-left: 5px;
                    font-size: 10px;
                }
                .replyget .replyget-description {
                    color: #888;
                    font-size: 11px;
                    margin-left: 13px;
                }
            </style>
            <script>
                $('.replyget','#replybrocontainer').on('click',function(e){
                    e.preventDefault();
                    $.post($(this).find('a').attr('href'),{}, function(resp){
                        if (typeof resp == 'object' && typeof resp.macro == 'object')  {
                            macroTrigger(resp.macro);
                        }
                    });
                    return false;
                }).on('click','.edit',function(e) {
                    e.stopPropagation();
                });
            </script>
        {/literal}
    {elseif $action == 'get_tree' || $action == 'browser'}
        <link rel="stylesheet" href="{$template_dir}js/tree/jqtree.css?v={$hb_version}">
        <script type="text/javascript" src="{$template_dir}js/tree/tree.jquery.js?v={$hb_version}"></script>
        <input type="text" id="jqitems_pr-search" class="input-sm jqitems-search" placeholder="Search..." >
        <div class="jqitems-tree"></div>
        {literal}
            <script>
                //retrieve data
                function retrieveData() {
                    $.ajaxSetup({async:false});
                    var returnData = null;
                    $.post('?cmd=predefinied&action=get_tree&only_data=true',{},function (d) {returnData = d;});
                    $.ajaxSetup({async:true});
                    return $.parseJSON(returnData);
                }

                var tree = $('.jqitems-tree'),
                    filter = $('#jqitems_pr-search'),
                    state = null,
                    thread = null,
                    _filtering = false,
                    data = retrieveData();

                tree.tree({
                    data: data,
                    dragAndDrop: true,
                    closedIcon: $('<i class="fa fa-folder"></i>'),
                    openedIcon: $('<i class="fa fa-folder-open"></i>'),
                    useContextMenu: false,
                    onCreateLi: function(node, $li) {
                        var search = filter.val().toLowerCase();
                        var icon = '';
                        var html = '';
                        if (search !== '') {
                            $li.hide();
                            if (!node.is_cat) {
                                var value = node.name.toLowerCase();
                                var parent = node.parent;
                                if (value.indexOf(search) > -1) {
                                    $li.show();
                                    $li.find('.jqtree-title').addClass('jqtree-title-active');
                                    while (typeof (parent.element) !== 'undefined') {
                                        tree.tree('openNode', parent);
                                        $(parent.element).show().addClass('jqtree-filtered');
                                        parent = parent.parent;
                                    }
                                }
                                if (!_filtering) {
                                    _filtering = true;
                                }
                                if (!tree.hasClass('jqtree-filtering')) {
                                    tree.addClass('jqtree-filtering');
                                }
                            }
                        } else {
                            if (_filtering) {
                                _filtering = false;
                            }
                            if (tree.hasClass('jqtree-filtering')) {
                                tree.removeClass('jqtree-filtering');
                            }
                        }
                        if (node.is_cat) {
                            icon = '<a class="jqtree-toggler jqtree_common jqtree-toggler-left" role="presentation" aria-hidden="true"><i class="fa fa-folder-open"></i></a>';
                            html += '<a href="?cmd=predefinied&action=viewcat&cid='+ node.item_id +'" target="_blank" class="edit jqtree-element-link">edit</a>';
                            $li.not('.jqtree-folder').find('.jqtree-element').find('.jqtree-toggler').find('i').remove();
                            $li.not('.jqtree-folder').find('.jqtree-element').prepend(icon);
                            $li.find('.jqtree-element').append(html);
                        } else {
                            icon = '<a class="jqtree-toggler jqtree_common jqtree-toggler-left" role="presentation" aria-hidden="true"><i class="fa fa-info"></i></a>';
                            html += '<a href="?cmd=predefinied&action=view&id='+ node.item_id +'" target="_blank" class="edit jqtree-element-link">edit</a>';
                            if (node.reply.length) {
                                html += '<div class="edit jqtree-element-description"><small>'+node.reply+'</small></div>';
                            }
                            $li.find('.jqtree-element').prepend(icon);
                            $li.find('.jqtree-element').append(html);
                        }
                    }
                }).on(
                    'tree.move',
                    function(event) {
                        if (filter.val().toLowerCase() == '') {
                            if (!event.move_info.target_node.is_cat && event.move_info.position  == 'inside')  {
                                event.preventDefault();
                            } else {
                                window.setTimeout(function () {
                                    var json = tree.tree('toJson');
                                    $.post('{/literal}?cmd={$cmd}&action=update_tree{literal}', {tree:json},  function(data){parse_response(data)});
                                }, 200);
                            }
                        } else {
                            event.preventDefault();
                            alert('You can not move items while searching');
                        }
                    }
                ).on(
                    'tree.click',
                    function(event) {
                        var macro = event.node;
                        if (typeof macro == 'object' && $('#ticketbody').length && !macro.is_cat)  {
                            macroTrigger(macro);
                        } else {
                            if (event.click_event.srcElement.classList.contains('jqtree-element-link')){
                                event.click_event.preventDefault();
                                window.open(event.click_event.srcElement.href, '_blank');
                            } else {
                                tree.tree('toggle', event.node);
                            }
                        }
                    }
                ).on(
                    'tree.open',
                    function(e) {
                        if (filter.val().toLowerCase() == '') {
                            state = tree.tree('getState');
                        }
                    }
                ).on(
                    'tree.close',
                    function(e) {
                        if (filter.val().toLowerCase() == '') {
                            state = tree.tree('getState');
                        }
                    }
                );
                filter.keyup(function() {
                    tree.tree('loadData', data);
                    if (filter.val().toLowerCase() == '') {
                        tree.tree('setState', state);
                    }
                });
            </script>
        {/literal}
    {/if}
{elseif $action=='viewcat' || $action=='newcat'}
    {include file='support/macros/menu.tpl'}

    <form action="?cmd={$cmd}&action={$action}{if $action=='viewcat'}&cid={$category.id}{/if}" method="post" >
        {if $action=='viewcat'}
            <input type="hidden" name="make" value="update" />
        {else}
            <input type="hidden" name="make" value="add" />
        {/if}
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <div class="form-group">
                        <label>{$lang.parentcat}:</label>
                        <select name="parent_cat" id="catpicker"  class="form-control">
                            <option value="0">{$lang.topcategory}</option>
                            {foreach from=$categories item=cat}
                                <option value="{$cat.id}" {if $category.parent_cat==$cat.id || $parent_category_id == $cat.id}selected="selected"{/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>{$lang.Name}</label>
                        <input name="name" value="{if $action=='viewcat'}{$category.name}{/if}" class="form-control" type="text" />
                    </div>
                </div>
            </div>
        </div>



        <div class="blu">
            <a href="?cmd={$cmd}"  class="tload2"><strong>&laquo; {$lang.backtolisting}</strong></a>
            {if $action=='viewcat'}
                <button type="submit" class="btn btn-success"><strong>{$lang.savechanges}</strong></button>
            {else}
                <button type="submit" class="btn btn-success"><strong>{$lang.addcat}</strong></button>
            {/if}
            <span class="orspace">{$lang.Or}</span> <a class="editbtn"  href="?cmd=predefinied">{$lang.Cancel}</a>
        </div>
        {securitytoken}
    </form>
{else}
    {include file='support/macros/menu.tpl'}

    {if $category}
        <div class="sectioncontent">
            <div class="nicerblu">
                <h3>Subcategories:</h3>
                <ul class="grab-sorter" data-sort-type="categories">
                    {if $category.categories}
                        {foreach from=$category.categories item=cat name=loop2}
                            <li class="{if $smarty.foreach.loop2.index%2==0}even{/if}">
                                <div class="actions">
                                    <input type="hidden" name="order[{$cat.id}]" value="{$cat.sort_order}" class="sort-order"/>
                                    <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                                        <span class="movesth" title="move">&nbsp;</span>
                                    </a>
                                    <a title="edit" href="?cmd=predefinied&action=viewcat&cid={$cat.id}" class="menuitm menu-auto">
                                        <span class="editsth"></span>
                                    </a>
                                    <a onclick="return confirm('Are you sure you wish to remove this from your list?');"
                                       href="?cmd=predefinied&action=deletecat&cid={$cat.id}&security_token={$security_token}"
                                       title="delete" class="menuitm menu-auto">
                                        <span class="delsth"></span>
                                    </a>
                                </div>
                                <div class="name"><a href="?cmd=predefinied&cid={$cat.id}">{$cat.name|truncate:100|escape}</a></div>
                            </li>
                        {/foreach}
                    {else}
                        <li><div style="float:none; text-align: center">0 subcategories in this category</div></li>
                    {/if}
                </ul>
                <a href="?cmd={$cmd}&action=newcat{if $category.id}&category_id={$category.id}{/if}" class="btn btn-sm btn-default">Add Sub-category</a>
                <br />
            </div>
            <div class="nicerblu">
                <h3><strong>Macros ({$category.replies|@count})</strong></h3>
                <ul class="grab-sorter" data-sort-type="replies">
                    {if $category.replies}
                        {foreach from=$category.replies item=rpl name=loop3}
                            <li class="{if $smarty.foreach.loop.index%2==0}even{/if}">
                                <div class="actions">
                                    <input type="hidden" name="order[{$rpl.id}]" value="{$rpl.sort_order}" class="sort-order"/>
                                    <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                                        <span class="movesth" title="move">&nbsp;</span>
                                    </a>
                                    <a title="edit" href="?cmd={$cmd}&action=view&id={$rpl.id}" class="menuitm menu-auto">
                                        <span class="editsth"></span>
                                    </a>
                                    <a onclick="return confirm('Are you sure you wish to remove this from your list?');"
                                       href="?cmd={$cmd}&action=deletereply&id={$rpl.id}&cid={$category.id}&security_token={$security_token}"
                                       title="delete" class="menuitm menu-auto">
                                        <span class="delsth"></span>
                                    </a>
                                </div>
                                <div class="name">{$rpl.name|truncate:100|escape}</div>
                                <div class="lastitm fs11">
                                    {$lang.Affects}:
                                    <span class="fold-text" style="display: inline-block; vertical-align: text-bottom; width: 100px; padding-left: 5px;"><i>
                                    {if $rpl.reply}{if $rpl.note}{$lang.Note}{else}{$lang.Reply}{/if}{if $rpl.tags || $rpl.Owner || $rpl.priority || $rpl.status}, {/if}{/if}
                                            {if $rpl.tags}{$lang.tags}{if $rpl.Owner || $rpl.priority || $rpl.status}, {/if}{/if}
                                            {if $rpl.owner}{$lang.owner}{if $rpl.priority || $rpl.status}, {/if}{/if}
                                            {if $rpl.priority}{$lang.priority}{if $rpl.status}, {/if}{/if}
                                            {if $rpl.status}{$lang.Status}{/if}
                                        </i></span><br />
                                    {$lang.Usage}: <b>{$rpl.usability}</b>
                                </div>
                            </li>
                        {/foreach}
                    {else}
                        <li><div style="float:none; text-align: center">0 replies in this category</div></li>
                    {/if}
                </ul>
                <a href="?cmd={$cmd}&action=new{if $category.id}&category_id={$category.id}{/if}" class="btn btn-default btn-sm" ><span>{$lang.addmacro}</span></a>
                <br />
            </div>
        </div>

        <div style="display: none" class="sectioncontent">
            <div class="nicerblu">
                <ul class="grab-sorter" data-sort-type="myreplies">
                    {if $myreplies}
                        {foreach from=$myreplies item=reply name=loop}
                            <li class="{if $smarty.foreach.loop.index%2==0}even{/if}">
                                <div class="actions">
                                    <input type="hidden" name="order[{$reply.id}]" value="{$reply.sort_order}" class="sort-order"/>
                                    <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                                        <span class="movesth" title="move">&nbsp;</span>
                                    </a>
                                    <a title="edit" href="?cmd={$cmd}&action=view&id={$reply.id}" class="menuitm menu-auto">
                                        <span class="editsth"></span>
                                    </a>
                                    <a onclick="return confirm('Are you sure you wish to remove this from your list?');"
                                       href="?cmd={$cmd}&action={$action}&make=deletemyreply&reply_id={$reply.id}&security_token={$security_token}"
                                       title="delete" class="menuitm menu-auto">
                                        <span class="delsth"></span>
                                    </a>
                                </div>
                                <div class="name">{$reply.name|truncate:100|escape}</div>
                                <div class="lastitm fs11">
                                    {$lang.Affects}:
                                    <span class="fold-text" style="display: inline-block; vertical-align: text-bottom; width: 100px; padding-left: 5px;"><i>
                                    {if $reply.reply}{if $reply.note}{$lang.Note}{else}{$lang.Reply}{/if}{if $reply.tags || $reply.Owner || $reply.priority || $reply.status}, {/if}{/if}
                                    {if $reply.tags}{$lang.tags}{if $reply.Owner || $reply.priority || $reply.status}, {/if}{/if}
                                    {if $reply.owner}{$lang.owner}{if $reply.priority || $reply.status}, {/if}{/if}
                                    {if $reply.priority}{$lang.priority}{if $reply.status}, {/if}{/if}
                                    {if $reply.status}{$lang.Status}{/if}
                                        </i></span><br />
                                    {$lang.Usage}: <b>{$reply.usability}</b>
                                </div>
                            </li>
                        {/foreach}
                    {else}
                        <li><div style="float:none; text-align: center">Your list is currently empty</div></li>
                    {/if}
                </ul>
                <br />
                {if $allreplies}
                    <form method="post" action="">
                        <input type="hidden" name="tab" value="1" />
                        <input type="hidden" name="make" value="addmyreply"/>
                        <div class="p6">
                            <table cellspacing="0" cellpadding="3">
                                <tbody><tr>
                                        <td>
                                            {$lang.addtoyourlist}:
                                            <select name="reply_id">
                                                {foreach from=$allreplies item=r}
                                                    <option value="{$r.id}">{$r.catname|escape} - {$r.name|escape}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td>
                                            <input type="submit" onclick="" style="font-weight:bold" value="{$lang.Add}">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        {securitytoken}
                    </form>
                {/if}
            </div>
        </div>

        <div style="display: none" class="sectioncontent">
            <div class="nicerblu">
                <div class="tree-block">
                    {literal}
                        <script>
                            ajax_update("{/literal}?cmd={$cmd}&action=get_tree"{literal}, {}, '.tree-block', true);
                        </script>
                    {/literal}
                </div>
            </div>
        </div>

        <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
        {literal}
            <script type="text/javascript">
                $('#newshelfnav').TabbedMenu({
                    elem:'.sectioncontent',
                    picker:'.list-1 li',
                    aclass:'active'
                    {/literal}{if $pickedtab}, picked:'{$pickedtab}'{/if}{literal}
                });
                $('#newshelfnav').TabbedMenu({
                    elem:'.navsubmenu',
                    picker:'.list-1 li',
                    aclass:'active'
                    {/literal}{if $pickedtab}, picked:'{$pickedtab}'{/if}{literal}
                });
                $('#newshelfnav').TabbedMenu({
                    elem:'.breadcrumb',
                    picker:'.list-1 li',
                    aclass:'active'
                    {/literal}{if $pickedtab}, picked:'{$pickedtab}'{/if}{literal}
                });
                $(function(){
                    $(".grab-sorter").dragsort({
                        dragSelector: "a.sorter-handler",
                        dragBetween: false,
                        itemSelector:'li',
                        placeHolderTemplate: "<li class='placeHolder'></li>",
                        dragEnd: set_sort
                    });
                });
                function set_sort(){
                    var list = $(this).parents(".grab-sorter");
                    var len = list.find('.sort-order').length;
                    var sorttype = $(list).attr('data-sort-type');
                    if (!sorttype)
                        sorttype = 'replies';

                    list.find('.sort-order').each(function(i){
                        $(this).val(parseInt(i+1));
                    });

                    ajax_update("{/literal}?cmd={$cmd}&action={$action}&cid={$category.id}&make=sort&type="+sorttype+"{literal}", list.find('.sort-order').serialize(), '#bodycont');
                }
            </script>
        {/literal}
    {else}
        <div class="blank_state blank_kb">
            <div class="blank_info">
                <h1>{$lang.blank_kb}</h1>
                {$lang.blank_kb_desc}
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd=predefinied&action=newcat" style="margin-top:10px">
                    <span>{$lang.addcat}</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{/if}