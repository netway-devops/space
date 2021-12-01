<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="{if  !$picked_tab}active{/if}">
                <a href="?cmd=ticketbans&picked_tab=0"><span class="ico money">Pre {$lang.filters}</span></a>
            </li>
            <li class="{if  $picked_tab == 1}active{/if} last">
                <a href="?cmd=ticketbans&picked_tab=1"><span class="ico plug">Post {$lang.filters}</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2">
        {if $action!='add' && $action!='edit'}

        <div class="navsubmenu haveitems">
            <ul>
                <li class="list-2elem"><a href="?cmd={$cmd}&action=add&type=pre" ><span>Add Pre Filter</span></a></li>
            </ul>
        </div>
        <div class="navsubmenu haveitems" style="display:none">
            <ul>
                <li class="list-2elem"><a href="?cmd={$cmd}&action=add" ><span>Add Post Filter</span></a></li>
            </ul>
        </div>

        {/if}
    </div>
</div>


{if $action=='add' || $action=='edit'}
    <script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js?v={$hb_version}"></script>
    {literal}
        <style>
            .last .join_type, .addcond{
                visibility: hidden;
            }
            .last .addcond{
                visibility: visible;
            }
            .join_type img{
                padding: 0 5px 0 0;
                vertical-align: sub;
            }
            .last .join_type div{
                display: none;
            }
            .join_type div{
                position: relative;
                top:16px;
                width: 50px
            }
        </style>
        <script type="text/javascript">
            $(function () {
                $('textarea.inp').elastic();
                $('input[name="join_type"]').change(function () {
                    if ($(this).val() == 'any')
                        var tt = '{/literal}{$lang.Or|upper}';
                                    else
                                        var tt = '{$lang.And|upper}{literal}';
                                    $('.join_type div span').text(tt);
                                });
                            });
                            function span_new_condition(ele) {
                                $(ele).parent().parent().removeClass('last').clone().addClass('last').find('select,input,textarea').val('').end().insertAfter($(ele).parent().parent());
                                if ($('.menuitm').length > 1)
                                    $('.menuitm').removeClass('disabled');

                                return false;
                            }
                            function rem_condition(ele) {
                                if ($(ele).hasClass('disabled'))
                                    return false;
                                $(ele).parent().parent().remove();
                                $('#condtable tr').removeClass('last').filter(':last').addClass('last');
                                if ($('.menuitm').length < 2)
                                    $('.menuitm').addClass('disabled');
                                return false;
                            }
        </script>
    {/literal}
    <form method="post" action="">
        <div class="nicerblu">
            <table cellpadding="10" cellspacing="0" >
                <tbody>

                    <tr class="bordme">
                        <td colspan="2"style="text-align: right; width:140px" >{$lang.Name}</td>
                        <td colspan="4"><input class="inp" name="name" value="{$filter.name}" style="width: 100%" /></td>
                    </tr>
                    <tr  class="bordme">
                        <td colspan="2" style="text-align: right">{$lang.match}</td>
                        <td colspan="4">
                            <label><input {if $filter.join_type == 'all'}checked="checked"{/if} type="radio" name="join_type" value="all" /> {$lang.All}</label> 
                            <label><input {if $filter.join_type == 'any' || !$filter.join_type}checked="checked"{/if} type="radio" name="join_type" value="any" /> {$lang.Any}</label>
                                {if $pre}
                                <input type="hidden" name="final" value="1" />
                            {/if}
                        </td>
                    </tr>
                    {if !$pre}
                        <tr  class="bordme">
                            <td colspan="2" style="text-align: right">{$lang.final} <a href=#" class="vtip_description" title="{$lang.final_desc}"></a></td>
                            <td colspan="4">
                                <label><input {if $filter.final == '1'}checked="checked"{/if} type="radio" name="final" value="1" /> {$lang.Yes} </label> 
                                <label><input {if !$filter.final}checked="checked"{/if} type="radio" name="final" value="0" /> {$lang.No}</label>
                            </td>
                        </tr>
                    {/if}
                </tbody>
                <tbody id="condtable">
                    <tr>
                        <td colspan="6"><h3>{$lang.If|upper}:</h3></td>
                    </tr>
                    {if $filter.items}
                        {foreach from=$filter.items item=item name=loop}
                            <tr {if $smarty.foreach.loop.last}class="last"{/if}>
                                <td style="width:30px; vertical-align: top;">
                                    <a class="menuitm" href="#" onclick="return rem_condition(this)"><span class="delsth"></span></a>
                                </td>
                                <td style="vertical-align: top;">
                                    <select class="inp" name="item_field[]">
                                        {foreach from=$fields item=name key=field}
                                            <option {if $field == $item.field}selected="selected"{/if} value="{$field}">{$name}</option>
                                        {/foreach}
                                    </select>
                                </td>
                                <td style="vertical-align: top;">
                                    <select class="inp" name="item_type[]">
                                        <option {if "contains" == $item.type}selected="selected"{/if} value="contains">{$lang.Contains}</option>
                                        <option {if "match" == $item.type}selected="match"{/if} value="match">{$lang.exact_match}</option>
                                        <option {if "regexp" == $item.type}selected="regexp"{/if} value="regexp">{$lang.regex}</option>
                                    </select>
                                </td>
                                <td style="vertical-align: top;">
                                    <textarea class="inp" style="width:500px; height:17px; box-sizing: content-box;" name="item_content[]">{$item.content|escape}</textarea>
                                </td>
                                <td class="join_type"><div><img src="{$template_dir}/img/arrow.png" /><span>{if $filter.join_type == 'any' || !$filter.join_type}{$lang.Or|upper}{else}{$lang.And|upper}{/if}</span></div></td>
                                <td colspan="6">
                                    <button class="addcond  btn btn-info btn-sm" onclick="return span_new_condition(this)">
                                        Add next
                                    </button>
                                </td>
                            </tr>
                        {/foreach}
                    {else}
                        <tr class="last">
                            <td style="width:30px; vertical-align: top;">
                                <a class="menuitm disabled" href="#" onclick="return rem_condition(this)"><span class="delsth"></span></a>
                            </td>
                            <td style="vertical-align: top;">
                                <select class="inp" name="item_field[]">
                                    {foreach from=$fields item=name key=field}
                                        <option {if $field == $item.field}selected="selected"{/if} value="{$field}">{$name}</option>
                                    {/foreach}
                                </select>
                            </td>
                            <td style="vertical-align: top;">
                                <select class="inp" name="item_type[]">
                                    <option {if "contains" == $item.type}selected="selected"{/if} value="contains">{$lang.Contains}</option>
                                    <option {if "match" == $item.type}selected="match"{/if} value="match">{$lang.exact_match}</option>
                                    <option {if "regexp" == $item.type}selected="regexp"{/if} value="regexp">{$lang.regex}</option>
                                </select>
                            </td>
                            <td style="vertical-align: top;">
                                <textarea class="inp" style="width:500px; height:17px; box-sizing: content-box;" name="item_content[]">{$item.content|escape}</textarea>
                            </td>
                            <td class="join_type"><div><img src="{$template_dir}/img/arrow.png" /><span>{if $filter.join_type == 'any' || !$filter.join_type}{$lang.Or|upper}{else}{$lang.And|upper}{/if}</span></div></td>
                            <td colspan="6">
                                <button class="addcond  btn btn-info btn-sm" onclick="return span_new_condition(this)">
                                    Add next
                                </button>
                            </td>
                        </tr>
                    {/if}
                </tbody>
                <tbody>
                    <tr>
                        <td colspan="6"><h3>{$lang.Action}</h3></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            {if $pre}
                                <strong>When matched: {$lang.rejectmsg}</strong>
                            {else}

                                <div class="form-group">
                                    <label>When matched: {$lang.applymacro}</label>
                                    <select name="macro_id" class="form-control">
                                        <option value="0" > -- </option>
                                        {foreach from=$macros item=macro}
                                            <option {if $filter.macro_id == $macro.id}selected="selected"{/if} value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
                                        {/foreach}
                                        {*}<option value="add">{$lang.newmacro}</option> {*}
                                    </select>
                                </div>
                            {/if}
                        </td>
                    </tr>
                </tbody>
            </table>

        </div>

        <div class="blu">
            <a href="?cmd=ticketbans{if !$pre}&tab=1{/if}"  class="tload2"><strong>&laquo; {$lang.backtolisting}</strong></a>
            <input type="submit" value="{if $action=='add'}{$lang.Add}{else}{$lang.savechanges}{/if}" name="save" style="font-weight:bold" class="btn btn-primary btn-sm btn-save"/>
            <input type="submit" name="cancel" value="{$lang.Cancel}"  class="btn btn-default btn-sm" />
        </div>
        {securitytoken}
    </form>	
{else}

    <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
    {literal}
        <style>
            a.sorter-handler{
                cursor:n-resize
            }
            a.sorter-handler:active{
                border-color:#B0B0B0!important;
                background:#f2f2f2!important
            }
            ul.grab-sorter{
                border:solid 1px #ddd;
                border-bottom:none;
                position: relative;
            }
            ul.grab-sorter li{
                border-bottom:solid 1px #ddd;
                clear: both;
                background: #fff;
                width: 100%
            } 

            ul.grab-sorter li div{
                float:left;
                padding: 10px 5px;
            }

            ul.grab-sorter li:after{
                content: ".";
                display: block;
                clear: both;
                visibility: hidden;
                line-height: 0;
                height: 0;
            }
            ul.grab-sorter li div.lastitm{
                width:150px;
                float:right;
                padding: 3px 5px;
                background:#F0F0F3;
                color:#767679;
            }
            ul.grab-sorter li div.actions{
                height: 15px;
                width: 120px;
            }
            ul.grab-sorter li:hover div.lastitm, ul.grab-sorter li:hover{
                background: #FFFED1;
            }
            ul.grab-sorter li.placeHolder{
                height:35px;
                border:dashed 1px #999
            }
        </style>
        <script type="text/javascript">
            $(function () {
                $(".grab-sorter").dragsort({
                    dragSelector: "a.sorter-handler",
                    dragBetween: false,
                    itemSelector: 'li',
                    placeHolderTemplate: "<li class='placeHolder'></li>",
                    dragEnd: set_sort
                });
            });
            function set_sort(){
            var list = $(this).parents(".grab-sorter");
                var len = list.find('.sort-order').length;
                list.find('.sort-order').each(function(i){
            $(this).val(len - i);
            });
                ajax_update("{/literal}?cmd={$cmd}&action={$action}&make=sort{literal}&" + list.find('.sort-order').serialize(), {}, false);
            }
            $('#newshelfnav').TabbedMenu({elem:'.sectioncontent', picker:'.list-1 li', aclass:'active'{/literal}{if $picked_tab}, picked:'{$picked_tab}'{/if}{literal}});
             $('#newshelfnav').TabbedMenu({elem:'.navsubmenu', picker:'.list-1 li', aclass:'active'{/literal}{if $picked_tab}, picked:'{$picked_tab}'{/if}{literal}});
        </script>
    {/literal}
    <form method="post" >
        <div class="nicerblu">
            <div {if $picked_tab}style="display: none"{/if} class="sectioncontent">
                {if $filters_pre}
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <strong>Pre filters</strong> are checked for each imported email and new tickets created by clients. You can use it to reject tickets that match defined rules.
                        </div>
                    </div>
                    <ul class="grab-sorter">
                        {foreach from=$filters_pre item=filter name=loop}
                            <li class="{if $smarty.foreach.loop.index%2==0}even{/if}">
                                <div class="actions">
                                    <input type="hidden" name="order[{$filter.id}]" value="{$filter.sort_order}" class="sort-order"/>
                                    <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                                        <span class="movesth" title="move">&nbsp;</span>
                                    </a>
                                    <a title="edit" href="?cmd={$cmd}&action=edit&id={$filter.id}" class="menuitm menu-auto">
                                        <span class="editsth"></span>
                                    </a>
                                    <a onclick="return confirm('Are you sure you wish to remove this item?');" 
                                       href="?cmd={$cmd}&action={$action}&make=delete&id={$filter.id}&security_token={$security_token}" 
                                       title="delete" class="menuitm menu-auto">
                                        <span class="delsth"></span>
                                    </a>    
                                </div>
                                <div class="name">{$filter.name}</div>
                                <div class="lastitm fs11">
                                    {$lang.match}: <b>
                                        {if $filter.join_type == 'any'}{$lang.Any}
                                        {else}{$lang.All}
                                        {/if}
                                    </b><br />
                                    {$lang.final}: <b>
                                        {if $filter.final}{$lang.Yes}
                                        {else}{$lang.No}
                                        {/if}
                                    </b>
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                {else}
                    <div class="blank_state blank_news">
                        <div class="blank_info">
                            <h1>{$lang.blank_pre_header}</h1>
                            {$lang.blank_pre_desc}
                            <div class="clear"></div>
                            <a class="new_add new_menu" href="?cmd=ticketbans&action=add&type=pre" style="margin-top:10px">
                                <span>{$lang.addprefilter}</span></a>
                            <div class="clear"></div>
                        </div>
                    </div>
                {/if}
            </div>
            <div class="sectioncontent" {if !$picked_tab}style="display: none"{/if}>

                {if $filters_post}
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <strong>Post filters</strong> are executed for all imported tickets, new tickets created by clients and after each client reaply.
                            You can use filters to run macros to automatically set things like assigned staff member, tags, priority and more.
                        </div>
                    </div>
                    <ul class="grab-sorter">
                        {foreach from=$filters_post item=filter name=loop}
                            <li class="{if $smarty.foreach.loop.index%2==0}even{/if}">
                                <div class="actions">
                                    <input type="hidden" name="order[{$filter.id}]" value="{$filter.sort_order}" class="sort-order"/>
                                    <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                                        <span class="movesth" title="move">&nbsp;</span>
                                    </a>
                                    <a title="edit" href="?cmd={$cmd}&action=edit&id={$filter.id}" class="menuitm menu-auto">
                                        <span class="editsth"></span>
                                    </a>
                                    <a onclick="return confirm('{$lang.removeruleconfirm}');" 
                                       href="?cmd={$cmd}&action={$action}&tab=1&make=delete&id={$filter.id}&security_token={$security_token}" 
                                       title="delete" class="menuitm menu-auto">
                                        <span class="delsth"></span>
                                    </a>    
                                </div>
                                <div class="name">{$filter.name}</div>
                                <div class="lastitm fs11">
                                    {$lang.match}: <b>
                                        {if $filter.join_type == 'any'}{$lang.Any}
                                        {else}{$lang.All}
                                        {/if}
                                    </b>
                                    <br />
                                    {$lang.final}: <b>
                                        {if $filter.final}{$lang.yes}
                                        {else}{$lang.no}
                                        {/if}
                                    </b>
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                {else}
                    <div class="blank_state blank_news">
                        <div class="blank_info">
                            <h1>{$lang.blank_post_header}</h1>
                            <strong>Post filters</strong> are executed for all imported tickets, new tickets created by clients and after each client reaply.
                            You can use filters to run macros to automatically set things like assigned staff member, tags, priority and more.
                            <div class="clear"></div>
                            <a class="new_add new_menu" href="?cmd=ticketbans&action=add" style="margin-top:10px">
                                <span>{$lang.addpostfilter}</span>
                            </a>
                            <div class="clear"></div>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
    </form>

{/if}