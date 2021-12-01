<input type="hidden" name="submit" value="1"/>


<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td width="50%" valign="top">


            <table cellspacing="2" cellpadding="3" border="0" width="100%">
                <tbody>

                    {if $allowsynchronize}
                        <tr
                                {if $details.manual == '1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if} {if $details.status != 'Pending' || $details.status=='Terminated'}class="livemode"{/if}>
                            <td width="150">{$lang.lastsync}</td>
                            <td>{if $details.synch_date == '0000-00-00 00:00:00'}{$lang.None}{else}{if $details.synch_error}
                                    <font style="color:#990000; font-weight: bold; margin-right: 10px;">{$lang.Failed}</font>{else}
                                    <font style="color:#006633; font-weight: bold; margin-right: 10px;">{$lang.Successful}</font>{/if}{$details.synch_date|dateformat:$date_format}{/if}
                                <button type="submit" name="synchronize"
                                        class="btn btn-default btn-sm">{$lang.Synchronize}</button>
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td width="150">{$lang.Package}</td>
                        <td>
                            <select name="product_id" id="product_id" onchange="sh1xa(this, '{$details.product_id}')">
                                {foreach from=$packages item=package}
                                {if $package.catname!=$baz}
                                {if $baz}</optgroup>{/if}
                                <optgroup label="{$package.catname}">{/if}
                                    <option value="{$package.id}"
                                            {if $package.simmilar=='0'}class="h_manumode"{/if}
                                            {if $package.simmilar=='0' && $details.manual=='0'}disabled="disabled"{/if}
                                            {if $package.id==$details.product_id}selected="selected" def="def"{/if} >
                                        {$package.name}
                                    </option>

                                    {if $package.catname!=$baz}
                                        {assign var=baz value=$package.catname}
                                    {/if}
                                    {/foreach}

                            </select>
                            <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank"
                               id="link_to_product" class="btn btn-sm"><i class="fa fa-external-link"></i></a>
                            <div style="display:none;padding:3px;" id="upgrade_opt" class="lighterblue">

                                <input type="submit" class="btn btn-default btn-sm" name="charge_upgrade"
                                       value="{$lang.orderupgrade}"
                                       {if  $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}/>
                                {if $allowpckgchange}
                                    <input type="submit" class="btn btn-default btn-sm"
                                           name="changepackage" onclick="return checkup()"
                                           value="{$lang.changepackage}" class="livemode"
                                           {if  $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}/>
                                {/if}
                            </div>

                        </td>
                    </tr>


                    <tr>
                        <td>{$lang.Server} / App</td>
                        <td>
                            <div id="serversload">
                                <select name="server_id" id="server_id"
                                        class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
                                        {if $details.manual != '1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}>
                                    <option value="0" {if $server.id=='0'}selected="selected"
                                            def="def"{/if}>{$lang.none}</option>
                                    {if $servers}
                                        {foreach from=$servers item=server}
                                            <option value="{$server.id}"
                                                    {if $details.server_id==$server.id}selected="selected"
                                                    def="def"{/if}>{$server.name} ({$server.accounts}
                                                /{$server.max_accounts} Accounts)
                                            </option>
                                        {/foreach}
                                    {else}
                                        <option value="0">{$lang.noservers}</option>
                                    {/if}
                                </select></div>

                            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
                                  {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{if $details.server_name}{$details.server_name}{else}{$lang.none}{/if}</span>

                        </td>
                    </tr>
                    {if !$details_fields || (count($details_fields)==1 && $details_fields.option4)}

                            <tr {if $details.domain==""}class="manumode" style="display:none"{/if}>
                                <td>{$lang.Hostname}</td>
                                <td>
                                    <input type="text" value="{$details.domain|escape}" name="domain" id="domain_name"
                                           class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
                                           {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                                    <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
                                          {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.domain}</span>
                                    <a style="color: rgb(204, 0, 0);" target="_blank" href="http://{$details.domain}">www</a>
                                    <a target="_blank"
                                       href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.domain}&security_token={$security_token}"
                                       onclick="window.open(this.href, 'WHOIS', 'width=500, height=500, scrollbars=1');
                                            return false">whois</a>
                                </td>
                            </tr>

                        {if $details.ptype=='Dedicated' || $details.ptype=='Server' || $details.ptype=='Colocation'}
                            <tr>
                                <td>{$lang.Username}</td>
                                <td>
                                    {if $details.user_error == '1' && $details.status != 'Pending' && $details.status != 'Terminated' && $details.manual != '1'}
                                        <strong style="color: red">{$lang.userdiff}</strong>
                                        <br/>
                                    {/if}
                                    <input type="text" value="{$details.username|escape}" name="username" size="20"
                                           id="username"
                                           class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
                                           {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                                    <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
                                          {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>
                                        {$details.username|escape}
                                    </span>
                                </td>
                            </tr>
                            {if $admindata.access.viewAccountsPasswords}
                                <tr>
                                    <td>{$lang.Password}</td>
                                    <td>
                                        <input type="text" value="{$details.password|escape}" name="password" size="20"
                                               id="password" autocomplete="off"/>
                                        {if $allowpasschange}
                                            <input type="submit"
                                                   name="changepassword"
                                                   class="btn btn-default btn-sm"
                                                   value="{$lang.changepassword}"/>
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td>{$lang.rootpass}</td>
                                    <td>
                                        <input type="text" value="{$details.rootpassword|escape}" name="rootpassword" size="20"
                                               id="password"/>
                                    </td>
                                </tr>
                            {else}
                                <input type="hidden" value="{$details.password|escape}" name="password" size="20" id="password"/>
                                <input type="hidden" value="{$details.rootpassword|escape}" name="rootpassword" size="20" id="password"/>
                            {/if}
                        {/if}
                    {elseif $details_fields}
                        {foreach from=$details_fields item=field key=field_key}
                            {if $field.name == 'domain'}
                                {if $field.type == 'hidden'}
                                    <input value="{$details.domain|escape}" name="domain" id="domain_name" type="hidden"/>
                                {else}
                                    <tr>
                                        <td>{if $details.ptype=='Dedicated' || $details.ptype=='Server' || $details.ptype=='Colocation'}{$lang.Hostname}{else}{$lang.Domain}{/if}</td>
                                        <td>
                                            <input type="text" value="{$details.domain|escape}" name="domain" id="domain_name"
                                                   class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
                                                   {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                                            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
                                                  {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>
                                                {$details.domain}
                                            </span>
                                            <a style="color: rgb(204, 0, 0);" target="_blank"
                                               href="http://{$details.domain}">www</a>
                                            <a target="_blank"
                                               href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.domain}&security_token={$security_token}"
                                               onclick="window.open(this.href, 'WHOIS', 'width=500, height=500, scrollbars=1');
                                                return false">whois</a>
                                        </td>
                                    </tr>
                                {/if}
                            {elseif $field.name == 'username'}
                                {if $field.type == 'hidden'}
                                    <input type="hidden" value="{$details.username|escape}" name="username" size="20"
                                           id="username"/>
                                {else}
                                    <tr>
                                        <td>{$lang.Username}</td>
                                        <td>{if $details.user_error == '1' && $details.status != 'Pending' && $details.status != 'Terminated' && $details.manual != '1'}
                                                <strong style="color: red">{$lang.userdiff}</strong>
                                                <br/>
                                            {/if}

                                            <input type="text" value="{$details.username|escape}" name="username" size="20"
                                                   id="username"
                                                   class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
                                                   {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                                            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
                                                  {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>
                                                {$details.username|escape}
                                            </span>
                                        </td>
                                    </tr>
                                {/if}
                            {elseif $field.name == 'password'}
                                {if $field.type == 'hidden'}
                                    <input type="hidden" value="{$details.password|escape}" name="password" size="20"
                                           id="password"/>
                                {else}

                                    {if $admindata.access.viewAccountsPasswords}
                                        <tr>
                                            <td>{$lang.Password}</td>
                                            <td>
                                                <input type="text" value="{$details.password|escape}" name="password" size="20"
                                                       id="password" autocomplete="off"/>
                                                {if $allowpasschange}
                                                    <input type="submit"
                                                           name="changepassword"
                                                           value="{$lang.changepassword}"
                                                           class="btn btn-default btn-sm"/>
                                                {/if}
                                            </td>
                                        </tr>
                                    {else}
                                        <input type="hidden" value="{$details.password|escape}" name="password" size="20" id="password"/>
                                    {/if}
                                {/if}
                            {elseif $field.name == 'rootpassword'}
                                {if $field.type == 'hidden'}
                                    <input type="hidden" value="{$details.rootpassword|escape}" name="rootpassword" size="20"
                                           id="password"/>
                                {else}
                                    {if $admindata.access.viewAccountsPasswords}
                                        <tr>
                                            <td>{$lang.rootpass}</td>
                                            <td><input type="text" value="{$details.rootpassword|escape}" name="rootpassword"
                                                       size="20" id="password"/></td>
                                        </tr>
                                    {else}
                                        <input type="hidden" value="{$details.rootpassword|escape}" name="rootpassword" size="20" id="rootpassword"/>
                                    {/if}
                                {/if}
                            {elseif $field.name}

                                {if $field.type == 'hidden'}
                                    <input type="hidden"
                                           value="{if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}{/if}"
                                           name="extra_details[{$field_key}]"/>
                                {else}
                                    <tr>
                                        <td>{if $lang[$field.name]}{$lang[$field.name]}{else}{$field.name}{/if}</td>
                                        <td>
                                            {if $field.type == 'input'}
                                                <input type="text"
                                                       value="{if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}{/if}"
                                                       name="extra_details[{$field_key}]" size="20"
                                                       class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
                                                       {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                                                <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
                                                      {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>
                                                    {if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}
                                                    {/if}
                                                </span>
                                            {elseif $field.type == 'select'}
                                                <select name="extra_details[{$field_key}]"
                                                        class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"
                                                        {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}>
                                                    {foreach from=$field.default item=item}
                                                        <option value="{$item|escape:'html':'utf-8'}"
                                                                {if $item == $details.extra_details.$field_key}selected{/if}>{$item|escape:'html':'utf-8'}</option>
                                                    {/foreach}
                                                </select>
                                                <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}"
                                                      {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>
                                                    {if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}
                                                    {/if}
                                                </span>
                                            {elseif $field.type == 'tpl'}
                                                {include file=$field.tpl value=$details.extra_details.$field_key}
                                            {/if}
                                        </td>
                                    </tr>
                                {/if}
                            {/if}
                        {/foreach}
                    {/if}



                    {if ($details.status=='Active' || $details.status=='Suspended') && $custom.GetStatus}
                        <tr>
                            <td>{$lang.Status}</td>
                            <td><a href="" onclick="getStatus({$details.id}, this); return false;">Get Status</a></td>
                        </tr>
                    {/if}
                    {literal}
                    <script type="text/javascript">
                        function getStatus(id, elem) {
                            var field = $(elem).parent();
                            $(field).html('{/literal}{$lang.Loading}...{literal}');
                            ajax_update('?cmd=accounts&action=getstatus&id=' + id, {}, field);
                            return false;
                        }
                    </script>
                    {/literal}

                    <tr {if !$allowterminate && !$allowsuspend && !$allowcreate && !$allowunsuspend && !$allowrenewal}class="manumode"
                        {if $details.manual!='1'}style="display:none"{/if}{/if}>
                        <td>{$lang.availactions}</td>
                        <td>


                            <input type="submit" onclick="$('body').addLoader();" name="create" value="Create"
                                   class="{if !$allowcreate}manumode{/if} btn btn-primary btn-sm"
                                   {if !$allowcreate && $details.manual!='1'}style="display:none"{/if}/>

                            <input type="submit" name="suspend" value="Suspend"
                                   class="{if !$allowsuspend} manumode{/if} btn btn-default btn-sm"
                                   {if !$allowsuspend && $details.manual!='1'}style="display:none"{/if}
                                   onclick="return confirm('{$lang.suspendconfirm}')"/>
                            <input type="submit" name="unsuspend" value="Unsuspend"
                                   class="{if !$allowunsuspend} manumode{/if} btn btn-default btn-sm"
                                   {if !$allowunsuspend && $details.manual!='1'}style="display:none"{/if}/>

                            <input type="submit" name="terminate" value="Terminate"
                                   class="{if !$allowterminate}manumode{/if} btn btn-danger btn-sm"
                                   {if !$allowterminate && $details.manual!='1'}style="display:none;;"{else}
                                   style=""{/if} onclick="return confirm('{$lang.terminateconfirm}')"/>


                            <input type="submit" name="renewal" value="Renewal"
                                   {if !$allowrenewal}style="display:none"{/if} class="btn btn-default btn-sm"/>


                            {foreach from=$custom item=btn}
                                {if $btn!='GetOsTemplates' && $btn!='GetNodes' && $btn!='GetStatus' && $btn!='restoreBackup' && $btn!='createBackup' && $btn!='deleteBackup'}
                                    <input type="submit" name="customfn" value="{$btn}"
                                           class="{if $details.status!='Active'}manumode{/if} {if $loadable[$btn]}toLoad{/if} btn btn-default btn-sm"
                                           {if $details.status!='Active' && $details.manual!='1'}style="display:none"{/if} />
                                {/if}
                            {/foreach}

                        </td>
                    </tr>
                    {if $details.autosuspend==1}
                    <tr {if !$allowautosuspend}style="display:none"{/if}>
                        <td>{$lang.overridesus}
                        </td>
                        <td>
                            <input type="checkbox" name="autosuspend" value="1"
                                   {if $details.autosuspend==1}checked="checked"{/if} onclick="autosus(this)"
                                   style="float:left"/>
                            <div id="autosuspend_date" {if $details.autosuspend!=1}style="display:none"{/if} >
                                <input name="autosuspend_date"
                                       value="{$details.autosuspend_date|dateformat:$date_format}" class="haspicker"
                                       size="12"/>
                            </div>
                        </td>
                    </tr>
                    {/if}
                    <tr>
                        <td>{$lang.sendacce}</td>
                        <td><select name="mail_id" id="mail_id">
                                {foreach from=$product_emails item=send_email}
                                    <option value="{$send_email.id}"
                                            {if $send_email.id==$welcome_email_id}selected="selected"{/if}>{$send_email.tplname}</option>
                                {/foreach}
                                <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
                            </select>
                            <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"
                                   class="btn btn-default btn-sm"/>
                        </td>
                    </tr>
                </tbody>
            </table>

        </td>
        <td width="50%" valign="top">
            {if $details.status!='Cancelled' && $details.status!='Fraud'}
                <div id="autoqueue">
                    <i class="fa fa-circle-o-notch fa-spin  fa-fw"></i>
                    <span class="sr-only">Loading...</span>
                    Loading automation queue
                    <script type="text/javascript">
                        appendLoader('getAccQueue');

                        function getAccQueue() {literal}{{/literal}
                            ajax_update("?cmd=accounts&action=getqueue&id={$details.id}&product_id={$details.product_id}", false, '#autoqueue');
                            {literal}}{/literal}
                    </script>
                </div>
            {/if}
        </td>

    </tr>
</table>

{if $details.custom}
    <input type="hidden" name="arecustom" value="1"/>
    <table cellspacing="2" cellpadding="3" border="0" width="100%">
        {foreach from=$details.custom item=c key=kk}
            {if $c.items}
                <tr>
                    <td style="vertical-align: top" width="150">{$c.name} </td>
                    <td>
                        {include file=$c.configtemplates.accounts currency=$details.currency forcerecalc=true}
                    </td>
                </tr>
            {/if}
        {/foreach}

    </table>
{/if}



{adminwidget module="accounts" section="accountdetails"}