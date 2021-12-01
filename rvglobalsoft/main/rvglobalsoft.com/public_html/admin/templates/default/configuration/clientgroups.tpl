{if $action=='groups'}
    {if !$groups}
        <div id="blank_state" class="blank_state blank_news">
            <div class="blank_info">
                <h1>Organize your customers into groups</h1>
                Let your priority clients stand out with privileged discounts, automation settings and more - all
                possible from client groups.
                <br/>Note: All clients by default are assigned to "None" group
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd=clients&action=addgroup" style="margin-top:10px">
                    <span>Add custom client group</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {else}
        <div style="padding:15px;">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;"
                   class="whitetable">
                <tbody>
                    <tr>
                        <th align="left" colspan="4">Current client groups</th>
                    </tr>
                    {foreach from=$groups item=group}
                        <tr class="havecontrols  ">
                            <td style="padding-left:10px" width="150"><a
                                        href="?cmd=clients&action=editgroup&id={$group.id}"
                                        class="isclient isclient-{$group.id}">{$group.name}</a></td>
                            <td>{$group.description}</td>
                            <td width="100">
                                <a href="?cmd=clients&list={$group.id}" class="fs11"
                                   target="_blank">{$group.count} customers</a>
                            </td>
                            <td width="23" align="center">
                                <a class="delbtn"
                                   href="?cmd=clients&action=groups&make=delete&id={$group.id}&security_token={$security_token}"
                                   onclick="return confirm('Are you sure? Clients from under this group will be re-assigned to default group (None)')">Delete</a>
                            </td>
                        </tr>
                    {/foreach}

                </tbody>
            </table>
            <a style="margin-top:10px" href="?cmd=clients&amp;action=addgroup" class="new_add new_menu">
                <span>Add custom client group</span></a>
            <div class="clear"></div>
        </div>
    {/if}

