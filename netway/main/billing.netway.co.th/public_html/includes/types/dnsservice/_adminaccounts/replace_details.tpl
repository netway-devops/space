<script type="text/javascript" src="{$system_url}templates/common/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$system_url}templates/common/facebox/facebox.css" type="text/css" />
<script type="text/javascript">{literal}
 
	function metteredBillinghistory() {
                $('#meteredusagelog').addLoader();
		var url={/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&do=metered_history';{literal};
		ajax_update(url,{metered_period:$('#metered_period').val()},'#meteredusagelog');
		return false;
	}
    function bindMe() {
        $('#tabbedmenu').TabbedMenu({elem:'.tab_content',picker:'li.tpicker',aclass:'active'});
    }
    appendLoader('bindMe');
    {/literal}</script>

<form action="" method="post" id="account_form" >
    <input type="hidden" value="{$details.firstpayment}" name="firstpayment" />
    <input type="hidden" name="account_id" value="{$details.id}" id="account_id" />
    <div class="blu">{include file='_common/accounts_nav.tpl'}</div>

    <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;"></div>



    <div id="ticketbody" >
        {include file='_common/accounts_billing.tpl'}



        <ul class="tabs" id="tabbedmenu">
            <li class="tpicker active"><a href="#tab1" onclick="return false">Provisioning</a></li>
            <li class="tpicker tab-metered"><a href="#tab2" onclick="return false">Metered Billing</a></li>
            <li class="tpicker"><a href="#tab2" onclick="return false">Client Domains<span  class="top_menu_count">{$user_domains_cnt}</span> </a></li>
            <li class="tpicker"><a href="#tab3" onclick="return false">Addons<span id="numaddons" class="top_menu_count">{$details.addons}</span> </a></li>
        </ul>
        <div class="tab_container">

            <div class="tab_content" style="display: block;">
                {include file='_common/accounts_details.tpl'}

            </div>
            <div class="tab_content" style="display: none;">
                <!--metered billing start-->
                {if !$metered_enable}
                    Metered billing is disabled for this package, <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank">click here to manage metered billing pricing.</a>
                {else}
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                    <tr class="odd havecontrols">
                        <td width="16%" align="right"><b>Billing period</b></td>
                        <td width="16%">{$details.previous_invoice|dateformat:$date_format} - {$details.next_invoice|dateformat:$date_format}</td>
                   
                        <td width="16%" align="right"><b>Next invoice total</b></td>
                        <td width="16%"><b>{$summary.charge|price:$currency}</b>
                            <br><span class="fs11">{$user_domains_cnt} domains x {$curent_price|price:$currency}/domain</span></td>
                    
                        <td width="16%" align="right"><b>Current price/domain</b></td>
                        <td width="16%">{$curent_price|price:$currency}</td>
                    </tr>
                    <tr class="even">
                        <td colspan="4"></td>
                        <td colspan="2" style="text-align:right">Month (yyyy-mm): <select name="metered_period" id="metered_period" onchange="metteredBillinghistory()">
                                {foreach from=$metered_periods item=p}
                                    <option value="{$p}">{$p}</option>
                                {/foreach}
                            </select></td>
                    </tr>
                </table>
                {if $metered_usage_log}<div id="meteredusagelog">{include file='_common/accounts_meteredtable.tpl'}</div>
                <br/><b>Legend</b>
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                    {foreach from=$metered_usage_log.variables item=vr}
                        <tr class="even">
                            <td width="150"><b>{$vr.name}</b></td>
                            <td>{$vr.description}</td>

                        </tr>
                    {/foreach}
                </table>

                {else}
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                    <tr class="odd havecontrols">
                        <td align="center"><b>No data reported yet</b></td>
                    </tr>

                </table>

                {/if}
              
               
                {/if}
                <!--eof: metered billing -->
            </div>
            <div class="tab_content" style="display: none;">
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="whitetable">
                    <thead>
                        <tr>
                            <th align="left">Domain</th>
                            <th width="150">Creation date</th>
                                    {if $metered_enable}<th width="80">Price</th>{/if}
                            <th width="80"></th>
                        </tr>
                    </thead>

                    {if $user_domains}	<tbody>
                            {foreach from=$user_domains item=domain name=row}
                                <tr {if  $smarty.foreach.row.index%2 == 0}class="even"{else}class="odd"{/if}>
                                    <td align="left"><a target="_blank" href="{if $dns_manager_enabled}?cmd=dns_zone_editor&action=show&zone_id={$domain.rawoutput}&server_id={$details.server_id}&security_token={$security_token}{else}../?action=adminlogin&id={$details.client_id}&redirect=%3Fcmd%3Dclientarea%26action%3dservices%26service%3d{$details.id}%26act%3ddns_manage%26domain_id%3d{$domain.rawoutput}{/if}">{$domain.output}</a></td>
                                    <td>{if $domain.date_created}{$domain.date_created|dateformat:$date_format}{else}-{/if}</td>
                                    {if $metered_enable}<td>{if $domain.charge}{$domain.charge|price:$domain.currency_id}{else}-{/if}</td> {/if}
                                    <td><a target="_blank" href="{if $dns_manager_enabled}?cmd=dns_zone_editor&action=show&zone_id={$domain.rawoutput}&server_id={$details.server_id}&security_token={$security_token}{else}../?action=adminlogin&id={$details.client_id}&redirect=%3Fcmd%3Dclientarea%26action%3dservices%26service%3d{$details.id}%26act%3ddns_manage%26domain_id%3d{$domain.rawoutput}{/if}" class="editbtn">View zone</a></td>
                                </tr>
                            {/foreach}
                    </tbody>

                    <tbody>
                        <tr>
                            <th colspan="{if $metered_enable}1{else}3{/if}" style="font-weight:normal">Domains count:  <b {if $dom_limit && $user_domains_cnt==$dom_limit}style="color:red"{/if}>{$user_domains_cnt}</b> {$lang.maxallowed|default:"Max allowed"}: <b>{if $lang[$dom_limit]}{$lang[$dom_limit]}{else}{$dom_limit}{/if}</b></th>
                           {if $metered_enable}
                           <th align="right" style="text-align:right">Total:</th>
                           <th colspan="2" > <b>{$details.metered_total|price:$details.currency}</b></th>{/if}

                        </tr>
                    </tbody>
                        {else}
                        <tbody>
                            <tr>
                                <td colspan="{if $metered_enable}5{else}4{/if}" align="center">No domains added yet</td>
                            </tr>
                       </tbody>

                        {/if}

                </table>

            </div>
            <div class="tab_content" style="display: none;">
                {include file='_common/accounts_addons.tpl'}
            </div>
        </div>

        <div class="clear"></div>
        {include file='_common/accounts_multimodules.tpl'}
        {include file='_common/noteseditor.tpl'}

    </div>



    <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
    {securitytoken}
</form>