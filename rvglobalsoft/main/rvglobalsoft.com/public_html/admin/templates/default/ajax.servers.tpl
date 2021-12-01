{if $action == 'get_fields'}
    {if $server_fields &&  $server.type!='Domain'}
        {if $custom_template}
            {include file=$custom_template}
        {else}
            <table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
            {if $server_fields.display.hostname}<tr><td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td><td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.ip}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.maxaccounts}<tr><td  align="right" width="165"><strong>{if $server_fields.description.maxaccounts}{$server_fields.description.maxaccounts}{else}{$lang.maxnoofaccounts}{/if}</strong></td><td ><input  name="max_accounts" size="6" value="{$server.max_accounts}" class="inp"/></td></tr>{/if}
{if $server_fields.display.status_url}<tr><td  align="right" width="165">{if $server_fields.description.status_url}{$server_fields.description.status_url}{else}{$lang.serverstatusaddress}{/if}</td><td ><input  name="status_url" size="60" value="{$server.status_url}" class="inp" /></td></tr>{/if}
{if $server_fields.display.username}<tr><td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>{/if}
{if $server_fields.display.password}<tr><td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>{/if}
{if $server_fields.display.field1}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td><td ><input  name="field1" size="25" value="{$server.field1}" class="inp"/></td></tr>{/if}
{if $server_fields.display.field2}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</strong></td><td ><input  name="field2" size="25" value="{$server.field2}" class="inp"/></td></tr>{/if}
{if $server_fields.display.hash}<tr><td valign="top" align="right" width="165"><strong>{if $server_fields.description.hash}{$server_fields.description.hash}{else}{$lang.accesshash}{/if}</strong></td><td ><textarea name="hash" cols="60" rows="8"  class="inp">{$server.hash}</textarea></td></tr>{/if}
{if $server_fields.display.ssl}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ssl}{$server_fields.description.ssl}{else}{$lang.Secure}{/if}</strong></td><td align="left"><input type="checkbox" value="1" {if $server.secure == '1'}checked="checked"{/if} name="secure"/> {if $server_fields.description.ssl}{else}{$lang.usessl}{/if}</td></tr>{/if}
            {if $server_fields.display.custom}
                {foreach from=$server_fields.display.custom item=conf key=k}
                    {assign var="name" value=$k}
                    {assign var="name2" value=$modconfig.module}
                    {assign var="baz" value="$name2$name"}
        <tr>
            <td  align="right" width="165">
                <strong>
                    {if $lang.$baz}{$lang.$baz}
                    {elseif $lang.$name}{$lang.$name}
                    {elseif $conf.name}{$conf.name}
                    {else}{$name}
                    {/if}
                </strong>
                {if $conf.description}
                    <a style="padding: 5px 12px 0 10px; background-position: center center;"
                       class="vtip_description" title="{$conf.description|escape}"></a>
                {/if}
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
                            <option {if $server.custom.$k == $selectopt}selected="selected" {/if}>{$selectopt|escape}</option>
                        {/foreach}
                    </select> 
                {/if}
            </td>
        </tr>
    {/foreach}
{/if}
</table>
{/if}
{elseif $server.type=='Domain' && $modconfig}
    <table border="0" width="100%" cellpadding="5" cellspacing="0">
        {foreach from=$modconfig.config item=conf key=k}
            <tr >

                {assign var="name" value=$k}
                {assign var="name2" value=$modconfig.module}
                {assign var="baz" value="$name2$name"}
                <td align="right" width="165">
                    <strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</strong>
                    {if $conf.description}<a style="padding: 5px 12px 0 10px; background-position: center center;" class="vtip_description" title="{$conf.description}"></a>{/if}
                </td>
                {if $conf.type=='input'}

                    <td ><input type="text" name="option[{$k}]" value="{$conf.value}" class="inp"/></td>
                    {elseif $conf.type=='password'}
                    <td ><input type="password" autocomplete="off" name="option[{$k}]" value="{$conf.value}"  class="inp"/></td>
                    {elseif $conf.type=='check'}
                    <td ><input name="option[{$k}]" type="checkbox" value="1" {if $conf.value == "1"}checked="checked"{/if} style="margin:0px"  /></td>
                    {elseif $conf.type=='select'}
                    <td >
                        <select name="option[{$k}]"  class="inp" >
                            {foreach from=$conf.default item=selectopt}
                                <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                            {/foreach}
                        </select> 
                    </td>
                {elseif $conf.type=='textarea'}
                    <td >
                        <span style="vertical-align:top"><textarea name="option[{$k}]" rows="5" cols="60" style="margin:0px" >{$conf.value}</textarea></span>
                    </td>
                {/if}
            </tr>
        {/foreach}
    </table>
{/if}