{else}
    <link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css"/>
{literal}
    <style>
        .sub-section {
            margin: 20px 0;
        }

        .sub-section-header {
            border-bottom: 1px solid #b9b9b9;
        }

        .toggle-override .contener {
            padding: 10px;
            background: #fafafa;
        }

        .contener .radio:first-child {
            margin-top: 0;
        }

        .option-line{
            margin: 5px 0;
        }
        .contener p:first-child, .option-line:first-child{
            margin-top: 0
        }
        .contener p:last-child, .option-line:last-child {
            margin-bottom: 0;
        }

    </style>
{/literal}
    <script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js?v={$hb_version}"></script>
    {if $action == 'overrides'}
        <div class="blu">
            <div class="menubar">
                <a href="?cmd=clients&action=show&id={$client.id}">
                    <strong>&laquo; {$lang.backtoclient}</strong>
                </a>
            </div>
        </div>
    {/if}
    <form action="" method="post" id="sme">
        <div id="newshelfnav" class="newhorizontalnav">
            <input type="hidden" name="picked_tab" id="picked_tab" value="{$picked_tab}"/>
            <div class="list-1">
                <ul>
                    {if $action !== 'overrides'}
                        <li>
                            <a href="#">General</a>
                        </li>
                    {/if}

                    <li>
                        <a href="#" rel="billing">Billing <span class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}" style="display: none">0</span></a>
                    </li>
                    <li>
                        <a href="#" rel="automation">Automation <span class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}" style="display: none">0</span></a>
                    </li>
                    <li>
                        <a href="#" rel="orders">Orders <span class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}" style="display: none">0</span></a>
                    </li>
                    <li>
                        <a href="#" rel="discounts">Discounts <span class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}" style="display: none">0</span></a>
                    </li>
                    <li class="last">
                        <a href="#" rel="support">Support & Notifications <span class="label {if $action !== 'overrides'}label-warning{else}label-danger{/if}" style="display: none">0</span></a>
                    </li>
                </ul>
            </div>
        </div>

        <div style="padding:15px;">
            {if $action !== 'overrides'}
                <div class="sectioncontent">
                    <table width="100%" cellspacing="0" cellpadding="6">
                        <tbody>
                            <tr>
                                <td width="160" align="right"><strong>Name</strong></td>
                                <td class="editor-container">
                                    <input style="font-size: 16px !important; font-weight: bold;" class="inp" size="50"
                                           name="name" value="{$groupx.name}"/>
                                </td>
                            </tr>

                            <tr>
                                <td width="160" align="right"><strong>Group color<a class="vtip_description"
                                                                                    title="Group members will be listed using this color"></a></strong>
                                </td>
                                <td class="editor-container">
                                    <input id="colorSelector_i" type="hidden" class="w250" size="7" name="color"
                                           value="{$groupx.color}" style="margin-bottom:5px"/>
                                    <div id="colorSelector"
                                         style="border: 2px solid #ddd; cursor: pointer; float: left; height: 15px;margin: 6px 0 5px 8px;position:relative; width: 40px; background: {$groupx.color};"
                                         onclick="$('#colorSelector_i').click()">
                                        <div style="position:absolute; bottom:0; right: 0; color:white; background:url('{$template_dir}img/imdrop.gif') no-repeat 3px 4px #ddd; height:10px; width:10px"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td width="160" align="right"><strong>Admin-only description</strong></td>
                                <td class="editor-container">
                                <textarea name="description"
                                          style="width:400px;height:50px">{$groupx.description}</textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            {/if}


            <div class="sectioncontent" style="display:none">
                {if $action === 'overrides'}
                    <div class="form-group">
                        <label>{$lang.taxexempt}</label>
                        <select name="settings[TaxExempt]" class="form-control overridedefault" data-default="0" >
                            <option value="0">{$lang.Disabled}</option>
                            <option value="1" {if $configuration.TaxExempt}selected{/if}>{$lang.Enabled}</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <strong>Tax rate</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[TaxOverrideRate]" class="toc" value="1"
                                   {if $groupx.settings_enabled.TaxOverrideRate}checked{/if} />
                            Override billing settings

                            <div class="contener">
                                Use <input name="settings[TaxOverrideRate]" type="number" min="0" max="100" step="0.01"
                                           class="inp" value="{$configuration.TaxOverrideRate}" style="width: 50px;"/>%
                                as L1 tax rate.
                            </div>
                        </div>
                    </div>
                {/if}

                <div class="form-group">
                    <strong>{$lang.FinalInvoiceOnPayment}</strong>
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[FinalInvoiceOnPayment]" class="toc" value="1"
                               {if $groupx.settings_enabled.FinalInvoiceOnPayment}checked{/if} />
                        Override billing settings

                        <div class="contener">
                            <div class="option-line">
                                <input name="settings[FinalInvoiceOnPayment]" type="radio" value="on"
                                       {if $configuration.FinalInvoiceOnPayment=='on'}checked{/if}
                                       class="inp"/>
                                <strong>{$lang.yes}, </strong> {$lang.FinalInvoiceOnPayment_on}
                            </div>
                            <div class="option-line">
                                <input name="settings[FinalInvoiceOnPayment]" type="radio" value="off"
                                       {if $configuration.FinalInvoiceOnPayment=='off'}checked{/if}
                                       class="inp"/>
                                <strong>{$lang.no}, </strong>{$lang.FinalInvoiceOnPayment_off}
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <strong>{$lang.MergeInvoices}</strong>
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[GenerateSeparateInvoices]" class="toc" value="1"
                               {if $groupx.settings_enabled.GenerateSeparateInvoices}checked{/if} />
                        Override billing settings

                        <div class="contener">
                            <div class="option-line">
                                <input name="settings[GenerateSeparateInvoices]" type="radio" value="off"
                                       {if $configuration.GenerateSeparateInvoices=='off'}checked{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong> {$lang.MergeInvoicesCron}
                            </div>
                            <div class="option-line">
                                <input name="settings[GenerateSeparateInvoices]" type="radio" value="due"
                                       {if $configuration.GenerateSeparateInvoices=='due'}checked{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong>{$lang.MergeInvoicesDue}
                            </div>
                            <div class="option-line">
                                <input name="settings[GenerateSeparateInvoices]" type="radio" value="on"
                                       {if $configuration.GenerateSeparateInvoices=='on'}checked{/if} class="inp"/>
                                <strong>{$lang.no}, </strong>{$lang.MergeInvoiceNone}
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <strong>{$lang.ContinueInvoices}</strong>
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[ContinueInvoices]" class="toc" value="1"
                               {if $groupx.settings_enabled.ContinueInvoices}checked{/if} />
                        Override billing settings

                        <div class="contener">
                            <input name="settings[ContinueInvoices]" type="radio" value="on"
                                   {if $configuration.ContinueInvoices=='on'}checked{/if} class="inp"/>
                            <strong>{$lang.yes}, </strong> {$lang.ContinueInvoices_descr}<br/>
                            <input name="settings[ContinueInvoices]" type="radio" value="off"
                                   {if $configuration.ContinueInvoices=='off'}checked{/if} class="inp"/>
                            <strong>{$lang.no}, </strong>{$lang.ContinueInvoices_descr1}
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <strong>Auto-apply credit</strong>
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[CreditAutoApply]" class="toc" value="1"
                               {if $groupx.settings_enabled.CreditAutoApply}checked{/if} />
                        Override billing settings

                        <div class="contener">
                            <input name="settings[CreditAutoApply]" type="radio" value="on"
                                   {if $configuration.CreditAutoApply=='on'}checked{/if}
                                   class="inp"/>
                            <strong>{$lang.yes}, </strong> {$lang.autocredit_yes}<br/>
                            <input name="settings[CreditAutoApply]" type="radio" value="off"
                                   {if $configuration.CreditAutoApply=='off'}checked{/if}
                                   class="inp"/>
                            <strong>{$lang.no}, </strong>{$lang.autocredit_no}
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <strong>{$lang.CCChargeAuto}</strong>
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[CCChargeAuto]" class="toc" value="1"
                               {if $groupx.settings_enabled.CCChargeAuto}checked{/if} />
                        Override billing settings

                        <div class="contener">
                            <div class="option-line">
                                <input type="radio" name="settings[CCChargeAuto]" value="off"
                                       {if $configuration.CCChargeAuto=='off'}checked{/if}
                                       data-toggle=""/>
                                <strong>{$lang.no}, </strong> {$lang.CCChargeAuto_dscr1}
                            </div>
                            <div class="option-line">
                                <input type="radio" name="settings[CCChargeAuto]" value="on"
                                       {if $configuration.CCChargeAuto=='on'}checked{/if}
                                       data-toggle=".chargefew"/>
                                <strong>{$lang.yes}, </strong> {$lang.CCChargeAuto_dscr}
                                <input type="text" size="3"
                                       value="{if $configuration.CCChargeAuto!='on'}0{else}{$configuration.CCDaysBeforeCharge}{/if}"
                                       name="settings[CCDaysBeforeCharge]"/>
                                {$lang.CCChargeAuto2}
                            </div>

                            <div class="chargefew"
                                 style="padding-left: 10px; margin-left: 5px; border-left: 1px solid #ddd">
                                <div class="option-line">
                                    <input type="radio" name="settings[CCAttemptOnce]" value="on"
                                           {if $configuration.CCAttemptOnce=='on'}checked{/if}/> {$lang.CCAttemptOnce}
                                </div>
                                <div class="option-line">
                                    <input type="radio" name="settings[CCAttemptOnce]" value="off"
                                           {if $configuration.CCAttemptOnce=='off'}checked{/if}/> {$lang.CCAttemptOnce2}
                                    <input type="text" size="3" name="settings[CCRetryForDays]"
                                           value="{if $configuration.CCRetryForDays}{$configuration.CCRetryForDays}{else}3{/if}"/>
                                    {$lang.days}
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <strong>{$lang.AllowControlInvoiceDelivery}</strong>
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[AllowControlInvoiceDelivery]" class="toc" value="1"
                               {if $groupx.settings_enabled.AllowControlInvoiceDelivery}checked{/if} />
                        Override billing settings

                        <div class="contener">
                            <div class="option-line">
                                <input type="radio" name="settings[AllowControlInvoiceDelivery]" value="on"
                                       {if $configuration.AllowControlInvoiceDelivery=='on'}checked{/if}
                                       data-toggle=".chargefew"/>
                                <strong>{$lang.yes}</strong>
                            </div>
                            <div class="option-line">
                                <input type="radio" name="settings[AllowControlInvoiceDelivery]" value="off"
                                       {if $configuration.AllowControlInvoiceDelivery=='off'}checked{/if}
                                       data-toggle=""/>
                                <strong>{$lang.no}</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <strong>{$lang.InvoiceDeliveryMethod}</strong>
                    {if  $configuration.InvoiceModel=='eu'}{assign var=attach_type value='AttachPDFInvoicePaid'}
                    {else} {assign var=attach_type value='AttachPDFInvoice'}
                    {/if}
                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[{$attach_type}]" class="toc" value="1"
                               {if $groupx.settings_enabled.$attach_type}checked{/if} />
                        Override billing settings
                        <div class="contener">
                            <div class="option-line">
                                <input name="settings[{$attach_type}]" type="radio" value="on"
                                       {if $configuration.$attach_type=='on'}checked="checked"{/if} class="inp" onchange="$('.printqueue').fadeOut('fast');"/>
                                {$lang.InvoiceDeliveryMethod_descr1}<br/>
                            </div>
                            <div class="option-line">
                                <input name="settings[{$attach_type}]" type="radio" value="off"
                                       {if $configuration.$attach_type=='off'}checked="checked"{/if} class="inp" onchange="$('.printqueue').fadeOut('fast');"/>
                                {$lang.InvoiceDeliveryMethod_descr2}
                            </div>
                            <div class="option-line">
                                <input name="settings[{$attach_type}]" type="radio" value="paper"
                                       {if $configuration.$attach_type=='paper'}checked="checked"{/if} class="inp" onchange="$('.printqueue').fadeIn('fast');"/>
                                {$lang.InvoiceDeliveryMethod_descr3}
                            </div>
                            <div class="option-line">
                                <input name="settings[{$attach_type}]" type="radio" value="paperpdf"
                                       {if $configuration.$attach_type=='paperpdf'}checked="checked"{/if} class="inp" onchange="$('.printqueue').fadeIn('fast');"/>
                                {$lang.InvoiceDeliveryMethod_descr4}
                            </div>
                            <div class="printqueue"
                                 style="padding-left: 10px; margin-left: 5px; border-left: 1px solid #ddd; {if
                                 !in_array($configuration.$attach_type, array('paper', 'paperpdf'))}display:none;{/if}" >
                                {if  $configuration.InvoiceModel=='eu'}
                                    <input type="hidden" name="settings_enabled[AddToPrintQueue]" value="1">
                                    <strong>{$lang.AddToPrintQueue}</strong>
                                    <div class="option-line">
                                        <input type="radio" name="settings[AddToPrintQueue]" value="proforma"
                                               {if $configuration.AddToPrintQueue=='proforma'}checked{/if}/> {$lang.ProForma}
                                    </div>
                                    <div class="option-line">
                                        <input type="radio" name="settings[AddToPrintQueue]" value="final"
                                               {if $configuration.AddToPrintQueue=='final'}checked{/if}/> {$lang.FinalInvoice}
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="sectioncontent" style="display:none">
                <div class="sub-section">
                    <h1 class="sub-section-header">Services</h1>

                    <div class="form-group">
                        <strong>{$lang.auto_create}</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoCreation]" class="toc" value="1"
                                   {if $groupx.settings_enabled.EnableAutoCreation}checked{/if} />
                            Override package settings

                            <div class="contener">
                                <input type="radio" value="0" name="settings[EnableAutoCreations]"
                                       {if !$configuration.EnableAutoCreation}checked{/if} id="autooff"
                                       data-toggle="" onclick="$('#autooff_').click();"/>
                                <label for="autooff"><b>{$lang.no}</b></label>

                                <input type="radio" value="1" name="settings[EnableAutoCreations]"
                                       {if $configuration.EnableAutoCreation > 0}checked {/if}id="autoon"
                                       data-toggle="#autosetup_opt"/>
                                <label for="autoon"><b>{$lang.yes}</b></label>

                                <div class="p5" id="autosetup_opt"
                                     style="{if $configuration.EnableAutoCreation=='0' || !$groupx.settings_enabled.EnableAutoCreation}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                    <input type="radio" style="display:none"
                                           {if $configuration.EnableAutoCreation=='0'}checked{/if}
                                           value="0" name="settings[EnableAutoCreation]" id="autooff_"/>

                                    <input type="radio"
                                           {if $configuration.EnableAutoCreation=='3'}checked{/if}
                                           value="3" name="settings[EnableAutoCreation]" id="autosetup3"/>
                                    <label for="autosetup3">{$lang.whenorderplaced}</label>
                                    <br/>
                                    <input type="radio"
                                           {if $configuration.EnableAutoCreation=='2'}checked{/if}
                                           value="2" name="settings[EnableAutoCreation]" id="autoon_"/>
                                    <label for="autoon_">{$lang.whenpaymentreceived}</label>
                                    <br/>
                                    <input type="radio"
                                           {if $configuration.EnableAutoCreation=='1'}checked{/if}
                                           value="1" name="settings[EnableAutoCreation]" id="autosetup1"/>
                                    <label for="autosetup1">{$lang.whenmanualaccept}</label>
                                    <br/>
                                    <input type="radio"
                                           {if $configuration.EnableAutoCreation=='4'}checked{/if}
                                           value="4" name="settings[EnableAutoCreation]" id="autosetup4"/>
                                    <label for="autosetup4">{$lang.procesbycron}</label>
                                    <div class="clear"></div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="form-group">
                        <strong>Automatic Upgrades</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoUpgrades]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.EnableAutoUpgrades}checked{/if} />
                            Override package settings
                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.EnableAutoUpgrades == 'off'}checked="checked"{/if}
                                       name="settings[EnableAutoUpgrades]" value="off"
                                       data-toggle=""
                                       id="upgrades_off"/>
                                <label for="upgrades_off"><b>{$lang.no}</b></label>

                                <input type="radio"
                                       {if $configuration.EnableAutoUpgrades == 'on'}checked="checked"{/if}
                                       name="settings[EnableAutoUpgrades]" value="on"
                                       data-toggle="#upgrades_options"
                                       id="upgrades_on"/>
                                <label for="upgrades_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="upgrades_options"
                                     style="{if $configuration.EnableAutoUpgrades == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                    Upgrade account automatically after receiving payment
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <strong>Automatic Renew</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoRenewService]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.EnableAutoRenewService}checked{/if} />
                            Override package settings
                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.EnableAutoRenewService == 'off'}checked="checked"{/if}
                                       name="settings[EnableAutoRenewService]" value="off"
                                       data-toggle=""
                                       id="renew_off"/>
                                <label for="renew_off"><b>{$lang.no}</b></label>

                                <input type="radio"
                                       {if $configuration.EnableAutoRenewService == 'on'}checked="checked"{/if}
                                       name="settings[EnableAutoRenewService]" value="on"
                                       data-toggle="#renew_options"
                                       id="renew_on"/>
                                <label for="renew_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="renew_options"
                                     style="{if $configuration.EnableAutoRenewService == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                    Renew account automatically after receiving payment
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <strong>Account suspension</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoSuspension]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.EnableAutoSuspension}checked{/if} />
                            Override package settings
                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.EnableAutoSuspension == 'off'}checked{/if}
                                       name="settings[EnableAutoSuspension]" value="off"
                                       data-toggle="" id="suspend_off"/>
                                <label for="suspend_off"><b>{$lang.no}</b></label>

                                <input type="radio"
                                       {if $configuration.EnableAutoSuspension == 'on'}checked{/if}
                                       name="settings[EnableAutoSuspension]" value="on"
                                       data-toggle="#suspension_options" id="suspend_on"/>
                                <label for="suspend_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="suspension_options"
                                     style="{if $configuration.EnableAutoSuspension != 'on'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                    {$lang.new_EnableAutoSuspension1}
                                    <input type="text" size="3" value="{$configuration.AutoSuspensionPeriod}"
                                           name="settings[AutoSuspensionPeriod]" class="inp config_val"/>
                                    {$lang.new_EnableAutoSuspension2}

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">

                        <strong>{$lang.new_EnableAutoTermination}</strong>

                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoTermination]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.EnableAutoTermination}checked{/if} />
                            Override package settings

                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.EnableAutoTermination == 'off'}checked{/if}
                                       name="settings[EnableAutoTermination]" value="off"
                                       data-toggle=""
                                       id="termination_off"/>
                                <label for="termination_off"><b>{$lang.no}</b></label>

                                <input type="radio"
                                       {if $configuration.EnableAutoTermination == 'on'}checked{/if}
                                       name="settings[EnableAutoTermination]" value="on"
                                       data-toggle="#termination_options"
                                       id="termination_on"/>
                                <label for="termination_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="termination_options"
                                     style="{if $configuration.EnableAutoTermination != 'on'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                    {$lang.new_EnableAutoTermination1}
                                    <input type="text" size="3"
                                           value="{$configuration.AutoTerminationPeriod}"
                                           name="settings[AutoTerminationPeriod]"
                                           class="inp config_val"/>
                                    {$lang.new_EnableAutoTermination2}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="sub-section">
                    <h1 class="sub-section-header">Domains</h1>

                    <div class="form-group">
                        <strong>Auto-Register domains</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoRegisterDomain]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.EnableAutoRegisterDomain}checked{/if} />
                            Override package settings

                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.EnableAutoRegisterDomain == 'off'}checked{/if}
                                       name="settings[EnableAutoRegisterDomain]" value="off"
                                       data-toggle=""
                                       id="register_off"/>
                                <label for="register_off"><b>{$lang.no}</b></label>

                                <input type="radio"
                                       {if $configuration.EnableAutoRegisterDomain == 'on'}checked{/if}
                                       name="settings[EnableAutoRegisterDomain]" value="on"
                                       data-toggle="#register_opt"
                                       id="register_on"/>

                                <label for="register_on"><b>{$lang.yes}</b></label>
                                <div class="p5" id="register_opt"
                                     style="{if $configuration.EnableAutoRegisterDomain != 'on'}display:none;{/if}">
                                    <input type="radio" value="1" name="settings[AutoRegisterDomainType]"
                                            {if $configuration.AutoRegisterDomainType == 1} checked{/if}>
                                    {$lang.whenorderplaced}
                                    <br>
                                    <input type="radio" value="0" name="settings[AutoRegisterDomainType]"
                                            {if $configuration.AutoRegisterDomainType == 0} checked{/if}>
                                    After receiving payment
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <strong>Auto-Transfer domains</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoTransferDomain]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.EnableAutoTransferDomain}checked{/if} />
                            Override package settings
                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.EnableAutoTransferDomain == 'off'}checked{/if}
                                       name="settings[EnableAutoTransferDomain]" value="off"
                                       data-toggle=""
                                       id="transfer_off"/><label for="transfer_off"><b>{$lang.no}</b></label>
                                <input type="radio"
                                       {if $configuration.EnableAutoTransferDomain == 'on'}checked{/if}
                                       name="settings[EnableAutoTransferDomain]" value="on"
                                       data-toggle="#transfer_options"
                                       id="transfer_on"/><label for="transfer_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="transfer_options"
                                     style="{if $configuration.EnableAutoTransferDomain != 'on'}display:none;{/if}">
                                    <input type="radio" value="1" name="settings[AutoTransferDomainType]"
                                            {if $configuration.AutoTransferDomainType == 1} checked{/if}>
                                    {$lang.whenorderplaced}
                                    <br>
                                    <input type="radio" value="0" name="settings[AutoTransferDomainType]"
                                            {if $configuration.AutoTransferDomainType == 0} checked{/if}>
                                    After receiving payment
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <strong>Auto-Renew domains</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[EnableAutoRenewDomain]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.EnableAutoRenewDomain}checked{/if} />
                            Override package settings

                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.EnableAutoRenewDomain == 'off'}checked{/if}
                                       name="settings[EnableAutoRenewDomain]" value="off"
                                       data-toggle=""
                                       id="renew_off"/><label for="renew_off"><b>{$lang.no}</b></label>

                                <input type="radio"
                                       {if $configuration.EnableAutoRenewDomain == 'on'}checked{/if}
                                       name="settings[EnableAutoRenewDomain]" value="on"
                                       data-toggle="#renewal_options"
                                       id="renew_on"/><label for="renewa_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="renewal_options"
                                     style="{if $configuration.EnableAutoRenewDomain != 'on'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                    <input type="radio" value="on" name="settings[RenewOnOrder]"
                                            {if $configuration.RenewOnOrder == 'on'} checked{/if}>
                                    When renwal order is placed
                                    <br>
                                    <input type="radio" value="" name="settings[RenewOnOrder]"
                                            {if $configuration.RenewOnOrder != 'on'} checked{/if}>
                                    After receiving payment
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="sub-section">
                    <h1 class="sub-section-header">General</h1>

                    <div class="form-group">
                        <strong>{$lang.InvoiceGeneration} </strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[RenewInvoice]" class="toc" value="1"
                                   {if $groupx.settings_enabled.RenewInvoice}checked{/if} />
                            Override package settings


                            <div class="contener">
                                <div class="radio">
                                    <label for="igen_off">
                                        <input type="radio" {if $configuration.RenewInvoice == 0}checked{/if}
                                               name="settings[RenewInvoice]" value="0" data-toggle=""
                                               id="igen_off"/>
                                        <b>{$lang.no}</b>,
                                        do not generate renewal invoices for services automatically.
                                    </label>
                                </div>
                                <div class="radio">
                                    <label for="igen_on">
                                        <input type="radio" {if $configuration.RenewInvoice == 1}checked{/if}
                                               name="settings[RenewInvoice]" value="1"
                                               data-toggle="#RenewInvoiceOn,.due-date,.move-due-date"
                                               id="igen_on"/>
                                        <b>{$lang.yes}</b>, generate invoices relative to service due date.
                                    </label>
                                </div>
                                <div class="radio">
                                    <label for="igen_on">
                                        <input type="radio" {if $configuration.RenewInvoice == 2}checked{/if}
                                               name="settings[RenewInvoice]" value="2"
                                               data-toggle="#RenewInvoiceOn2,.due-date,.set-due-date"
                                               id="igen_on_2"/>
                                        <b>{$lang.yes}</b>, generate invoices on specific day.
                                    </label>
                                </div>

                                <div class="p5" id="RenewInvoiceOn">
                                    <span class="prorata">{$lang.InvoiceGeneration}</span>
                                    <input type="number" size="3" value="{$configuration.InvoiceGeneration}"
                                           name="settings[InvoiceGeneration]" class="inp"/>
                                    {$lang.InvoiceGeneration2}.
                                </div>
                                <div class="p5" id="RenewInvoiceOn2">
                                    <div class="option-line">
                                        Generate invoices on
                                        <select name="settings[InvoiceGenerationDay]">
                                            {section start="1" loop=31 name=days}
                                                <option {if $configuration.InvoiceGenerationDay == $smarty.section.days.index}selected{/if}
                                                >{$smarty.section.days.index}
                                                </option>
                                            {/section}
                                            <option value="31"
                                                    {if $configuration.InvoiceGenerationDay == 31}selected{/if}
                                            >Last
                                            </option>
                                        </select>
                                        day of the month.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <strong>Advanced due date settings </strong>

                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[AdvancedDueDate]" class="toc" value="1"
                                   {if $groupx.settings_enabled.AdvancedDueDate}checked{/if} /> Override
                            package settings

                            <div class="contener">
                                <div class="option-line">
                                    <input type="hidden" value="1" name="settings[AdvancedDueDate]"/>
                                    {$lang.InvoiceExpectDays}
                                    <input type="text" size="3" class="inp"
                                           value="{$configuration.InvoiceExpectDays}"
                                           name="settings[InvoiceExpectDays]"/> {$lang.InvoiceUnpaidReminder2}
                                </div>
                                <div class="option-line">
                                    {$lang.InitialDueDays}
                                    <input type="text" size="3" class="inp"
                                           value="{$configuration.InitialDueDays}"
                                           name="settings[InitialDueDays]"/> {$lang.InitialDueDays2}
                                </div>
                                <p class="due-date">
                                    <span class="move-due-date">Move due date</span>
                                    <span class="set-due-date">Set minimum </span>
                                    <input type="text" size="3" class="inp"
                                           name="settings[MoveDueDays]"
                                           value="{$configuration.MoveDueDays}"/>
                                    <span class="move-due-date">days into future for recurring invoices.</span>
                                    <span class="set-due-date">days for recurring invoices due date.</span>
                                </p>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">

                        <strong>{$lang.new_SendPaymentReminderEmails}</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[SendPaymentReminderEmails]" class="toc"
                                   value="1"
                                   {if $groupx.settings_enabled.SendPaymentReminderEmails}checked{/if} />
                            Override package settings

                            <div class="contener">
                                <input type="radio"
                                       {if $configuration.SendPaymentReminderEmails == 'off'}checked{/if}
                                       name="settings[SendPaymentReminderEmails]" value="off"
                                       data-toggle="" id="reminder_off"/>
                                <label for="reminder_off"><b>{$lang.no}</b></label>
                                <input type="radio"
                                       {if $configuration.SendPaymentReminderEmails == 'on'}checked{/if}
                                       name="settings[SendPaymentReminderEmails]"
                                       data-toggle="#reminder_options" id="reminder_on"/>
                                <label for="reminder_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="reminder_options"
                                     style="{if $configuration.SendPaymentReminderEmails == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">


                                    {$lang.InvoiceUnpaidReminder} <span>
                                        <input type="checkbox" value="1"
                                               {if $configuration.InvoiceUnpaidReminder>0}checked{/if}
                                               onclick="check_i(this)"/>
                                        <input type="text" size="3"
                                               class="config_val  inp" {if $configuration.InvoiceUnpaidReminder<=0} value="0" disabled="disabled"{else}value="{$configuration.InvoiceUnpaidReminder}"{/if}
                                               name="settings[InvoiceUnpaidReminder]"/>
                                    </span> {$lang.InvoiceUnpaidReminder2}
                                    <br/><br/>

                                    {$lang.1OverdueReminder}
                                    <span>
                                        <input type="checkbox" value="1"
                                               {if $configuration.1OverdueReminder>0}checked{/if}
                                               onclick="check_i(this)"/>
                                        <input type="text" size="3" class="config_val  inp"
                                               {if $configuration.1OverdueReminder<=0}value="0"
                                               disabled="disabled"
                                               {else}value="{$configuration.1OverdueReminder}"{/if}
                                               name="settings[1OverdueReminder]"/>
                                    </span>
                                    <span>
                                        <input type="checkbox" value="1"
                                               {if $configuration.2OverdueReminder>0}checked{/if}
                                               onclick="check_i(this)"/>
                                        <input type="text" size="3"
                                               class="config_val inp"
                                               {if $configuration.2OverdueReminder<=0}value="0"
                                               disabled="disabled"
                                               {else}value="{$configuration.2OverdueReminder}"{/if}
                                               name="settings[2OverdueReminder]"/>
                                    </span>
                                    <span>
                                        <input type="checkbox" value="1"
                                               {if $configuration.3OverdueReminder>0}checked{/if}
                                               onclick="check_i(this)"/>
                                        <input type="text" size="3"
                                               class="config_val  inp"
                                               {if $configuration.3OverdueReminder<=0}value="0"
                                               disabled="disabled"
                                               {else}value="{$configuration.3OverdueReminder}"{/if}
                                               name="settings[3OverdueReminder]"/>
                                    </span>
                                    {$lang.1OverdueReminder2}


                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">

                        <strong>{$lang.new_LateFeeType_on|capitalize}</strong>

                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[LateFeeType]" class="toc"
                                   value="1" {if $groupx.settings_enabled.LateFeeType}checked{/if} />
                            Override package settings
                            <div class="contener">
                                <input type="radio" {if $configuration.LateFeeType == '0'}checked{/if}
                                       name="settings[LateFeeType_sw]" value="0"
                                       data-toggle=""
                                       id="latefee_off"/>
                                <label for="latefee_off"><b>{$lang.no}</b></label>

                                <input type="radio" {if $configuration.LateFeeType != '0'}checked{/if}
                                       name="settings[LateFeeType_sw]" value="1"
                                       data-toggle="#latefee_options"
                                       id="latefee_on"/>
                                <label for="latefee_on"><b>{$lang.yes}</b></label>

                                <div class="p5" id="latefee_options"
                                     style="{if $configuration.LateFeeType == '0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                    {$lang.new_LateFeeType_on1}
                                    <input size="1" class="inp config_val"
                                           value="{$configuration.LateFeeValue}"
                                           name="settings[LateFeeValue]"/>

                                    <select class="inp config_val" name="settings[LateFeeType]">
                                        <option {if $configuration.LateFeeType=='1'}selected{/if}
                                                value="1">%
                                        </option>
                                        <option {if $configuration.LateFeeType=='2'}selected
                                                {/if}value="2">{if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</option>
                                    </select>
                                    {$lang.new_LateFeeType_on2}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <strong>Late Fee Days</strong>
                        <div class="toggle-override">
                            <input type="checkbox" name="settings_enabled[AddLateFeeAfter]" class="toc"
                                   value="1" {if $groupx.settings_enabled.AddLateFeeAfter}checked{/if} />
                            Override package settings
                            <div class="contener">
                                <div class="p5" id="latefeedays_options"
                                     style="margin-top:10px;border:#ccc 1px solid;">
                                    <input type="text" size="3" value="{$configuration.AddLateFeeAfter}"
                                           name="settings[AddLateFeeAfter]" class="config_val inp"/>
                                    {$lang.LateFeeType2x}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="sectioncontent" style="display:none">

                <div class="form-group">
                    <label>Order scenario</label>
                    <a class="vtip_description"
                       title="You can choose whether customer{if $action !== 'overrides'}s from this group{/if} falls under default scenario, or are processed with custom one"></a>

                    <div class="editor-container">
                        <select name="settings[OrderScenario]" class="form-control overridedefault" data-default="0">
                            <option value="0">Use default scenario</option>
                            {foreach from=$scenarios item=scenario}
                                <option value="{$scenario.id}"
                                        {if $groupx.settings.OrderScenario==$scenario.id}selected{/if}>
                                    {$scenario.name}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label>Pro-rata billing</label>
                    <a href="#" class="vtip_description"
                       title="With this option enabled client will have all his services billed on certain day of month."></a>

                    <div class="toggle-override">
                        <input type="checkbox" {if $groupx.settings_enabled.EnableProRata}checked{/if}
                               name="settings_enabled[EnableProRata]" value="1" class="toc"/>
                        Force pro-rata billing for new services

                        <div class="contener">
                            {$lang.new_ProRataDay}
                            <input class="inp" size="2" name="settings[ProRataDay]"
                                   value="{$configuration.ProRataDay}"/>
                            {$lang.new_ProRataMonth}
                            <select class="inp" name="settings[ProRataMonth]">
                                <option value="disabled"
                                        {if $configuration.ProRataMonth == 'disabled'}selected{/if}>
                                    {$lang.new_ProRataMonth_disabled}
                                </option>
                                {foreach from=$months item=month}
                                    <option value="January"
                                            {if $configuration.ProRataMonth == $month}selected{/if}>
                                        {$lang[$month]}
                                    </option>
                                {/foreach}
                            </select>
                            <div>
                                {$lang.new_ProRataNextMonth}
                                <a class="vtip_description" title="{$lang.promonthdesc}"></a>
                                <input type="checkbox" name="settings_enabled[ProRataNextMonth]" value="1"
                                       {if $configuration.ProRataNextMonth>0}checked{/if} value="1"/>
                                <input type="text" name="settings[ProRataNextMonth]"
                                       value="{$configuration.ProRataNextMonth}" inp" size="3" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Upgrade pro-rata</label>

                    <div class="toggle-override">
                        <input type="checkbox" name="settings_enabled[UpgradeProratePrecision]" class="toc"
                               value="1" {if $groupx.settings_enabled.UpgradeProratePrecision}checked{/if} />
                        Override system / package settings

                        <div class="contener">
                            <select name="settings[UpgradeProratePrecision]">
                                <option value="seconds"
                                        {if $configuration.UpgradeProratePrecision == 'seconds'}selected{/if}>
                                    Seconds - calculate charge based on time left to due date
                                </option>
                                <option value="hours"
                                        {if $configuration.UpgradeProratePrecision == 'hours'}selected{/if}>
                                    Hours - calculate charge based on hours left to due date
                                </option>
                                <option value="days"
                                        {if $configuration.UpgradeProratePrecision == 'days'}selected{/if}>
                                    Days - calculate charge based on days left to due date
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="sectioncontent" style="display:none">

                <div class="form-group">
                    <label>Global Discount</label>
                    <div class="input-group col-lg-1 col-md-2">
                        <input type="number" max="100" min="0" class="form-control overridedefault" data-default="0"
                               name="settings[DiscountGlobal]"
                               value="{$groupx.settings.DiscountGlobal|default:0}"/>
                        <span class="input-group-addon">%</span>
                    </div>
                </div>

                <div class="form-group">
                    <label>Form component discount</label>
                    <div class="checkbox" style="margin-top: 0">
                        <label>
                            <input type="checkbox"
                                   value="1" id="DiscountFormsToggle"
                                   {if $groupx.settings_enabled.DiscountForms}checked{/if}/>
                            Discount form component
                        </label>
                        <span class="vtip_description">
                            <div>
                                When this option is enabled product price <strong><u>will not</u></strong> be
                                discounted. Discount will only apply to price from selected form components.
                                When disabled discount is calculated from product price and all forms that allow it.
                            </div>
                        </span>
                    </div>
                    <select multiple="multiple" name="settings[DiscountForms][]" class="form-control" data-chosen
                            data-placeholder="Select applicable form variables" id="DiscountForms">
                        {foreach from=$formvars item=variable}
                            <option value="{$variable}"
                                    {if in_array($variable, $configuration.DiscountForms)}selected{/if}>
                                {$variable}
                            </option>
                        {/foreach}
                    </select>
                    <div class="help-block">
                        <small>Select variables used in forms that you want to discount.</small>
                    </div>
                </div>


                <div class="panel panel-default">
                    <div class="panel-heading">Category / product specific discount</div>
                    <table class="table">
                        <tbody id="product-discounts">
                            {foreach from=$groupx.discounts item=discount name=fl}
                                <tr id="{$discount.key}">
                                    <td style="padding-left:10px">{$discount.name}
                                        <input type="hidden" name="discounts[{$smarty.foreach.fl.index}][discount]"
                                               value="{$discount.discount}"/>
                                        <input type="hidden" name="discounts[{$smarty.foreach.fl.index}][type]"
                                               value="{$discount.type}"/>
                                        <input type="hidden" name="discounts[{$smarty.foreach.fl.index}][product_id]"
                                               value="{$discount.key}"/>
                                    </td>
                                    <td width="140">{$discount.discount} {if $discount.type=='percent'}%{/if}</td>
                                    <td width="40"><a href="#" class="btn btn-default remove-entry btn-sm">Remove</a>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>

                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-5">
                                <label>New discount category / product</label>
                                <select class="form-control" id="product_id" data-chosen>
                                    {foreach from=$services item=category}
                                        {if $category.products}
                                            <optgroup label="{$category.name}">
                                                <option value="cat_{$category.id}">{$category.name} - Entire category
                                                </option>
                                                {foreach from=$category.products item=prod}
                                                    <option value="prod_{$prod.id}">{$category.name}
                                                        - {$prod.name}</option>
                                                {/foreach}
                                            </optgroup>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group col-md-3">
                                <label>Discount</label>
                                <input type="text" class="form-control" value="0.00" size="5" id="discount_value">
                            </div>
                            <div class="form-group col-md-2">
                                <label>Type</label>
                                <select class="form-control" id="discount_type">
                                    <option value="fixed">Fixed</option>
                                    <option value="percent">Percent</option>
                                </select>
                            </div>
                            <div class="form-group col-md-2">
                                <label class="visible-md-block visible-lg-block">&nbsp;</label>
                                <a class="btn btn-default add-product-dicount" href="#">Add</a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="sectioncontent" style="display:none">
                <div class="form-group">
                    <label>Send Emails </label>
                    <select name="settings[EmailSwitch]" class="form-control overridedefault" data-default="">
                        <option value="">
                            Default
                        </option>
                        <option value="on" {if $groupx.settings.EmailSwitch=="on"}selected{/if}>
                            {$lang.Enabled}, {$lang.EmailSwitchd1|lcfirst}
                        </option>
                        <option value="off" {if $groupx.settings.EmailSwitch=="off"}selected{/if}>
                            {$lang.Disabled}, {$lang.EmailSwitchd2|lcfirst}
                        </option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Ticket priority </label>
                    <a class="vtip_description"
                       title="Select what default ticket priority client{if $action !== 'overrides'}s from this group{/if} should have"></a>

                    <select name="settings[SupportPriority]" class="form-control overridedefault" data-default="">
                        <option value="">
                            Default
                        </option>
                        <option value="0" {if $groupx.settings.SupportPriority==="0"}selected{/if}>
                            Low
                        </option>
                        <option value="1" {if $groupx.settings.SupportPriority==="1"}selected{/if}>
                            Medium
                        </option>
                        <option value="2" {if $groupx.settings.SupportPriority==="2"}selected{/if}>
                            High
                        </option>
                    </select>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">Auto CC emails to ticket</div>
                    <div class="panel-body">
                        <p>
                            Emails listed below will be automatically added to new tickets assigned to client{if $action !== 'overrides'}s from this group{/if}.
                        </p>
                        <p id="add-cc-body"></p>
                        <input type="hidden" name="settings[SupportCC]"
                               value="{$configuration.SupportCC|escape}" id="cc-form">
                        <div class="input-group col-lg-3 col-md-4 col-sm-6">
                            <input type="email" id="add-cc-form" class="form-control"/>
                            <span class="input-group-btn">
                                <button class="btn btn-default" id="add-cc-btn"><i class="fa fa-plus"></i></button>
                            </span>
                        </div>
                    </div>
                </div>


                <div class="panel panel-default">
                    <div class="panel-heading">Override Support Rates</div>
                    <table class="table">
                        <tbody id="support-rates">
                            {foreach from=$supportrates item=rate}
                                {if $configuration.SupportRates[$rate.id]}
                                    <tr id="rate_{$rate.id}">
                                        <td style="padding-left:10px">
                                            {$rate.name} ({$rate.price|price}{if $rate.type == 'hourly'} per Hour{/if})
                                            <input type="hidden" name="settings[SupportRates][{$rate.id}]"
                                                   value="{$configuration.SupportRates[$rate.id]}"/>
                                        </td>
                                        <td width="140">{$configuration.SupportRates[$rate.id]} {$currency.iso} {$rate.type|capitalize}</td>
                                        <td width="40"><a href="#"
                                                          class="btn btn-default remove-entry btn-sm">Remove</a></td>
                                    </tr>
                                {/if}
                            {/foreach}
                        </tbody>
                    </table>

                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label>Support Rate</label>
                                <select class="form-control" id="rate_id" data-chosen>
                                    {foreach from=$supportrates item=rate}
                                        <option value="{$rate.id}"
                                                data-type="{$rate.type|capitalize}"
                                                data-price="{$rate.price}">
                                            {$rate.name} ({$rate.price|price}{if $rate.type == 'hourly'} per Hour{/if})
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group col-md-3">
                                <label>Price</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" value="0.00"
                                           size="5" id="rate_value">
                                    <span class="input-group-addon" id="currency-iso">{$currency.iso}</span>
                                </div>
                            </div>

                            <div class="form-group col-md-3">
                                <label class="visible-md-block visible-lg-block">&nbsp;</label>
                                <a class="btn btn-default add-support-rate" href="#">Add</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary">
                {$lang.savechanges}
            </button>
            <div class="clear"></div>
        </div>
        <input type="hidden" name="make" value="s"/>
        {securitytoken}
    </form>
{/if}

<script type="text/javascript" src="{$template_dir}js/clientgroups.js?v={$hb_version}"></script>
{literal}
    <script type="text/x-handlebars-template" id="product-discount">
        <tr id="{{product_id}}">
            <td style="padding-left:10px">
                {{name}}
                <input type="hidden" name="discounts[{{id}}][discount]" value="{{discount}}"/>
                <input type="hidden" name="discounts[{{id}}][type]" value="{{type}}"/>
                <input type="hidden" name="discounts[{{id}}][product_id]" value="{{product_id}}"/>
            </td>
            <td width="140">{{discount}} {{typeunit}}</td>
            <td width="40">
                <a href="#" class="btn btn-default remove-entry btn-sm">Remove</a>
            </td>
        </tr>
    </script>
    <script type="text/x-handlebars-template" id="suport-rate">
        <tr id="rate_{{id}}">
            <td style="padding-left:10px">
                {{name}}
                <input type="hidden" name="settings[SupportRates][{{rate_id}}]" value="{{price}}"/>
            </td>
            <td width="140">{{price}} {{type}}</td>
            <td width="40">
                <a href="#" class="btn btn-default remove-entry btn-sm">Remove</a>
            </td>
        </tr>
    </script>
{/literal}

