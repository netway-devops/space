{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'tickets.tpl.php');
{/php}

<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
<link href="{$template_dir}css/badger.min.css?v={$hb_version}" rel="stylesheet" media="all" />
<script type="text/javascript" src="{$template_dir}js/badger.min.js"></script>

<script type="text/javascript" src="{$template_dir}js/jquery.timeago.js"></script>
<script type="text/javascript">
{literal}
$(document).ready( function () {
    setTimeout('howLongAgo()', 1000);
    $('.leftMavigatorArea').hide();
});
function howLongAgo ()
{
    $('td.border_0').each(function (i) {
        $(this).attr('title', $(this).text());
        $(this).timeago();
    });
    setTimeout('howLongAgo()', 5000);
}

function createChangeTicket ()
{
    var fbUrl   = '?cmd=supportcataloghandle&action=createchangeticket';
    $.facebox({ ajax:fbUrl, width:900, nofooter:true, opacity:0.8, addclass:'modernfacebox' });
    return false;
}

{/literal}
</script>


<script type="text/javascript">loadelements.tickets = true;
    {foreach from=$statuses item=status}
        {assign value=$status|replace:'-':'a' var=purstatus}
    lang["{$status}"] = "{if $lang[$purstatus]}{$lang[$purstatus]}{else}{$status}{/if}";
    {/foreach}
    lang["startedreplyat"] = "{$lang.startedreplyat}";
    lang["draftsavedat"] = "{$lang.draftsavedat}";
    lang["preview"] = "{$lang.preview}";
    lang['none'] = "{$lang.none}";
    lang['nochange'] = "{$lang.nochange}";
