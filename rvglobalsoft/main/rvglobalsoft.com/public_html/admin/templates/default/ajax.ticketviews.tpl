{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.ticketviews.tpl.php');
{/php}

{if $display == 'theaders'}
    <th width="20"><input type="checkbox" id="checkall"/></th>
    {foreach from=$tview.columns item=col name=columns}
        <th {if $col==32}width="80"{elseif $col==1 || $col==16384 || $col==524288}width="50"{elseif $col==1048576}width="70"{/if} class="tviews view{$col}"  style="white-space: nowrap; overflow: hidden; text-overflow:ellipsis ">
            {assign value=$columns[$col] var=colname}
            <a href="?cmd={$cmd}&tview={$tview.id}&orderby=column{$smarty.foreach.columns.index}|ASC"  class="sortorder" 
               title="{if $lang.$colname}{$lang.$colname}{else}{$colname}{/if}">
                {if $lang.$colname}{$lang.$colname}
                {else}{$colname}
                {/if}
            </a>
        </th>
    {/foreach}    
    <th class="border_0" style="width: 0"></th>
{elseif $display=='trow'}
    <td width="20"><input type="checkbox" class="check" value="{$ticket.id}" name="selected[]"/></td>
    {foreach from=$tview.columns item=col name=cols }
    {assign value="column`$smarty.foreach.cols.index`" var=columnx}
    {if $col == 131072}{* Tags*}
        <td class="tagnotes">
            {if $ticket[$columnx]}
                <div class="right inlineTags">
                    {foreach from=$ticket[$columnx] item=tag name=tagloop}
                        {if $smarty.foreach.tagloop.index < 3} 
                            <span style="background-color:{$tag.color}">{$tag.tag}</span>
                        {/if}
                    {/foreach}
                </div>
            {/if}
        </td>
    {elseif $col == 65536}{* Assigned *}
        <td style="white-space: nowrap;">
            {if $ticket[$columnx] > 0}
                <a href="?cmd=editadmins&action=administrator&id={$ticket[$columnx]}" >{foreach from=$staff_members item=staff}{if $staff.id == $ticket[$columnx]}{$staff.username}{break}{/if}{/foreach}</a>
            {else}
                -
            {/if}
        </td>
    {elseif $col == 16384}{* Notes*}
        <td class="tagnotes">
            {if $ticket[$columnx] > 0}
                <span class="hasnotes ticketflag-note" ></span>
            {/if}
        </td>
    {elseif $col == 4096}{* Status*}
        <td style="white-space: nowrap;"><span class="{$ticket[$columnx]}">{if $ticket[$columnx] == 'Open'}{$lang.Open}{elseif $ticket[$columnx] == 'Answered'}{$lang.Answered}{elseif $ticket[$columnx] == 'Closed'}{$lang.Closed}{elseif $ticket[$columnx] == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket[$columnx] == 'In-Progress'}{$lang.Inprogress}{else}{$ticket[$columnx]}{/if} </span></td>

    {elseif $col == 2048}{* SUBJECT *}
        <td class="subjectline">
            <div class="df1">
                <div class="df2">
                    <div class="df3">
                        <a href="?cmd=tickets&action=view&num={$ticket.ticket_number}{if $backredirect}&brc={$backredirect}{/if}" 
                           data-pjax class="{if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">
                            {if $ticket[$columnx]}
                                {$ticket[$columnx]|wordwrap:80:"\n":true|escape}
                            {else}
                                #{$ticket.ticket_number}
                            {/if}
                            </a>
                    </div>
                </div>
            </div>
            <div style="color:gray">({$aTicket.date|date_format:"%d/%m/%Y"})</div>
        </td>
    {elseif $col == 256}{* CLIENT NAME *}
        <td style="white-space: nowrap;">{if $ticket.client_id!='0'}<a href="?cmd=clients&action=show&id={$ticket.client_id}" class="isclient isclient-{$ticket.group_id}" >{/if}{$ticket[$columnx]}{if $ticket.client_id!='0'}</a>{/if}</td>
    {elseif $col == 64}{* Department*}
        <td style="white-space: nowrap;"><a href="?cmd=tickets&dept={$ticket[$columnx]}&list=all&showall=true" >{$ticket.department}</a></td>
    {elseif $col == 32 || $col == 1}{* Number  or ID*}
        <td><a href="?cmd=tickets&action=view&num={$ticket.ticket_number}{if $backredirect}&brc={$backredirect}{/if}" 
               data-pjax class="{if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">#{$ticket[$columnx]}</a></td>
    {elseif $col == 2 || $col == 4 }{* dates *}
        <td style="white-space: nowrap;">{$ticket[$columnx]}</td>
    {else}
        <td class="fold-text" style="cursor:default">{$ticket[$columnx]}</td>
    {/if}
    {/foreach}
    <td class="border_{$ticket.priority}"></td>
{elseif $action=="default" || ($action=="menubutton" && $make=="poll")}
    {if $tview}
        
        {include file='ajax.tickets.tpl'}
        <script type="text/javascript">ticket.alignColumns();</script>
        
    {elseif $views}
        {if !$ajax}
        <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li class="active last">
                    <a href="?cmd=ticketviews">Ticket Views</a>
                </li>

            </ul>
        </div>
            <div class="list-2">

                <div class="navsubmenu haveitems" >
                    <ul>
                        <li class="list-2elem"><a href="?cmd=ticketviews&action=add" ><span>Add view</span></a></li>
                    </ul>
                </div>
            </div>
        </div>

        <form>
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>

            <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
        </form>
        <table cellspacing="0" cellpadding="7" border="0" width="100%" class="table glike hover">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Owner</th>
                    <th>Type</th>
                    <th width="50"></th>
                </tr>
            </thead>
            <tbody id="updater">
                {/if}
                {foreach from=$views item=view key=k}
                    <tr>
                        <td  class="{if ! $aViewInfos.$k.isDeleteable}isForbidAccess{/if}" ><a href="?cmd=ticketviews&action=edit&id={$view.id}" title="edit">{$view.name}</a></td>
                        <td>{if $view.username}{$view.username}{else}--{/if}</td>
                        <td>{if $view.options & 1}Public{else}Private{/if}</td>
                        <td  class="{if ! $aViewInfos.$k.isDeleteable}isForbidAccess{/if}" >
                            <a onclick="return confirm('Are you sure you want to delete this view?');" href="?cmd=ticketviews&action=delete&id={$view.id}&security_token={$security_token}" class="menuitm menu-auto "><span class="delsth"></span></a>
                        </td>
                    </tr>
                {/foreach}
                {if !$ajax}
            </tbody>

        </table>

                {/if}
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>Custom ticket views</h1>
                Select whitch ticket should be listed and how you want them to be presented to you!
                <div class="clear"></div>
                <a style="margin-top:10px" href="?cmd={$cmd}&action=add" class="new_add new_menu">
                    <span>Create view</span>
                </a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=='add' || $action=='edit' || $action=='fromfilter'}
    <link href="{$template_dir}css/jquery-ui.css" rel="stylesheet" media="all" />
    {literal}
        <style>
