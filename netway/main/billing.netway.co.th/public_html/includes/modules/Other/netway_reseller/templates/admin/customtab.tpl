
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
	<tr>
		<td ><h3>รายชื่อผู้ได้รับอนุญาติให้เข้าถึงบริการ</h3></td>
		<td  class="searchbox">
			
			</div>
			<div id="hider" style="display:none"></div>
		</td>
	</tr>
	<tr>
		<td class="leftNav">
			
		</td>
		<td  valign="top"  class="bordered">
			<div id="bodycont"> 

				
					<div class="blu" style="text-align:right">
    					
       	 					
       	 					<div class="blu">
    							<div class="right">
            						<div class="pagination"></div>
        						</div>
        						<div class="clear"></div>
    						</div>
		
							<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
    							
   	 							<tbody id="updater">
									<tr>				
										<td colspan="2">{include file="$tplPath/admin/ajax.customtab.tpl"}</td>
									</tr>
    							</tbody>
								
							</table> 
								
					</div>
				
		</td>
	</tr>
</table>
<script type="text/javascript">
{literal}
$(document).ready(function() {
    //$('#totalpages').val({/literal}{$totalpages}{literal});
	//$("div.pagination").pagination($("#totalpages").val());
	//$(selector).pagination('getCurrentPage');
});
{/literal}
</script>