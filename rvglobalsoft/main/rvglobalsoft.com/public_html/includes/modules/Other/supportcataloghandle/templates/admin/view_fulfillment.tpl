<div id="RequestFulfillmentProcess">
    
    <h2 id="tocFulfillment" style="border-bottom: 1px solid #AAAAAA;">
    	Request Fulfillment Process
    
    <span style="float: right">
    	<input class="new_control" type="button" onclick="displayServiceCatalog()" value="Refresh" />
	    <input class="new_control" type="button" onclick="resize(0)" value="+ |" />
	    <input class="new_control" type="button" onclick="resize(1)" value="| +" />
	    <input class="new_control" type="button" onclick="resize(2)" value="+ | +" />    	
    </span>
    
    </h2>
    {if ! $isInprogressFulfillment}
    
	    {if $aProcessGroup|@count}
	    
	    {foreach from=$aProcessGroup item="aGroup"}
	    	{if ! $aProcess[$aGroup.id]|@count}{continue}{/if}
	    <div style="display: inline-block; vertical-align: top;" id="content-{$aGroup.id}">
	    		<div class="box-product noactive" style="height: auto;">
					<div class="box-product-in">
						<div class="box-bell-top"><div></div></div>
							<div class="box-border1">
								<div class="box-border2">
									<div class="fix box-describe-con">
										<div class="box-head" style="text-align: center;">
											<ul class="hidden-list-dots">
												<li><input type="radio" class="selectFulfillmentGroup" name="{$aGroup.name}" id="{$aGroup.id}"></li>
												<li>{$aGroup.name}</li>
											</ul>
											{assign var=DLA value=0}
											{foreach from=$aProcess[$aGroup.id] item="aTeam"}
												{foreach from=$aTeam.task item="aTask"}
													{assign var=DLA value=$DLA+$aTask.ola_in_minute}
												{/foreach}
											{/foreach}
											<span style="font-size: 12px">ระยะเวลาในการส่งมอบ: {$DLA} นาที</span>
											
										</div>
												<table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
												    <tbody>
												    	{assign var=tempTeam value=''}
												        {foreach from=$aProcess[$aGroup.id] item="aTeam"}
												        {if $tempTeam != $aTeam.team}
												       		{assign var=tempTeam value=$aTeam.team}
												        <tr class="tdGray2">
												            <td style="padding-left: 20px;"><strong>{$aTeam.team}</strong></td>
												            <td>&nbsp;</td>
												            <td class="mrow1">
												                &nbsp;
												            </td>
												        </tr>
												        {/if}
												        {foreach from=$aTeam.task item="aTask"}
												        <tr>
												            <td colspan="3" class="mrow1" style="padding-left: 20px; line-height: 1.2em;">
												                <label class="css-label">{$aTask.name}</label>
												            </td>
												        </tr>
												        {/foreach}
												        {/foreach}
												        <tr>
												            <td colspan="3" style="height: 10px;"></td>
												        </tr>
												    </tbody>
												    </table>
									<div class="button-con" id="dd-{$aGroup.id}"></div>
								</div> 				
							</div> 				
						</div>
					</div> 				
				</div>
	    	</div>
	    {/foreach}
	
	    {else}
	    <p align="center" style="padding:15px; color: gray;">--- ไม่พบข้อมูล Fullfilment Process สำหรับ Service Catalog นี้ ---</p>
	    {/if}
	    <div><p>&nbsp;</p></div><div><p>&nbsp;</p></div>
	    <div><p>&nbsp;</p></div><div><p>&nbsp;</p></div>
    {else}
    <div id="left-content" style="display: inline-block; vertical-align: top; width: 48%">
    		<div class="box-product noactive" style="height: auto; width: 100% !important">
				<div class="box-product-in">
					<div class="box-bell-top"><div></div></div>
						<div class="box-border1">
							<div class="box-border2">
								<div class="fix box-describe-con">
									<div class="box-head" style="text-align: center;">
										<ul class="hidden-list-dots">
											<li>{$currentFulfillmentData.name}</li>
										</ul>
										
										{assign var=DLA value=0}
										{foreach from=$currentActivityData item="aTask"}
												{assign var=DLA value=$DLA+$aTask.ola_in_minute}
										{/foreach}
										<span style="font-size: 15px">ระยะเวลาในการส่งมอบ: {$DLA} นาที</span>
										
									</div>
											<table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5" style="table-layout: fixed; width: 100%">
											    <tbody>
											    	{assign var=countNotIsComplete value=0}
											        {foreach from=$currentActivityData item="aTeam"}
											        
											  		{assign var=IsComplete value=0}		
											  										        
											        {if $aTeam.link_google_form != ''}
											        	{assign var=isGForm value=$aTeam.link_google_form}
											        	{assign var=responseTitle value=$aTeam.name}
											        {/if}
											        
											        {if $aTeam.link_response_google_form != ''}
											        	{assign var=isResGForm value=$aTeam.link_response_google_form}
											        {/if}
											        
											        {if $tempTeam != $aTeam.team_name}
											       		{assign var=tempTeam value=$aTeam.team_name}
												        <tr class="tdGray2">
												            <td style="padding-left: 20px;"><strong>{$aTeam.team_name}</strong></td>
												            <td>&nbsp;</td>
												            <td class="mrow1">
												                &nbsp;
												            </td>
												        </tr>
											        {/if}
											        <tr>
											            <td colspan="3" class="mrow1" style="{if $countNotIsComplete == 0 && $aTeam.is_complete == 0} background-color: #fff1a8 !important; {/if}padding-left: 20px; line-height: 1.2em; word-wrap: break-word">
											            	<input type="checkbox" class="css-checkbox" {if $aTeam.is_complete == 1}checked="checked"{/if} onclick="expand({$aTeam.activity_id})"/>
											                <label class="css-label" style="margin-left: 15px;" onclick="expand({$aTeam.activity_id})">{if $aTeam.is_complete == 1}<strike>{/if}{$aTeam.name}{if $aTeam.is_complete == 1}</strike>{/if}</label>
											                <label style="float: right">
											                	{if $aTeam.is_complete == 0}
											                	<!-- &nbsp;<button id="clickToReassign-{$aTeam.activity_id}" onclick="reAssignClick('{$aTeam.activity_id}')">เปลี่ยน</button> -->
											                	&nbsp;<span><a style="color: red; cursor: pointer" id="clickToReassign-{$aTeam.activity_id}" onclick="reAssignClick('{$aTeam.activity_id}')">เปลี่ยน</a></span>
											                	<span id="showReassign-{$aTeam.activity_id}" style="display: none">
												                	<select id="assign-{$aTeam.activity_id}" activityName="{$aTeam.name}" name="assign">
									                                    {foreach from=$aAssign item="arr"}
									                                    <optgroup label="{$arr.team}">
									                                        {foreach from=$arr.staff item="arr2" key="staffId"}
									                                        {if $staffId == $aTeam.activity_staff_id}{continue}{/if}
									                                        <option value="{$staffId}">Lv.{$arr2.level} {$arr2.firstname}</option>
									                                        {/foreach}
									                                    </optgroup>
									                                    {/foreach}
									                                </select>
									                                <button class="new_control" name="updateReassign" onclick="reassignStaff('{$aTeam.activity_id}')">Update</button>
									                                <button class="new_control" name="updateReassignCancel" onclick="reAssignClick('{$aTeam.activity_id}')">Cancel</button>
								                                </span>
								                                {/if}
											                </label>
											                <label style="float: right" id="assignStaff-{$aTeam.activity_id}">
											                	{if $aTeam.is_complete == 1}<strike>{/if}OLA: {$aTeam.ola_in_minute} นาที ผู้รับผิดชอบ: {$aTeam.staff_name}{if $aTeam.is_complete == 1}</strike>{/if}								                                
											                </label>
											                
											                {if $aTeam.is_complete == 0}
											                	{assign var=countNotIsComplete value=$countNotIsComplete+1}
											                {/if}
											                {if $aTeam.is_complete == 1}
											                	{assign var=IsComplete value=1}
											                {/if}
											                <div {if $countNotIsComplete != 1 || $IsComplete == 1}style="display: none"{/if} id="activityDetail-{$aTeam.activity_id}">
											                	<div id="boxDetail" style="padding: 15px 15px 15px 15px">
											                		{if $aTeam.link_google_form != ''}
											                		<div  id="tosubmitGForm" style="display: none">
											                			<a href="{$isGForm}" target="_blank">Google Form {$responseTitle} #Ticket Id: {$currentFulfillmentData.ticket_id}</a>
											                		</div>
											                		{/if}
											                		{$aTeam.detail}
											                		<br><br>
											                		<h3>Comments.....</h3>
											                		<div class="comment-block" id="comment-block-{$aTeam.activity_id}">
											                		{if $aActivityCommentData}
											                		{foreach from=$aActivityCommentData item="aCommentData"}
											                			{if $aCommentData.ticket_activity_id != $aTeam.activity_id} {continue} {/if}	
												                		<div class="comment-item comment-id-{$aCommentData.id}">
												                			<div>
												                				<span style=" float: left">เวลา: {$aCommentData.date}</span>
												                				{if $aCommentData.date != $aCommentData.last_update}
												                				<span>&nbsp;| แก้ไขล่าสุด: {$aCommentData.last_update} </span>
												                				{/if}
												                				<span style=" float: right">
												                					{if $aAdmin.id == $aCommentData.staff_id}
												                					<!-- Action: -->
												                					<a style="margin-top: 2px" class="menuitm" title="edit" onclick="showEditCommentEditor('{$aCommentData.id}')"><span class="editsth"></span></a>
            																		<a style="margin-top: 2px" class="menuitm" title="Delete" onclick="deleteActivityComment('{$aCommentData.id}','{$aTeam.name}')"><span class="delsth"></span></a>
												                					{/if}
												                				</span>
												                			</div>
												                			<div class="comment-avatar">
																				<img src="{$aCommentData.adminAvatar}" alt="avatar">
																				<span style="padding: 5px;">{$aCommentData.comment}</span>
																			</div>
																		</div>
																		<div class="editComment-{$aCommentData.id}" style="display: none">
																			<br>
																			<textarea id="editCommentEditor-{$aCommentData.id}" name="editCommentEditor" rows="3" class="styled inp" style="width:99%;">{$aCommentData.comment}</textarea>
																			<button class="new_control" type="button" id="button-editActivityComment-{$aCommentData.id}" onclick="editActivityComment('{$aCommentData.id}')" activityName="{$aTeam.name}">Edit</button>
																			<button class="new_control" type="button" id="button-canceleditActivityComment" onclick="showEditCommentEditor('{$aCommentData.id}')">Cancel</button>
																			<script language="JavaScript">
															                {literal}
															                CKEDITOR.replace('editCommentEditor-{/literal}{$aCommentData.id}{literal}', {toolbar:'Basic', width:'100%', height:'100px'});
															                CKEDITOR.addCss( '.tag-incomment { color: #3E6D8E;background-color: #E0EAF1;border-bottom: 1px solid #b3cee1;border-right: 1px solid #b3cee1;padding: 3px 4px 3px 4px;margin: 2px 2px 2px 0;text-decoration: none;font-size: 90%;line-height: 2.4;white-space: nowrap;}.tag-incomment:hover {background-color: #c4dae9;border-bottom: 1px solid #c4dae9;border-right: 1px solid #c4dae9;text-decoration: none;}' );
															                $(document).ready(function () {
															                   var editorId = 'commentEditor' + '-{/literal}{$aCommentData.id}{literal}';
															                   CKFinder.setupCKEditor( CKEDITOR.instances.editorId );
															                });
															                {/literal}
															                </script>
																		</div>
																	{/foreach}	
																	{/if}
																	</div>
																	<br>
																	<div>
													                <textarea id="commentEditor-{$aTeam.activity_id}" name="commentEditor" rows="3" class="styled inp" style="width:99%;"></textarea>
													                <script language="JavaScript">
													                {literal}
													                CKEDITOR.replace('commentEditor-{/literal}{$aTeam.activity_id}{literal}', {toolbar:'Basic', width:'100%', height:'100px'});
													                CKEDITOR.addCss( '.tag-incomment { color: #3E6D8E;background-color: #E0EAF1;border-bottom: 1px solid #b3cee1;border-right: 1px solid #b3cee1;padding: 3px 4px 3px 4px;margin: 2px 2px 2px 0;text-decoration: none;font-size: 90%;line-height: 2.4;white-space: nowrap;}.tag-incomment:hover {background-color: #c4dae9;border-bottom: 1px solid #c4dae9;border-right: 1px solid #c4dae9;text-decoration: none;}' );
													                $(document).ready(function () {
													                   var editorId = 'commentEditor' + '-{/literal}{$aTeam.activity_id}{literal}';
													                   CKFinder.setupCKEditor( CKEDITOR.instances.editorId );
													                });
													                {/literal}
													                </script>
													            </div>
																	
																	<br>
											                			<form method="post" id="formComment-{$aTeam.activity_id}">
											                				<label class="comment">
																				<div id="scTicketStaffLists" class="mmfeatured-f ff-{$aTeam.activity_id}">
															                        <input type="text" id="ffFilterStaff-{$aTeam.activity_id}" placeholder="ค้นหา staff" style="width: 96%; border: 1px solid #CCCCCC;" tempvalue="{$aTeam.activity_id}"/>
															                        <div class="clearBoth">&nbsp;</div>
															                        <ul>
															                            {foreach from=$staff_members item=arr}
															                            <li>
															                                <label id="ffTagStaff-{$aTeam.activity_id}" value="{$arr.adminId},{$arr.adminFullName}" style="cursor: pointer">
															                                    
															                                    <img id="ffTagStaff-{$aTeam.activity_id}" value="{$arr.adminId},{$arr.adminFullName}" src="{if $arr.adminAvatar != ''}{$arr.adminAvatar}{else}{$template_dir}/img/sblock.png{/if}" width="14" />
															                                    {$arr.adminName}
															                                </label>
															                            </li>
															                            {/foreach}
															                        </ul>
															                        <div class="clearBoth">&nbsp;</div>
															                        
															                    </div>
																				
																				<button class="new_control" type="button" id='button-addActivityComment' value="{$aTeam.activity_id}" activityName="{$aTeam.name}">Comment</button>
																			</label>
																		</form>
											                		<br><hr><br>
											                		{if $IsComplete == 0}
											                			<input type="button" class="new_control greenbtn" value="Complete" onclick="completeActivity({$aTeam.activity_id},'{$aTeam.name}',1,'{$currentFulfillmentData.id}')"/>
											                		{elseif	$IsComplete == 1}
											                			<input type="button"  class="new_control redbtn" value="Incomplete" onclick="completeActivity({$aTeam.activity_id},'{$aTeam.name}',0,'{$currentFulfillmentData.id}')"/>
											                		{/if}
											                	</div>
											                </div>
											                
											            </td>
											        </tr>
											        
											        {/foreach}
											        <tr>
											            <td colspan="3" style="height: 10px;"></td>
											        </tr>
											    </tbody>
											    </table>
								<div class="button-con" id="dd">
									<span style="cursor: pointer" onclick="cancelFulfillment({$currentFulfillmentData.id})">ยกเลิก</span>
								</div>
							</div> 				
						</div> 				
					</div>
				</div> 				
			</div>
	    </div>
	    
	  	<div style="display: inline-block; vertical-align: top; width: 48%" id="right-content">  
	  		
	    	<div style="display: inline-block; vertical-align: top; width: 100%" id="gFormData">
	    		<div class="box-product noactive" style="height: auto; min-height: 10px !important; width: 100% !important;">
					<div class="box-product-in">
						<div class="box-bell-top"><div></div></div>
							<div class="box-border1">
								<div class="box-border2">
									<div class="fix box-describe-con">
										<div class="box-head" style="text-align: center;">
											<ul class="hidden-list-dots">
												<li></li>
											</ul>
											<span></span>
										</div>
												<table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
												    <tbody>
													        <tr class="tdGray2">
													            <td style="padding-left: 20px;"><strong></strong></td>
													            <td>&nbsp;</td>
													            <td class="mrow1">
													                &nbsp;
													            </td>
													        </tr>
												        <tr>
												            <td colspan="3" class="mrow1" style="padding-left: 20px; line-height: 1.2em;">
												                <label>
												                	
												                </label>
												            </td>
												        </tr>
												            	
												    </tbody>
												    </table>
									<div class="button-con">
										<span style="cursor: pointer"></span>
									</div>
								</div> 				
							</div> 				
						</div>
					</div> 				
				</div>
	    	</div>
	    	
		    <div style="display: inline-block; vertical-align: top; width: 100%">
		    	<div class="box-product noactive" style="height: auto; min-height: 10px !important; width: 100% !important;">
					<div class="box-product-in">
						<div class="box-bell-top"><div></div></div>
							<div class="box-border1">
								<div class="box-border2">
									<div class="fix box-describe-con">
										<div class="box-head" style="text-align: center;">
											<ul class="hidden-list-dots">
												<li>Attachment</li>
											</ul>
											
											<span></span>
											
										</div>
												<table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
												    <tbody>
													        <tr class="tdGray2">
													            <td style="padding-left: 20px;">
													            	{if $haveAttachment}
													            	{foreach from=$fulfillmentAttachment item=attachment}
                           												<div class="attachment" {if $attachment.type|in_array:$imgExt} style="display: block; clear: both; height: 64px;" {/if}>
                                										{if $attachment.type|in_array:$imgExt}
                                											<a href="/attachments/{$attachment.filename}" target="_blank" style="margin: 2px;"><img src="/attachments/{$attachment.filename}" width="120" height="60" border="0" align="left" /></a>
                                										{/if}
                                											<a href="/attachments/{$attachment.filename}" target="_blank">{$attachment.filename}</a>
                                											&nbsp;&nbsp;
                                											<!--<a  class="delbtn" style="display:inline; padding-left:12px;" onclick=" if (confirm('Are you sure you want to delete this attrachment file?')) deleteAttachmentFile(this); return false;" href="?cmd=supporthandle&action=deleteattachment&ticketId={$ticket.id}&id={$attachment.id}">Delete </a>-->
                            											</div>
                    												{/foreach}
													            	{/if}
													            </td>
													            <td>&nbsp;</td>
													            <td class="mrow1">
													                &nbsp;
													            </td>
													        </tr>
												        <tr>
												            <td colspan="3" class="mrow1" style="padding-left: 20px; line-height: 1.2em;">
												                <label>
												                	<div id="fileUploaderAttachmentFulfillment">      
										                                <noscript>          
										                                    <p>Please enable JavaScript to use file uploader.</p>
										                                    <!-- or put a simple form for upload here -->
										                                </noscript>         
										                            </div>
                            										<div class="qq-upload-extra-drop-area">Drop files here too</div>
												                </label>
												            </td>
												        </tr>
												            	
												    </tbody>
												    </table>
									<div class="button-con">
										  
									</div>
								</div> 				
							</div> 				
						</div>
					</div> 				
				</div>
	    	</div>
	    	
	    </div>
	    	
	    <div><p>&nbsp;</p></div><div><p>&nbsp;</p></div>	
	    <div><p>&nbsp;</p></div><div><p>&nbsp;</p></div>
	    <div><p>&nbsp;</p></div><div><p>&nbsp;</p></div>
	    
    {/if}
