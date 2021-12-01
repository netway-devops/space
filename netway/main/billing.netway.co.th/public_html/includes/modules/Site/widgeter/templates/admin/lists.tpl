<script src="{$system_url}includes/modules/Site/widgeter/templates/js/script.js"></script>
<link href="{$template_dir}css/bootstrap.customize.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$template_dir}css/style.css?v={$hb_version}" rel="stylesheet" media="all" />

<h3 id="nw-notes"><span class="status status-resolved">{$allWidgets.$widgetName.title}</span></h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
<tr>
    <td ><h3>Widget</h3></td>
    <td  class="searchbox">
    	<div id="hider2" style="text-align:right">
            &nbsp;&nbsp;&nbsp;
			<a href="?cmd={$cmd}&action=getadvanced&widget={$wedgetName}" class="fadvanced">{$lang.filterdata}</a> 
			<a href="?cmd={$cmd}&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
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
		
		<a href="?cmd={$cmd}&action=lists&widget={$widgetName}" id="currentlist" style="display:none"></a>
		{if $widgetNow == 'widgetManualDuedateError'}<h2>Refresh หน้านี้เพื่อแสดงข้อมูลล่าสุด</h2>
		<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="200" colspan="3">Account</th>
                <th width="200" colspan="3">Type</th>
                <th width="200" colspan="2">Nextdue Date</th>
               <th width="200"colspan="2">Expiry Date</th>
               <th width="200"colspan="2">Next Invoice Date</th>
                <th width="200"colspan="2">Update Data</th>
            </tr>
        </tbody>
        {elseif $widgetNow == 'widgetListDueIn30Days'}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody><tr><td colspan="3"><font>*เฉพาะ product gsuite และ microsoft</font></td><td></td><td></td><td></td></tr>
            <tr>
                <th width="200" colspan="3">Invoice</th>
                <th width="200" colspan="2">Due</th>
                <th width="200" colspan="2">Account</th>
            </tr>
        </tbody>
        {elseif $widgetNow == 'widgetListRecurringError'}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody><tr><td colspan="3"><font>*รายการที่แสดงไม่รวม Google Apps, Dedicated  Server, VPS Hosting, Cloud VPS, Private Cloud, Co-location</font></td><td></td><td></td><td></td></tr>
            <tr>
                <th width="200" colspan="3">Account ID</th>
                <th width="200" colspan="2">Name</th>
                <th width="200" colspan="2">Product</th>
            </tr>
        </tbody>
        {elseif $widgetNow == 'widgetNewCreditLog'}
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>      
                            <th  width="130"><a href="?cmd=clientcredit&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th  width="150"><a href="?cmd=clientcredit&orderby=lastname|ASC"  class="sortorder">Client</a></th>
                            <th><a href="?cmd=clientcredit&orderby=description|ASC"  class="sortorder">Description</a></th>
                            <th width="90">Increase</th>
                            <th width="90">Decrease</th>
                            <th width="90">Credit after</th>
                            <th width="130"><a href="?cmd=clientcredit&orderby=transaction_id|ASC"  class="sortorder">Trans. id</a></th>
                            <th width="90"><a href="?cmd=clientcredit&orderby=invoice_id|ASC"  class="sortorder">Invoice</a></th>
                            <th width="130"><a href="?cmd=clientcredit&orderby=admin_name|ASC"  class="sortorder">Staff</a></th>
                        </tr>
        </tbody>
		{else}
		
		<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="80">#ID</th>
                <th width="150">Service</th>
                <th>Name</th>
				<th width="180">Due date</th>
				<th width="180">Expire</th>
				<th width="150">Status</th>
                <th align="center" width="150">Action</th>
            </tr>
        </tbody>
        {/if}
        <tbody id="updater">
            {include file="$tplPath/admin/ajax.lists.tpl"}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="9">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords|number_format:0:'':','}</span>
                </th>
				<th align="right">&nbsp;</th>
            </tr>
        </tbody>
        </table>
        {literal}
                <script language="JavaScript">
                $(document).ready(function () {
                    $('.highlight td').css('backgroundColor','#FFFCCC');
                });
                </script>
        {/literal}
        <div class="blu">
            <div class="right"><div class="pagination"></div> </div>
            <div class="clear"></div>
        </div>
		
		</form>
			
    </div>
	</td>
  </tr>
</table>

{if $widgetName == 'widgetManualDuedateError'}
<div class="imp_msg">
    <strong>กรณีตัวอย่าง:</strong><br />
    Q. ข้อมูลถูกต้อง แต่ทำไมยังแสดงว่าผิดพลาด Account: opsthailand.com   Type: Service     Nextdue Date: 2016-07-21  Expiry Date: 2016-07-21  Next Invoice Date: 2016-06-21<br>
    <blockquote>
    A. พบว่า invoice ตั้งค่า duedate ผิดพลาด<br />
    #16916 Invoice Date:   25 Aug 2014 Due Date:   22 Jul 2015 (duedate ตั้งข้ามปี และนานกว่า invoice ใหม่ซะอีก)<br />
    #26042 Invoice Date:   21 Jun 2015 Due Date:   21 Jul 2015<br />
    </blockquote>
</div>
{/if}