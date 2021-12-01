{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'contacts/contacts.tpl.php');
{/php}
{*

    Manage contacts

*}

            
<div class="text-block clear clearfix">
  <h5>{$lang.account}</h5>
 
  <div class="clear clearfix">
      <div class="account-box">
      
          {include file='clientarea/leftnavigation.tpl'}
          
          <div class="account-content">
          <div class="content-padding">
              <h6>{*$lang.profiles*}{if $act == 'emailcontact'}Email contact{else}Address contact{/if}</h6>
              <div class="overflow-fix" style="overflow:visible">
              {if $act == 'emailcontact'}
              <div class="table-box">
                  <div class="table-header">
                      <div class="right-btns-l">
                          <form id="formEmailContact" method="post" action="" >
                              <span id="actNotification" class="alert text-error"></span>
                              <input type="text" name="emailaddress" id="emailaddress" value="" placeholder="กรุณาระบุ email ที่ต้องการให้แจ้งเตือน" class="input-xlarge" />
                              <input type="submit" name="add" value="+ เพิ่ม" class="btn btn-success" />
                          </form>
                      </div>
                  </div>
                  {if $profiles}
                  <table class="table table-striped table-hover tb-account table-fix">
                      <tr class="table-header-high" valign="bottom">
                          <th>Email address</th>
                          <th>Contact</th>
                          <th>Notification</th>
                          <th class="w20">{$lang.options}</th>
                      </tr>
                      <tr valign="top">
                          <td class="blue-c">{$oClient->email}</td>
                          <td class="grey-c">
                              {$oClient->firstname} {$oClient->lastname}<br />
                              {$oClient->phonenumber}
                          </td>
                          <td class="grey-c">All notification</td>
                          <td class="grey-c">
                            Main account
                         </td>
                      </tr>
                      {foreach from=$profiles item=p name=ff}
                          {if $aContacts[$p.id]->addressType != 'Notify'}
                              {continue}
                          {/if}
                      <tr valign="top">
                          <td class="blue-c">{$p.email}</td>
                          <td class="grey-c">
                              {if $p.email != $aContacts[$p.id]->firstname}{$aContacts[$p.id]->firstname}{/if} {$aContacts[$p.id]->lastname}<br />
                              {$aContacts[$p.id]->phonenumber}
                          </td>
                          <td class="grey-c">{$aContacts[$p.id]->notifyInfo}</td>
                          <td class="cell-border">
                            <div class="btn-group">
                                <a href="{$ca_url}profiles/edit/{$p.id}/&act=emailcontact" class="btn dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-cog"></i> 
                                    <span class="caret" style="padding:0;"></span>
                                </a>
                                <ul class="dropdown-menu" style="right:0; left:auto;">
                                    <div class="dropdown-padding">
                                        <li><a href="{$ca_url}profiles/edit/{$p.id}/&act=emailcontact" style="color:#737373">{$lang.editcontact}</a></li>
                                        <li><a href="{$ca_url}profiles/&do=delete&id={$p.id}&security_token={$security_token}" 
                                                onclick="{literal}if (confirm('{/literal}{$lang.areyousuredelete}{literal}')) {$.get(''+$(this).prop('href')+'', {}, function() { location.reload(); });} return false;{/literal}" 
                                                style="color:red">{$lang.delete}</a></li>
                                    </div>
                                </ul>
                            </div>
                         </td>
                      </tr>
                      {/foreach}
                  </table>
                  <p><br /><br /><br /><br /><br /></p>
                  {/if}
              </div>
              
              {literal}
              <script language="javascript">
              $(document).ready( function () {
                  $('#formEmailContact').submit( function () {
                      $('#actNotification').hide();
                      
                      $.post('?cmd=addresshandle&action=addEmailContact', { emailaddress : $('#emailaddress').val() }, function (data) {
                          var oData     = $.parseJSON(data);
                          if (oData.result.success == '1') {
                              window.location = '{/literal}{$ca_url}{literal}profiles/edit/'+ oData.result.contactId +'/&act=emailcontact';
                          } else {
                              $('#actNotification').html(oData.result.message).show();
                          }
                          
                      });
                      return false;
                  });
                  $('#actNotification').hide();
                  
              });
              </script>
              {/literal}
              
              {else}
              <div class="table-box">
                  <div class="table-header">
                      <div class="right-btns-l">
                          <a href="{$ca_url}profiles/add/" class="clearstyle green-custom-btn btn l-btn"><i class="icon-white-add"></i> {$lang.addnewprofile}</a>
                      </div>
                      <p class="small-txt">{$lang.profileinfo}</p>
                  </div>
                  {if $profiles}
                  <table class="table table-striped table-hover tb-account table-fix">
                      <tr class="table-header-high" valign="bottom">
                          <th>{$lang.firstname} {$lang.lastname}</th>
                          <th> ที่อยู่ / {$lang.email} </th>
                          {*<th class="w20">{$lang.lastname}</th>*}
                          {*<th class="w25 cell-border">{$lang.email}</th>*}
                          <th class="w20 cell-border">{*$lang.lastlogin*}ใช้ล่าสุด</th>
                          <th class="w10">{$lang.options}</th>
                      </tr>
                      <tr valign="top">
                          <td class="blue-c" valign="top">{$oClient->firstname} {$oClient->lastname}<br /><br /><br /><br /></td>
                          <td class="blue-c">
                              <span class="text-gray">
                              {if $oClient->companyname != ''}{$oClient->companyname}<br />{/if}
                              {$oClient->address1} {$oClient->address2}<br />
                              {$oClient->city} {$oClient->state} {$oClient->postcode}<br />
                              {$oClient->phonenumber}
                              </span>
                          </td>
                          <td class="cell-border grey-c">
                              Main contact
                          </td>
                          <td class="cell-border">
                            <div class="btn-group">
                                <a href="{$ca_url}clientarea/details/" class="btn dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-cog"></i> 
                                    <span class="caret" style="padding:0;"></span>
                                </a>
                                <ul class="dropdown-menu" style="right:0; left:auto;">
                                    <div class="dropdown-padding">
                                        <li><a href="{$ca_url}clientarea/details/" style="color:#737373">{$lang.editcontact}</a></li>
                                    </div>
                                </ul>
                            </div>
                         </td>
                      </tr>
                      {foreach from=$profiles item=p name=ff}
                          {if $aContacts[$p.id]->addressType != '' && $aContacts[$p.id]->addressType != 'Invoice'}
                              {continue}
                          {/if}
                      <tr class="address-type-{$aContacts[$p.id]->addressType}" valign="top">
                          <td class="blue-c" valign="top">{$p.firstname} {$p.lastname}<br /><br /><br /><br /></td>
                          <td class="blue-c">
                              <span class="text-gray">
                              {if $aContacts[$p.id]->companyname != ''}{$aContacts[$p.id]->companyname}<br />{/if}
                              {$aContacts[$p.id]->address1} {$aContacts[$p.id]->address2}<br />
                              {$aContacts[$p.id]->city} {$aContacts[$p.id]->state} {$aContacts[$p.id]->postcode}<br />
                              {$aContacts[$p.id]->phonenumber}
                              </span>
                          </td>
                          {*<td class="cell-border blue-c">{$p.lastname}</td>*}
                          {*<td class="cell-border blue-c">{$p.email}</td>*}
                          <td class="cell-border grey-c">
                          {if $p.lastlogin == '0000-00-00 00:00:00'}
                              -
                          {else}
                              {$p.lastlogin|date_format:'%d %b %Y'}
                          {/if}</td>
                          <td class="cell-border">
                            <div class="btn-group">
              					<a href="{$ca_url}profiles/edit/{$p.id}/" class="btn dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-cog"></i> 
                                    <span class="caret" style="padding:0;"></span>
                                </a>
                                <ul class="dropdown-menu" style="right:0; left:auto;">
                                	<div class="dropdown-padding">
            							<li><a href="{$ca_url}profiles/edit/{$p.id}/" style="color:#737373">{$lang.editcontact}</a></li>
            							{*<li><a href="{$ca_url}profiles/loginascontact/{$p.id}/" style="color:#737373">{$lang.loginascontact}</a></li>*}
            							{if ! isset($aIsUnableToDelete) || ! in_array($p.id, $aIsUnableToDelete)}
            							<li><a href="{$ca_url}profiles/&do=delete&id={$p.id}&security_token={$security_token}" onclick="return confirm('{$lang.areyousuredelete}');" style="color:red">{$lang.delete}</a></li>
            							{else}
            							<li><a href="javascript:void(0);" class="disabled" style="color:#999999;">ถูกใช้งานอยู่</a></li>
            							{/if}
									</div>
          						</ul>
          					</div>
                         </td>
                      </tr>
                      {/foreach}
                  </table>
                  <p><br /><br /><br /><br /><br /></p>
                  {else}
                      <h3>{$lang.nothing}</h3>
                  {/if}
              </div>
              {/if}
          </div>
      </div>
      </div>
      
      
  </div>
</div>
</div>