</div>

{literal}
<script>

	$(document).ready(function () {
		
		$('#gFormData').block({ message: '<h3>Loading {/literal}{$responseTitle}{literal} #Ticket Id: {/literal}{$currentFulfillmentData.ticket_id}{literal}</h3>' });
		$('#gFormData').load( '?cmd=supportcataloghandle&action=getGFormData&ticketId='+ {/literal}{$ticketId}{literal} , function() {
	         $('#gFormData').unblock();
	    });
	    
	    var uploaderFulfillment    = new qq.FileUploader({
                                    element: document.getElementById('fileUploaderAttachmentFulfillment'),
                                    action: '?cmd=supporthandle&action=addFulfillmentAttachment',
                                    params: {ticketFulfillmentId:'{/literal}{$currentFulfillmentData.id}{literal}'},
                                    uploadButtonText: 'Add attachment',
                                    extraDropzones: [qq.getByClass(document, 'qq-upload-extra-drop-area')[0]],
                                    onComplete: function(id, fileName, responseJSON){
                                       if(responseJSON.success){
                                       		displayServiceCatalog();
                                       }
                                    }
                                });

	});
	
	$("button[id^='button-addActivityComment']").click(function() {
		
		var ticketActivityId = $(this).attr("value");
		var activityName	= $(this).attr("activityName");
		var comment = CKEDITOR.instances['commentEditor-'+ ticketActivityId].getData();
		
		if(comment == ''){
			alert('กรุณาใส่ข้อความ !!');
			CKEDITOR.instances['commentEditor-'+ ticketActivityId].focus();
			return false;
		}
		
		if(confirm('ยืนยันดำเนินการ ?')){
	        $.post('?cmd=supportcataloghandle&action=addActivityComment', {
				
				ticketActivityId	: ticketActivityId ,
		        ticketId		 	: '{/literal}{$ticketId}{literal}' ,
		        comment				: comment ,
		        activityName		: activityName ,
		        currentFulfillment	: '{/literal}{$currentFulfillmentData.name}{literal}'
		        
	        }, function (a) {
	        	
	        	var obj = $.parseJSON(a.data);
				$('#comment-block-' + ticketActivityId).append(obj.commentHtml);
	        	CKEDITOR.instances['commentEditor-'+ ticketActivityId].setData('');
	        	CKEDITOR.instances['commentEditor-'+ ticketActivityId].focus();
	        	
	        	if(obj.assign_staff_id  == '0') return false;
	        	
	        	$.post('?cmd=supportcataloghandle&action=assignStaffFromComment', {
	        	 	
			        ticketId		 	: '{/literal}{$ticketId}{literal}' ,
			        to					: obj.assign_staff_id 
			        
		        }, function (a) {
		        	console.log(obj);        	
		        	$.post('?cmd=supportcataloghandle&action=assignCurrentStaff', {
	        	 	
				        ticketId		 	: '{/literal}{$ticketId}{literal}' ,
				        currentStaffTags	: obj.currentStaffTags ,
				        currentStaffTagsId	: obj.currentStaffTagsId
				        
			        }, function (a) {
			        	      	
				    });
		        	        	
			    });
	        	
		    });
		} 
    });
    
	$("input[id^='ffFilterStaff-']").keyup(function( event ) {
        var id         = $(this).attr("tempvalue");
        var str 	   = $(this).val();
        if (str == '') {
            $('.ff-'+id+' ul li').show();
            return;
        }
        $('.ff-'+id+' ul li').hide();
        $('.ff-'+id+' ul li:containsIN("'+ str +'")').show();
    });
    
    $("label[id^='ffTagStaff-']").click(function(){
    	
    	var activityId = $(this).attr('id').split('-');
    	var str = $(this).attr('value').split(',');    	
    	var data = CKEDITOR.instances['commentEditor-'+ activityId[1]].getData();
    	data 		+= "<a href='#' class='tag-incomment'>" + str[1] + "</a>&nbsp;";
		data        = decodeURIComponent(data);
        data        = data.replace(/\/\#\.([^\s]+)/, ' ');
        CKEDITOR.instances['commentEditor-'+ activityId[1]].setData(data);

    });
 
	$('.selectFulfillmentGroup').click(function(e){
		
		if(confirm('ยืนยันดำเนินการ ?')){
			
			var id 		= e.target.id;
			var name 	= e.target.name;
			$.post('?cmd=supportcataloghandle&action=startFulfillment', {
				
		        processGroupId 	 	: id ,
		        processGroupName	: name ,
		        ticketId		 	: '{/literal}{$ticketId}{literal}' ,
		        serviceCatalogId	: '{/literal}{$scId}{literal}' ,
		        
	        }, function (a) {
		        parse_response(a);
		        displayServiceCatalog();
		    });

	   }else{
	   		$(this).prop('checked', false);
	   }
	});
	
	function completeActivity(activityId,activityName,status,fulfillmentid){
		
		if(confirm('ยืนยันดำเนินการ ?')){
			$('#RequestFulfillmentProcess').parent().addLoader();
			$.post('?cmd=supportcataloghandle&action=completeActivity', {
				
		        activityId 	 	: activityId ,
		        activityName	: activityName ,
		        status			: status ,
		        fulfillmentId	: fulfillmentid ,
		        ticketId		: '{/literal}{$ticketId}{literal}'
		        
	        }, function (a) {
	        	$('#preloader').remove();
		        parse_response(a);
		        displayServiceCatalog();
		    });
			
		}
		
	}
	
	function cancelFulfillment(fulfillmentId){
		
		if(confirm('ยืนยันดำเนินการ ?')){
			
			$.post('?cmd=supportcataloghandle&action=cancelFulfillment', {
				
		        fulfillmentId 	 	: fulfillmentId ,
		        ticketId		 	: '{/literal}{$ticketId}{literal}' ,
		        
	        }, function (a) {
		        parse_response(a);
		        displayServiceCatalog();
		    });
			
		}
		
	}
	
	function expand(id){
		$('#activityDetail-'+id).toggle('slow');
	}
	
	function resize(mode){
		
		if(mode == 0){
			$('#left-content').css('width' , '100%');
			$('#left-content').show('slow');
			$('#right-content').hide('slow');
		}
		if(mode == 1){
			$('#right-content').css('width' , '100%');
			$('#right-content').show('slow');
			$('#left-content').hide('slow');
		}
		if(mode == 2){
			$('#left-content').css('width' , '48%');
			$('#left-content').show('slow');
			$('#right-content').css('width' , '48%');
			$('#right-content').show('slow');
		}
	}
	
	function reAssignClick(id){
		$('#showReassign-'+id).toggle();
		$('#assignStaff-'+id).toggle();
		$('#clickToReassign-'+id).toggle();
	}
	
	function deleteActivityComment(commentId , activityName){
		
		if(confirm('ยืนยันดำเนินการ ?')){
		 
			$.post('?cmd=supportcataloghandle&action=deleteActivityComment', {
				
					ticketId		 	: '{/literal}{$ticketId}{literal}' ,
			        commentId		 	: commentId ,
			        activityName		: activityName ,
			        currentFulfillment	: '{/literal}{$currentFulfillmentData.name}{literal}'
			        
		        }, function (a) {
			        parse_response(a);
			        $('.comment-id-'+commentId).hide('slow');
			});
		}
	}
	
	function showEditCommentEditor(commentId){
		
		$('.editComment-'+commentId).toggle();
		$('.comment-id-'+commentId).toggle();
		
	}
	
	function editActivityComment(commentId){

		var comment = CKEDITOR.instances['editCommentEditor-'+ commentId].getData();
		var activityName	= $('#button-editActivityComment-'+commentId).attr("activityName");
		
		if(comment == ''){
			alert('กรุณาใส่ข้อความ !!');
			CKEDITOR.instances['editCommentEditor-'+ commentId].focus();
			return false;
		}
		
		if(confirm('ยืนยันดำเนินการ ?')){
	        $.post('?cmd=supportcataloghandle&action=editActivityComment', {
				
				commentId			: commentId ,
		        ticketId		 	: '{/literal}{$ticketId}{literal}' ,
		        comment				: comment ,
		        activityName		: activityName ,
		        currentFulfillment	: '{/literal}{$currentFulfillmentData.name}{literal}'
		        
	        }, function (a) {
	        	parse_response(a);
		        displayServiceCatalog();
	        });
		}
		
	}
	
	function reassignStaff(activityId){
		
		if(confirm('ยืนยันดำเนินการ ?')){
	        $.post('?cmd=supportcataloghandle&action=reassignStaff', {
				
				reassignStaffId			: $('#assign-'+activityId).val() ,
		        ticketId		 		: '{/literal}{$ticketId}{literal}' ,
		        activityId				: activityId ,
		        activityName			: $('#assign-'+activityId).attr('activityName') ,
		        currentFulfillment		: '{/literal}{$currentFulfillmentData.name}{literal}'
		        
	        }, function (a) {
	        	parse_response(a);
		        displayServiceCatalog();
	        });
		}
		
	}

</script>
{/literal}

