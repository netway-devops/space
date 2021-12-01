
<h3 id="nw-notes"><span class="status status-resolved"> Change recurring price </span></h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
<tr>
    <td ><h3>แก้ไขราคา GSuite</h3></td>
    <td  class="searchbox">

    </td>
</tr>
<tr>
    <td class="leftNav">
	    {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
	<div id="bodycont"> 
        <a href="?cmd=googleresellerprogramhandle&action=changeRecurringPrice&recalculate=1">คำนวนใหม่</a> &nbsp;&nbsp;&nbsp;

        {if $calculate}
            &nbsp;&nbsp;&nbsp;
            <div class="left spinner"><img src="ajax-loading2.gif"></div>
            {literal}
            <script type="text/javascript">
            $(document).ready(function() {
                document.location = '?cmd=googleresellerprogramhandle&action=changeRecurringPrice&calculate=1';
            });
            </script>
            {/literal}
        {/if}

        <a href="?cmd=googleresellerprogramhandle&action=changeRecurringPrice&calculate=1">คำนวนต่อ</a> &nbsp;&nbsp;&nbsp;

        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="clear"></div>
        </div>
	
        <form id="testform" method="post">
        {securitytoken}
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
		
		<a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none"></a>
		<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>      
                <th>#</th>
                <th width="150">Domain</th>
                <th>Status</th>
                <th>Seat</th>
                <th>Price</th>
                <th>Cycle</th>
                <th>Recurring</th>
                <th>Recurring (New)</th>
                <th>Due</th>
                <th>Expire</th>
                <th>Product</th>
                <th>Sync</th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file="$tplPath/admin/ajax.recurring.tpl"}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="10">
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