.view-option {
    clear: both;
    line-height: 30px;
}
.view-option b {
    display: block;
    float: left;
    width: 120px;
}

.view-columns, .view-filters{
    list-style: none outside none;
    margin: 0;
    padding: 0;
    clear:both
}
.view-columns li {
    float: left;
    line-height: 26px;
    margin: 5px;
    padding: 2px 5px;
    width: 215px;
    cursor: move;
}
.view-columns li input{
    vertical-align: middle;
    cursor:pointer;
    margin: 0;
}
.view-filters > li {
    float: left;
    line-height: 26px;
    margin: 0.33%;
    width: 32%;
}
.view-filters > li > span{
    display:block;
    line-height: 25px;
}
.view-filters li .inp_{
    width: 95%;
    vertical-align: middle;
}
.view-filters li label{
    margin-right: 5px;
    white-space: nowrap;
}
.view-filters li .span-checkbox{
    float: left;
    line-height: 50px;
    margin-right: 5px;
}
.view-filters li .inp_checkbox{
    height: 46px;
}

#content_tb .view-sep{
    clear:both;
    padding-top: 10px;
    margin-top: 10px;
    border-top: solid 1px #ddd;
    box-shadow:0 1px white;
}
.tag-form .input ul{
    border-color: #7F9DB9
}

    </style>
    <script type="text/javascript">
        $(function() {
            $( ".view-columns" ).sortable();
        });
    </script>
        
    {/literal}

    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li class="active last">
                    <a href="?cmd=ticketviews">Ticket Views</a>
                </li>

            </ul>
        </div>
        <div class="list-2">

            <div class="navsubmenu haveitems" >
                <ul>
                    {if $action!='add'}
                    <li class="list-2elem picked"><a href="?cmd=ticketviews&action=edit&id={$view.id}" ><span>Edit view</span></a></li>
                        {else}
                        <li class="list-2elem picked"><a href="?cmd=ticketviews&action=add" ><span>Add view</span></a></li>
                    {/if}

                </ul>
            </div>
        </div>
    </div>

    <form action="" method="post">
        <div class="nicerblu" style="padding:10px;">
            <div class="view-option">
                <b>{$lang.Name}</b>
                <input name="name" value="{$view.name}" size="70" class="inp"/>
            </div>
            {if !($view.options & 4)}
            <div class="view-option">
                <b>Audience</b>
                <input {if !($view.options & 1) }checked="checked"{/if} type="radio" name="audience" value="0"/> Private
                <input {if ($view.options & 1) }checked="checked"{/if} type="radio" name="audience" value="1"/> Public
            </div>
            {/if}
            <div class="view-option">
                <b>Departments</b>
                {foreach from=$departments item=option key=value}
                    <label><input class="inp_m_checkbox" type="checkbox" value="{$option.id}"  name="view_filter[1048576][{$option.id}]" 
                                  {if !$option.my}disabled="disabled"{/if}
                                  {assign value=$view.filters[1048576] var=check}{if ($option.my && (!$view.filters || !$view.filters[1048576])) || isset($check[$option.id])}checked="checked"{/if} />
                        {$option.name}
                    </label>
                {/foreach}
            </div>
            <h3 class="view-sep">Columns to include</h3>
            <ul class="view-columns clearfix">
                {foreach from=$columns item=name key=field name=loop}
                    <li width="33%" class="ui-state-highlight">
                        <input type="checkbox" name="columns[{$field}]" value="1" {if $view.columns.$field}checked="checked"{/if} /> 
                        {if $lan[$name]}{$lang[$name]}{else}{$name|capitalize}{/if}
                    </li>
                {/foreach}
            </ul>
            {if !($view.options & 4)}
            <h3 class="view-sep">Filters</h3>
            <ul class="view-filters clearfix">
                {foreach from=$filters item=filtr key=field name=loop}
                    {if $filtr}
                    <li>
                        <span {if $filtr.type}class="span-{if $filtr.options}m-{/if}{$filtr.type}"{/if}>{if $lan[$filtr.name]}{$lang[$filtr.name]}{else}{$filtr.name|ucfirst}{/if}
                        {if $filtr.type == 'tags'}
                            <a href="#" id="tagdescr" class="vtip_description" title="You can use &quot;and&quot;, &quot;or&quot;, &quot;not&quot; keywords when filtering with tags, default is &quot;and&quot;, example: <br> &bullet;&nbsp;tag1 tag2 or tag3 &raquo; (tag1 and tag2) or tag3"></a>
                        {/if}
                        </span>
                        
                        {if $filtr.type == 'select' }
                            <select class="inp inp_"  name="view_filter[{$field}]" {foreach from=$filtr item=attv key=attn}{if $attn!='type' && $attn!='name'}{$attn}="{$attv}"{/if}{/foreach}>
                            {foreach from=$filtr.options item=option key=value}
                                <option {if $view.filters.$field == $value}selected="selected"{/if} value="{$value}">{$option}</option>
                            {/foreach}
                            </select>
                        {elseif $filtr.type == 'multiselect'}
                            <select id="select_{$field}" class="inp inp_"  name="view_filter[{$field}][]" multiple {foreach from=$filtr item=attv key=attn}{if $attn!='type' && $attn!='name'}{$attn}="{$attv}"{/if}{/foreach}>
                            {foreach from=$filtr.options item=option key=value}
                                <option {if (in_array($value, $view.filters.$field, empty($value) && $value !== '0')) || empty($view.filters.$field) && $value == 'all'}selected="selected"{/if} value="{$value}">{$option}</option>
                            {/foreach}
                            </select>
                            {literal}
                                <script>
                                    $('#select_{/literal}{$field}{literal}').chosenedge({
                                        enable_split_word_search: true,
                                        search_contains: true,
                                    }).on('change', function (e, data) {
                                        var select = $(this),
                                            values = select.val();

                                        if (values.indexOf('all') >= 0) {
                                            if (data.selected == 'all')
                                                select.val(['all']).trigger('chosen:updated')
                                            else {
                                                values.splice(values.indexOf('all'), 1);
                                                select.val(values).trigger('chosen:updated');
                                            }
                                        }
                                    });
                                </script>
                            {/literal}
                        {elseif $filtr.type =='radio' || $filtr.type == 'checkbox'}
                            {if $filtr.options}
                                {foreach from=$filtr.options item=option key=value}
                                    <label><input class="inp_m_{$filtr.type}" type="{$filtr.type}"  {assign value=$view.filters[$field] var=check}{if (!$view.filters && $value!='Closed') || isset($check.$value)}checked="checked"{/if} value="{$value}"  name="view_filter[{$field}][{$value}]" />{$option}</label>
                                {/foreach}
                            {else}
                                <input class="inp_{$filtr.type}" type="{$filtr.type}" {if $view.filters.$field}checked="checked"{/if} value="1" name="view_filter[{$field}]" /> 
                            {/if}
                        {elseif $filtr.type == 'tags'}
                            {if is_array($view.filters.$field)}
                                <input class="inp inp_ inp_{$filtr.type}" type="text" value="{foreach from=$view.filters.$field item=t name=a key=g}{if is_numeric($g)}{$t|regex_replace:"!(.+)!":'&quot;\1&quot;'}{if !$smarty.foreach.a.last}{if $view.filters.$field.tag == 'any'} or {else} and {/if}{/if}{/if}{/foreach}" name="view_filter[{$field}]" /> 
                            {else}
                                <input class="inp inp_ inp_{$filtr.type}" type="text" value="{$view.filters.$field}" name="view_filter[{$field}]" /> 
                            {/if}
                            {*}
                            <div id="tagsInput_{$field}" class="left ticketsTags" style="position:relative; width:75% ;line-height: 14px; padding: 3px 0 0 5px; border: 1px solid #7F9DB9; background: #fff; margin-right: 3px; overflow: visible">
                                {foreach from=$view.filters.$field item=tag key=k}

                                    {if $k!=='tag'}
                                    <span class="tag"><a>{$tag}</a> |<a class="cls">x</a></span>
                                    {/if}
                                {/foreach}
                                <label style="position:relative" for="tagsin2" class="input">
                                    <em style="position:absolute">{$lang.tags}</em>
                                    <input id="tagsin2" autocomplete="off" style="width: 80px">
                                    <ul style="overflow-y:scroll; max-height: 100px; bottom: 23px; left: -7px"></ul>
                                </label>
                            </div>
                            <select class="inp" style="width: 19%" name="view_filter[{$field}][tag]">
                                <option {if $view.filters.$field.tag == 'any'}selected="selected"{/if} value="any" >Any</option>
                                <option {if $view.filters.$field.tag == 'all'}selected="selected"{/if} value="all" >All</option>
                            </select>
                            <div id="tags_{$field}" style="display: none">
                                {foreach from=$view.filters.$field item=tag key=k}
                                    {if $k!=='tag'}
                                    <input type="hidden" name="view_filter[{$field}][]" value="{$tag}" />
                                    {/if}
                                {/foreach}
                            </div>
                            {literal}
                                <script type="text/javascript">
                                $(function(){
                                    ticket.bindTagsActions({/literal}'#tagsInput_{$field}'{literal}, 0, 
                                        function(tag){$({/literal}'#tags_{$field}').append('<input type="hidden" name="view_filter[{$field}][]" value="'+tag+'" />'); repozition('#tagsInput_{$field}'){literal};},
                                        function(tag){repozition({/literal}'#tagsInput_{$field}');$('#tags_{$field} {literal}input[value="'+tag+'"]').remove(); } 
                                    );
                                    function repozition(el){
                                        $(el+' ul').css({left: - $(el+' label').position().left - 2, bottom:$(el).height()+2});
                                    }
                                    repozition({/literal}'#tagsInput_{$field}'{literal}); 
                                });
                                </script>
                            {/literal}
                            {*}
                        {else}
                            <input class="inp inp_{$filtr.type}" {if $filtr.type} type="{$filtr.type}"{else}type="text"{/if} value="{$view.filters.$field}" name="view_filter[{$field}]" {foreach from=$filtr item=attv key=attn}{if $attn!='type' && $attn!='name'}{$attn}="{$attv}"{/if}{/foreach}/> 
                        {/if}
                    </li>
                    {/if}
                {/foreach}
            </ul>
            {/if}
            <div class="clear"></div>
        </div>
        <div class="blu">	
            <table border="0" cellpadding="2" cellspacing="0" >
                <tr>
                    <td><a href="?cmd={$cmd}"><strong>&laquo; {$lang.backto} Ticket views</strong></a>&nbsp;</td>
                    <td><input type="submit" name="save" value="{$lang.Save}" style="font-weight:bold;" class="btn btn-primary btn-sm"/></td>
                </tr>
            </table>
        </div>
        {securitytoken}
    </form>
{elseif $action=='view'}
    
    {include file='ajax.tickets.tpl'}
    
{/if}