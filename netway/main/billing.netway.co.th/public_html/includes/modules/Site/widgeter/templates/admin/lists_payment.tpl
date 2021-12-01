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
		<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="80">#ID</th>
                <th width="150">Payment module</th>
                <th>Transaction id</th>
				<th width="180">email</th>
				<th width="180">amount</th>
				{if $widgetName eq 'widgetPaypalSubSB'}
				<th width="180">cp id</th>
				<th width="180">invoice เดิม</th>
				<th width="180">invoice hostbill</th>
				<th width="180">mail hostbill</th>
				{else}
				<th width="180">invoice อ้างอิง</th>
				{/if}
				
				<th width="150">date</th>
                <th align="center" width="150">status</th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file="$tplPath/admin/ajax.lists_payment.tpl"}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="6">
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
