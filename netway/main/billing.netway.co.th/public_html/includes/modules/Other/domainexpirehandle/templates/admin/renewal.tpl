<script src="{$system_url}includes/modules/Site/widgeter/templates/js/script.js"></script>
<link href="{$template_dir}css/bootstrap.customize.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$template_dir}css/style.css?v={$hb_version}" rel="stylesheet" media="all" />

<h3 id="nw-notes"><span class="status status-resolved">ประวัติการต่ออายุ Domain</span></h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
<tr>
    <td ><h3>{$widgetName}</h3></td>
    <td  class="searchbox">
        <div id="hider2" style="text-align:right">
            &nbsp;&nbsp;&nbsp;
            <a href="?cmd={$cmd}&action=getadvanced&widget={$widgetName}" class="fadvanced">{$lang.filterdata}</a> 
            <a href="?cmd={$cmd}&action=renewal&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        </div>
        <div id="hider" style="display:none"></div>
    </td>
</tr>
<tr>
    <td class="leftNav">
        {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
    <div id="bodycont"> 
        
        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="clear"></div>
        </div>
    
        <form id="testform" method="post">
        {securitytoken}
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        
        <a href="?cmd={$cmd}&action=renewal&widget={$widgetName}" id="currentlist" style="display:none"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th><a href="?cmd={$cmd}&action=renewal&export=1" class="btn btn-primary btn-xs"> Export</a></th>
                <th>Date</th>
                <th>Domain</th>
                <th>Module</th>
                <th>Start (จาก invoice item)</th>
                <th>End (จาก domain sync)</th>
                <th>Year</th>
                <th>Invoice</th>
            </tr>
        </tbody>
        {if $export}
        <tbody>
            <tr>
                <td colspan="7">
                    <a href="?cmd=reports&action=show&report=75007&output=csv&export[]=logID&export[]=logDate&export[]=DomainName&export[]=Registrar&export[]=StartDate&export[]=EndDate&export[]=Year&export[]=InvoiceID" target="_blank">Download CSV</a><br />
                </td>
                <td>
                    <a href="?cmd=reports&action=get&id=75007" target="_blank">Setting</a><br />
                </td>
            </tr>
        </tbody>
        {/if}
        <tbody id="updater">
            {include file="$tplPath/admin/ajax.renewal.tpl"}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="7">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords|number_format:0:'':','}</span>
                </th>
                <th align="right">&nbsp;</th>
            </tr>
        </tbody>
        </table>
        
        <div class="blu">
            <div class="right"><div class="pagination"></div> </div>
            <div class="clear"></div>
        </div>
        
        </form>
            
    </div>
    </td>
  </tr>
</table>
