<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    {if $server_fields.display.hostname}<tr><td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td><td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.ip}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.maxaccounts}<tr><td  align="right" width="165"><strong>{if $server_fields.description.maxaccounts}{$server_fields.description.maxaccounts}{else}{$lang.maxnoofaccounts}{/if}</strong></td><td ><input  name="max_accounts" size="6" value="{$server.max_accounts}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.status_url}<tr><td  align="right" width="165">{if $server_fields.description.status_url}{$server_fields.description.status_url}{else}{$lang.serverstatusaddress}{/if}</td><td ><input  name="status_url" size="60" value="{$server.status_url}" class="inp" /></td></tr>{/if}
    {if $server_fields.display.username}<tr><td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.password}<tr><td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>{/if}
    {if $server_fields.display.field1}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td><td ><input  name="field1" size="25" value="{$server.field1}" class="inp"/></td></tr>{/if}


    {if $server_fields.display.field2}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</strong></td><td ><input  name="field2" size="25" value="{$server.field2}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.hash}<tr><td valign="top" align="right" width="165"><strong>API Token</strong><br>or Access Hash (deprecated)</td><td ><textarea name="hash" cols="60" rows="8"  class="inp">{$server.hash}</textarea></td></tr>{/if}
    {if $server_fields.display.ssl}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ssl}{$server_fields.description.ssl}{else}{$lang.Secure}{/if}</strong></td><td align="left"><input type="checkbox" value="1" {if $server.secure == '1'}checked="checked"{/if} name="secure"/> {if $server_fields.description.ssl}{else}{$lang.usessl}{/if}</td></tr>{/if}


    {if $server_fields.display.custom}
        {foreach from=$server_fields.display.custom item=conf key=k}
            {assign var="name" value=$k}
            {assign var="name2" value=$modconfig.module}
            {assign var="baz" value="$name2$name"}
            <tr>
                <td  align="right" width="165">
                    <strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}</strong>
                    {if $conf.description}<a style="padding: 5px 12px 0 10px; background-position: center center;" class="vtip_description" title="{$conf.description}"></a>{/if}
                </td>
                <td >
                    {if $conf.type=='input'}
                        <input type="text" name="custom[{$k}]" value="{$server.custom.$k}" class="inp"/>
                    {elseif $conf.type=='check'}
                        <input type="checkbox" name="custom[{$k}]" value="1" {if $server.custom.$k==1}checked="checked"{/if}/>
                    {elseif $conf.type=='password'}
                        <input type="password" autocomplete="off" name="custom[{$k}]" value="{$server.custom.$k}"  class="inp"/>
                    {elseif $conf.type=='textarea'}
                        <span style="vertical-align:top">
                        <textarea name="custom[{$k}]" rows="5" cols="60" style="margin:0px" >{$server.custom.$k}</textarea>
                    </span>
                    {elseif $conf.type=='select'}
                        <select name="custom[{$k}]"  class="inp" >
                            {foreach from=$conf.default item=selectopt}
                                <option {if $server.custom.$k == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                            {/foreach}
                        </select>
                    {/if}
                </td>
            </tr>
        {/foreach}
    {/if}
</table>