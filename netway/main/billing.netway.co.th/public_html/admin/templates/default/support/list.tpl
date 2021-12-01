{if $tickets}
    {if $showall}

        <form action="" method="post" id="testform" >
            <div class="bottom-fixed" style="display:none">
                <div style="position: relative">
                    {if !$forbidAccess.editTicket}
                        <a href="#" class="menuitm hasMenu" id="bulk_macro">{$lang.applymacro}: <span class="morbtn">{$lang.none}</span><input type="hidden" name="bulk_macro"/></a>
                        <a href="#" class="menuitm hasMenu" id="bulk_dept">{$lang.department}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_dept"/></a>
                        <a href="#" class="menuitm hasMenu" id="bulk_priority">{$lang.setpriority}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_prio"/></a>
                        <a href="#" class="menuitm hasMenu" id="bulk_status">{$lang.status}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_status"/></a>
                        <a href="#" class="menuitm hasMenu" id="bulk_owner">{$lang.assignto}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_owner"/></a>

                        {if $agreements}
                            <a href="#" class="menuitm hasMenu" id="bulk_share">{$lang.sharewith}: 
                                <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_share"/>
                            </a>
                        {/if}
                        <br />
                    {/if}

                    <div style="padding: 5px 0;">
                        <div class="tag-form" id="bulk-tag-form"></label>
                        </div>
                        <div id="bulk-tags" style="display: none"></div>
                    </div>

                    <input type="checkbox" onchange="$(this).next().slideToggle();
                            if (!$('#bulk_status input').val().length)
                                dropdown_handler('Answered', $('#bulk_status'), null, $('#bulk_status_m').find('a[href=Answered]').html());" name="bulk_reply"/> {$lang.addreply} 
                    <textarea style="width: 99%; display: none" name="bulk_message"></textarea>
                    <a name="bulk_actions" rel=".bottom-fixed form" href="#" class="submiter menuitm greenbtn" onclick="$(this).parents('.bottom-fixed').slideUp('fast');">Apply to selected</a>

                    <ul id="bulk_macro_m" class="ddmenu" load="?cmd=predefinied&action=getmacros">
                        <li><a href="0">{$lang.none}</a></li>
                            {foreach from=$macros item=macro}
                            <li><a href="{$macro.id}">{$macro.name}</a></li>
                            {/foreach}
                    </ul>
                    <ul id="bulk_dept_m" class="ddmenu">
                        <li><a href="0">{$lang.nochange}</a></li>
                            {foreach from=$myDepartments item=dept}
                                {if $dept.id && !$dept.view}
                                <li><a href="{$dept.id}">{$dept.name}</a></li>
                                {/if}
                            {/foreach}
                    </ul>
                    <ul id="bulk_priority_m" class="ddmenu">
                        <li><a href="">{$lang.nochange}</a></li>
                        <li class="opt_low" ><a href="0">{$lang.Low}</a></li>
                        <li class="opt_medium" ><a href="1">{$lang.Medium}</a></li>
                        <li class="opt_high"><a href="2">{$lang.High}</a></li>
                        <li class="opt_critical"><a href="3">{$lang.Critical}</a></li>
                    </ul>
                    <ul id="bulk_status_m" class="ddmenu">
                        <li><a href="">{$lang.nochange}</a></li>
                            {foreach from=$statuses item=status}
                            <li><a href="{$status}">{$lang.$status}</a></li>
                            {/foreach}
                    </ul>
                    <ul id="bulk_owner_m" class="ddmenu" >
                        <li><a href="0">{$lang.nochange}</a></li>
                            {foreach from=$staff_members item=stfmbr}
                            <li><a href="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</a></li>
                            {/foreach}
                    </ul>
                    <ul id="bulk_share_m" class="ddmenu">
                        <li><a href="0">{$lang.nochange}</a></li>
                            {foreach from=$agreements item=agreement}
                            <li><a href="{$agreement.uuid}">{$lang.sharewith} #{$agreement.tag}</a></li>
                            {/foreach}
                    </ul>
                </div>
                {literal}
                    <script type="text/javascript">
                        $(function () {
                            $('.bottom-fixed .hasMenu').dropdownMenu({}, function (a, o, p, h) {
                                dropdown_handler(a, o, p, h)
                            });

                            $('#bulk-tag-form').hbtags()
                                .on('tags.add', function (e, tag) {
                                    $('#bulk-tags').append('<input type="hidden" name="bulk_tags[]" value="' + tag.replace(/"/g, '&quote;') + '" />');
                                })
                                .on('tags.rem', function (e, tag) {
                                    $('#bulk-tags input[value="' + tag + '"]').remove();
                                })

                            $('#tagsBox').on('tag.update', function (ev, tags) {
                                var bulk = $('#bulk-tag-form');
                                if (!bulk.length || !bulk.data('hbtags'))
                                    return;

                                bulk.data('hbtags').suggestions = tags.map(function (x) {
                                    return x.tag;
                                })
                            });
                        });

                        $('#testform').undelegate('input.check, #checkall', 'change').delegate('input.check, #checkall', 'change', showhide_bulk);
                        if (!$('.bottom-fixed').data('check')) {
                            $(document).ajaxStop(showhide_bulk);
                            $('.bottom-fixed').data('check', true);
                        }
                    </script>
                {/literal}
            </div>
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="left menubar">
                    {if !$forbidAccess.editTicket || !$forbidAccess.removeTicket}{$lang.withselected}
                    {/if}
                    {if !$forbidAccess.editTicket}
                        <a class="submiter menuitm menu-auto confirm" name="markmerged"   href="#" ><span >{$lang.Merge}</span></a>
                        <a class="submiter menuitm menu-auto" name="markasread"  href="#" ><span >{$lang.markasread}</span></a>
                        <a class="submiter menuitm menu-auto" name="markclosed"  href="#" ><span >{$lang.Close}</span></a>
                        {/if}
                        {if !$forbidAccess.removeTicket}
                        <a class="submiter menuitm confirm menu-auto" name="markdeleted" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
                        {/if}
                </div>
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {if $tview}
                <a href="?cmd={$cmd}&tview={$tview.id}" id="currentlist" style="display:none" updater="#updater"></a>
            {else}
                <a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}" id="currentlist" style="display:none" updater="#updater"></a>
            {/if}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover ticketstable" style="table-layout: fixed;">
                <tbody>
                    <tr>
                        {if $tview}
                            {include file="ajax.ticketviews.tpl" display=theaders}
                        {else}
                            <th width="20"><input type="checkbox" id="checkall"/></th>
                            <th width="190" class="col_name"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=name|ASC"  class="sortorder">{$lang.Client}</a></th>
                            <th class="subjectlineth"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                            <th class="tagnotes" ></th>
                            <th width="100"  class="col_status"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                            <th width="120" class="col_rp_name"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=rp_name|ASC"  class="sortorder">{$lang.lastreplier}</a></th>
                            <th  width="110" class="lastelb col_lastreply"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=priority_lastreply|ASC"  class="sortorder">{$lang.Lastreply}</a></th>
                            {/if}
                    </tr>
                </tbody>
                <tbody id="updater">
                {/if}
                {include file="support/poll.tpl"}
                {literal}
                <script type="text/javascript">
                    var tdwidth = notew = 0;
                    $(".hasnotes").length && (notew = $(".hasnotes").outerWidth(!0)), $(".tagnotes").each(function () {
                        var a = 0;
                        $(this).children().each(function () {
                            a += $(this).outerWidth(!0)
                        }), a > tdwidth && (tdwidth = a)
                    }), $(".tagnotes").width(tdwidth + notew)
                </script> 
            {/literal}
            {if $showall}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th></th>
                        <th  class="col_name">{$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span></th>
                        {if $tview}
                            {section name=foo start=0 loop=$columns_count step=1}
                                <th></th>
                            {/section}
                            {else}
                            <th></th>
                            <th class="tagnotes"></th>
                            <th class="col_status"></th>
                            <th class="col_rp_name"></th>
                            <th class="col_lastreply"></th>
                        {/if}

                    </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="left menubar">
                    {if !$forbidAccess.editTicket || !$forbidAccess.removeTicket}{$lang.withselected}
                    {/if}
                    {if !$forbidAccess.editTicket}
                        <a class="submiter menuitm menu-auto confirm" name="markmerged"   href="#" ><span >{$lang.Merge}</span></a>
                        <a class="submiter menuitm menu-auto" name="markasread"  href="#" ><span >{$lang.markasread}</span></a>
                        <a class="submiter menuitm menu-auto" name="markclosed"  href="#" ><span >{$lang.Close}</span></a>
                        {/if}
                        {if !$forbidAccess.removeTicket}
                        <a class="submiter menuitm confirm menu-auto" name="markdeleted" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
                        {/if}
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}
        </form>
        {if $ajax}
            <script type="text/javascript">bindEvents();</script>
        {/if}
    {/if}
    {if $ajax}
        <script type="text/javascript">bindTicketEvents();</script>
    {/if}
{else}
    {if $showall}
        <div id="blank_state" class="blank_state blank_news" style="padding:0 15px ">
            <div class="blank_info">
                {if !$enableFeatures.support}
                    <h1>Feature not enabled on your system</h1>
                {elseif $assigned}
                    <h1>{$lang.nothingtodisplay}</h1>
                    {$lang.nothing_assigned}
                {elseif $currentdept=='all'}
                    <h1>{$lang.nothingtodisplay}</h1>
                    {$lang.nothing_here}  
                    <div class="clear"></div>
                    <a style="margin-top:10px" href="?cmd=tickets&action=new" class="new_add new_menu"><span>{$lang.opensupticket}</span></a>
                        {else}
                    <h1>{$lang.nothingtodisplay}</h1>
                    {$lang.nothing_indept}
                {/if}
            </div>
            <script type="text/javascript">var he = $('#blank_state').height() / 2;
                $('#blank_state').css('padding-top', ($('#blank_state').parent().parent().height() / 2) - he).css('padding-bottom', ($('#blank_state').parent().parent().height() / 2) - he)</script>
        </div>
    {else}
        <tr>
            <td colspan="7"><p align="center" >{$lang.nothingtodisplay}</p></td>
        </tr>
    {/if}
{/if}