{if $server_fields.display.nameservers || $server.type=='Domain'}

    <div class="panel panel-default" style="margin-top:17px">
        <div class="panel-heading" role="tab" >
            <h4 class="panel-title">
                <a href="#collapseListGroup1" class="" role="button" data-toggle="collapse"  aria-controls="collapseListGroup1"> {$lang.Nameservers} </a> </h4> </div>
        <div class="panel-collapse collapse" role="tabpanel" id="collapseListGroup1" aria-labelledby="collapseListGroupHeading1"  >
            <div class="panel-body">
                <table cellspacing="0" cellpadding="6" border="0" width="100%" >
                    <tbody>
                    {foreach item=i from=1|@range:10}
                        {assign var=sns value="ns`$i`"}{assign var=sip value="ip`$i`"}{assign var=sns2 value="ns`$i+1`"}{assign var=sip2 value="ip`$i+1`"}
                        <tr class="newns{$i}" {if $i != 1 && !$server.$sns && !$server.$sip}style="display:none"{/if}><td width="150"  align="right"><strong>NS {$i}:</strong></td><td ><input  name="ns{$i}" size="40" value="{$server.$sns}" class="inp"/></td></tr>
                        <tr class="newns{$i}" {if $i != 1 && !$server.$sns && !$server.$sip}style="display:none"{/if}><td  align="right"><strong>NS {$i} IP:</strong></td><td ><input  name="ip{$i}" size="20" value="{$server.$sip}" class="inp"/></td></tr>
                        {if $i != 10}
                            <tr class="newns{$i} addns{$i+1}" {if ($i != 1 && !$server.$sns && !$server.$sip) || ($server.$sns2 || $server.$sip2)}style="display:none"{/if}>
                               <td></td>
                                <td >
                                    <a href="" onclick="$('.newns{$i+1}').show();
                                            $('.addns{$i+1}').hide();
                                            return false;" class="btn btn-sm btn-default">{$lang.addnewns}</a>
                                </td></tr>
                        {/if}
                    {/foreach}
                    </tbody></table>

            </div>
             <div class="panel-footer">{if $server.type=='Domain'}
                     Default nameservers set here will be used if TLD-specific nameservers are not set, or customer would not provide his own NS
                 {else}
                     Nameservers defined here will be used for domain registration, if customer choose to order domain with service using this App connection
                 {/if}
             </div>
        </div>
    </div>


{/if}

    <div class="panel panel-default" style="">
        <div class="panel-heading" role="tab" >
            <h4 class="panel-title">
                <a href="#collapseListGroup2" class="" role="button" data-toggle="collapse"  aria-controls="collapseListGroup2"> {$lang.monthlycosts} </a> </h4> </div>
        <div class="panel-collapse collapse" role="tabpanel" id="collapseListGroup2" aria-labelledby="collapseListGroupHeading2"  >
            <div class="panel-body">
                <table cellspacing="0" cellpadding="6" border="0" width="100%" >
                    <tbody>
                    <tr>
                        <td width="150" align="right"><strong>{$lang.monthlycosts}</strong></td>
                        <td >{$currency.sign}<input  name="monthly_cost" size="40" value="{$server.monthly_cost}" class="inp"/></td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="panel-footer">{$lang.monthlycostsdescription}</div>
        </div>
    </div>




