
<h3 id="nw-notes"><span class="status status-resolved"> List cPanel license </span></h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
<tr>
    <td ><h3>Home</h3></td>
    <td  class="searchbox">
        รายการ cPanel license ทั้งหมด ดูจาก OS, Control Panel และ Server Software 
        <a href="?cmd=cpanellicenselisthandle&action=download" class="btn btn-primary">Export list</a>
    </td>
</tr>
<tr>
    <td class="leftNav">
	    {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
	<div id="bodycont"> 
        <p>
            เช็คจาก account ที่ link ไปยัง product ที่ใช้ OS template ที่มี cPanel หรือใช้ Control Panel ที่เป็น cPanel 
            และ account ที่เชื่อมต่อกับ Server App cPanel Manage 2
        <p>
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
                <th width="150">AccountId</th>
                <th>Domain</th>
                <th>Product</th>
                <th>Item</th>
                <th>ItemGroup</th>
                <th>ipid</th>
                <th>IPAM_IP</th>
                <th>Hostbill_IP</th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file="$tplPath/admin/ajax.lists.tpl"}
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
