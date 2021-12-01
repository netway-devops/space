<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/VIP.js"></script>
<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/symantecvip.js"></script>

<link href="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />

<script type="text/javascript">

	var system_url = "{$system_url}";

{literal}	

     $(document).ready(function () {
    	 $.symantecvip.init();
	 });
	</script>
	
{/literal}

<div id="content">
    <div id="content-header">
    
 
    	
    	<h2>Subscription Detail</h2>
       
    </div>
 
	<B>VIP INFO ID: #{$vip_info_id}</B>
	
	<br />
	

{if $product_id eq '55' or $product_id eq '58'  or $product_id eq '59'}
      
       
    <br />
    
    Management Symantec VIP status: {$vip_manage_status}
    
    <br /><br />
    
    <h3>Step 1: Register VIP Account</h3> 
    
    <br />
   
    <form name="frmStep1" id="frmStep1" method="post" action="">
    
    <input type="hidden" name="vip-info-id" id="vip-info-id" value="{$vip_info_id}">
    <input type="hidden" name="usr-id" id="usr-id" value="{$usr_id}">
    <input type="hidden" name="account-id" id="account-id" value="{$account_id}">
	<input type="hidden" name="vip-info-type" id="vip-info-type" value="{$vip_info_type}">
	<input type="hidden" name="vip-product-id" id="vip-product-id" value="{$product_id}">
	<input type="hidden" name="vip-product-name" id="vip-product-name" value="{$product_name}">
	<input type="hidden" name="vip-quantity" id="vip-quantity" value="{$quantity}">
 
            <table width="98%">
            <tr>
                <td width="250"><div align="right">Organizational Unit Number:</div></td>
                <td><div align="left"><input type="text" id="vip-ou-number" name="vip-ou-number" class="required"  title="กรุณากรอก Organizational Unit Number" value="{$vip_ou_number}" /></div></td>
            </tr>
           	<tr>
           		<td><div align="right"># Account in subscription:</div></td>
                <td><div align="left">{$quantity} account(s)</div></td>
            </tr>
           <tr>
            	<td><div align="right"># Account in Symantec VIP official site:</div></td>
            	<td><div align="left"><input type="text" id="vip-quantity-at-symantec" name="vip-quantity-at-symantec" readonly style="background-color: #DDDDDD" class="required"  title="กรุณากรอก จำนวน Account ที่สั่งซื้อใน Symantec VIP" value="{$quantity_at_symantec}" />  account(s) <font color='#FF0000'>{$chk_not_eq}</font></div></td>
            </tr> 
            <tr>
            	<td colspan="2"><div align="left"><input type="button" id="vip-save-account" name="vip-save-account" value="Save" class="ui-button" /></div></td>
          	</tr>
          	</table>
            
            </form>
        
       <div style="clear:both;">&nbsp;</div>
  
   <br />
   
    <h3>Step 2: Upload Certificate File</h3> 
    
    <br />
    
    
    
    
    ลิ้งค์สำหรับ สร้าง Certificate file <a href='https://manager.vip.symantec.com/vipmgr/certmgrhome.v' target='_blank'>https://manager.vip.symantec.com/vipmgr/certmgrhome.v</a>
      
    <br />
    
    
  
        <form name="frmStep2" id="frmStep2" method="post"  action="" enctype="multipart/form-data">
 
      	 	<input type="hidden" name="vip-info-id" id="vip-info-id" value="{$vip_info_id}">
    		<input type="hidden" name="usr-id" id="usr-id" value="{$usr_id}">
    		<input type="hidden" name="date-file-upload" id="date-file-upload" value="{$date_file_upload_pem}">
    		<input type="hidden" name="date-file-upload-p12" id="date-file-upload-p12" value="{$date_file_upload_p12}">
    		
    
    
    <fieldset><legend><h3>ข้อมูลสำหรับสร้าง certificate file</h3></legend>
          
    		
            <table width="98%">
            <tr>
                <td width="250"><div align="right">Certificate Name :</div></td>
                <td><div align="left"><input type="text" name="certificate-file-name" id="certificate-file-name" class="required"  title="กรุณากรอก Certificate Name .pem" value="{$certificate_file_name}" readonly="readonly" style="background-color: #CCCCCC"  size="50" />
               <input type="hidden" name="certificate-file-name-p12" id="certificate-file-name-p12" class="required"  value="{$certificate_file_name_p12}" />
                </div>
                </td>
            </tr>
            
            
           <tr>
                <td><div align="right">Certificate Password :</div></td>
                <td><div align="left"><input type="text" name="certificate-file-password" id="certificate-file-password" class="required"  title="กรุณากรอก Certificate Password" value="{$certificate_file_password}" readonly="readonly" style="background-color: #CCCCCC" />
                <input type="hidden" name="certificate-file-password-p12" id="certificate-file-password-p12" class="required" value="{$certificate_file_password_p12}"  />
               
                </div>
                </td>
            </tr>  
            
         
            </table>
            
           </fieldset>
           
            <br />
           
           <fieldset><legend><h3>นำ certificate file ที่ได้ มาอัพโหลด และกรอกวันหมดอายุของ certificate file ในแบบฟอร์มด้านล่างนี้</h3></legend>
           
    
            <table width="98%">
     <!--      <tr>
                <td width=250><div align="right">Certificate Name .pem:</div></td>
                <td><div align="left"><input type="text" name="certificate-file-name" id="certificate-file-name" class="required"  title="กรุณากรอก Certificate Name .pem" value="{$certificate_file_name}"  size="50" />
                
                
                </div>
                </td>
            </tr>
            
             -->  
             
             
            <tr>
                <td width="250"><div align="right">Upload Certificate File .pem:</div></td>
                <td><div align="left"><input type="file" name="certificate-file" id="certificate-file" class="required" title="กรุณาเลือก Certificate File .pem" /></div></td>
            </tr>

            <tr>
                <td><div align="right">Certificate File  .pem:</div></td>
        		<td><div align="left">{if $has_cer_pem eq '1'}<a href="javascript:void(0);" id="show-dialog-cer-file" class="show-dialog"><span class="ui-button">รายละเอียดไฟล์ Certificate</span></a>{else}ยังไม่มีไฟล์ Certificate{/if}</div></td>
            </tr>
         
            
            <tr>
            	<td colspan="2">&nbsp;</td>
            </tr>
            
     <!--       
            <tr>
                <td><div align="right">Certificate Name .p12:</div></td>
                <td><div align="left"><input type="text" name="certificate-file-name-p12" id="certificate-file-name-p12" class="required"  title="กรุณากรอก Certificate Name .p12" value="{$certificate_file_name_p12}" size="50" />
                
                </div>
                </td>
            </tr>
            
      --> 
            
            <tr>
                <td><div align="right">Upload Certificate File .p12:</div></td>
                <td><div align="left"><input type="file" name="certificate-file-p12" id="certificate-file-p12" class="required"  title="กรุณาเลือก Certificate File .p12" /></div></td>
            </tr>

            <tr>
                <td><div align="right">Certificate File  .p12:</div></td>
        		<td><div align="left">{if $has_cer_p12 eq '1'}<a href="javascript:void(0);" id="show-dialog-cer-file-p12" class="show-dialog"><span class="ui-button">รายละเอียดไฟล์ Certificate</span></a>{else}ยังไม่มีไฟล์ Certificate{/if}</div></td>
            </tr>
           
    <!--         <tr>
          		<td><div align="right">Certificate File Expire Date:</div></td>
          		<td><div align="left"><input type="text" class="haspicker" size="12" name="certificate-expire-date-p12" id="certificate-expire-date-p12" class="required"  title="กรุณาเลือก กรอกวันที่" value="{$certificate_expire_date_p12}" /></div></td>
            </tr>
            
          -->
          
          
             <tr>
            	<td colspan="2">&nbsp;</td>
            </tr>
             
            <tr>
          		<td><div align="right">Certificate File Expire Date:</div></td>
          		<td><div align="left"><input type="text" class="haspicker" size="12"  name="certificate-expire-date" id="certificate-expire-date" class="required"  title="กรุณาเลือก กรอกวันที่" value="{$certificate_expire_date}" /></div></td>
            </tr>
            
            <tr>
                <td><div align="right">ผลการทดลองเชื่อมต่อกับ Symantec Server:</div></td>
                <td><div align="left">{$symantec_connection}</div></td>
            </tr>   
            
            <tr>
            	<td colspan="2">&nbsp;</td>
            </tr>
            
            <tr>
            	<td colspan="2">
                <div class="action" align="left">{if $vip_info_id ne ''}<input type="button" id="vip-save-certificate-file" name="vip-save-certificate-file" value="Save" class="ui-button" /> {else}<input type='button' class='ui-button' value='Save' disabled>{/if} </div>
                </td>
          </tr>             
          </table>
          
           </form>
           
           
        <!--     <div style="clear:both;">&nbsp;</div>
  
   <br />
   
    <h3>Step 3: Certificate Password</h3> 
    
    <br />
       

            <form name="frmStep3" id="frmStep3" method="post"  action="">
 
      		<input type="hidden" name="vip-info-id" id="vip-info-id" value="{$vip_info_id}">
		
            <table width="98%">
            <tr>
                <td width="250"><div align="right">Certificate Password .pem:</div></td>
                <td><div align="left"><input type="text" name="certificate-file-password" id="certificate-file-password" class="required"  title="กรุณากรอก Certificate Password" value="{$certificate_file_password}" />
                 ผลการทดลองเชื่อมต่อกับ Symantec Server : {$symantec_connection}
                </div>
                
                </td>
            </tr>   
            <tr>
                <td><div align="right">Certificate Password .p12:</div></td>
                <td><div align="left"><input type="text" name="certificate-file-password-p12" id="certificate-file-password-p12" class="required"  title="กรุณากรอก Certificate Password" value="{$certificate_file_password_p12}" />
                </div>
                
                </td>
            </tr>     
            <tr>
            	<td colspan="2">
                <div class="action" align="left">
                {if $has_cer_p12 eq '1' && $has_cer_pem eq '1' }<input type="button" id="vip-save-certificate-file-pass" name="vip-save-certificate-file-pass" value="Save" class="ui-button" /> 
                {else}
                 <input type='button' value='Save' class='ui-button' disabled>
                {/if}
                </div>
                </td>
          </tr>              
          </table>
          
           </form>
           
            --> 
            
       </div>     
          
          
          
          
       <div id="dialog-cer-detail" style="display:none;" title="Certificate file PEM Detail (WHM)">
       
       <table>
       <tr>
       <td><div align="right">File name : </div></td>
       <td><div align="left">{$certificate_file_name}</div></td>
       </tr>
       <tr>
       <td><div  align="right">File type : </div></td>
       <td><div align="left">{$certificate_file_type}</div></td>
       </tr>
       <tr>
        <td><div  align="right">File size : </div></td>
        <td><div align="left">{$file_size} bytes</div></td>
        </tr>
       <tr>
        <td><div align="right">File upload date : </div></td>
        <td><div align="left">{$date_file_upload_pem}</div></td>
        </tr>
       <tr>
        <td><div align="right">File last upload date : </div></td>
        <td><div align="left">{$date_file_last_upload_pem}</div></td>
        </tr>
       <tr>
        <td><div align="right">md5sum : </div></td>
        <td><div align="left">{$md5sum}</div></td>
       </tr>
       <tr>
       	<td colspan="2"><div align="center"><a href="{$view_cer_pem_path}" target="_blank">Download Certificate File (คลิกขวาที่ลิ้งค์ แล้วเลือก Save Link As...)</a></div></td>
       </tr>
       </table>
       
       </div>
       
       
       
       
       <div id="dialog-cer-detail-p12" style="display:none;" title="Certificate file P12 Detail (WHM)">
       
       <table>
       <tr>
       <td><div align="right">File name : </div></td>
       <td><div align="left">{$certificate_file_name_p12}</div></td>
       </tr>
       <tr>
       <td><div  align="right">File type : </div></td>
       <td><div align="left">{$certificate_file_type_p12}</div></td>
       </tr>
       <tr>
        <td><div  align="right">File size : </div></td>
        <td><div align="left">{$file_size_p12} bytes</div></td>
        </tr>
       <tr>
        <td><div align="right">File upload date : </div></td>
        <td><div align="left">{$date_file_upload_p12}</div></td>
        </tr>
       <tr>
        <td><div align="right">File last upload date : </div></td>
        <td><div align="left">{$date_file_last_upload_p12}</div></td>
        </tr>
       <tr>
        <td><div align="right">md5sum : </div></td>
        <td><div align="left">{$md5sum_p12}</div></td>
       </tr>
       <tr>
       	<td colspan="2"><div align="center"><a href="{$view_cer_p12_path}" target="_blank">Download Certificate File (คลิกขวาที่ลิ้งค์ แล้วเลือก Save Link As...)</a></div></td>
       </tr>
       </table>
       
       </div>
       
           
           
           
      {elseif $product_id eq '60'}
      
      <br />
      
       
    <h3>Upload Certificate File</h3> 
    
    <br />
    
    			{if $vip_info_id eq ''}
    			
    			<br />
    			<font color='#FF0000'><b>
    			กรุณาอัพโหลด Certificate file ที่ Order หลักของผู้ซื้อนี้ก่อน
    			</b></font>
    			<br />
    			
    			{else}
    
    
    ลิ้งค์สำหรับ สร้าง Certificate file <a href='https://manager.vip.symantec.com/vipmgr/certmgrhome.v' target='_blank'>https://manager.vip.symantec.com/vipmgr/certmgrhome.v</a>
      
    <br />    <br />
    
    
      
      <!--  for cPanel  -->
      
      
           <form name="frmStep2" id="frmStep2" method="post"  action="" enctype="multipart/form-data">
 
      	 	<input type="hidden" name="vip-info-id" id="vip-info-id" value="{$vip_info_id}">
    		<input type="hidden" name="usr-id" id="usr-id" value="{$usr_id}">
    		<input type="hidden" name="date-file-upload" id="date-file-upload" value="{$date_file_upload_cp_apps}">
    		<input type="hidden" name="date-file-upload-p12" id="date-file-upload-p12" value="{$date_file_upload_p12_cp_apps}">
    		<input type="hidden" name="cer-file-type" id="cer-file-type" value="cPanel">
    		
    		
    		<input type="hidden" name="account-id" id="account-id" value="{$account_id}">
      
         <fieldset><legend><h1>cPanel UI / cPanel user SSH,SCP,SFTP / Webmail UI</h1></legend>
          
          
          <br />
          
          <fieldset><legend><h3>ข้อมูลสำหรับสร้าง certificate file</h3></legend>
          
    		
            <table width="98%">
            <tr>
                <td width="250"><div align="right">Certificate Name :</div></td>
                <td><div align="left"><input type="text" name="certificate-file-name" id="certificate-file-name" class="required"  title="กรุณากรอก Certificate Name .pem" value="{$certificate_file_name_cp_apps}" readonly="readonly" style="background-color: #CCCCCC"  size="50" />
                </div>
                </td>
            </tr>
            
            
           <tr>
                <td><div align="right">Certificate Password :</div></td>
                <td><div align="left"><input type="text" name="certificate-file-password" id="certificate-file-password" class="required"  title="กรุณากรอก Certificate Password" value="{$certificate_file_password_cp_apps}" readonly="readonly" style="background-color: #CCCCCC" />
               
                </div>
                </td>
            </tr>  
            
         
            </table>
            
           </fieldset>
           
            <br />
           
           <fieldset><legend><h3>นำ certificate file ที่ได้ มาอัพโหลด และกรอกวันหมดอายุของ certificate file ในแบบฟอร์มด้านล่างนี้</h3></legend>
           
           
           <table width="98%">
            <tr>
                <td width="250"><div align="right">Upload Certificate File .pem:</div></td>
                <td><div align="left"><input type="file" name="certificate-file" id="certificate-file" class="required" title="กรุณาเลือก Certificate File .pem" /></div></td>
            </tr>

            <tr>
                <td><div align="right">Certificate File  .pem:</div></td>
        		<td><div align="left">{if $has_cer_pem_cp_apps eq '1'}<a href="javascript:void(0);" id="show-dialog-cer-file-cpanel" class="show-dialog"><span class="ui-button">รายละเอียดไฟล์ Certificate</span></a>{else}ยังไม่มีไฟล์ Certificate{/if}</div></td>
            </tr>
            
            <tr>
            	<td colspan="2">&nbsp;</td>
            </tr>
            
            <tr>
                <td><div align="right">Upload Certificate File .p12:</div></td>
                <td><div align="left"><input type="file" name="certificate-file-p12" id="certificate-file-p12" class="required"  title="กรุณาเลือก Certificate File .p12" /></div></td>
            </tr>

            <tr>
                <td><div align="right">Certificate File  .p12:</div></td>
        		<td><div align="left">{if $has_cer_p12_cp_apps eq '1'}<a href="javascript:void(0);" id="show-dialog-cer-file-p12-cpanel" class="show-dialog"><span class="ui-button">รายละเอียดไฟล์ Certificate</span></a>{else}ยังไม่มีไฟล์ Certificate{/if}</div></td>
            </tr>
            
            
            
            <tr>
            	<td colspan="2">&nbsp;</td>
            </tr>
            
            
 
            <tr>
          		<td><div align="right">Certificate File Expire Date:</div></td>
          		<td><div align="left"><input type="text" class="haspicker" size="12" name="certificate-expire-date" id="certificate-expire-date" class="required"  title="กรุณาเลือก กรอกวันที่" value="{$certificate_expire_date_cp_apps}" /></div></td>
            </tr>
            
            
            <tr>
            	<td><div align="right">ผลการทดลองเชื่อมต่อกับ Symantec Server : </div></td>
            	<td><div align="left">{$symantec_connection_cp_apps}</td>
            </tr>
                  
          </table>
          
          </fieldset>
          
          <br />
          
          </fieldset>
          
       
            <div class="action" align="left">
            {if $vip_info_id ne ''}
            <input type="button" id="vip-save-certificate-file-cpanel-app" name="vip-save-certificate-file-cpanel-app" value="Save" class="ui-button" /> 
            {else}
            <input type='button' class='ui-button' value='Save' disabled>
            {/if} 
            </div>
         
      </form>
      
      
      </div>
      
       <div id="dialog-cer-detail-cpanel" style="display:none;" title="Certificate file PEM Detail (cPanel)">
       
       <table>
       <tr>
       <td><div align="right">File name : </div></td>
       <td><div align="left">{$certificate_file_name}</div></td>
       </tr>
       <tr>
       <td><div  align="right">File type : </div></td>
       <td><div align="left">{$certificate_file_type}</div></td>
       </tr>
       <tr>
        <td><div  align="right">File size : </div></td>
        <td><div align="left">{$file_size} bytes</div></td>
        </tr>
       <tr>
        <td><div align="right">File upload date : </div></td>
        <td><div align="left">{$date_file_upload_pem}</div></td>
        </tr>
       <tr>
        <td><div align="right">File last upload date : </div></td>
        <td><div align="left">{$date_file_last_upload_pem}</div></td>
        </tr>
       <tr>
        <td><div align="right">md5sum : </div></td>
        <td><div align="left">{$md5sum}</div></td>
       </tr>
       <tr>
       	<td colspan="2"><div align="center"><a href="{$view_cer_pem_path}" target="_blank">Download Certificate File (คลิกขวาที่ลิ้งค์ แล้วเลือก Save Link As...)</a></div></td>
       </tr>
       </table>
       
       </div>
       
       
       
       
       <div id="dialog-cer-detail-p12-cpanel" style="display:none;" title="Certificate file P12 Detail (cPanel)">
       
       <table>
       <tr>
       <td><div align="right">File name : </div></td>
       <td><div align="left">{$certificate_file_name_p12}</div></td>
       </tr>
       <tr>
       <td><div  align="right">File type : </div></td>
       <td><div align="left">{$certificate_file_type_p12}</div></td>
       </tr>
       <tr>
        <td><div  align="right">File size : </div></td>
        <td><div align="left">{$file_size_p12} bytes</div></td>
        </tr>
       <tr>
        <td><div align="right">File upload date : </div></td>
        <td><div align="left">{$date_file_upload_p12}</div></td>
        </tr>
       <tr>
        <td><div align="right">File last upload date : </div></td>
        <td><div align="left">{$date_file_last_upload_p12}</div></td>
        </tr>
       <tr>
        <td><div align="right">md5sum : </div></td>
        <td><div align="left">{$md5sum_p12}</div></td>
       </tr>
       <tr>
       	<td colspan="2"><div align="center"><a href="{$view_cer_p12_path_p12}" target="_blank">Download Certificate File (คลิกขวาที่ลิ้งค์ แล้วเลือก Save Link As...)</a></div></td>
       </tr>
       </table>
       
       </div>
       
           
           
      
      
      		{/if}
     
          
          
      
      {elseif $product_id eq '61'}
      
      
       <br />
       
    <h3>Upload Certificate File</h3> 
    
    <br />
    
    			{if $vip_info_id eq ''}
    			
    			<br />
    			<font color='#FF0000'><b>
    			กรุณาอัพโหลด Certificate file ที่ Order หลักของผู้ซื้อนี้ก่อน
    			</b></font>
    			<br />
    			
    			{else}
    
    
    ลิ้งค์สำหรับ สร้าง Certificate file <a href='https://manager.vip.symantec.com/vipmgr/certmgrhome.v' target='_blank'>https://manager.vip.symantec.com/vipmgr/certmgrhome.v</a>
      
    <br />    <br />
    
    
      
      <!--  for Apps  -->
      
      
           <form name="frmStep2" id="frmStep2" method="post"  action="" enctype="multipart/form-data">
 
      	 	<input type="hidden" name="vip-info-id" id="vip-info-id" value="{$vip_info_id}">
    		<input type="hidden" name="usr-id" id="usr-id" value="{$usr_id}">
    		<input type="hidden" name="date-file-upload" id="date-file-upload" value="{$date_file_upload_cp_apps}">
    		<input type="hidden" name="date-file-upload-p12" id="date-file-upload-p12" value="{$date_file_upload_p12_cp_apps}">
    		<input type="hidden" name="cer-file-type" id="cer-file-type" value="Apps">
    		
    		
    		<input type="hidden" name="account-id" id="account-id" value="{$account_id}">
      
         <fieldset><legend><h1>Apps</h1></legend>
          
          
          <br />
          
          <fieldset><legend><h3>ข้อมูลสำหรับสร้าง certificate file</h3></legend>
          
    		
            <table width="98%">
            <tr>
                <td width="250"><div align="right">Certificate Name :</div></td>
                <td><div align="left"><input type="text" name="certificate-file-name" id="certificate-file-name" class="required"  title="กรุณากรอก Certificate Name .pem" value="{$certificate_file_name_cp_apps}" readonly="readonly" style="background-color: #CCCCCC"  size="50" />
                </div>
                </td>
            </tr>
            
            
           <tr>
                <td><div align="right">Certificate Password :</div></td>
                <td><div align="left"><input type="text" name="certificate-file-password" id="certificate-file-password" class="required"  title="กรุณากรอก Certificate Password" value="{$certificate_file_password_cp_apps}" readonly="readonly" style="background-color: #CCCCCC" />
               
                </div>
                </td>
            </tr>  
            
         
            </table>
            
           </fieldset>
           
            <br />
           
           <fieldset><legend><h3>นำ certificate file ที่ได้ มาอัพโหลด และกรอกวันหมดอายุของ certificate file ในแบบฟอร์มด้านล่างนี้</h3></legend>
           
           
           <table width="98%">
            <tr>
                <td width="250"><div align="right">Upload Certificate File .pem:</div></td>
                <td><div align="left"><input type="file" name="certificate-file" id="certificate-file" class="required" title="กรุณาเลือก Certificate File .pem" /></div></td>
            </tr>

            <tr>
                <td><div align="right">Certificate File  .pem:</div></td>
        		<td><div align="left">{if $has_cer_pem_cp_apps eq '1'}<a href="javascript:void(0);" id="show-dialog-cer-file-apps" class="show-dialog"><span class="ui-button">รายละเอียดไฟล์ Certificate</span></a>{else}ยังไม่มีไฟล์ Certificate{/if}</div></td>
            </tr>
            
            <tr>
            	<td colspan="2">&nbsp;</td>
            </tr>
            
            <tr>
                <td><div align="right">Upload Certificate File .p12:</div></td>
                <td><div align="left"><input type="file" name="certificate-file-p12" id="certificate-file-p12" class="required"  title="กรุณาเลือก Certificate File .p12" /></div></td>
            </tr>

            <tr>
                <td><div align="right">Certificate File  .p12:</div></td>
        		<td><div align="left">{if $has_cer_p12_cp_apps eq '1'}<a href="javascript:void(0);" id="show-dialog-cer-file-p12-apps" class="show-dialog"><span class="ui-button">รายละเอียดไฟล์ Certificate</span></a>{else}ยังไม่มีไฟล์ Certificate{/if}</div></td>
            </tr>
            
            
            
            <tr>
            	<td colspan="2">&nbsp;</td>
            </tr>
            
            
 
            <tr>
          		<td><div align="right">Certificate File Expire Date:</div></td>
          		<td><div align="left"><input type="text" class="haspicker" size="12" name="certificate-expire-date" id="certificate-expire-date" class="required"  title="กรุณาเลือก กรอกวันที่" value="{$certificate_expire_date_cp_apps}" /></div></td>
            </tr>
            
            
            <tr>
            	<td><div align="right">ผลการทดลองเชื่อมต่อกับ Symantec Server : </div></td>
            	<td><div align="left">{$symantec_connection_cp_apps}</td>
            </tr>
                  
          </table>
          
          </fieldset>
          
          <br />
          
          </fieldset>
          
       
            <div class="action" align="left">
            {if $vip_info_id ne ''}
            <input type="button" id="vip-save-certificate-file-cpanel-app" name="vip-save-certificate-file-cpanel-app" value="Save" class="ui-button" /> 
            {else}
            <input type='button' class='ui-button' value='Save' disabled>
            {/if} 
            </div>
         
      </form>
      
      
      
      
      </div>
      
       <div id="dialog-cer-detail-apps" style="display:none;" title="Certificate file PEM Detail (Apps)">
       
       <table>
       <tr>
       <td><div align="right">File name : </div></td>
       <td><div align="left">{$certificate_file_name}</div></td>
       </tr>
       <tr>
       <td><div  align="right">File type : </div></td>
       <td><div align="left">{$certificate_file_type}</div></td>
       </tr>
       <tr>
        <td><div  align="right">File size : </div></td>
        <td><div align="left">{$file_size} bytes</div></td>
        </tr>
       <tr>
        <td><div align="right">File upload date : </div></td>
        <td><div align="left">{$date_file_upload_pem}</div></td>
        </tr>
       <tr>
        <td><div align="right">File last upload date : </div></td>
        <td><div align="left">{$date_file_last_upload_pem}</div></td>
        </tr>
       <tr>
        <td><div align="right">md5sum : </div></td>
        <td><div align="left">{$md5sum}</div></td>
       </tr>
       <tr>
       	<td colspan="2"><div align="center"><a href="{$view_cer_pem_path}" target="_blank">Download Certificate File (คลิกขวาที่ลิ้งค์ แล้วเลือก Save Link As...)</a></div></td>
       </tr>
       </table>
       
       </div>
       
       
       
       
       <div id="dialog-cer-detail-p12-apps" style="display:none;" title="Certificate file P12 Detail (Apps)">
       
       <table>
       <tr>
       <td><div align="right">File name : </div></td>
       <td><div align="left">{$certificate_file_name_p12}</div></td>
       </tr>
       <tr>
       <td><div  align="right">File type : </div></td>
       <td><div align="left">{$certificate_file_type_p12}</div></td>
       </tr>
       <tr>
        <td><div  align="right">File size : </div></td>
        <td><div align="left">{$file_size_p12} bytes</div></td>
        </tr>
       <tr>
        <td><div align="right">File upload date : </div></td>
        <td><div align="left">{$date_file_upload_p12}</div></td>
        </tr>
       <tr>
        <td><div align="right">File last upload date : </div></td>
        <td><div align="left">{$date_file_last_upload_p12}</div></td>
        </tr>
       <tr>
        <td><div align="right">md5sum : </div></td>
        <td><div align="left">{$md5sum_p12}</div></td>
       </tr>
       <tr>
       	<td colspan="2"><div align="center"><a href="{$view_cer_p12_path_p12}" target="_blank">Download Certificate File (คลิกขวาที่ลิ้งค์ แล้วเลือก Save Link As...)</a></div></td>
       </tr>
       </table>
       
       </div>
       
      
      		{/if}
           
      {/if}
      
  
            <div style="clear:both;">&nbsp;</div>
  
   <br />
       </div>