{elseif $action == 'test_connection'}
    {if $result}
        {if $result.result == 'not_supported'}
            {$lang.test_not_supported}
        {else}
            {foreach from=$result.logs item=log}
                <div class="log-line {$log.type}" style="white-space: pre-wrap">{$log.msg}</div>
            {/foreach}
            <span style="font-weight: bold; color: {if $result.result == 'Success'}#009900{else}#990000{/if};">
        {if $lang[$result.result]}{$lang[$result.result]}{else}{$result.result}{/if}{if $result.error}: {$result.error}{/if}
    </span>
{/if}
{/if}
{elseif $action=='monitor'}
    {if $status}
        <td width="30%"><strong><a href="?cmd=servers&action=edit&id={$status.id}">{$status.name}</a></strong></td>
        {if $config.FTP}<td>{if $status.status.FTP=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.SSH}<td>{if $status.status.SSH=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.HTTP}<td>{if $status.status.HTTP=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.POP3}<td>{if $status.status.POP3=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.IMAP}<td>{if $status.status.IMAP=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.MYSQL}<td>{if $status.status.MYSQL=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working" />{/if}</td>{/if}
    {if $config.LOAD}<td>{if $status.status.LOAD}{$status.status.LOAD}{else}{$lang.Unavailable}{/if}</td>{/if}
{if $config.UPTIME}<td>{if $status.status.UPTIME}{$status.status.UPTIME}{else}{$lang.Unavailable}{/if}</td>{/if}
{/if}
{elseif $action=='group'}
    {foreach from=$servers item=serv}
        <tr class="product">
            <td width="20" style="display:none" class="frow_"><input type="radio" {if $serv.default=='1'}checked="checked"{/if} onclick="setDefault({$serv.id},{$group.id})" value="{$server.id}" name="defse"/></td>
            <td><a href="?cmd=servers&action=edit&id={$serv.id}">{if $serv.name}{$serv.name}{else}<em>({$lang.emptyname})</em>{/if}</a> {if $serv.default=='1'} <em class="fs11 editgray">({$lang.default})</em>{/if}</td>
            <td class="server-acc-stats">
                <a title="Pending" {if $group.type!='Domain'}href="?cmd=accounts&filter[server_id]={$serv.id}&filter[status]=Pending"
                   {else}href="?cmd=domains&filter[module]={$serv.module}&filter[status]=Pending"{/if} target="_blank">
                    <span class="Pending">{$serv.pending}</span>
                </a> /
                <a {if $group.type!='Domain'}title="Provisioned (Active / Suspended)" href="?cmd=accounts&filter[server_id]={$serv.id}&filter[status][]=Active&filter[status][]=Suspended"
                    {else}title="Registered" href="?cmd=domains&filter[module]={$serv.module}&filter[status][]=Active&filter[status][]=Pending Transfer&filter[status][]=Pending Registration"{/if} target="_blank">
                    <span class="Active">{$serv.provisioned}</span>
                </a> /
                <a {if $group.type!='Domain'}title="Cancelled / Terminated" href="?cmd=accounts&filter[server_id]={$serv.id}&filter[status][]=Terminated&filter[status][]=Cancelled&filter[status][]=Fraud"
                    {else}title="Cancelled / Expired" href="?cmd=domains&filter[module]={$serv.module}&filter[status][]=Expired&filter[status][]=Cancelled&filter[status][]=Fraud"{/if} target="_blank">
                    <span class="Cancelled">{$serv.cancelled}</span>
                </a>
                    {if $group.type!='Domain'} / <span title="Maximum accounts">{$serv.max_accounts}</span>{/if}
            </td>
            <td>{if $group.type!='Domain'}{$serv.ip}{/if}</td>
            <td>{if $group.type!='Domain'}{$serv.host}{/if}</td>
            <td >{$serv.monthly_cost|price:0}</td>
            <td class="fs11" id="testing_result{$serv.id}"></td>
            <td colspan="2">
                <a href="#" class="editbtn editgray" onclick="return testConnectionList('{$serv.id}', this);">{$lang.test_configuration}</a>
            </td>
            <td style="width: 200px; text-align: right;">
                <a href="?cmd=servers&amp;action=duplicate&id={$serv.id}&group={$group.id}&security_token={$security_token}" onclick="return confirm('{$lang.areyousure}');" class="menuitm menu-auto">{$lang.duplicate_connection}</a>
                <a href="?cmd=servers&action=edit&id={$serv.id}" class="menuitm menu-auto editbtn">{$lang.Edit}</a>
                <a href="?cmd=servers&make=delete&action=group&group={$group.id}&id={$serv.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteserverconfirm}')" class="menuitm menu-auto ajax"><span class="delsth"></span></a>
            </td>
    </tr>
{/foreach}
{elseif $action == 'getadvanced'}

    <a href="?cmd=accounts&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=accounts" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
       
        {if $custom_filters}
            <table width="100%" cellspacing="2" cellpadding="3" border="0">
                <tbody>
                    {include file=$custom_filters}
                    <tr>
                        <td>{$lang.Server}</td>
                        <td colspan="5">
                            <select name="filter[server_id]">
                                <option value=''>{$lang.Any}</option>
                                {foreach from=$advanced.servers item=o}
                                    <option {if $currentfilter.server_id==$o.id}selected="selected"{/if} value='{$o.id}'>{$o.groupname} - {$o.name}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6"><center>
                    <input type="submit" value="{$lang.Search}" class="btn btn-primary btn-sm"/>
                    &nbsp;&nbsp;&nbsp;
                    <input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;" class="btn btn-default btn-sm"/>
                </center></td>
                </tr>
                </tbody>
            </table>
        {/if}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{else}
    {foreach from=$servers item=cat}
        <tr>
            <td ><a href="?cmd=servers&group={$cat.id}&action=group">{$cat.name}</a></td>
            <td >{$cat.modulename}</td>
            <td >{$cat.servers}</td>
            <td ><a href="?cmd=servers&group={$cat.id}&action=group" class="menuitm menu-auto editbtn">{$lang.Edit}</a></td>
            <td ></td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="5">{$lang.nothingtodisplay}</td>
        </tr>
    {/foreach}
{/if}
