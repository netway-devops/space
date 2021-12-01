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
              <h6>{$lang.profiles}</h6>
              <div class="overflow-fix" style="overflow:visible">
              <div class="table-box">
                  <div class="table-header">
                      <div class="right-btns-l">
                          <a href="{$ca_url}profiles/add/" class="clearstyle green-custom-btn btn l-btn"><i class="icon-white-add"></i> {$lang.addnewprofile}</a>
                      </div>
                      <p class="small-txt">{$lang.profileinfo}</p>
                  </div>
                  {if $profiles}
                  <table class="table table-striped table-hover tb-account table-fix">
                      <tr class="table-header-high">
                          <th>{$lang.firstname}</th>
                          <th class="w20">{$lang.lastname}</th>
                          <th class="w25 cell-border">{$lang.email}</th>
                          <th class="w20 cell-border">{$lang.lastlogin}</th>
                          <th class="w10">{$lang.options}</th>
                      </tr>
                      {foreach from=$profiles item=p name=ff}
                      <tr>
                          <td class="blue-c">{$p.firstname}</td>
                          <td class="cell-border blue-c">{$p.lastname}</td>
                          <td class="cell-border blue-c">{$p.email}</td>
                          <td class="cell-border grey-c">
                          {if !$p.lastlogin|date_format:'%d %b %Y'}
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
            							<li><a href="{$ca_url}profiles/edit/{$p.id}/" style="color:#737373">{if $lang.editcontact} {$lang.editcontact} {else} Edit contact {/if}</a></li>
            							<li><a href="{$ca_url}profiles/loginascontact/{$p.id}/" style="color:#737373">{if $lang.loginascontact} {$lang.loginascontact} {else} Login as contact {/if}</a></li>
            							<li><a href="{$ca_url}profiles/&do=delete&id={$p.id}&security_token={$security_token}" onclick="return confirm('{$lang.areyousuredelete}');" style="color:red">{$lang.delete}</a></li>
									</div>
          						</ul>
          					</div>
                         </td>
                      </tr>
                      {/foreach}
                  </table>
                  {else}
                      <h3>{$lang.nothing}</h3>
                  {/if}
              </div>
          </div>
      </div>
      </div>
      
      
  </div>
</div>
</div>


