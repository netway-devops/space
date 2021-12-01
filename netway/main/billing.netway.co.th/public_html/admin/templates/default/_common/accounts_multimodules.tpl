{foreach from=$details.modules item=module key=mid}
    <ul class="accor">
        <li>
            <a href="#" class="bg-{$module.status}">Module details: {$module.modname} ({$module.status})</a>
            <div class="sor">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="50%" valign="top">
                            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                                <tbody>

                                    <tr>
                                        <td >{$lang.Server} / App</td>
                                        <td>
                                            <div  >
                                                <select name="modules[{$mid}][server_id]" id="server_id" >
                                                    <option value="0" {if $server.id=='0'}selected="selected" def="def"{/if}>{$lang.none}</option>
                                                    {foreach from=$moduleservers.$mid item=server}
                                                        <option value="{$server.id}" {if $module.server_id==$server.id}selected="selected" def="def"{/if}>{$server.name} ({$server.accounts}/{$server.max_accounts} Accounts)</option>
                                                    {foreachelse}
                                                        <option value="0">{$lang.noservers}</option>
                                                    {/foreach}
                                                </select></div>


                                        </td>
                                    </tr>
                                    <tr>
                                        <td>{$lang.Status}</td> 
                                        <td>
                                            <select name="modules[{$mid}][status]">
                                                <option {if $module.status=='Pending'}selected="selected"{/if} value="Pending">{$lang.Pending}</option>
                                                <option {if $module.status=='Active'}selected="selected"{/if} value="Active">{$lang.Active}</option>
                                                <option {if $module.status=='Suspended'}selected="selected"{/if} value="Suspended">{$lang.Suspended}</option>
                                                <option {if $module.status=='Cancelled'}selected="selected"{/if} value="Cancelled">{$lang.Cancelled}</option>
                                                <option {if $module.status=='Terminated'}selected="selected"{/if} value="Terminated">{$lang.Terminated}</option>
                                            </select>
                                        </td>
                                    </tr>

                                    {if $moduledetails.$mid}
                                        {foreach from=$moduledetails.$mid item=field key=field_key}
                                            {if $field.name == 'domain'}

                                            {elseif $field.name == 'username'}
                                                <tr>
                                                    <td >{$lang.Username}</td>
                                                    <td >
                                                        <input type="text" value="{$module.username}" name="modules[{$mid}][username]" size="20"  class="{if $module.status!='Pending' && $module.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $module.status!='Pending' && $module.status!='Terminated'}style="display:none"{/if}/>
                                                        <span class="{if $module.status!='Pending' && $module.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $module.status=='Pending' || $module.status=='Terminated'}style="display:none"{/if}>
                                                        {if $module.username}{$module.username}{else}<span style="color:#848C93;user-select: none">{$lang.none}</span>{/if}
                                                    </span>
                                                </td>
                                            </tr>
                                        {elseif $field.name == 'password'}
                                            {if $admindata.access.passwordSettings}
                                                <tr>
                                                    <td >{$lang.Password}</td>
                                                    <td ><input type="text" value="{$module.password}" name="modules[{$mid}][password]" size="20" />  {if $moduleacl.$mid.allowpasschange}<input type="submit" class="btn btn-sm btn-default" name="moduleaction[{$mid}][changepassword]" value="{$lang.changepassword}" />{/if}</td>
                                                </tr>
                                            {else}
                                                <input type="hidden" value="{$module.password}" name="modules[{$mid}][password]"/>
                                            {/if}
                                        {elseif $field.name == 'rootpassword'}
                                            {if $admindata.access.passwordSettings}
                                                <tr>
                                                    <td >{$lang.rootpass}</td>
                                                    <td ><input type="text" value="{$module.rootpassword}" name="modules[{$mid}][rootpassword]" size="20" /></td>
                                                </tr>
                                            {else}
                                                <input type="hidden" value="{$module.rootpassword}" name="modules[{$mid}][rootpassword]"/>
                                            {/if}
                                        {elseif $field.name}
                                            {if $field.type == 'hidden'}
                                            <input type="hidden" value="{if $module.extra_details.$field_key}{$module.extra_details.$field_key}{/if}" name="modules[{$mid}][extra_details][{$field_key}]" />
                                        {else}
                                            <tr>
                                                <td>{if $lang[$field.name]}{$lang[$field.name]}{else}{$field.name}{/if}</td>
                                                <td>
                                                    {if $field.type == 'input'}
                                                        <input type="text" value="{if $module.extra_details.$field_key}{$module.extra_details.$field_key}{/if}" name="modules[{$mid}][extra_details][{$field_key}]" size="20" class="{if $module.status!='Pending' && $module.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $module.status!='Pending' && $module.status!='Terminated'}style="display:none"{/if}/>
                                                        <span class="{if $module.status!='Pending' && $module.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $module.status=='Pending' || $module.status=='Terminated'}style="display:none"{/if}>
                                                        {if $module.extra_details.$field_key}{$module.extra_details.$field_key}{else}<span style="color:#848C93;user-select: none">{$lang.empty}</span>{/if}
                                                    </span>
                                                {elseif $field.type == 'tpl'}{include file=$field.tpl value=$details.extra_details.$field_key}

                                                {/if}
                                            </td>
                                        </tr>
                                    {/if}
                                {/if}
                            {/foreach}
                        {/if}

                        <tr >
                            <td >{$lang.availactions}</td>
                            <td >

                                <input type="submit" onclick="$('body').addLoader();"  name="moduleaction[{$mid}][create]" value="Create" class="{if !$moduleacl.$mid.allowcreate}manumode{/if} btn btn-sm btn-primary" {if !$moduleacl.$mid.allowcreate && $details.manual!='1'}style="display:none"{/if}/>
                                <input type="submit" name="moduleaction[{$mid}][suspend]" value="Suspend"  class="{if !$moduleacl.$mid.allowsuspend}manumode{/if}  btn btn-sm btn-default" {if !$moduleacl.$mid.allowsuspend && $details.manual!='1'}style="display:none"{/if}  onclick="return confirm('{$lang.suspendconfirm}')"/>
                                <input type="submit" name="moduleaction[{$mid}][unsuspend]" value="Unsuspend"  class="{if !$moduleacl.$mid.allowunsuspend}manumode{/if} btn btn-sm btn-default" {if !$moduleacl.$mid.allowunsuspend && $details.manual!='1'}style="display:none"{/if}/>
                                <input type="submit" name="moduleaction[{$mid}][terminate]"  value="Terminate" class="{if !$moduleacl.$mid.allowterminate}manumode{/if} btn btn-sm btn-danger" {if !$moduleacl.$mid.allowterminate && $details.manual!='1'}style="display:none;"{else} {/if} onclick="return confirm('{$lang.terminateconfirm}')"/>
                                <input type="submit" name="moduleaction[{$mid}][renewal]"  value="Renewal"  class="btn btn-sm btn-default" {if !$moduleacl.$mid.allowrenewal}style="display:none"{/if}/>


                                {foreach from=$modulecustom.$mid item=btn}
                                    <input type="submit" name="moduleaction[{$mid}][customfn]" value="{$btn}" class="{if $module.status!='Active'}manumode{/if} {if $loadable[$btn]}toLoad{/if}" {if $module.status!='Active' && $details.manual!='1'}style="display:none"{/if} />
                                {/foreach}

                            </td>
                        </tr>
                        </tbody>
                    </table>

                </td>
                <td width="50%" valign="top"></td>
            </tr>
        </table>
    </div>
</li>
</ul>
    {if $typetemplates.adminaccounts.details.append.$mid}
        {include file=$typetemplates.adminaccounts.details.append.$mid}
    {/if}
{/foreach}