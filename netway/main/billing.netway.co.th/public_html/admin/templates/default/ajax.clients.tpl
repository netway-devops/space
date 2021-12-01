{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.client.tpl.php');
{/php}


{if $action=='clientcontacts'}

    <div class="blu" style="text-align:right">


        <a href="?cmd=clients&action=newprofile&id={$client_id}" class="btn btn-primary pull-right btn-xs" target="_blank"><i class="fa fa-plus"></i> {$lang.addcontact}</a>
        <div class="clear"></div>

    </div>

{* custom code นับจำนวน client contact address *}

    {if $contacts}
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>
                    <th>#</th>
                    <th>{$lang.firstname}</th>
                    <th>{$lang.lastname}</th>
                    <th>{$lang.email}</th>
                    <th>{$lang.Created}</th>
                    <th>{$lang.Status}</th>
                    <th width="40"></th>
                </tr>
            </tbody>
            <tbody>

                {foreach from=$contacts item=client}
                    <tr>
                        <td><a href="?cmd=clients&action=showprofile&id={$client.id}">{$client.id}</a></td>
                        <td><a href="?cmd=clients&action=showprofile&id={$client.id}">{$client.firstname}</a></td>
                        <td><a href="?cmd=clients&action=showprofile&id={$client.id}">{$client.lastname}</a></td>
                        <td>{$client.email}</td>
                        <td>{$client.datecreated|dateformat:$date_format}</td>
                        <td>{$lang[$client.status]}</td>
                        <td align="right"><a  class=" editbtn"   href="?cmd=clients&action=showprofile&id={$client.id}" >{$lang.Edit}</a></td>
                    </tr>
                {/foreach}
            </tbody>

        </table>
        {if $totalpages}
            <script>
                {literal}
                $('#per_page').on('change', function () {
                    const form_clientcontacts = $('.clientform').serializeArray();
                    form_clientcontacts.push({name:'contacts_per_page', value:$(this).val()});
                    var url = $('.currentpage').attr('href');
                    $('.slide:visible').addLoader();
                    ajax_update(url,form_clientcontacts,$(this).parents('.slide'));
                });
                {/literal}
            </script>
            <div class="text-right" style="margin: 10px 0px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="contacts_per_page" id="per_page">
                        <option value="10" {if $contacts_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $contacts_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $contacts_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $contacts_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $contacts_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class=" paginercontainer" >
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=clients&action=clientcontacts&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                               {if $smarty.section.foo.iteration-1==$currentpage}
                                   currentpage
                               {/if}"
                               >{$smarty.section.foo.iteration}</a>

                        {/section}
                    </center>
                </div>
            </div>
            <script> $('.paginercontainer', 'div.slide:visible').infinitepages();</script>
        {/if}
    {else}
        <p style="text-align: center">{$lang.nothingtodisplay}</p>

    {/if}
{elseif $action=='ccadd' ||  $action=='ccshow' || $action=='ccard'}
    {if $verify}
        {if $cardcode && $cmake=='ccadd'}
            <table cellpadding="5" cellspacing="0" border="0">
                {if $cardcode.token_gateway_id}
                    <tbody id="ccbody">
                        <tr>
                            <td colspan="2">  Client credit card <b>{$cardcode.cardnum}</b> has been tokenised by payment module <b>{$cardcode.module}</b>. <br/>
                                This process is irreversible, to edit credit card remove current entry and add new CC</td>
                        </tr>
                        <tr>
                            <td>Added:</td>
                            <td><strong>{if $cardcode.cardcreated}{$cardcode.cardcreated|dateformat:$date_format}{else}-{/if}</strong></td>
                        </tr>
                        <tr>
                            <td>Updated:</td>
                            <td><strong>{if $cardcode.cardupdated}{$cardcode.cardupdated|dateformat:$date_format}{else}-{/if}</strong></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input name="removeCC" value="Remove Credit Card" type="submit" style="font-weight:bold;color:red"/>
                                <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle(); return false" />
                            </td>
                        </tr>
                    </tbody>
                {else}
                    <tbody id="ccbody">
                        <tr>
                            <td width="160">{$lang.ccardtype}</td>
                            <td>
                                <select name="cardtype" class="form-control">
                                    {foreach from=$supportedcc item=cc}
                                        <option {if $cardcode.cardtype==$cc}selected="selected"{/if}>{$cc}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>{$lang.ccardnum}:</td>
                            <td id="cardnum"><input type="text" name="cardnum" size="25" value="{$cardcode.cardnum}"  class="form-control"/></td>
                        </tr>
                        <tr class="form-inline">
                            <td>{$lang.ccexpiry}:</td><td><input type="text" name="expirymonth" size="2" maxlength="2"  value="{$cardcode.expirymonth}"  class="form-control" style="width: 50px" /> /
                                <input type="text" name="expiryyear" size="2" maxlength="2"  value="{$cardcode.expiryyear}"  class="form-control" style="width: 50px" /> (MM/YY)</td></tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input name="updateCC" value="{$lang.updateccard}" type="submit" class="btn btn-sm btn-success"/>
                                <input name="removeCC" value="Remove Credit Card" type="submit" class="btn btn-sm btn-danger"/>
                                <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle(); return false" class="btn btn-sm btn-default" />
                            </td>
                        </tr>
                        <tr>
                            <td>Added:</td>
                            <td><strong>{if $cardcode.cardcreated}{$cardcode.cardcreated|dateformat:$date_format}{else}-{/if}</strong></td>
                        </tr>
                        <tr>
                            <td>Updated:</td>
                            <td><strong>{if $cardcode.cardupdated}{$cardcode.cardupdated|dateformat:$date_format}{else}-{/if}</strong></td>
                        </tr>
                    </tbody>
                {/if}
            </table>
        {elseif $cardcode && $cmake=='ccshow'}
            <table cellpadding="5" cellspacing="0" border="0">
                <tbody id="ccbody">
                    <tr>
                        <td width="160">{$lang.ccardtype}:</td>
                        <td><strong>{$cardcode.cardtype}</strong></td>
                    </tr>
                    <tr>
                        <td>{$lang.ccardnum}:</td>
                        <td id="cardnum"><strong>{$cardcode.cardnum}</strong></td>
                    </tr>
                    <tr>
                        <td>{$lang.ccexpiry}:</td>
                        <td><strong>{$cardcode.expdate}</strong></td>
                    </tr>
                     <tr>
                        <td>Added:</td>
                        <td><strong>{if $cardcode.cardcreated}{$cardcode.cardcreated|dateformat:$date_format}{else}-{/if}</strong></td>
                    </tr>
                    <tr>
                        <td>Updated:</td>
                        <td><strong>{if $cardcode.cardupdated}{$cardcode.cardupdated|dateformat:$date_format}{else}-{/if}</strong></td>
                    </tr>
                </tbody>
            </table>
        {else}
            <table cellpadding="5" cellspacing="0" border="0">
                <tbody id="ccbody">
                    <tr>
                        <td width="160">{$lang.ccardtype}:</td>
                        <td>
                            <select name="cardtype">
                                <option >Visa</option>
                                <option >MasterCard</option>
                                <option >Discover</option>
                                <option >American Express</option>
                                <option >Laser</option>
                                <option >Maestro</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$lang.ccardnum}:</td>
                        <td id="cardnum"><input type="text" name="cardnum" size="25" value=""/></td>
                    </tr>
                    <tr>
                        <td>{$lang.ccexpiry}:</td>
                        <td>
                            <input type="text" name="expirymonth" size="2" maxlength="2"  value="" /> /
                            <input type="text" name="expiryyear" size="2" maxlength="2"  value="" /> (MM/YY)
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input name="updateCC" value="{$lang.addccard}" type="submit"  style="font-weight:bold"/>
                            <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle(); return false" />
                        </td>
                    </tr>
                </tbody>
            </table>
        {/if}
    {else}
        <form onsubmit="return verify_pass({if $admindata.access.editCC}'ccadd'{else}'ccshow'{/if})">
            {$lang.provideyourpassword}
            <input  type="password" autocomplete="off" name="admin_pass" id="admin_pass" />
            <input type="submit" id="ccbutton" value="{$lang.submit}" style="font-weight:bold" />
        </form>
    {/if}

{elseif $action=='achadd' ||  $action=='achshow' || $action=='ach'}
    {if $verify}
        {if $cardcode && $cmake=='achadd'}
            <table cellpadding="5" cellspacing="0" border="0">
                {if $cardcode.token_gateway_id}
                    <tbody id="ccbody">
                        <tr>
                            <td colspan="2">  Client bank account <b>{$cardcode.account}</b> has been tokenised by payment module <b>{$cardcode.module}</b>. <br/>
                                This process is irreversible, to bank details remove current entry and add new one</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input name="removeACH" value="Remove ACH" type="submit" style="font-weight:bold;color:red"/>
                                <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle(); return false" />
                            </td>
                        </tr>
                    </tbody>
                {else}
                    <tbody id="ccbody">
                        <tr>
                            <td width="160">Type:</td>
                            <td>
                                <select name="ach[type]">
                                    <option value="checkings" {if $cardcode.type=='checkings'}selected="selected"{/if}>{$lang.checking}</option>
                                    <option value="savings" {if $cardcode.type=='savings'}selected="selected"{/if}>{$lang.savings}</option>
                                    <option value="business_checking" {if $cardcode.type=='business_checking'}selected="selected"{/if}>{$lang.business_checking}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>{$lang.ach_account_number}:</td>
                            <td id="ach_account_number"><input type="text" name="ach[account]" size="25" value="{$cardcode.account}"/></td>
                        </tr>

                        <tr>
                            <td>{$lang.ach_routing_number}:</td>
                            <td id="ach_routing_number"><input type="text" name="ach[routing]" size="25" value="{$cardcode.routing}"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input name="updateACH" value="Update ACH info" type="submit" style="font-weight:bold"/>
                                <input name="removeACH" value="Remove ACH info" type="submit" style="font-weight:bold;color:red"/>
                                <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle(); return false" />
                            </td>
                        </tr>
                    </tbody>
                {/if}
            </table>
        {elseif $cardcode && $cmake=='achshow'}
            <table cellpadding="5" cellspacing="0" border="0">
                <tbody id="ccbody">
                    <tr>
                        <td width="160">Type:</td>
                        <td><strong>{$lang[$cardcode.type]}</strong></td>
                    </tr>
                    <tr>
                        <td>{$lang.ach_account_number}:</td>
                        <td id="cardnum"><strong>{$cardcode.account}</strong></td>
                    </tr>
                    <tr>
                        <td>{$lang.ach_routing_number}:</td>
                        <td><strong>{$cardcode.routing}</strong></td>
                    </tr>
                </tbody>
            </table>
        {elseif $cmake=='achshow'}
            This client do not have bank details on file.
        {else}
            <table cellpadding="5" cellspacing="0" border="0">
                <tbody id="ccbody">
                    <tr>
                        <td width="160">Type:</td>
                        <td>
                            <select name="ach[type]">
                                <option value="checkings">{$lang.checking}</option>
                                <option value="savings">{$lang.savings}</option>
                                <option value="business_checking">{$lang.business_checking}</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$lang.ach_account_number}:</td>
                        <td id="ach_account_number"><input type="text" name="ach[account]" size="25" value=""/></td>
                    </tr>

                    <tr>
                        <td>{$lang.ach_routing_number}:</td>
                        <td id="ach_routing_number"><input type="text" name="ach[routing]" size="25" value=""/></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input name="updateACH" value="Add bank details" type="submit"  style="font-weight:bold"/>
                            <input type="button" value="{$lang.Cancel}" onclick="$('#ccinfo').toggle(); return false" />
                        </td>
                    </tr>
                </tbody>
            </table>
        {/if}
    {else}
        <form onsubmit="return verify_pass({if $admindata.access.editCC}'achadd'{else}'achshow'{/if})">
            {$lang.provideyourpassword}
            <input  type="password" autocomplete="off" name="admin_pass" id="admin_pass" />
            <input type="submit" id="ccbutton" value="{$lang.submit}" style="font-weight:bold" />
        </form>
    {/if}
{elseif $action=='field'}
    {include file='ajax.clientfields.tpl'}
{elseif $action=='default'}
    {if $clients}
        {foreach from=$clients item=client}
            <tr>
                <td><input type="checkbox" class="check" value="{$client.id}" name="selected[]"/></td>
                <td><a href="?cmd=clients&amp;action=show&amp;id={$client.id}">{$client.id}</a></td>
                <td><a href="?cmd=clients&amp;action=show&amp;id={$client.id}">{$client.firstname}</a></td>
                <td><a href="?cmd=clients&amp;action=show&amp;id={$client.id}">{$client.lastname}</a></td>
                <td>{$client.email}</td>
                <td>{$client.companyname}</td>
                <td>{$client.services}</td>
                <td>{$client.datecreated|dateformat:$date_format}</td>
                <td>
                    {if $client.affiliate}
                        <div class="right inlineTags" >
                            <a href="?cmd=affiliates&action=affiliate&id={$client.affiliate}" style="text-decoration: none">
                                <span {if $client.afstatus == 'Active'}style="background: #3daa34"{else}style="background: #aa3d34"{/if}>{$lang.affiliate}</span>
                            </a>
                        </div>
                    {/if}
                </td>
            </tr>

        {/foreach}
    {else}
        <tr>
            <td colspan="10"><p align="center" >{$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregistercustomer}</p></td>
        </tr>
    {/if}

{elseif $action=='loadstatistics'}
    {include file="clients/statistics.tpl"}
{elseif $action=='sendmailcriterias'}
    {if $criterias}
        {if $type == 'services'}
            {foreach from=$criterias item=category key=id}
                <optgroup label="{$id}">
                    {foreach from=$category item=service}
                        <option value="{$service.id}">{$service.name}</option>
                    {/foreach}
                </optgroup>
            {/foreach}
        {else}
            {foreach from=$criterias item=criteria name=checker}
                <option value="{$criteria.id}">{$criteria.name}</option>
            {/foreach}
        {/if}
    {else}
        {if $type=='services'}
            {$lang.noservices}
        {elseif $type=='servers'}
            {$lang.noservers}
        {elseif $type=='countries'}
            {$lang.nocountries}
        {/if}
    {/if}
{elseif $action=='getadvanced'}
    <a href="?cmd=clients&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=clients" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>

    <script type="text/javascript">bindFreseter();</script>


{/if}