</script>
<script type="text/javascript" src="{$template_dir}js/jquery.textareafullscreen.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tickets.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td class="leftMavigatorArea" ><h3>{$lang.Support}</h3></td>
        <td  class="searchbox">

            <div id="hider2" style="text-align:right">
                
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="10%">
                <div style="float: left; display: block;"><a href="#" onclick="$('.leftMavigatorArea').toggle(); return false;" class="menuitm"> &lt; ซ่อน / แสดง แถบเมนู </a></div>
                </td>
                <td nowrap="nowrap">
                    <div style="text-align:left">
                        <table width="100%" border="0">
                        <tr>
                            <td align="right">
                                <input type="text" id="simpleQuery" name="simpleQuery" value="{$filterKeyword}" size="30" placeholder="ค้นหา #หมายเลข ticket" title="ค้นหา #หมายเลข ticket" style="width:150px; height: 1em;" class="styled inp query">
                                <input type="button" id="simpleSearch" name="simpleSearch" value="Go" class="new_control greenbtn" style="line-height: 1em;" >
                            </td>
                            <td align="right">
                                <input type="text" id="advanceQuery" name="advanceQuery" value="{$filterKeyword}" size="30" placeholder="ค้นหา หัวข้อ หรือเนื้อหา ticket" title="ค้นหา หัวข้อ หรือเนื้อหา ticket" style="width:200px; height: 1em;" class="styled inp query">
                                <input type="button" id="advanceSearch" name="advanceSearch" value="Go" class="new_control greenbtn" style="line-height: 1em;" >
                            </td>
                            <td id="badgeSummary" width="600" nowrap="nowrap" align="center"></td>
                        </tr>
                        </table>
                    </div>
                </td>
                <td nowrap="nowrap">
                
                <div class="filter-actions">
                    <a class="left fTag" {if !$currentfilter.tag}style="display:none"{/if}>Tag: <em>{$currentfilter.tag}</em></a>

                    {if $tview}
                        <a href="?cmd={$cmd}&tview={$tview.id}&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
                        <a href="?cmd={$cmd}&tview={$tview.id}&resetfilter=1" {if $currentfilter}style="display:inline"{/if} class="freseter">{$lang.filterisactive}</a>
                    {elseif $cmd == 'tickets'}
                        <a href="?cmd=tickets&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
                        <a href="?cmd=ticketviews&action=fromfilter"  {if $currentfilter}style="display:inline"{/if} ><b>Create View</b></a>
                        <a href="?cmd=tickets&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
                    {elseif $cmd == 'tickettimetracking'}
                        <a href="?cmd=tickettimetracking&action=getadvanced" class="fadvanced"> Advance {$lang.filterdata}</a>
                        <a href="?cmd=tickettimetracking&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
                    {/if}
                </div>
                
                </td>
            </tr>
            </table>
            
            <div id="simpleQueryResult" title="" class="mmfeatured-db" style="margin: auto; width: 80%; padding: 10px; text-align: left; display: none;"></div>
            
                
            </div>
            <div id="hider" style="display:none"></div></td>
    </tr>
    <tr>
        <td class="leftNav leftMavigatorArea ">
            <a href="#" onclick="createNewTicket();"  data-href="?cmd=tickets&action=new" {if $cmd=='tickets'}data-pjax{/if} 
               class="tstyled btn btn-success" rel="new"><strong>{$lang.opensupticket}</strong></a>
               
            <br />
            <br />
            <div class="searchbox" style="border-bottom:2px solid #6694E3;">
                <a href="https://www.rvglobalsoft.com:2096" target="_blank">View ticket raws</a><br />
                email: ticketraw@tickets.rvglobalsoft.com<br />
                pass: gvlwvgv=5487<br />
            </div>
               
            <br />
            {foreach from=$myDepartments item=dept}
            
                 {if isset($dept.show) && ! $dept.show}
                 {continue}
                 {/if}
            
                {assign var=opendept value=false}
                {assign var=assign_parm value=""}
                {if $dept.name == 'total' && $dept.id == 0}
                {if $currentdept=='all' && !$assigned}{assign var=opendept value=true}{/if}
                {assign var=id_parm value="all"}
                {assign var=name_parm value="All Open &amp; Client reply  Tickets"}
                {assign var=count_parm value=$mytickets.total}
            {elseif $dept.name == 'assigned' && $dept.id == 0}
            {if $currentdept=='all' && $assigned}{assign var=opendept value=true}{/if}
            {assign var=assign_parm value="&assigned=true"}
            {assign var=id_parm value="my"}
            {assign var=name_parm value="My Open &amp; Client-reply Ticket"}{*$lang.mytickets*}
            {assign var=count_parm value=$mytickets.assigned}
        {else}
        {if $currentdept == $dept.id}{assign var=opendept value=true}{/if}
        {assign var=id_parm value=$dept.id}
        {assign var=name_parm value=$dept.name}
        {assign var=count_parm value=$dept.total}
    {/if}
    {if $dept.view}
        <a href="?cmd=ticketviews&tview={$dept.id}" class="tstyled {if $dept.id==$curentview}selected{/if}" >
            <div>{$name_parm}
                <span class="msg_counter" id="ticketsn_v{$id_parm}">{if $count_parm > 0}({$count_parm}){/if}</span>
            </div>
        </a>
        {if ($tview.options & 4) }
            <div {if $dept.id!=$curentview}style="display:none"{/if} id="listdept_v{$id_parm}">
                {foreach from=$statuses item=status}
                {if is_array($status)}{assign value=$status.status var=status}{/if}
                    <a href="?cmd=ticketviews&tview={$dept.id}&list={$status}"  class="tstyled tsubit {if $dept.id==$curentview && $currentlist==$status|lower}selected{/if}"  rel="{$status|lower}">
                        {assign value=$status|replace:'-':'a' var=purstatus}
                        {assign value="`$status`tickets" var=statustickets}
                    {if $lang[$statustickets]}{$lang[$statustickets]}{else}{$status} {$lang.Tickets}{/if}
                    <span class="msg_counter" id="ticketsn_{$status|regex_replace:"/[^\w]/":""}_v{$id_parm}">{if $dept.$status}({$dept.$status}){/if}</span>
                </a>
            {/foreach}
        </div>
    {/if}
{else}
    {if $id_parm == 'my'}<hr />{/if}
    <a href="?cmd=tickets{if $dept.id}&dept={$dept.id}{/if}&list=all&showall=true{$assign_parm}" id="dept_{$id_parm}" 
       {if $cmd=='tickets'}data-pjax {/if}
       class="tstyled {if $opendept && $currentlist=='all'}selected{/if}" rel="all">
        <div>{$name_parm}
            <span class="msg_counter" id="ticketsn_{$id_parm}">{if $count_parm > 0}({$count_parm}){/if}</span>
        </div>
    </a>
    {if $cmd=='tickets' && !$dept.view}
        <div {if !$opendept}style="display:none"{/if} id="listdept_{$id_parm}">
            {foreach from=$statuses item=status}
                {if is_array($status)}{assign value=$status.status var=status}{/if}
                <a href="?cmd=tickets{if $dept.id}&dept={$dept.id}{/if}&list={$status}&showall=true{$assign_parm}"  
                   {if $cmd=='tickets'}data-pjax {/if}
                   class="tstyled tsubit {if $opendept && $currentlist==$status|lower}selected{/if}"  rel="{$status|lower}">
                    {assign value=$status|replace:'-':'a' var=purstatus}
                    {assign value="`$status`tickets" var=statustickets}
                {if $lang[$statustickets]}{$lang[$statustickets]}{else}{$status} {$lang.Tickets}{/if}
                <span class="msg_counter" id="ticketsn_{$status|regex_replace:"/[^\w]/":""}_{$id_parm}">{if $dept.$status}({$dept.$status}){/if}</span>
            </a>
        {/foreach}
    </div>
{/if}

{if $id_parm == 'my'}<hr />{/if}

