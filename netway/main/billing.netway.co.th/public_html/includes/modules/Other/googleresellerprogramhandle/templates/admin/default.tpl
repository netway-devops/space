
<h3 id="nw-notes"><span class="status status-resolved"> GSuite Subscription </span></h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
<tr>
    <td ><h3>รายการที่ไม่มีอยู่บน Hostbill</h3></td>
    <td  class="searchbox">

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
		
		<a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none"></a>
		<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>      
                <th width="150">customerDomain</th>
                <th>numberOfSeats</th>
                <th>skuId</th>
                <th>skuName</th>
                <th>planName</th>
                <th>endTime</th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file="$tplPath/admin/ajax.lists.tpl"}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="5">
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
