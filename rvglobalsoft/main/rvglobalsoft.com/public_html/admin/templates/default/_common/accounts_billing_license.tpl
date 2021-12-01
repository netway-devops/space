{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '_common/accounts_billing_license.tpl.php');
{/php}

{if $isLicense}
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
        <tr>
            <td width="100%" valign="top">
                <ul class="accor">
                    <li><a href="#">License</a></li>
                        <!-- <li id='account_id' style="display: none">{$sbAccountId}</li> -->
                        
                    <div style="padding: 0px 10px 10px;"> 
                      <table class ="license_site">   
                          {if $sbId}
                        <tr>
                            <td><b>RVsitebuilder</b></td>       
                        </tr>
                        <tr>
                            <td>  License_ID : </td><td> <input  class="license_id" type="text"  name="license" value="{$sbId}" disabled></td>
                            <td>  Primary IP : </td><td><input class="primary_ip" type="text"  name="primary_ip" value="{$aSite.primary_ip}"></td>
                            <td>  Secondary IP : </td><td> <input class="secondary_ip" type="text"  name="secondary_ip" value="{$aSite.secondary_ip}"></td>       
                        </tr>
                        <tr>
                            <td>  Status :</td>
                            <td>
                                <select  name="active" class="active" disabled>
                                    <option {if $aSite.active == '1'} selected="selected" {/if}value="1">Active</option>
                                    <option {if $aSite.active== '0'}selected="selected" {/if}value="0">Suspended</option>
                                </select>
                            </td>
                            <td>  Expiration Date : </td>
                            <td>
                                <input class="expiredate-site" type="text" name="expire"  value="{$aSite.expire}">
                                <input class='account_id' type="text"  value="{$sbAccountId}" style="display: none">
                            </td>                                 
                        </tr>                           
                        <tr>
                            <td>
                              <input type="button" onclick="save_site()" style="color: #fff;background-color: #087711;border-color: #047419;"  value="Save"  />
                            </td>
                       </tr>       
                    {else}
                    {/if}   
                    </table>
                    <!--------------------- RVSkin -------------------- -->
                         <table class ="license_skin">
                         {if $skId}
                                <tr>
                                    <td><b>RVskin</b></td>              
                                </tr>
                                
                                <tr>
                                    <td>  License_ID : </td>
                                    <td> <input  class="sklicense" type="text" value="{$skId}" disabled></td>
                                    <td>  Main IP : </td><td><input class="main_ip" type="text" value="{$aSkin.main_ip}"></td>
                                    <td>  second IP : </td><td> <input class="second_ip" type="text" value="{$aSkin.second_ip}"></td>
                                </tr>
                                <tr>
                                    <td>  Active :</td>
                                    <td>
                                        <select  name="status" class="skactive" disabled>
                                            <option {if $aSkin.active == 'yes'} selected="selected" {/if} value="yes">Yes</option>
                                            <option {if $aSkin.active == 'no'} selected="selected" {/if} value="no">No</option>
                                        </select>
                                    </td>
                                     <td>  Expiration Date : </td>
                                    <td>
                                        <input class="expiredate-skin" type="text" name="chooseday"  value="{$aSkin.expire}">
                                        <input class='account_id' type="text"  value="{$skAccountId}" style="display: none">
                                    </td>
                                    <td>  Auto Renew :</td>
                                    <td>
                                        <select  name="renew" class="skrenew">
                                           <option {if $aSkin.auto_renew == 'yes'}selected="selected" {/if}
                                                    value="yes">Yes</option>
                                            <option {if $aSkin.auto_renew == 'no'}selected="selected" {/if}
                                                    value="no">No</option>
                                            
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="button" onclick="save_skin()" style="color: #fff;background-color: #087711;border-color: #047419;" value="Save"  />
                                    </td>
                                </tr>  
                            {else}
                        {/if}     
                        </table>
                      {if !$sbId  and  !$skId  }  
                      <p>
                          <b>RVsitebuilder:</b>
                          <button class="btn-primary" ><a href="?cmd=verifyrvlicense&action=addRVSitebuilderLicense&id={$details.id}" style="color: #FFFFFF" >Add License</a></button>
                      </p>
                      <p>
                      <b>RVSkin:</b>
                      <button class="btn-primary" ><a href="?cmd=verifyrvlicense&action=addRVSkinLicense&id={$details.id}" style="color:#FFFFFF">Add License</a></button>  
                       </p> 
                      {/if}
                        
                        {if $skAccountId != $details.id and $skAccountId != 0  }
                            <a href="?cmd=accounts&action=edit&id={$skAccountId}" style="color: red" target="_blank">พบ IP RVSkin License นี้อยู่ที่ Account {$skAccountId}</a>
                        {/if}
                        {if $sbAccountId != $details.id and $sbAccountId != 0 }
                            <a href="?cmd=accounts&action=edit&id={$sbAccountId}"  style="color: red" target="_blank"> พบ IP RVSitebuilder License นี้อยู่ที่ Account {$sbAccountId}</a>
                        {/if} 
                    </div>
                </ul>
            </td>
        </tr>
    </tbody>
    
    
    
</table>




  {literal}
  <script>
   $(document).ready(function() {
          $('.expiredate-site').datePicker({clickInput:true,dateFormat: 'dd-M-yy'});      
          $('.expiredate-skin').datePicker({clickInput:true,dateFormat: 'dd-M-yy'});             
    
   });
   
  
  function save_site() {
      var account_id = $('.account_id').val();
      var license       = $('.license_id').val();
      var primary_ip    = $('.primary_ip').val();
      var secondary_ip  = $('.secondary_ip').val(); 
      var active        = $('.active').val();
      var expiredate    = $('.expiredate-site').val();      
      var accountDate   = expiredate.split('/');
      var nexDue        = accountDate[2] + '-'+accountDate[1] + '-'+ accountDate[0];
      console.log(account_id+' '+expiredate+' '+nexDue);
        $.post( "?cmd=verifyrvlicense&action=updateSite_Licence", 
        {
            expiredate   : expiredate,
            account_id   : account_id,
            license      : license,
            primary_ip   : primary_ip,
            secondary_ip : secondary_ip,
            active       : active,
            nexDue       : nexDue
        },function(data) {
        location.reload();
       });
  }
  
    function save_skin() {
        var account_id = $('.account_id').val();
        var license    = $('.sklicense').val();
        var main_ip    = $('.main_ip').val();
        var second_ip  = $('.second_ip').val(); 
        var active     = $('.skactive').val();
        var expiredate = $('.expiredate-skin').val();
        var accountDate = expiredate.split('/');
        var nexDue      = accountDate[2] + '-'+accountDate[1] + '-'+ accountDate[0];
        var renew       =$('.skrenew').val();
      console.log(account_id+' '+license+' '+main_ip+' '+second_ip+' '+active+' '+expiredate+renew+' '+nexDue);
        $.post( "?cmd=verifyrvlicense&action=updateSkin_Licence", 
        {
            account_id   : account_id,
            license      : license,
            main_ip      : main_ip,
            second_ip    : second_ip,
            active       : active,
            expiredate   : expiredate,
            nexDue       : nexDue,
            renew        : renew
        },function(data) {
            location.reload();
       });
    }
 </script> 
 
   {/literal}   
{/if}
    