{/if}
{/foreach}
<br /><br />
{if $admindata.access.reviewTickets}
                <a href="?cmd=tickets&list=Review&showall=true{$assign_parm}"
                   {if $cmd=='tickets'}data-pjax {/if}
                   class="tstyled {if $currentlist=='review'}selected{/if}" rel="review">
                    <div>
                        {$lang.pendingReview}
                        <span class="msg_counter" id="ticketsn_Review_Pending">({$pendingtickets|default:0})</span>
                    </div>
                </a>
            {/if}
{if $enableFeatures.support}
    <a href="?cmd=predefinied"  class="tstyled {if $cmd=='predefinied'}selected{/if}">{$lang.ticketmacros|capitalize}</a>
    <a href="?cmd=ticketdepts"  class="tstyled {if $cmd=='ticketdepts'}selected{/if}">{$lang.ticketdepts|capitalize}</a>

    <a href="?cmd=ticketbans"  class="tstyled {if $cmd=='ticketbans'}selected{/if}">{$lang.ticketfilters|capitalize}</a>
    <a href="?cmd=ticketshare"  class="tstyled {if $cmd=='ticketshare'}selected{/if}">{$lang.ticketshare|capitalize}</a>
    <a href="?cmd=supportrating"  class="tstyled {if $cmd=='supportrating'}selected{/if}">Ticket Ratings</a>
    <a href="?cmd=ticketviews"  class="tstyled {if $cmd=='ticketviews' && !$tview}selected{/if}">Ticket Views</a>
    {if $enableFeatures.supportext}
        <a href="?cmd=tickettimetracking"  class="tstyled {if $cmd=='tickettimetracking'}selected{/if}">Ticket Billing</a>
    {/if}
    <a href="?cmd=tickettags"  class="tstyled {if $cmd=='tickettags' && !$tview}selected{/if}">Ticket Tags</a>
{/if}
<br />

{if isset($admindata.access.menuAdministrators)}
<a href="?cmd=editadmins"  class="tstyled {if $cmd=='editadmins' || $cmd=='root'}selected{/if}">{$lang.Administrators|capitalize}</a>
{/if}

<br /><br />
<div class="tagNav">
    <strong>{$lang.tags}</strong>
    <div class="tag-list">
        <div id="tagsBox">
            <em>Loading...</em>
        </div>
    </div>
</div>

<br />
<hr />
<a href="?cmd=logs&action=importlog" target="_blank">Log import ticket</a>

</td>
<td  valign="top"  class="bordered">
    <div id="bodycont" style=""> 
        {if $cmd=='tickets'}
            {include file='ajax.tickets.tpl'}
        {elseif $cmd=='predefinied'}
            {include file='ajax.predefinied.tpl'}
        {elseif $cmd=='ticketdepts'}
            {include file='ajax.ticketdepts.tpl'}
        {elseif $cmd=='ticketbans'} 
            {include file='ajax.ticketbans.tpl'}
        {elseif $cmd=='tickettags'}
            {include file='ajax.tickettags.tpl'}
        {elseif $cmd=='ticketviews' }   
            {include file='ajax.ticketviews.tpl'}
        {elseif $cmd=='tickettimetracking' }    
            {include file='ajax.tickettimetracking.tpl'}
        {elseif $cmd=='editadmins' || $cmd=='root'} 
            {include file='ajax.editadmins.tpl'}
        {elseif $cmd=='supportrating'}  
            {include file='ajax.supportrating.tpl'}
        {/if} 
    </div>
</td>
</tr>
</table>


<script language="JavaScript">
{literal}
$(document).ready( function () {
    $('#simpleQuery').keydown(function (event) {
        if (event.which == 13) {
            ticketSimpleQuery($('#simpleQuery').val());
        }
    });
    $('#simpleSearch').click( function () {
        ticketSimpleQuery($('#simpleQuery').val());
    });
    $('#advanceQuery').keydown(function (event) {
        if (event.which == 13) {
            ticketSimpleQuery($('#advanceQuery').val());
        }
    });
    $('#advanceSearch').click( function () {
        ticketSimpleQuery($('#advanceQuery').val());
    });
});


function ticketSimpleQuery (keyword)
{
    $('#simpleQueryResult').html('').hide();
    if (keyword == '') {
        return false;
    }
    
    keyword    = keyword.trim();
    keyword    = keyword.replace(/^#/, '');
    
    var url    = '?cmd=supporthandle&action=search';
    
    if (keyword == '-reload-') {
       keyword = $('#simpleQueryResult').attr('title');
       url     += '&reload=1';
    } else {
        $('#simpleQueryResult').attr('title', keyword);
    }
    url    += '&keyword='+ encodeURIComponent(keyword);
    
    $('#content_tb').parent().addLoader();
    $('#simpleQueryResult').load(url, function() {
        $('#preloader').remove();
        $('#simpleQueryResult').show();
    });
    
}

function createNewTicket ()
{
    $('html > body').parent().addLoader();
    $.get('?cmd=supporthandle&action=createticket', function (data) {
        
        parse_response(data);
        
        var codes           = queryResult(data);
        var ticketNumber    = codes.TICKET_NUMBER;
        
        if (typeof ticketNumber != 'undefined') {
            document.location = '?cmd=tickets&action=view&num='+ ticketNumber;
        } else {
            $('#preloader').remove();
        }
        
    });
    
    return false;
}

function queryResult (data)
{
    var codes   = {};
    if (data.indexOf("<!-- {") == 0) {
        codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
    }
    return codes;
}

{/literal}
</script>
