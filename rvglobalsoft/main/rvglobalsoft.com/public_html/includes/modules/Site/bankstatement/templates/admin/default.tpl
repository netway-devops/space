<script src="{$system_url}includes/modules/Site/bankstatement/templates/js/script.js"></script>
<link href="{$template_dir}css/bootstrap.customize.css?v={$hb_version}" rel="stylesheet" media="all" />
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
<tr>
    <td ><h3>Bank Statement</h3></td>
    <td  class="searchbox">
    	<div id="hider2" style="text-align:right">
            &nbsp;&nbsp;&nbsp;
			<a href="?cmd={$cmd}&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> 
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
	
		{include file="$tplClientPath/netway/notificationinfo.tpl"}
		
        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="left menubar">
                <a onclick="$('.addWithdraw').toggle(); return false;" style="margin-right: 30px;font-weight:bold;" href="?cmd={$cmd}&action=addwithdraw" class="menuitm"><span class="addsth">ลงบันทึกการ ฝาก / ถอนเงิน</span></a>
            </div>
			<div class="clear"></div>
        </div>
		
		<div class="addWithdraw" style="display:none; padding:15px;">{include file="$tplPath/admin/ajax.addwithdraw.tpl"}</div>
		
        <form id="testform" method="post">
        {securitytoken}
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
		
		<a href="?cmd={$cmd}" id="currentlist" style="display:none"></a>
		<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th>Invoice</th>
                <th>Bank</th>
                <th>Date</th>
                <th align="right" width="150">Amount</th>
            </tr>
            <tr>
                <th colspan="3">&nbsp;</th>
                <th align="right"><strong>{$totalAmount|number_format:2:'.':','} บาท</strong></th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file="$tplPath/admin/ajax.lists.tpl"}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="3">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords|number_format:0:'':','}</span>
                </th>
				<th align="right"><strong>{$totalAmount|number_format:2:'.':','} บาท</strong></th>
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

<script type="text/javascript">
//loadinvoices=true;
</script>