{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.productaddons.tpl.php');
{/php}

{if $action=='addon' && $addon}
    <script type="text/javascript">{literal}
        function saveAddonFull() {
            $('#addonform').submit();
            return false;
        }
        {/literal}
    </script>
    <!-- ADDONS FORM START -->
    <form action="" method="post" id="addonform">
        <input type="hidden" name="make" value="update"/>
        <table width="100%" cellspacing="0" cellpadding="10" border="0">
            <tr>
                <td style="padding:0px">
                    <div class="newhorizontalnav" id="newshelfnav">
                        <div class="list-1">
                            <ul>
                                <li>
                                    <a href="#"><span class="ico money">General</span></a>
                                </li>
                                {if $addon.module!=''}
                                    <li>
                                        <a href="#"><span class="ico plug">Connect with App</span></a>
                                    </li>
                                {/if}
                                <li>
                                    <a href="#"><span class="ico gear">Automation</span></a>
                                </li>
                                <li class="">
                                    <a href="#"><span class="ico gear">{$lang.Emails}</span></a>
                                </li>
                                <li class="last">
                                    <a href="#"><span class="ico gear">Products</span></a>
                                </li>

                            </ul>
                        </div>
                        <div class="list-2">
                            <div class="subm1 haveitems">
                                <ul>
                                    {if $addon.visible=='1'}
                                        <li>
                                            <a href="#"
                                               onclick=" $('#add_visibility').removeAttr('checked');$('#addonvisibility').ShowNicely();$(this).hide();return false;"><span>{$lang.hide_addon}</span></a>
                                        </li>
                                    {/if}
                                    {if $addon.unique!='1'}
                                        <li>
                                            <a href="#"
                                               onclick="$('#add_unique').attr('checked',true);$('#adddonunique').ShowNicely();$(this).hide();return false;"><span>{$lang.make_unique}</span></a>
                                        </li>
                                    {/if}
                                    {if $configuration.EnableProRata != 'on'}
                                        <li>
                                            <a href="#"
                                               onclick="$('#prorated_ctrl').show();$('#prorata_on').click();$(this).hide();return false"><span>{$lang.new_EnableProRata}</span></a>
                                        </li>
                                    {/if}
                                </ul>
                            </div>
                            <div class="subm1" style="display:none"></div>
                            <div class="subm1" style="display:none"></div>
                            <div class="subm1" style="display:none"></div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="nicers" style="border:none">
                    <table cellspacing="0" cellpadding="6" border="0" width="100%">
                        <tbody class="sectioncontent">
                            <tr>
                                <td width="160" align="right"><strong>{$lang.Name}</strong></td>
                                <td align="left">
                                    {hbinput value=$addon.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="60" name="name"}
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top"><strong>{$lang.Description}</strong></td>
                                <td align="left">
                                    {if $addon.description==''}<a href="#"
                                                                  onclick="$(this).hide();$('#prod_desc_c').show();return false;">
                                        <strong>{$lang.adddescription}</strong></a>
                                        <div id="prod_desc_c"
                                             style="display:none">{hbwysiwyg value=$addon.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="full"}</div>
                                    {else}
                                        {hbwysiwyg value=$addon.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="full"}

                                    {/if}
                                </td>
                            </tr>
                            <tr id="addonvisibility" {if $addon.visible=='1'}style="display:none"{/if}>
                                <td align="right" valign="top"><strong>{$lang.Visible}</strong></td>
                                <td><input type="checkbox" name="visible" {if $addon.visible=='1'}checked="checked"{/if}
                                           id="add_visibility"/></td>
                            </tr>
                            <tr id="adddonunique" {if $addon.unique!='1'}style="display:none"{/if}>
                                <td align="right" valign="top"><strong>{$lang.Unique}</strong></td>
                                <td><input type="checkbox" name="unique" {if $addon.unique=='1'}checked="checked"{/if}
                                           id="add_unique"/> {$lang.UniqueDesc}</td>
                            </tr>

                            <tr>
                                <td valign="top" width="160" align="right"><strong>{$lang.Price}</strong></td>
                                <td id="priceoptions">
                                    {foreach from=$supported_billingmodels item=bm name=boptloop}
                                        <a href="#"
                                           class="billopt {if $smarty.foreach.boptloop.first}bfirst{/if} {if $product.paytype==$bm}checked{/if}"
                                           {if $product.paytype!=$bm}style="display:none"{/if}
                                           onclick='return switch_t2(this,"{$bm}");'>{if $lang[$bm]}{$lang[$bm]}{else}{$bm}{/if}</a>
                                        <input type="radio" value="{$bm}" name="paytype"
                                               {if $product.paytype==$bm}checked="checked"{/if} id="{$bm}"
                                               style="display:none"/>
                                    {/foreach}

                                    <a href="#" class="editbtn"
                                       onclick="$(this).hide();$(this).parent().find('.billopt').show();return false;">{$lang.Change}</a>

                                    <!-- pricing -->
                                    {foreach from=$supported_billingmodels item=bm name=boptloop}
                                        <!-- {$bm} pricing -->
                                        {include file="productbilling_`$bm`.tpl"}
                                        <!-- {$bm} billing end -->
                                    {/foreach}
                                    <!-- pricing end -->
                                </td>
                            </tr>

                            <tr>
                                <td valign="top" align="right"><strong>{$lang.taxaddon}</strong></td>
                                <td>
                                    <label>
                                        <input type="radio" {if $product.taxable!='1'}checked{/if}
                                               name="taxable" value="0" data-toggle/>
                                        <strong>{$lang.no}</strong>
                                    </label>
                                    <label>
                                        <input type="radio" {if $product.taxable=='1'}checked{/if}
                                               name="taxable" value="1" data-toggle="#tax_group"/>
                                        <strong>{$lang.yes}</strong>
                                    </label>

                                    <div class="p5" id="tax_group" {if $product.tax!='1'}style="display: none;"{/if}>
                                        {$lang.taxgroup}:
                                        <select name="tax_group_id">
                                            {foreach from=$tax_groups item=taxg}
                                                <option value="{$taxg.id}" {if $product.tax_group_id == $taxg.id}selected{/if}>
                                                    {$taxg.name}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </td>
                            </tr>

                            {include file="services/prorata.tpl"}
                        </tbody>


                        {if $addon.module!=''}
                            <tbody class="sectioncontent" style="display:none">
                                <tr>
                                    <td colspan="2" style="padding:0px !important">
                                        <table border="0" width="100%" cellpadding="6" cellspacing="0">
                                            {if $addon.modulename}
                                                <tbody id="loadable">
                                                    <!-- module config -->
                                                    {include file='ajax.configmodule.tpl'}
                                                    <!-- module config end -->
                                                </tbody>
                                            {/if}
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        {/if}


                        <tbody class="sectioncontent" style="display:none">
                            <tr>
                                <td id="auts-settings" colspan="2">
                                    <table class="editor-container" cellspacing="0" cellpadding="6" width="100%">

                                        <tr class="odd">
                                            <td align="right" valign="top" width="200">
                                                <strong>{$lang.auto_create}</strong>
                                            </td>

                                            <td id="automateoptions">
                                                <input type="radio" value="0" name="autosetup2"
                                                       {if $addon.autosetup=='0'}checked="checked"{/if} id="autooff"
                                                       onclick="$('#autosetup_opt').hide();$('#autooff_').click();"/><label
                                                        for="autooff"><b>{$lang.no}</b></label>
                                                <input type="radio" value="1" name="autosetup2"
                                                       {if $addon.autosetup!='0'}checked="checked"{/if} id="autoon"
                                                       onclick="$('#autosetup_opt').ShowNicely();$('#autoon_').click();"/><label
                                                        for="autoon"><b>{$lang.yes}</b></label>

                                                <div class="p5" id="autosetup_opt"
                                                     style="{if $addon.autosetup=='0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                                    <input type="radio" style="display:none"
                                                           {if $addon.autosetup=='0'}checked="checked"{/if} value="0"
                                                           name="autosetup" id="autooff_"/>
                                                    <input type="radio" {if $addon.autosetup=='3'}checked="checked"{/if}
                                                           value="3" name="autosetup" id="autosetup3"/> <label
                                                            for="autosetup3">{$lang.whenorderplaced}</label><br/>
                                                    <input type="radio" {if $addon.autosetup=='2'}checked="checked"{/if}
                                                           value="2" name="autosetup" id="autoon_"/> <label
                                                            for="autoon_">{$lang.whenpaymentreceived}</label><br/>
                                                    <input type="radio" {if $addon.autosetup=='1'}checked="checked"{/if}
                                                           value="1" name="autosetup" id="autosetup1"/> <label
                                                            for="autosetup1">{$lang.whenmanualaccept}</label> <br/>
                                                    <input type="radio" {if $addon.autosetup=='4'}checked="checked"{/if}
                                                           value="4" name="autosetup" id="autosetup4"/> <label
                                                            for="autosetup4">{$lang.whenaccreated}</label>


                                                    <div class="clear"></div>

                                                </div>
                                            </td>
                                        </tr>

{* custom code configProvisionWithFulfillment  *}

                                        <tr>
                                            <td width="200" valign="top" align="right">
                                                <strong>{$lang.new_EnableAutoSuspension}</strong>
                                            </td>
                                            <td>
                                                <input type="radio"
                                                       {if $configuration.EnableAutoSuspension == 'off'}checked="checked"{/if}
                                                       name="config[EnableAutoSuspension]" value="off"
                                                       onclick="$('#suspension_options').hide();"
                                                       id="suspend_off"/><label
                                                        for="suspend_off"><b>{$lang.no}</b></label>
                                                <input type="radio"
                                                       {if $configuration.EnableAutoSuspension == 'on'}checked="checked"{/if}
                                                       name="config[EnableAutoSuspension]" value="on"
                                                       onclick="$('#suspension_options').ShowNicely()" id="suspend_on"/><label
                                                        for="suspend_on"><b>{$lang.yes}</b></label>
                                                <div class="p5" id="suspension_options"
                                                     style="{if $configuration.EnableAutoSuspension == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                                    {$lang.new_EnableAutoSuspension1}
                                                    <input type="text" size="3"
                                                           value="{$configuration.AutoSuspensionPeriod}"
                                                           name="config[AutoSuspensionPeriod]"
                                                           class="inp config_val"/> {$lang.new_EnableAutoSuspension2}


                                                    <div class="clear"></div>
                                                </div>
                                            </td>
                                        </tr>

{* custom code configProvisionWithFulfillment  *}

                                        <tr class="odd">
                                            <td width="200" valign="top" align="right">
                                                <strong>{$lang.new_EnableAutoUnSuspension}</strong>
                                            </td>
                                            <td>

                                                <input type="radio"
                                                       {if $configuration.EnableAutoUnSuspension == 'off'}checked="checked"{/if}
                                                       name="config[EnableAutoUnSuspension]" value="off"
                                                       onclick="$('#unsuspension_options').hide();" id="unsuspend_off"/><label
                                                        for="unsuspend_off"><b>{$lang.no}</b></label>
                                                <input type="radio"
                                                       {if $configuration.EnableAutoUnSuspension == 'on'}checked="checked"{/if}
                                                       name="config[EnableAutoUnSuspension]" value="on"
                                                       onclick="$('#unsuspension_options').ShowNicely();"
                                                       id="unsuspend_on"/><label
                                                        for="unsuspend_on"><b>{$lang.yes}</b></label>


                                                <div class="p5" id="unsuspension_options"
                                                     style="{if $configuration.EnableAutoUnSuspension == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                                    {$lang.new_EnableAutoUnSuspension1}


                                                    <div class="clear"></div>
                                                </div>
                                            </td>

                                        </tr>

{* custom code configProvisionWithFulfillment  *}

                                        <tr>
                                            <td width="200" valign="top" align="right">
                                                <strong>{$lang.new_EnableAutoTermination}</strong>
                                            </td>
                                            <td>
                                                <input type="radio"
                                                       {if $configuration.EnableAutoTermination == 'off'}checked="checked"{/if}
                                                       name="config[EnableAutoTermination]" value="off"
                                                       onclick="$('#termination_options').hide();"
                                                       id="termination_off"/><label
                                                        for="termination_off"><b>{$lang.no}</b></label>
                                                <input type="radio"
                                                       {if $configuration.EnableAutoTermination == 'on'}checked="checked"{/if}
                                                       name="config[EnableAutoTermination]" value="on"
                                                       onclick="$('#termination_options').ShowNicely();"
                                                       id="termination_on"/><label
                                                        for="termination_on"><b>{$lang.yes}</b></label>


                                                <div class="p5" id="termination_options"
                                                     style="{if $configuration.EnableAutoTermination == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                                    {$lang.new_EnableAutoTermination1}
                                                    <input type="text" size="3"
                                                           value="{$configuration.AutoTerminationPeriod}"
                                                           name="config[AutoTerminationPeriod]"
                                                           class="inp config_val"/> {$lang.new_EnableAutoTermination2}
                                                    <br/>
                                                    <input type="checkbox"
                                                           {if $configuration.EnableAddonRelatedTermination=='on'}checked="checked"{/if}
                                                           value="on"
                                                           name="config[EnableAddonRelatedTermination]"/> {$lang.EnableAddonRelatedTermination}

                                                    <div class="clear"></div>
                                                </div>
                                            </td>
                                        </tr>

{* custom code configProvisionWithFulfillment  *}

                                        <tr class="odd">
                                            <td align="right">
                                                <strong>{$lang.InvoiceGeneration} </strong>
                                            </td>
                                            <td>
                                                <input type="text" size="3" value="{$configuration.InvoiceGeneration}"
                                                       name="config[InvoiceGeneration]"
                                                       class="inp"/> {$lang.InvoiceGeneration2}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="200" align="right" valign="top">
                                                <strong>{$lang.new_SendPaymentReminderEmails}</strong></td>
                                            <td>
                                                <input type="radio"
                                                       {if $configuration.SendPaymentReminderEmails == 'off'}checked="checked"{/if}
                                                       name="config[SendPaymentReminderEmails]" value="off"
                                                       onclick="$('#reminder_options').hide();"
                                                       id="reminder_off"/><label
                                                        for="reminder_off"><b>{$lang.no}</b></label>
                                                <input type="radio"
                                                       {if $configuration.SendPaymentReminderEmails == 'on'}checked="checked"{/if}
                                                       name="config[SendPaymentReminderEmails]"
                                                       onclick="$('#reminder_options').ShowNicely();" id="reminder_on"/><label
                                                        for="reminder_on"><b>{$lang.yes}</b></label>

                                                <div class="p5" id="reminder_options"
                                                     style="{if $configuration.SendPaymentReminderEmails == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">


                                                    {$lang.InvoiceUnpaidReminder} <span>
                                                        <input type="checkbox" value="1"
                                                               {if $configuration.InvoiceUnpaidReminder>0}checked="checked"{/if}
                                                               onclick="check_i(this)"/>
                                                        <input type="text" size="3"
                                                               class="config_val  inp" {if $configuration.InvoiceUnpaidReminder<=0} value="0" disabled="disabled"{else}value="{$configuration.InvoiceUnpaidReminder}"{/if}
                                                               name="config[InvoiceUnpaidReminder]"/>
                                                    </span> {$lang.InvoiceUnpaidReminder2}
                                                    <br/><br/>

                                                    {$lang.1OverdueReminder}
                                                    <span>
                                                        <input type="checkbox" value="1"
                                                               {if $configuration.1OverdueReminder>0}checked="checked"{/if}
                                                               onclick="check_i(this)"/>
                                                        <input type="text" size="3"
                                                               class="config_val  inp"
                                                               {if $configuration.1OverdueReminder<=0}value="0"
                                                               disabled="disabled"
                                                               {else}value="{$configuration.1OverdueReminder}"{/if}
                                                               name="config[1OverdueReminder]"/>
                                                    </span>
                                                    <span>
                                                        <input type="checkbox" value="1"
                                                               {if $configuration.2OverdueReminder>0}checked="checked"{/if}
                                                               onclick="check_i(this)"/>
                                                        <input type="text" size="3"
                                                               class="config_val inp"
                                                               {if $configuration.2OverdueReminder<=0}value="0"
                                                               disabled="disabled"
                                                               {else}value="{$configuration.2OverdueReminder}"{/if}
                                                               name="config[2OverdueReminder]"/>
                                                    </span>
                                                    <span>
                                                        <input type="checkbox" value="1"
                                                               {if $configuration.3OverdueReminder>0}checked="checked"{/if}
                                                               onclick="check_i(this)"/>
                                                        <input type="text" size="3"
                                                               class="config_val  inp"
                                                               {if $configuration.3OverdueReminder<=0}value="0"
                                                               disabled="disabled"
                                                               {else}value="{$configuration.3OverdueReminder}"{/if}
                                                               name="config[3OverdueReminder]"/>
                                                    </span>
                                                    {$lang.1OverdueReminder2}
                                                </div>
                                            </td>
                                        </tr>

                                        <tr class="odd">
                                            <td width="200" align="right" valign="top">
                                                <strong>{$lang.new_LateFeeType_on|capitalize}</strong>
                                            </td>
                                            <td>
                                                <input type="radio"
                                                       {if $configuration.LateFeeType == '0'}checked="checked"{/if}
                                                       name="config[LateFeeType_sw]" value="0"
                                                       onclick="$('#latefee_options').hide();" id="latefee_off"/><label
                                                        for="latefee_off"><b>{$lang.no}</b></label>
                                                <input type="radio"
                                                       {if $configuration.LateFeeType != '0'}checked="checked"{/if}
                                                       name="config[LateFeeType_sw]" value="1"
                                                       onclick="$('#latefee_options').ShowNicely();"
                                                       id="latefee_on"/><label
                                                        for="latefee_on"><b>{$lang.yes}</b></label>

                                                <div class="p5" id="latefee_options"
                                                     style="{if $configuration.LateFeeType == '0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">


                                                    {$lang.new_LateFeeType_on1}
                                                    <input size="1" class="inp config_val"
                                                           value="{$configuration.LateFeeValue}"
                                                           name="config[LateFeeValue]"/>
                                                    <select class="inp config_val" name="config[LateFeeType]">
                                                        <option {if $configuration.LateFeeType=='1'}selected="selected"{/if}
                                                                value="1">%
                                                        </option>
                                                        <option {if $configuration.LateFeeType=='2'}selected="selected"
                                                                {/if}value="2">{if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</option>
                                                    </select>
                                                    {$lang.new_LateFeeType_on2}
                                                    <input type="text" size="3"
                                                           value="{$configuration.AddLateFeeAfter}"
                                                           name="config[AddLateFeeAfter]"
                                                           class="config_val inp"/> {$lang.LateFeeType2x}
                                                    <br/>

                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </tbody>

                        <tbody style="display:none" class="sectioncontent">
                            <tr>
                                <td colspan="2">
                                    {include file="services/ajax.service_emails.tpl" product=$addon}
                                </td>
                            </tr>
                        </tbody>

                        <tbody style="display:none" class="sectioncontent">

                            <tr>
                                <td width="200" align="right" valign="top"><strong>This addon is assigned to:</strong>
                                </td>
                                <td valign="top">
                                    <font color="blue">สีน้ำเงิน: Pending</font>
                                    / <font color="green">สีเขียว: Active</font>
                                    / <font color="black">สีดำ: Suspended</font>
                                    / <font color="red">สีแดง: Terminated</font>
                                    / <font color="gray">สีเทา: Cancelled</font><br>
                                    <table>                                    
                                    {foreach from=$assigned_products item=product}
                                        <tr style="border-bottom: 1px solid gray;">
                                            <td>
                                                <a href="?cmd=services&action=product&id={$product.id}&picked_tab=4&picked_subtab=1"
                                           target="_blank">#{$product.id}: {$product.catname} - {$product.name}</a>
                                            </td>
                                            <td style="padding-left: 20px;">
                                                {if $aProductAccounts[$product.id].acc}{$aProductAccounts[$product.id].acc}{else}0{/if}
                                            </td>
                                        </tr>
                                    {foreachelse}
                                        <em>No product have this addon assigned yet</em>
                                    {/foreach}
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="nicers" style="border:0px">
                    <a class="new_dsave new_menu" href="#" onclick="return saveAddonFull();">
                        <span>{$lang.savechanges}</span>
                    </a>
                </td>
            </tr>
        </table>


        {securitytoken}
    </form>
    <!-- ADDONS FORM END -->
{elseif $action=='categories'}

    {if $categories}
        <div class="blu">
            <input type="button" value="{$lang.createnewaddon}" class="linkDirectly" href="?cmd=productaddons&action=addaddon"/>
            <input type="button" value="{$lang.createnewcat}" class="linkDirectly" href="?cmd=productaddons&action=addcategory"/>
        </div>
        <form id="serializeit" method="post">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tr>
                    <th width="10">&nbsp;</th>
                    <th width="32%">{$lang.Name}</th>
                    <th width="32%">{$lang.Description}</th>
                    <th width="32%">{$lang.DefaultOption}</th>
                    <th width="20">&nbsp;</th>
                    <th width="10">&nbsp;</th>
                </tr>
            </table>
            <ul id="grab-sorter">
                {foreach from=$categories item=a name=protd}
                    <li>
                        <div>
                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                                <tr class="havecontrols">
                                    <td width="14">
                                        <div class="controls">
                                            <a class="sorter-handle">sort</a>
                                        </div>
                                    </td>
                                    <td width="32%">
                                        <input type="hidden" name="sorts[]" value="{$a.id}"/>
                                        <a href="?cmd=productaddons&action=category&id={$a.id}">{$a.name}</a>
                                    </td>
                                    <td width="31%">{$a.description}</td>
                                    <td width="31%">{$a.default_name}</td>
                                    <td width="20">
                                        <a href="?cmd=productaddons&action=category&id={$a.id}" class="editbtn">{$lang.Edit}</a>
                                    </td>
                                    <td width="10">
                                        <a href="?cmd=productaddons&make=deletecat&cat_id={$a.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletecategoryconfirm}');" class="delbtn">Delete</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </li>
                {/foreach}
            </ul>
            {securitytoken}</form>
        <table class="table glike" cellpadding="3" cellspacing="0" width="100%">
            <tr>
                <th width="10">&nbsp;</th>
                <th><a href="?cmd=productaddons&action=addcategory" class="editbtn">{$lang.createnewcat}</a></th>
            </tr>
        </table>
        <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
        <script type="text/javascript">
            {literal}
                $("#grab-sorter").dragsort({
                    dragSelector: "a.sorter-handle",
                    dragEnd: saveOrder,
                    placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
                });
                function saveOrder() {
                    var sorts = $('#serializeit').serialize();
                    ajax_update('?cmd=productaddons&action=listcats&' + sorts, {});
                };
            {/literal}
        </script>
    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>{$lang.blank_kb2}</h1>
                {$lang.blank_kb2_desc}
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd=productaddons&action=addcategory" style="margin-top:10px">
                    <span>{$lang.createnewcat}</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}

{elseif $action=='addcategory'}
    <form action="" method="post" onsubmit="selectalladdons()">
        <input type="hidden" name="make" value="addcategory"/>
        <div class="blu">
            <a href="?cmd=productaddons&action=categories" class="tload2">
                <strong>&laquo; {$lang.backtoaddonscat}</strong>
            </a>
        </div>
        <div style="padding:5px; " class="lighterblue">
            <table cellspacing="0" cellpadding="6" border="0" width="600">
                <tbody>
                    <tr>
                        <td width="160" align="right"><strong>{$lang.Name}</strong></td>
                        <td><input type="text" size="60" name="name" value="{$submit.name}" class="inp"/></td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.Description}</strong></td>
                        <td><textarea rows="3" cols="60" name="description" class="inp">{$submit.description}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.clientcanorder}</strong></td>
                        <td>
                            <select name="type" class="inp">
                                <option value="one">{$lang.onlyoneaddonradio}</option>
                                <option value="list">{$lang.onlyoneaddonlist}</option>
                                <option value="many">{$lang.manyaddons}</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.defoptname}</strong></td>
                        <td><input type="text" size="60" name="default_name" class="inp"/></td>
                    </tr>

                </tbody>
            </table>
            <div style="padding:5px; " class="lighterblue" id="aplicator">
                {if $addons}
                    <table width="80%" cellpadding="6" cellspacing="0">
                        <tbody>
                            <tr>
                                <td valign="top" align="center">
                                    {$lang.applicableaddons}<br/>
                                    <select multiple="multiple" name="addons2[]" style="width:300px;height:300px;" id="listAvail">
                                        {foreach from=$addons item=cat}
                                            {if !$cat.assigned}
                                                <option value="{$cat.id}">{$cat.name}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                    <br/>
                                </td>
                                <td valign="middle">
                                    <input type="button" value=">>" onclick="addItem();return false;" name="move"/><br/>
                                    <input type="button" value="<<" onclick="delItem();return false;" name="move"/>
                                </td>
                                <td valign="top" align="center">
                                    {$lang.appliedaddons} <br/>
                                    <select multiple="multiple" name="addons[]" style="width:300px;height:300px;" id="listAlready">
                                        {foreach from=$addons item=cat}
                                            {if $cat.assigned}
                                                <option value="{$cat.id}">{$cat.name}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                {else}
                    {$lang.noaddonsyet}
                    <a href="?cmd=productaddons&action=addaddon">{$lang.heretoadd}</a>
                    {$lang.newaddon}.
                {/if}
            </div>
        </div>
        <div class="blu">
            <a href="?cmd=productaddons&action=categories" class="tload2"><strong>&laquo; {$lang.backtoaddonscat}</strong></a>
            <input type="submit" style="font-weight:bold" value="{$lang.addcategory}"/>
            <input type="button" onclick="window.location='?cmd=productaddons'" style="" value="{$lang.Cancel}"/>
        </div>
        {securitytoken}</form>
    </div>
{elseif $action=='category'}
    <form action="" method="post" onsubmit="selectalladdons()">
        <input type="hidden" name="make" value="update"/>
        <div class="blu"><a href="?cmd=productaddons&action=categories"
                            class="tload2"><strong>&laquo; {$lang.backtoaddonscat}</strong></a>
        </div>
        <div style="padding:5px; " class="lighterblue">
            <table cellspacing="0" cellpadding="6" border="0" width="600">
                <tbody>
                    <tr>
                        <td width="160" align="right"><strong>{$lang.Name}</strong></td>
                        <td><input type="text" size="60" name="name" value="{$category.name}" class="inp"/></td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.Description}</strong></td>
                        <td><textarea rows="3" cols="60" name="description"
                                      class="inp">{$category.description}</textarea></td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.clientcanorder}</strong></td>
                        <td><select name="type" class="inp">
                                <option value="one"
                                        {if $category.type=='one'}selected="selected"{/if}>{$lang.onlyoneaddonradio}</option>
                                <option value="list"
                                        {if $category.type=='list'}selected="selected"{/if}>{$lang.onlyoneaddonlist}</option>
                                <option value="many"
                                        {if $category.type=='many'}selected="selected"{/if} >{$lang.manyaddons}</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.defoptname}</strong></td>
                        <td><input type="text" size="60" name="default_name" value="{$category.default_name}"
                                   class="inp"/></td>
                    </tr>

                </tbody>
            </table>

            <div style="padding:5px;" class="lighterblue" id="aplicator">
                {if $addons}
                    <table width="80%" cellpadding="6" cellspacing="0">
                        <tbody>
                            <tr>
                                <td valign="top" align="center">
                                    {$lang.applicableaddons} <br/>
                                    <select multiple="multiple" name="addons2[]" style="width:300px;height:300px;" id="listAvail">
                                        {foreach from=$addons item=cat}
                                            {if !$cat.assigned}
                                                <option value="{$cat.id}">{$cat.name}</option>
                                            {/if}
                                        {/foreach}
                                    </select><br/>
                                </td>
                                <td valign="middle">
                                    <input type="button" value=">>" onclick="addItem();return false;" name="move"/><br/>
                                    <input type="button" value="<<" onclick="delItem();return false;" name="move"/>
                                </td>
                                <td valign="top" align="center">
                                    {$lang.appliedaddons} <br/>
                                    <select multiple="multiple" name="addons[]" style="width:300px;height:300px;"
                                            id="listAlready">


                                        {foreach from=$addons item=cat}
                                            {if $cat.assigned}
                                                <option value="{$cat.id}">{$cat.name}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                {else}
                    {$lang.noaddonsyet}
                    <a href="?cmd=productaddons&action=addaddon">{$lang.heretoadd}</a>
                    {$lang.newaddon}.
                {/if}
            </div>
        </div>
        <div class="blu">
            <input type="submit" style="font-weight:bold" value="{$lang.updatecategory}"/>
            <input type="button" onclick="window.location='?cmd=productaddons'" style="" value="{$lang.Cancel}"/>
        </div>
        {securitytoken}
    </form>
    </div>
{elseif $action=='default'}
    <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-1" >
            <ul>
                <li class="active">
                    <a href="?cmd=productaddons"><span>{$lang.Addons}</span></a>
                </li>
                <li>
                    <a href="?cmd=productaddons&action=addaddon"><span>{$lang.createnewaddon}</span></a>
                </li>
            </ul>
        </div>
    </div>
    {if $addons}
        <form id="serializeit" method="post">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tr>
                    <th width="20">&nbsp;</th>
                    <th width="300">{$lang.Name}</th>
                    <th>{$lang.Description}</th>
                    <th width="160">&nbsp;</th>
                </tr>
            </table>
            <ul id="grab-sorter">
                {foreach from=$addons item=a key=cat_id name=protd}
                    <li {if $a.visible=='0'}class="ishidden"{/if}>
                        <div>
                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                                <tr class="havecontrols">
                                    <td width="20" valign="middle">
                                        <div class="controls"><a class="sorter-handle">sort</a></div>&nbsp;
                                    </td>
                                    <td width="300"><input type="hidden" name="sorts[]"
                                                           value="{$a.id}"/>{if $a.visible=='0'}<em
                                                class="ishidden">{/if}<a
                                                    href="?cmd=productaddons&action=addon&id={$a.id}">{$a.name}</a>{if $a.visible=='0'}
                                        </em>{/if} {if $a.visible=='0'}<em class="hidden fs11">{$lang.hidden}</em>{/if}
                                    </td>
                                    <td>{$a.description}{if $a.modulename}
                                            <div style="font-size:10px">Module: <strong>{$a.modulename}</strong>
                                            </div>{/if}</td>
                                    <td width="160" style="text-align:right">
                                        <a href="?cmd=productaddons&action=addon&id={$a.id}" class="menuitm menu-auto "><span
                                                    style="color:red">{$lang.Edit}</span></a>

                                        <a href="?cmd=productaddons&action=duplicate&id={$a.id}&security_token={$security_token}"
                                           class="menuitm menu-auto ">{$lang.Duplicate}</a>

                                        {if $a.system != '1'}<a
                                            href="?cmd=productaddons&make=deleteaddon&id={$a.id}&security_token={$security_token}"
                                            onclick="return confirm('{$lang.deleteaddonconfirm}');"
                                            class="menuitm menu-auto"><span class="delsth"></span></a>{/if}
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </li>
                {/foreach}
            </ul>
            <table class="table glike" cellpadding="3" cellspacing="0" width="100%">
                <tr>
                    <th width="10">&nbsp;</th>
                    <th><a href="?cmd=productaddons&action=addaddon"
                           class="btn btn-sm btn-success">{$lang.createnewaddon}</a></th>
                </tr>
            </table>
            {securitytoken}</form>
        <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
        <script type="text/javascript">{literal}
            $("#grab-sorter").dragsort({
                dragSelector: "a.sorter-handle",
                dragEnd: saveOrder,
                placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
            });

            function saveOrder() {
                var sorts = $('#serializeit').serialize();
                ajax_update('?cmd=productaddons&action=listprods&' + sorts, {});
            };


            {/literal}
        </script>
    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>{$lang.blank_kb}</h1>
                {$lang.blank_kb_desc}
                <div class="clear"></div>

                <a class="new_add new_menu" href="?cmd=productaddons&action=addaddon" style="margin-top:10px">
                    <span>{$lang.createnewaddon}</span></a>
                <div class="clear"></div>

            </div>
        </div>
    {/if}
{/if}
{if $action=='addon' || $action=='addaddon'}
    <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
    <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
    <script type="text/javascript">
        {literal}

        function loadMod(el) {

            $('#subloader').html('<center><img src="ajax-loading.gif" /></center>');
            ajax_update('index.php?cmd=productaddons&action=showparentmod&addon_id={/literal}{$addon.id}{literal}&parentid=' + $(el).val(), {}, '#loadable');

        }

        function changeFunction(el) {
            $('.mdesc').hide().eq(el.selectedIndex).ShowNicely();
            $('#subloader').html('<center><img src="ajax-loading.gif" /></center>');
            ajax_update('index.php?cmd=productaddons&action=showparentmod&addon_id={/literal}{$addon.id}{literal}&id=' + $(el).val(), {}, '#loadable');
            return false;
        }

        function switch_t3(el, id) {
            $('#automateoptions .billopt').removeClass('checked');
            $(el).addClass('checked');
            if (id == "on1")
                $(el).removeClass('bfirst');
            $('input[name=autosetup]').removeAttr('checked');
            $('input#' + id).attr('checked', 'checked');
            $('#off1_a').hide();
            $('#on1_a').hide();
            $(el).parents('tbody.sectioncontent').find('.savesection').show();
            $('#' + id + '_a').show();
            return false;
        }

        function check_i(element) {
            var td = $(element).parent();
            if ($(element).is(':checked'))
                $(td).find('.config_val').removeAttr('disabled');
            else
                $(td).find('.config_val').attr('disabled', 'disabled');
        }

        function bindMe() {
            $('#newshelfnav').TabbedMenu({
                elem: '.sectioncontent',
                picker: '.list-1 li',
                aclass: 'active'{/literal}{if $picked_tab},
                picked:{$picked_tab}{/if}{literal}});
            $('#newshelfnav').TabbedMenu({
                elem: '.subm1',
                picker: '.list-1 li'{/literal}{if $picked_tab},
                picked:{$picked_tab}{/if}{literal}});
            $('#newsetup1').click(function () {
                $(this).hide();
                $('#newsetup').show();
                return false;
            });

        }

        function add_message(gr, id, msg) {
            var sel = $('#' + gr + '_msg select');
            sel.find('option:selected').removeAttr('selected');
            sel.prepend('<option value="' + id + '">' + msg + '</option>').find('option').eq(0).attr('selected', 'selected');
            return false;

        }

        appendLoader('bindMe');

        function switch_t2(el, id) {
            $('#priceoptions .billopt').removeClass('checked');
            $(el).addClass('checked');

            $('input[name=paytype]').removeAttr('checked').prop('checked', false);
            $('input#' + id).attr('checked', 'checked').prop('checked', true);
            if (id == 'recurx')
                $('input#recur').attr('checked', 'checked').prop('checked', true);

            $('.boption').hide();
            $('#recurx_b').hide();
            $('#' + id + '_b').show();
            $('#hidepricingadd').click();
            return false;
        }

        $('input[data-toggle]').on('change init', function (e) {
            var self = $(this),
                target = $(self.data('toggle'));

            if (self.is(':checked')) {
                $('input[name="' + self.attr('name') + '"]').not(self).change();
                e.type === 'init' ? target.show() : target.ShowNicely();
            } else if (e.type !== 'init') {
                //console.log('hide',self.data('toggle'));
                target.hide();
            }
        }).trigger('init');

        {/literal}
    </script>
{/if}