<form action="" method="post" id="account_form" >
    <input type="hidden" value="{$details.firstpayment}" name="firstpayment" />
    <input type="hidden" name="account_id" value="{$details.id}" id="account_id" />
    <div class="blu">{include file='_common/accounts_nav.tpl'}</div>

    <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;">
    </div>



    <div id="ticketbody">
        {include file='_common/accounts_billing.tpl'}



        <ul class="tabs" id="tabbedmenu">
            <li class="tpicker active tab-details"><a href="#tab1" onclick="return false">Provisioning</a></li>
            {if $bandwidthtab}
                <li class="tpicker tab-bandwidth"><a href="#tab2" onclick="return false">Bandwidth</a></li>
            {/if}
            {if $mtred}
                <li class="tpicker tab-metered"><a href="#tab2" onclick="return false">Metered Billing</a></li>
            {/if}
             <li class="tpicker tab-ipam"><a href="#tab2" onclick="return false">IPAM</a></li>
            {if $dedimgr}
                <li class="tpicker tab-dedimgr"><a href="#tab2" onclick="return false">Dedicated Srv Manager</a></li>
            {/if}
            {if $switch}
                <li class="tpicker tab-switch"><a href="#tab2" onclick="return false">Switch</a></li>
            {/if}
            {if $pdu}
                <li class="tpicker tab-pdu"><a href="#tab2" onclick="return false">PDU</a></li>
            {/if}
            <li class="tpicker"><a href="#tab3" onclick="return false">Addons<span id="numaddons" class="top_menu_count">{$details.addons}</span> </a></li>
        </ul>
        <div class="tab_container" style="overflow: visible">

            <div class="tab_content" style="display: block;">
                {include file='_common/accounts_details.tpl'}
            </div>
            {if $bandwidthtab}<div class="tab_content" style="display: none;">
                 {include file=$bandwidthtab}
            </div>{/if}

            {if $mtred}<div class="tab_content" style="display: none;">
                {include file='accountbilling_Metered.tpl'}
                </div>{/if}
            <div class="tab_content" style="display: none;">

                                                <input value="{$details.os}" name="os" type="hidden" />
                                                <input name="node" value="{$details.node}" type="hidden"  />
                                                <input value="{$details.burstable_ram}" name="burstable_ram"  type="hidden"/>
                                                <input value="{$details.guaranteed_ram}" name="guaranteed_ram"  type="hidden"/>
                                                <input value="{$details.bw_limit}" name="bw_limit"  type="hidden"/>
                                                <input value="{$details.disk_limit}" name="disk_limit" type="hidden" />

                <div id="ipameditor">  {if $ipam}
                    {literal}
                        <script type="text/javascript">
                            function loadIpamMGR() {
                                ajax_update('?cmd=module&module=ipam&action=accountseditor', {account_id: $('#account_id').val()}, '#ipameditor');
                            }

                            $(document).ready(loadIpamMGR);
                        </script>
                    {/literal}
                    {/if}


                    <table cellspacing="2" cellpadding="3" border="0" width="100%">
                        <tbody>
                            <tr>
                                <td width="150">{$lang.mainip}</td>
                                <td><input value="{$details.ip}" name="ip"/></td>
                            </tr>

                            {if $details.additional_ip}
                                {foreach from=$details.additional_ip item=ip}
                                    <tr>
                                        <td width="150">{$lang.addip}</td>
                                        <td><input value="{$ip}" name="additional_ip[]"/></td>
                                    </tr>
                                {/foreach}
                                <tr>
                                    <td>{$lang.addip}</td>
                                    <td><input value="" name="additional_ip[]" id="addip0" style="display:none"/>
                                        <a href="#"
                                           onclick="$(this).hide();$('#addip0').show();$('#addip00').show();return false;">{$lang.clicktoadd}</a>

                                        <a href="#" onclick="$(this).hide();$('#addip1').show();return false;"
                                           id="addip00" style="display:none">{$lang.addmoreip}</a></td>
                                </tr>
                            {else}
                                <tr>
                                    <td>{$lang.addip}</td>
                                    <td><input value="" name="additional_ip[]" id="addip0" style="display:none"/>
                                        <a href="#"
                                           onclick="$(this).hide();$('#addip0').show();$('#addip00').show();return false;">{$lang.clicktoadd}</a>

                                        <a href="#" onclick="$(this).hide();$('#addip1').show();return false;"
                                           id="addip00" style="display:none">{$lang.addmoreip}</a></td>
                                </tr>
                            {/if}


                            <tr style="display:none" id="addip1">
                                <td>{$lang.addip}</td>
                                <td><input value="" name="additional_ip[]"/> <a href="#"
                                                                                onclick="$(this).hide();$('#addip2').show();return false;">{$lang.addmoreip}</a>
                                </td>
                            </tr>
                            <tr style="display:none" id="addip2">
                                <td>{$lang.addip}</td>
                                <td><input value="" name="additional_ip[]"/> <a href="#"
                                                                                onclick="$(this).hide();$('#addip3').show();return false;">{$lang.addmoreip}</a>
                                </td>
                            </tr>
                            <tr style="display:none" id="addip3">
                                <td>{$lang.addip}</td>
                                <td><input value="" name="additional_ip[]"/> <a href="#"
                                                                                onclick="$(this).hide();$('#addip4').show();return false;">{$lang.addmoreip}</a>
                                </td>
                            </tr>
                            <tr style="display:none" id="addip4">
                                <td>{$lang.addip}</td>
                                <td><input value="" name="additional_ip[]"/> <a href="#"
                                                                                onclick="$(this).hide();$('#addip5').show();return false;">{$lang.addmoreip}</a>
                                </td>
                            </tr>
                            <tr style="display:none" id="addip5">
                                <td>{$lang.addip}</td>
                                <td><input value="" name="additional_ip[]"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>
            {if $dedimgr} <div class="tab_content" style="display: none;">
                <div id="dedimgr">Loading...</div>
                {literal}
                <script type="text/javascript">
                    function loadDediMgr() {
                        ajax_update('?cmd=module&module=dedimgr&do=getassignments',{account_id:$('#account_id').val()},'#dedimgr');
                    }
                    $(document).ready(loadDediMgr);
                </script>
                {/literal}


            </div> {/if}
            {if $switch} <div class="tab_content" style="display: none;">
                {literal}
                <script type="text/javascript">
                    function loadSwitchMgr() {
                        ajax_update('?cmd=switch_control&action=getAvailableSwitches',{account_id:$('#account_id').val()},'#switchmgr');
                    }
                    $(document).ready(loadSwitchMgr);
                </script>
                <div id="switchmgr">Loading...</div>
                {/literal}

            </div> {/if}
            {if $pdu} <div class="tab_content" style="display: none;">
                {literal}
                <script type="text/javascript">
                    function loadPDUMgr() {
                        ajax_update('?cmd=pdu_snmp&action=getAvailablePDUs',{account_id:$('#account_id').val()},'#pdumgr');
                    }
                    $(document).ready(loadPDUMgr);
                </script>
                <div id="pdumgr">Loading...</div>
                {/literal}
            </div> {/if}
            <div class="tab_content" style="display: none;">
                {include file='_common/accounts_addons.tpl'}
            </div>
        </div>

        <div class="clear"></div>

        {if $custom_template}
            {include file=$custom_template}
        {/if}

        {if $showmetrics}
            <ul class="accor">
                <li><a href="#">{$lang.quotaussage}</a>
                    {include file='_common/accounts_metrics.tpl'}
                </li>
            </ul>
        {/if}

        {include file='_common/accounts_extrabilling.tpl'}
        {include file='_common/accounts_multimodules.tpl'}
        {include file='_common/noteseditor.tpl'}


    </div>



    <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
    {securitytoken}
</form>
{literal}
<script type="text/javascript">
    function bindMe() {
        $('#tabbedmenu').TabbedMenu({elem:'.tab_content',picker:'li.tpicker',aclass:'active'});
    }
    appendLoader('bindMe');
</script>{/literal}

{graphs rel_id=$details.id rel_type='Hosting'}
