{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'newdomains.tpl.php');
{/php}

<input type="hidden" name="type" value="{$product.type}">

<input type="hidden" value="1" name="visible" id="prod_visibility" />
<input type="hidden" value="{$product.category_id}" name="category_id" />
<input type="hidden" value="{$product.id}" name="product_id_"  id="product_id"/>

<table width="100%" cellspacing="0" cellpadding="10" border="0" >
    <tr>
        <td colspan="2" style="padding:0px;">
            <div class="newhorizontalnav" id="newshelfnav">
                <div class="list-1">
                    <ul>
                        <li>
                            <a href="#"><span class="ico money">{$lang.general_tab}</span></a>
                        </li>
                        <li >
                            <a href="#"><span class="ico plug">{$lang.registrar_tab}</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico gear">{$lang.automation_tab}</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico gear">{$lang.Emails}</span></a>
                        </li>
                        <li>
                            <a href="#" ><span class="ico">Components</span></a>
                        </li>
                        <li {if $product.id == 'new'}class="last"{/if}>
                            <a href="#"><span class="ico formn">{$lang.widgets_tab}</span></a>
                        </li>
                        {if $product.id != 'new'}
                            <li class="last directlink">
                                <a href="?cmd=whoisservers&action=edit&id={$product.name|substr:1}" target="_blank"><span class="ico formn">Lookup settings</span></a>
                            </li>
                        {/if}
                    </ul>
                </div>
                <div class="list-2">
                    <div class="subm1 haveitems">
                        <ul >
                            <li >
                                <a href="#" onclick="$(this).hide();
                                        $('#change_orderpage').ShowNicely().show();
                                        return false"><span >{$lang.change_orderpage}</span></a>
                            </li>
                            <li>
                                <a href="?cmd=services&action=productexport&id={$product_id}"><span>Export Product</span></a>
                            </li>
                        </ul>
                        <div class="right" style="color:#999999;padding-top:5px">
                        </div>
                        <div class="clear"></div>
                    </div>

                    <div class="subm1" style="display:none"></div>
                    <div class="subm1 haveitems" style="display:none">
                        <ul >
                            <li>
                                <a  href="#"  onclick="return HBTasklist.assignNew({$product_id}, 'domains');" >
                                    <span class="addsth" ><strong>{$lang.addcustomautomation}</strong></span>
                                </a>
                            </li>
                            {if $otherproducts}
                                <li><a  href="#"   id="premadeautomationswitch" onclick="$('#premadeautomation').show();
                                        $(this).hide();
                                        return false"><span class="addsth" >{$lang.copyautomation}</span></a>
                                </li>
                            {/if}
                        </ul>
                    </div>
                    <div class="subm1" style="display:none"></div>
                    <div class="subm1 {if $product.id!='new'}haveitems{/if}" id="components_menu" style="display:none">
                        {if $product.id!='new'}
                            <ul class="list-3">
                                <li><a href="#"><span><b>{$lang.forms_tab}</b></span></a></li>
                                <li><a href="#"><span><b>Sub-products</b></span></a></li>
                            </ul>
                        {/if}
                    </div>

                    <div class="subm1 {if $product.id!='new'}haveitems{/if}" style="display:none">
                        {if $product.id!='new'}
                            <ul >
                                <li>
                                    <a href="#" onclick="return HBWidget.addCustomWidgetForm();"><span ><b>{$lang.assign_custom_widg}</b></span></a>
                                </li>

                                {if count($widgets)>1}
                                    <li>
                                        <a href="#" onclick="return HBWidget.enableAllWidgets();"><span >{$lang.enable_all_widgets}</span></a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="return HBWidget.disableAllWidgets();"><span >{$lang.disable_all_widgets}</span></a>
                                    </li>
                                {/if}

                                <li>
                                    <a href="#" onclick="return HBWidget.refreshWidgetView();"><span >Refresh available functions</span></a>
                                </li>
                            </ul>
                        {/if}
                    </div>

                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td valign="top" class="nicers" style="border:none;" colspan="2">
            <table width="100%" cellspacing="0" cellpadding="6">
                <tbody class="sectioncontent">

                    <tr >
                        <td width="160" align="right"><strong>{$lang.dom_ext}</strong>
                            {if $product.id=='new'}<a href="#" class="vtip_description" title="To add multiple TLD with same options & pricing at once, just enter extensions separated by comma, like:<br /> .com, .net, .eu, .co.uk<br />HostBill will automaticaly create multiple products"></a>{/if}
                        </td>
                        <td class="editor-container">
                            {if $product.id!='new'}
                                <div class="org-content havecontrols" ><span style=" font-size: 16px !important; font-weight: bold;" class="iseditable">{$product.name}</span> <a href="#" class="editbtn controls iseditable">{$lang.Edit}</a></div>
                                <div class="editor"><input type="text" class="inp" style=" font-size: 16px !important; font-weight: bold;" name="name" size="50" value="{$product.name}">
                                </div>
                            {else}
                                <input type="text" class="inp" style=" font-size: 16px !important; font-weight: bold;" name="name" size="50" value="{$product.name}">
                            {/if}
                        </td>
                    </tr>

                    <tr }>
                        <td width="160" align="right" valign="top" ><strong>Extension description</strong></td>
                        <td class="editor-container">
                            {if $product.description!=''}
                                {hbwysiwyg value=$product.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="full"}
                            {else}
                                <a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;"><strong>{$lang.adddescription}</strong></a>
                                <div id="prod_desc_c" style="display:none">{hbwysiwyg value=$product.description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="full"}</div>
                            {/if}
                        </td>
                    </tr>
                    {if $product.id!='new'}
                        <tr style="display:none" id="change_orderpage"><td align="right"><strong>{$lang.OrderPage}</strong></td><td>
                                <select name="change_orderpage" onchange="this.form.submit()">
                                    {foreach from=$categories item=ord_pg}
                                        <option value="{$ord_pg.id}" {if $ord_pg.id == $product.category_id}selected="selected"{/if}>{$ord_pg.name}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}

                    <tr>
                        <td valign="top" width="160" align="right"><strong>{$lang.Price}</strong></td>
                        <td id="priceoptions">
                            {foreach from=$supported_billingmodels item=bm name=boptloop}
                                <a href="#" class="billopt {if $bm=='Free'}bfirst{/if} {if $product.paytype==$bm}checked{/if}"  {if $product.paytype!=$bm}style="display:none"{/if} onclick='return switch_t2(this, "{$bm}");'>{if $lang[$bm]}{$lang[$bm]}{else}{$bm}{/if}</a>
                                <input type="radio" value="{$bm}" name="paytype" {if $product.paytype==$bm}checked="checked"{/if}  id="{$bm}" style="display:none"/>
                            {/foreach}

                            <a href="#" class="editbtn" onclick="$(this).hide();
                                    $(this).parent().find('.billopt').show();
                                    return false;">{$lang.Change}</a>


                            {foreach from=$supported_billingmodels item=bm name=boptloop}
                                {include file="productbilling_`$bm`.tpl"}
                            {/foreach}

                        </td>
                    </tr>

                    <tr  class="stockcontrol" {if $product.stock!='1'}style="display:none"{/if}>
                        <td valign="top" align="right"><strong>{$lang.stockcontrol}</strong></td>
                        <td><input type="checkbox" name="stock" value="1" {if $product.stock=='1'}checked="checked"{/if} onclick="if (this.checked)
                                    $('#sstoc').show();
                                else
                                    $('#sstoc').hide();"/></td>
                    </tr>
                    <tr id="sstoc" class="stockcontrol" {if $product.stock!='1'}style="display:none"{/if}>
                        <td align="right">{$lang.quantityinstock}</td>
                        <td ><input type="text" value="{$product.qty}" size="4" name="qty" class="inp"/>
                        </td>
                    </tr>

                    {if $product.id != 'new'}
                        {include file="newservices_dbc_integration.tpl"}
                    {/if}

                    {if $product.id!='new'}
                        <tr>
                            <td align="right"><strong>Tags</strong></td>
                            <td>{include file='services/tags.tpl'}</td>
                        </tr>
                    {/if}

                    {if $product.id != 'new'}
                    <tr>
                        <td align="right" width="160"><strong>Reseller Enable</strong> <a href="#" class="vtip_description" title="เปิดให้ Reseller สามารถนำ product นี้ไปขายต่อได้ผ่านระบบ Netway Reseller Program"></a></td>
                        <td align="left">
                            <input type="checkbox" name="is_reseller" value="1" {if $product.is_reseller=='1'}checked="checked"{/if} onclick="enableProductForReseller($(this), {$product.id}, 'Domain');" />
                            {literal}
                            <script language="JavaScript">
                            function enableProductForReseller (obj, id, type)
                            {
                                obj.parent().parent().addLoader();
                                $.post('?cmd=netway_reseller&action=enableProductForReseller', {
                                    productId   : id,
                                    type        : type
                                    }, function (a) {
                                        parse_response(a);
                                        $('#preloader').remove();
                                    });
                            }
                            </script>
                            {/literal}
                        </td>
                    </tr>
                    
                    <tr>
                        <td align="right" width="160"><strong>เอกสารประกอบการจดโดเมน</strong></td>
                        <td align="left">
                            <textarea name="domain_doc" id="domain_doc" rows="4" cols="100">{$product.reg_document.reg_document}</textarea>
                            {literal}
                            <script language="JavaScript">
                            $( "#domain_doc" ).blur(function() {
                                $(this).parent().parent().addLoader();
                                $.post('?cmd=domainhandle&action=DomainRegisterDocument', {
                                    productId           : '{/literal}{$product.id}{literal}',
                                    documentText        : $(this).val()
                                    }, function (a) {
                                        parse_response(a);
                                        $('#preloader').remove();
                                });
                            });
                            </script>
                            {/literal}
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="160"><strong>Kb Link</strong><a href="#" class="vtip_description" title="ระบุ Link ของ Kb ที่เกี่ยวข้องกับเอกสารการจดโดเมน"></a></td>
                        <td align="left">
                            <input style="width: 500px;" type="text" name="domain_doc_kb" id="domain_doc_kb" value="{$product.reg_document.reg_document_kb}">
                            {literal}
                            <script language="JavaScript">
                            $( "#domain_doc_kb" ).blur(function() {
                                $(this).parent().parent().addLoader();
                                $.post('?cmd=domainhandle&action=DomainRegisterDocumentKb', {
                                    productId           : '{/literal}{$product.id}{literal}',
                                    documentKbText        : $(this).val()
                                    }, function (a) {
                                        parse_response(a);
                                        $('#preloader').remove();
                                });
                            });
                            </script>
                            {/literal}
                        </td>
                    </tr>
                    
                    
                    {/if}

                </tbody>
                <tbody class="sectioncontent" style="display:none">
                    <tr id="module_config_container" class="module_config_tab module-loaded">
                        <td colspan="2" style="padding:0px !important">
                            <table border="0" width="100%" cellpadding="6" cellspacing="0">
                                <tr>
                                    <td align="right" width="160"><strong>{$lang.third_party_app}</strong><br />
                                    </td>
                                    <td>
                                        <input type="hidden" value="1" name="update" />
                                        <select name="module" onchange="loadDomainModule(this)" id="modulepicker" class="inp modulepicker" style="width:200px;">
                                            <option value="0" {if $product.module=='0'}selected="selected" {/if}>{$lang.none}</option>
                                            {foreach from=$modules item=mod}
                                                {if $mod.id!='-1'}
                                                    <option value="{$mod.id}" {if $product.module==$mod.id}selected="selected" {/if}>{$mod.modname}</option>
                                                {/if}
                                            {/foreach}
                                            <option value="new" style="font-weight:bold">Show non-activated registrars</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="app_picker" class="loadable" colspan="2">{include file='ajax.configdommodule.tpl'}
                                    </td></tr>
                                <tr>
                                    <td align="right" width="160" valign="top"></td>
                                    <td align="left" >

                                        <table border="0" cellspacing="0" cellpadding="6" width='800' >
                                            <tbody  id='doma-settings' >
                                            {foreach item=i from=0|@range:9}
                                                <tr>
                                                    <td width="160"><strong>{$lang.Nameserver} {$i+1}</strong></td>
                                                    <td>
                                                        <input class="inp" value="{$product.ns[$i]}"  name='ns[{$i}]'/>
                                                    </td>
                                                    <td><strong>{$lang.Nameserver} IP {$i+1}</strong> {$lang.optional}</td>
                                                    <td>
                                                        <input class="inp" value="{$product.nsip[$i]}"  name='nsip[{$i}]'/>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                            </tbody>
                                        </table>
                                        <div style="padding:10px 5px;" class="fs11">
                                            Nameservers above will be used during registration unless client provides own settings. If empty default nameservers (set in related App Connection) will be used.
                                            <br/> Nameservers can also be overidden by purchasing hosting+domain.
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right" width="160"><strong>{$lang.requireepp}</strong></td>
                                    <td align="left"><input type="checkbox" name="epp" value="1" {if $product.epp=='1'}checked="checked"{/if}/></td>
                                </tr>
                                <tr>
                                    <td align="right" width="160"><strong>Remove accented characters</strong> <a href="#" class="vtip_description" title="Checking this option will remove accented characters from contact data"></a></td>
                                    <td align="left"><input type="checkbox" name="asciimode" value="1" {if $product.asciimode=='1'}checked="checked"{/if}/></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
                <tbody class="sectioncontent" id="billingsopt"  style="display:none">
                    <tr>
                        <td colspan="2" style="padding:0px">
                            <table class="editor-container" cellspacing="0" cellpadding="6" width="100%">
                                <tr id="premadeautomation" style="display:none">
                                    <td colspan="2">
                                        {if $otherproducts}
                                            <div style="margin-bottom: 15px;"  class="p6">
                                                <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                Copy from:
                                                                <select name="copy_from" class="submitme">
                                                                    {foreach from=$otherproducts item=oth}
                                                                        <option value="{$oth.id}">{$oth.catname} - {$oth.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <input type="hidden" id="copyautomation" value="0" name="copyautomation" />
                                                                <input type="button" value="Use it" style="font-weight:bold" onclick="$('#copyautomation').val(1);
                                                                        return saveProductFull();">
                                                                <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#premadeautomation').hide();
                                                                        $('#premadeautomationswitch').show();
                                                                        return false;" class="editbtn">{$lang.Cancel}</a>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <span class="pdescriptions fs11" >{$lang.configspeedup}. It will also copy registrar settings</span>
                                            </div>
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" id="tasklistloader">
                                        {include file='ajax.tasklist.tpl'}
                                    </td>
                                </tr>

                                {if $product.id != 'new'}
                                <tr class="odd">
                                    <td width="200" valign="top" align="right"><strong>Provisioning</strong></td>
                                    <td>
                                        <input type="checkbox" {if $product.aConfig.provision_with_capture}checked="checked"{/if} 
                                               name="provision_with_capture" value="1"
                                               onclick="configProvisionWithCapture($(this), {$product.id});"
                                               id="provision_with_capture"/>
                                        <label for="provision_with_capture">ไม่อนุญาติให้ทำ Provision โดย Authorize Payment อย่างเดียวโดยที่ยังไม่ Capture Payment</label>
                                        
                                        {literal}
                                        <script language="JavaScript">
                                        function configProvisionWithCapture (obj, id)
                                        {
                                            obj.parent().parent().addLoader();
                                            var config  = 'provision_with_capture';
                                            var val     = obj.is(':checked') ? 1 : 0;
                                            $.post('?cmd=producthandle&action=updateConfig', {
                                                productId   : id,
                                                config      : config,
                                                value       : val
                                                }, function (data) {
                                                    $('#preloader').remove();
                                                });
                                        }
                                        </script>
                                        {/literal}
                                        
                                    </td>
                                </tr>
                                {/if}

                                <tr>
                                    <td align="right" valign="top" width="200"><strong>{$lang.auto_register}</strong></td>
                                    <td id="automateoptions" class="automate-options">
                                        <input type="radio" {if $configuration.EnableAutoRegisterDomain == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoRegisterDomain]" value="off" onclick="$('#autosetup_opt').hide();"
                                               id="autooff"/>
                                        <label  for="autooff"><b>{$lang.no}</b></label>

                                        <input type="radio" {if $configuration.EnableAutoRegisterDomain == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoRegisterDomain]" value="on" onclick="$('#autosetup_opt').ShowNicely();"
                                               id="autoon"/>
                                        <label  for="autoon"><b>{$lang.yes}</b></label>

                                        <div class="p5" style="color:red">สำหรับ Domain ถ้าเลือก auto register เป็น No ระบบจะไม่ Accept Order ให้อัตโนมัติ (แม้จะ Add payment แล้วก็ตาม)</div>

                                                {*}
                                                <input type="radio" value="0" name="autosetup" {if $product.autosetup=='0'}checked="checked"{/if}
                                                id="autooff" onclick="$('#autosetup_opt').hide();"/><label for="autooff"><b>{$lang.no}</b></label>
                                                <input type="radio"  value="2" name="autosetup" {if $product.autosetup!='0'}checked="checked"{/if}
                                                id="autoon" onclick="$('#autosetup_opt').ShowNicely();"/><label for="autoon"><b>{$lang.yes}</b></label>
                                                {*}
                                        <div class="p5" id="autosetup_opt" style="{if $configuration.EnableAutoRegisterDomain == 'off'}display:none;{/if}" >
                                            <input type="radio" value="1" name="config[AutoRegisterDomainType]"
                                                   {if $configuration.AutoRegisterDomainType == 1} checked="checked"{/if}>
                                            {$lang.whenorderplaced}
                                            <br>
                                            <input type="radio" value="0" name="config[AutoRegisterDomainType]"
                                                   {if $configuration.AutoRegisterDomainType == 0} checked="checked"{/if}>
                                            After receiving payment
                                        </div>
                                    </td>
                                </tr>

                                {if $product.id != 'new'}
                                <tr>
                                    <td width="200" valign="top" align="right">&nbsp;</td>
                                    <td>
                                        <div class="p5">
                                            Fulfillment ticket จาก service catalog ( <a href="?cmd=module&module=servicecataloghandle&action=browse" target="_blank">คลิกค้นหา service catalog id ที่จะใช้</a> )<br />
                                            ระบุ Service catalog id 
                                            <input type="text" id="fulfillment_create_id" name="fulfillment_create_id" value="{$product.aConfig.fulfillment_create_id}" onchange="$('#fulfillment_create_update').show();" size="5" class="inp" />
                                            <a id="fulfillment_create_update" href="#" onclick="configProvisionWithFulfillment($('#fulfillment_create_id'), {$product.id}); $(this).hide(); return false;" class="new_control greenbtn" style="display: none;" ><span class="wizard"> เลือกใช้งาน </span></a>
                                            <div id="fulfillment_create_process" style="{if ! $product.aConfig.fulfillment_create_id} display: none; {/if} padding-left: 20px;" >
                                                <a id="fulfillment_create_catalog" href="?cmd=servicecataloghandle&action=view&id={$product.aConfig.fulfillment_create_id}" target="_blank">{$product.aConfig.aFulfillment[$product.aConfig.fulfillment_create_id].title}</a><br />
                                                กรณีทำ <span style="color: red">provision fail</span> ให้ create fulfillment process 
                                                <select id="fulfillment_create_fail" name="fulfillment_create_fail" onchange="configProvisionWithFulfillment($(this), {$product.id})" class="new_control">
                                                    <option value="">--- เลือก ---</option>
                                                    {foreach from=$product.aConfig.aFulfillment[$product.aConfig.fulfillment_create_id].aProcess item=arr}
                                                    <option value="{$arr.id}" {if $arr.id == $product.aConfig.fulfillment_create_fail} selected="selected" {/if}>{$arr.name}</option>
                                                    {/foreach}
                                                </select>
                                                <br />
                                                กรณีทำ <span style="color: green">provision success</span> ให้ create fulfillment process 
                                                <select id="fulfillment_create_success" name="fulfillment_create_success" onchange="configProvisionWithFulfillment($(this), {$product.id})" class="new_control">
                                                    <option value="">--- ไม่เลือก ---</option>
                                                    {foreach from=$product.aConfig.aFulfillment[$product.aConfig.fulfillment_create_id].aProcess item=arr}
                                                    <option value="{$arr.id}" {if $arr.id == $product.aConfig.fulfillment_create_success} selected="selected" {/if}>{$arr.name}</option>
                                                    {/foreach}
                                                </select>
                                                <br />
                                            </div>
                                        </div>
                                        {literal}
                                        <script language="JavaScript">
                                        function configProvisionWithFulfillment (obj, id)
                                        {
                                            obj.parent().parent().addLoader();
                                            var config  = obj.attr('id');
                                            var prefix  = config.substr(0, (config.length-3));
                                            var val     = obj.val();
                                            $.post('?cmd=producthandle&action=updateConfig', {
                                                productId   : id,
                                                config      : config,
                                                value       : val
                                            }, function (data) {
                                                $('#preloader').remove();
                                                if (config.match(/\_id$/)) {
                                                    $('#'+ prefix +'_fail').val('');
                                                    $('#'+ prefix +'_success').val('');
                                                    configProvisionWithFulfillment($('#'+ prefix +'_fail'), id);
                                                    configProvisionWithFulfillment($('#'+ prefix +'_success'), id);
                                                    configProvisionWithFulfillmentDetail(obj, id);
                                                }
                                            });
                                            
                                        }
                                        function configProvisionWithFulfillmentDetail (obj, id)
                                        {
                                            obj.parent().parent().addLoader();
                                            var config  = obj.attr('id');
                                            var prefix  = config.substr(0, (config.length-3));
                                            var val     = obj.val();
                                            $.post('?cmd=producthandle&action=getConfig', {
                                                id      : id
                                            }, function (data) {
                                                $('#preloader').remove();
                                                
                                                var oData     = data.data;
                                                
                                                $('#'+ prefix +'_process').show();
                                                
                                                if (oData[config] == 0) {
                                                    $('#'+ prefix +'_process').hide();
                                                    return false;
                                                }
                                                
                                                var aProcess    = [];
                                                if (oData.aFulfillment[oData[config]].hasOwnProperty('aProcess')) {
                                                    aProcess    = oData.aFulfillment[oData[config]].aProcess;
                                                }
                                                
                                                $('#'+ prefix +'_catalog').attr('href', '?cmd=servicecataloghandle&action=view&id='+ oData[config]);
                                                $('#'+ prefix +'_catalog').html(oData.aFulfillment[oData[config]].title);
                                                
                                                $('#'+ prefix +'_fail option').remove();
                                                $('#'+ prefix +'_fail').append('<option value="">--- เลือก ---</option>');
                                                $('#'+ prefix +'_success option').remove();
                                                $('#'+ prefix +'_success').append('<option value="">--- ไม่เลือก ---</option>');
                                                
                                                $.each(aProcess, function (i, arr) {
                                                    $('#'+ prefix +'_fail').append('<option value="'+ arr.id +'"> '+ arr.name +' </option>');
                                                    $('#'+ prefix +'_success').append('<option value="'+ arr.id +'"> '+ arr.name +' </option>');
                                                    
                                                });
                                                
                                                
                                            });
                                            
                                        }
                                        </script>
                                        {/literal}
                                        
                                    </td>
                                </tr>
                                {/if}

                                <tr class="odd">
                                    <td width="200"  valign="top" align="right"><strong>{$lang.auto_transfer}</strong></td>
                                    <td class="automate-options">

                                        <input type="radio" {if $configuration.EnableAutoTransferDomain == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoTransferDomain]" value="off" onclick="$('#unsuspension_options').hide();"
                                               id="unsuspend_off"/><label  for="unsuspend_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.EnableAutoTransferDomain == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoTransferDomain]" value="on" onclick="$('#unsuspension_options').ShowNicely();"
                                               id="unsuspend_on"/><label  for="unsuspend_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="unsuspension_options" style="{if $configuration.EnableAutoTransferDomain == 'off'}display:none;{/if}" >
                                            <input type="radio" value="1" name="config[AutoTransferDomainType]"
                                                    {if $configuration.AutoTransferDomainType == 1} checked="checked"{/if}>
                                            {$lang.whenorderplaced}
                                            <br>
                                            <input type="radio" value="0" name="config[AutoTransferDomainType]"
                                                    {if $configuration.AutoTransferDomainType == 0} checked="checked"{/if}>
                                            After receiving payment
                                            <div class="clear"></div>
                                        </div>
                                    </td>
                                </tr>

                                {if $product.id != 'new'}
                                <tr>
                                    <td width="200" valign="top" align="right">&nbsp;</td>
                                    <td>
                                        <div class="p5">
                                            Fulfillment ticket จาก service catalog ( <a href="?cmd=module&module=servicecataloghandle&action=browse" target="_blank">คลิกค้นหา service catalog id ที่จะใช้</a> )<br />
                                            ระบุ Service catalog id 
                                            <input type="text" id="fulfillment_transfer_id" name="fulfillment_transfer_id" value="{$product.aConfig.fulfillment_transfer_id}" onchange="$('#fulfillment_transfer_update').show();" size="5" class="inp" />
                                            <a id="fulfillment_transfer_update" href="#" onclick="configProvisionWithFulfillment($('#fulfillment_transfer_id'), {$product.id}); $(this).hide(); return false;" class="new_control greenbtn" style="display: none;" ><span class="wizard"> เลือกใช้งาน </span></a>
                                            <div id="fulfillment_transfer_process" style="{if ! $product.aConfig.fulfillment_transfer_id} display: none; {/if} padding-left: 20px;" >
                                                <a id="fulfillment_transfer_catalog" href="?cmd=servicecataloghandle&action=view&id={$product.aConfig.fulfillment_transfer_id}" target="_blank">{$product.aConfig.aFulfillment[$product.aConfig.fulfillment_transfer_id].title}</a><br />
                                                กรณีทำ <span style="color: red">provision fail</span> ให้ create fulfillment process 
                                                <select id="fulfillment_transfer_fail" name="fulfillment_transfer_fail" onchange="configProvisionWithFulfillment($(this), {$product.id})" class="new_control">
                                                    <option value="">--- เลือก ---</option>
                                                    {foreach from=$product.aConfig.aFulfillment[$product.aConfig.fulfillment_transfer_id].aProcess item=arr}
                                                    <option value="{$arr.id}" {if $arr.id == $product.aConfig.fulfillment_transfer_fail} selected="selected" {/if}>{$arr.name}</option>
                                                    {/foreach}
                                                </select>
                                                <br />
                                                กรณีทำ <span style="color: green">provision success</span> ให้ create fulfillment process 
                                                <select id="fulfillment_transfer_success" name="fulfillment_transfer_success" onchange="configProvisionWithFulfillment($(this), {$product.id})" class="new_control">
                                                    <option value="">--- ไม่เลือก ---</option>
                                                    {foreach from=$product.aConfig.aFulfillment[$product.aConfig.fulfillment_transfer_id].aProcess item=arr}
                                                    <option value="{$arr.id}" {if $arr.id == $product.aConfig.fulfillment_transfer_success} selected="selected" {/if}>{$arr.name}</option>
                                                    {/foreach}
                                                </select>
                                                <br />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                {/if}

                                <tr >
                                    <td width="200"  valign="top" align="right"><strong>Auto-Delete domains</strong></td>
                                    <td class="automate-options">

                                        <input type="radio" {if $configuration.EnableAutoDeleteDomain == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoDeleteDomain]" value="off" onclick="$('#EnableAutoDeleteDomain_options').hide();"
                                               id="EnableAutoDeleteDomain_off"/><label  for="EnableAutoDeleteDomain_off"><b>{$lang.no}</b></label>

                                        <input type="radio" {if $configuration.EnableAutoDeleteDomain == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoDeleteDomain]" value="on" onclick="$('#EnableAutoDeleteDomain_options').ShowNicely();"
                                               id="EnableAutoDeleteDomain_on"/><label  for="EnableAutoDeleteDomain_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" style="color:red">สำหรับ Domain ต้องเลือก Auto renew เป็น Yes มิเช่นนั้นระบบจะไม่ Gen renew order ให้</div>

                                        <div class="p5" id="EnableAutoDeleteDomain_options" style="{if $configuration.EnableAutoDeleteDomain != 'on'}display:none;{/if}" >
                                            Auto-delete domain <a style="" class="vtip_description" title="Only, if related registrar supports 'delete' method. Domain will be deleted on registrar side, kept in HostBill for reference"></a>
                                            <input type="text" size="3" value="{$configuration.AutoDeleteDomainDays}" name="config[AutoDeleteDomainDays]" class="inp">
                                            days
                                            <select name="config[AutoDeleteDomainType]">
                                                <option {if $configuration.AutoDeleteDomainType=='after'}selected="selected"{/if}>after</option>
                                                <option {if $configuration.AutoDeleteDomainType=='before'}selected="selected"{/if}>before</option>
                                            </select> domain expiration date
                                            <div class="clear"></div>
                                        </div>
                                    </td>
                                </tr>

                                {if $product.id != 'new'}
                                <tr>
                                    <td width="200" valign="top" align="right">&nbsp;</td>
                                    <td>
                                        <div class="p5">
                                            Fulfillment ticket จาก service catalog ( <a href="?cmd=module&module=servicecataloghandle&action=browse" target="_blank">คลิกค้นหา service catalog id ที่จะใช้</a> )<br />
                                            ระบุ Service catalog id 
                                            <input type="text" id="fulfillment_renew_id" name="fulfillment_renew_id" value="{$product.aConfig.fulfillment_renew_id}" onchange="$('#fulfillment_renew_update').show();" size="5" class="inp" />
                                            <a id="fulfillment_renew_update" href="#" onclick="configProvisionWithFulfillment($('#fulfillment_renew_id'), {$product.id}); $(this).hide(); return false;" class="new_control greenbtn" style="display: none;" ><span class="wizard"> เลือกใช้งาน </span></a>
                                            <div id="fulfillment_renew_process" style="{if ! $product.aConfig.fulfillment_renew_id} display: none; {/if} padding-left: 20px;" >
                                                <a id="fulfillment_renew_catalog" href="?cmd=servicecataloghandle&action=view&id={$product.aConfig.fulfillment_renew_id}" target="_blank">{$product.aConfig.aFulfillment[$product.aConfig.fulfillment_renew_id].title}</a><br />
                                                กรณีทำ <span style="color: red">provision fail</span> ให้ create fulfillment process 
                                                <select id="fulfillment_renew_fail" name="fulfillment_renew_fail" onchange="configProvisionWithFulfillment($(this), {$product.id})" class="new_control">
                                                    <option value="">--- เลือก ---</option>
                                                    {foreach from=$product.aConfig.aFulfillment[$product.aConfig.fulfillment_renew_id].aProcess item=arr}
                                                    <option value="{$arr.id}" {if $arr.id == $product.aConfig.fulfillment_renew_fail} selected="selected" {/if}>{$arr.name}</option>
                                                    {/foreach}
                                                </select>
                                                <br />
                                                กรณีทำ <span style="color: green">provision success</span> ให้ create fulfillment process 
                                                <select id="fulfillment_renew_success" name="fulfillment_renew_success" onchange="configProvisionWithFulfillment($(this), {$product.id})" class="new_control">
                                                    <option value="">--- ไม่เลือก ---</option>
                                                    {foreach from=$product.aConfig.aFulfillment[$product.aConfig.fulfillment_renew_id].aProcess item=arr}
                                                    <option value="{$arr.id}" {if $arr.id == $product.aConfig.fulfillment_renew_success} selected="selected" {/if}>{$arr.name}</option>
                                                    {/foreach}
                                                </select>
                                                <br />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                {/if}

                                <tr class="odd">
                                    <td width="200" style="vertical-align: top; text-align: right"><strong>{$lang.auto_renew}</strong></td>
                                    <td class="automate-options">
                                        <input type="radio" {if $configuration.EnableAutoRenewDomain == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoRenewDomain]" value="off" onclick="$('#renewal_options').hide();"
                                               id="renew_off"/><label  for="renew_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.EnableAutoRenewDomain == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoRenewDomain]" value="on" onclick="$('#renewal_options').ShowNicely();"
                                               id="renew_on"/><label  for="renewa_on"><b>{$lang.yes}</b></label>
                                                {*}
                                                <input type="radio" {if $product.not_renew == '1'}checked="checked"{/if} name="donotrenew"
                                                value="1" onclick="$('#renewal_options').hide();" id="renew_off"/>
                                                <label  for="renew_off"><b>{$lang.no}</b></label>
                                                <input type="radio" {if  $product.not_renew != '1'}checked="checked"{/if} name="donotrenew"
                                                value="0" onclick="$('#renewal_options').ShowNicely();" id="renewa_on"/>
                                                <label  for="renewa_on"><b>{$lang.yes}</b></label>
                                                {*}
                                        <div class="p5" id="renewal_options" style="{if $configuration.EnableAutoRenewDomain == 'off'}display:none;{/if}" >
                                            <input type="radio" {if $configuration.RenewOnOrder == 'on'}checked="checked"{/if}
                                                   name="config[RenewOnOrder]" value="on"  />
                                            When renewal order is placed
                                            <br />
                                            <input type="radio" {if $configuration.RenewOnOrder != 'on'}checked="checked"{/if}
                                                   name="config[RenewOnOrder]" value=""  />
                                            After receiving payment
                                            <div class="clear"></div>
                                        </div>
                                    </td>
                                </tr>
                                <tr >
                                    <td width="200" style="vertical-align: top; text-align: right">
                                        <strong>Generate Renewal Order</strong>
                                    </td>
                                    <td class="automate-options">
                                        <input type="radio" {if  $configuration.RenewInvoice == 0}checked="checked"{/if} name="config[RenewInvoice]" value="0" onclick="$('#_InvoiceGeneration').hide();" id="igen_off"/>
                                        <label  for="igen_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.RenewInvoice == 1}checked="checked"{/if} name="config[RenewInvoice]" value="1" onclick="$('#_InvoiceGeneration').ShowNicely();" id="igen_on"/>
                                        <label  for="igen_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="_InvoiceGeneration" style="{if  $configuration.RenewInvoice == 0}display:none;{/if}" >
                                            Generate renewal orders
                                            <input type="text" size="3" value="{$configuration.InvoiceGeneration}" name="config[InvoiceGeneration]" class="inp"  onchange="$('#upInvNow').hide();" />
                                            {$lang.InvoiceGenerationDomains2}.

                                            <div id="upInvNow">
                                            การเปลี่ยนแปลงวันที่ gen invoice ล่วงหน้า ไม่มีผลทันทีต่อทุกโดเมน ถ้าต้องการ update วันที่ gen invoice ล่วงหน้าทุกโดเมน 
                                            <a href="?cmd=configurationhandle&action=updateDomainNextInvoice" onclick="return confirm('ยืนยันการ update วันที่ต้อง gen invoice ?');" target="_blank">Click here</a> 
                                            </div>

                                            <div class="clear"></div>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="odd">
                                    <td width="200" valign="top" align="right">
                                        <strong>{$lang.AutoCancelUnpaidOrders}</strong></td>
                                    <td>
                                        <input type="radio"
                                               {if $configuration.EnableAutoCancelUnpaidOrders == 'off'}checked="checked"{/if}
                                               name="config[EnableAutoCancelUnpaidOrders]" value="off"
                                               onclick="$('#cancel_order_options').hide();"
                                               id="autocancel_off"/>
                                        <label for="autocancel_off"><b>{$lang.no}</b></label>

                                        <input type="radio"
                                               {if $configuration.EnableAutoCancelUnpaidOrders == 'on'}checked="checked"{/if}
                                               name="config[EnableAutoCancelUnpaidOrders]" value="on"
                                               onclick="$('#cancel_order_options').ShowNicely()"
                                               id="autocancel_on"/>
                                        <label for="autocancel_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="cancel_order_options"
                                             style="{if $configuration.EnableAutoCancelUnpaidOrders == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;">
                                            {$lang.AutoCancelUnpaidOrdersDesc1}
                                            <input type="text" size="3" value="{$configuration.AutoCancelUnpaidOrdersPeriod}"
                                                   name="config[AutoCancelUnpaidOrdersPeriod]" class="inp config_val"/>
                                            {$lang.AutoCancelUnpaidOrdersDesc2}

                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top; text-align: right"><strong>Advanced due date settings </strong></td>
                                    <td class="automate-options">
                                        <input type="radio" {if $configuration.AdvancedDueDate == 'off'}checked="checked"{/if}   name="config[AdvancedDueDate]" value="off"  onclick="$('#advanceddue_options').hide();" id="advanceddue_off"/><label  for="advanceddue_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.AdvancedDueDate == 'on'}checked="checked"{/if}  name="config[AdvancedDueDate]" onclick="$('#advanceddue_options').ShowNicely();" id="advanceddue_on"/><label  for="advanceddue_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="advanceddue_options" style="{if $configuration.AdvancedDueDate == 'off'}display:none;{/if}" >

                                            {$lang.InvoiceExpectDays} <input type="text" size="3" class="inp" value="{$configuration.InvoiceExpectDays}" name="config[InvoiceExpectDays]"/> {$lang.InvoiceUnpaidReminder2}
                                            <br/><br/>

                                            {$lang.InitialDueDays} <input type="text" size="3" class="inp" value="{$configuration.InitialDueDays}" name="config[InitialDueDays]"/> {$lang.InitialDueDays2}
                                            <br/><br/>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="vertical-align: middle; text-align: right"><strong>Domain grace period <a style="" class="vtip_description" title="Number of days after domain expiration customer can renew it for"></a></strong></td>
                                    <td class="automate-options">
                                        <input type="text" size="3" class="inp" value="{$configuration.DomainGracePeriod}" name="config[DomainGracePeriod]"/>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="vertical-align: middle; text-align: right"><strong>Domain redemption period <a style="" class="vtip_description" title="Number of days after domain grace period where customer can renew it for with additional, redemption fee"></a></strong></td>
                                    <td class="automate-options">
                                        <input type="text" size="3" class="inp" value="{$configuration.DomainRedemptionPeriod}" name="config[DomainRedemptionPeriod]"/>
                                    </td>
                                </tr>


                                {if $custom_automation}
                                    <tr >
                                        <td colspan="2">
                                            {include file=$custom_automation}
                                        </td>
                                    </tr>
                                {/if}

                                <tr class="odd">
                                    <td  align="right" valign="top">
                                        <strong>{$lang.domrenewal_notice}</strong>
                                    </td>
                                    <td class="automate-options">
                                        <input type="radio" {if !$showreminders}checked="checked"{/if} name="c_12" value="off" onclick="$('#reminder_options').hide();
                                                $('#email_reminder_mail').val(0);" id="reminder_off"/><label  for="reminder_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $showreminders}checked="checked"{/if} name="c_12" value="on" onclick="$('#reminder_options').ShowNicely();" id="reminder_on"/><label  for="reminder_on"><b>{$lang.yes}</b></label>
                                        <div class="p5" id="reminder_options" style="{if !$showreminders}display:none;{/if}" >

                                            <strong>{$lang.domain_expiring_mail}</strong>
                                            <div class="clear"></div>
                                            <table border="0" cellspacing="0" cellpadding="3" style="margin-top:5px;">
                                                <tr><td> <input type="checkbox" value="1" {if $configuration.1DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/>
                                                        <input type="text" size="3" class="config_val  inp" {if $configuration.1DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.1DomainReminder}"{/if} name="config[1DomainReminder]" />{$lang.daysbeforerenewal}</td></tr>

                                                <tr class="reminder2" ><td ><input type="checkbox" value="1" {if $configuration.2DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val  inp" {if $configuration.2DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.2DomainReminder}"{/if} name="config[2DomainReminder]" /> {$lang.daysbeforerenewal}</td></tr>
                                                <tr class="reminder3" ><td ><input type="checkbox" value="1" {if $configuration.3DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val  inp" {if $configuration.3DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.3DomainReminder}"{/if} name="config[3DomainReminder]" /> {$lang.daysbeforerenewal}</td></tr>
                                                <tr class="reminder4" ><td ><input type="checkbox" value="1" {if $configuration.4DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val  inp" {if $configuration.4DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.4DomainReminder}"{/if} name="config[4DomainReminder]"/> {$lang.daysbeforerenewal}</td></tr>
                                                <tr class="reminder5" ><td ><input type="checkbox" value="1" {if $configuration.5DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val inp" {if $configuration.5DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.5DomainReminder}"{/if} name="config[5DomainReminder]" /> {$lang.daysbeforerenewal}</td></tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="odd">
                                    <td width="200" align="right" valign="top"><strong>{$lang.new_SendPaymentReminderEmails}</strong></td>
                                    <td class="automate-options">
                                        <input type="radio" {if $configuration.SendPaymentReminderEmails == 'off'}checked="checked"{/if}   name="config[SendPaymentReminderEmails]" value="off"  onclick="$('#remindere_options').hide();" id="remindere_off"/><label  for="remindere_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.SendPaymentReminderEmails == 'on'}checked="checked"{/if}  name="config[SendPaymentReminderEmails]" onclick="$('#remindere_options').ShowNicely();" id="remindere_on"/><label  for="remindere_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="remindere_options" style="{if $configuration.SendPaymentReminderEmails == 'off'}display:none;{/if}" >


                                            {$lang.InvoiceUnpaidReminder} <span><input type="checkbox" value="1" {if $configuration.InvoiceUnpaidReminder>0}checked="checked"{/if} onclick="check_i(this)" />
                                                <input type="text" size="3" class="config_val  inp" {if $configuration.InvoiceUnpaidReminder<=0} value="0" disabled="disabled"{else}value="{$configuration.InvoiceUnpaidReminder}"{/if} name="config[InvoiceUnpaidReminder]"/> </span> {$lang.InvoiceUnpaidReminder2}
                                            <br/><br/>

                                            {$lang.1OverdueReminder}
                                            <span>
                                                <input type="checkbox" value="1" {if $configuration.1OverdueReminder>0}checked="checked"{/if} onclick="check_i(this)" /><input type="text" size="3" class="config_val  inp" {if $configuration.1OverdueReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.1OverdueReminder}"{/if} name="config[1OverdueReminder]"/>
                                            </span>
                                            <span>
                                                <input type="checkbox" value="1" {if $configuration.2OverdueReminder>0}checked="checked"{/if} onclick="check_i(this)" /><input type="text" size="3" class="config_val inp" {if $configuration.2OverdueReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.2OverdueReminder}"{/if} name="config[2OverdueReminder]"/>
                                            </span>
                                            <span>
                                                <input type="checkbox" value="1" {if $configuration.3OverdueReminder>0}checked="checked"{/if} onclick="check_i(this)" /><input type="text" size="3" class="config_val  inp" {if $configuration.3OverdueReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.3OverdueReminder}"{/if} name="config[3OverdueReminder]"/>
                                            </span>
                                            {$lang.1OverdueReminder2}
                                            <div style="margin:10px 0px 0px;">

                                                <table id="reminder_table" class="table-striped" cellpadding="4"><tbody>

                                                        {foreach from=$configuration.InvoiceCustomReminder item=v key=k}
                                                            <tr id="reminder_{$k}" >
                                                                <td>Send: </td>
                                                                <td width="180"><select name="config[InvoiceCustomReminder][{$k}][mail]" class="form-control">
                                                                        {foreach from=$emails.Invoice item=mail}<option value="{$mail.id}" {if $v.mail==$mail.id}selected="selected"{/if}>{$mail.tplname}</option>{/foreach}
                                                                    </select></td>
                                                                <td width="50"><input class="form-control" type="text" name="config[InvoiceCustomReminder][{$k}][days]" value="{$v.days}"/></td>
                                                                <td>days</td>
                                                                <td width="80"><select name="config[InvoiceCustomReminder][{$k}][type]" class="form-control">
                                                                        <option value="before" {if $v.type=='before'}selected="selected"{/if}>before</option>
                                                                        <option value="after" {if $v.type=='after'}selected="selected"{/if}>after</option>
                                                                    </select></td>
                                                                <td>due date</td>
                                                                <td><a class="btn btn-default btn-sm" onclick="return HBServices.rmreminder('{$k}');"><i class="fa fa-times-circle"></i></a></td>
                                                            </tr>
                                                        {/foreach}
                                                        <tr id="reminder_template" style="display: none">
                                                            <td>Send: </td>
                                                            <td width="180"><select name="config[InvoiceCustomReminderr][+n+][mail]" class="form-control">
                                                                    {foreach from=$emails.Invoice item=mail}<option value="{$mail.id}">{$mail.tplname}</option>{/foreach}
                                                                </select></td>
                                                            <td width="50"><input class="form-control" type="text" name="config[InvoiceCustomReminderr][+n+][days]" /></td>
                                                            <td>days</td>
                                                            <td width="80"><select name="config[InvoiceCustomReminderr][+n+][type]" class="form-control">
                                                                    <option value="before">before</option>
                                                                    <option value="after">after</option>
                                                                </select></td>
                                                            <td>due date</td>
                                                            <td><a class="btn btn-default btn-sm" onclick="return HBServices.rmreminder('+n+');"><i class="fa fa-times-circle"></i></a></td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                                <button class="btn btn-sm btn-default" onclick="return HBServices.customreminder();" >Add more custom reminders</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td width="200" align="right" valign="top"><strong>{$lang.new_LateFeeType_on|capitalize}</strong></td>
                                    <td class="automate-options">
                                        <input type="radio" {if $configuration.LateFeeType == '0'}checked="checked"{/if} name="config[LateFeeType_sw]" value="0"  onclick="$('#latefee_options').hide();" id="latefee_off"/><label  for="latefee_off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.LateFeeType != '0'}checked="checked"{/if} name="config[LateFeeType_sw]" value="1" onclick="$('#latefee_options').ShowNicely();" id="latefee_on"/><label  for="latefee_on"><b>{$lang.yes}</b></label>

                                        <div class="p5" id="latefee_options" style="{if $configuration.LateFeeType == '0'}display:none;{/if}" >

                                            {$lang.new_LateFeeType_on1} <input size="1" class="inp config_val"  value="{$configuration.LateFeeValue}" name="config[LateFeeValue]"/>
                                            <select  class="inp config_val" name="config[LateFeeType]">
                                                <option {if $configuration.LateFeeType=='1'}selected="selected"{/if} value="1">%</option>
                                                <option {if $configuration.LateFeeType=='2'}selected="selected"{/if}value="2">{if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</option>
                                            </select>
                                            {$lang.new_LateFeeType_on2}<input type="text" size="3" value="{$configuration.AddLateFeeAfter}" name="config[AddLateFeeAfter]" class="config_val inp" /> {$lang.LateFeeType2x} <br />

                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td width="200" align="right" valign="top"><strong>{$lang.credit_failed_renewals}</strong></td>
                                    <td>
                                        <input type="radio" {if $configuration.CreditFailedRenewals == 'off' || !$configuration.CreditFailedRenewals}checked="checked"{/if}
                                               name="config[CreditFailedRenewals]" value="off"><b>{$lang.no}</b></label>
                                        <input type="radio" {if $configuration.CreditFailedRenewals == 'on'}checked="checked"{/if}
                                               name="config[CreditFailedRenewals]" value="on"><b>{$lang.yes}</b></label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
                <tbody class="sectioncontent" style="display:none" >
                    <tr>
                        <td colspan="2">
                            {include file="services/ajax.service_emails.tpl"}
                        </td>
                    </tr>
                </tbody>
                <tbody class="sectioncontent" id="configfields" style="display:none" >
                    <tr>
                        <td colspan="2" style="padding:0px">
                            <table border="0" cellspacing="0" cellpadding="6" width="100%">
                                <tbody style="display:none" class="components_content" id="configfields">
                                {if $product.id=='new'}
                                    <tr>
                                        <td align="center" colspan="2">
                                            <strong>{$lang.save_product_first}</strong>
                                        </td>
                                    </tr>
                                {else}
                                    <tr id="importforms" style="display:none">
                                        <td colspan="2">
                                            <a name="import-config"></a>
                                            <div style="margin-bottom: 15px;" class="p6">
                                                <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                                                    <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="file" name="importforms"/>
                                                        </td>
                                                        <td>
                                                            <input type="button" value="Import" style="font-weight:bold" onclick="return saveProductFull();">
                                                            <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#importforms').hide();
                                                                                $('#importformsswitch').show();
                                                                                return false;" class="editbtn">{$lang.Cancel}</a>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                                <span class="pdescriptions fs11">{$lang.importformsnotice}</span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="configeditor">
                                        <td id="configeditor_content" colspan="2">
                                            {if $alerttab.eq==4}
                                                <div style="margin:0px 0px 15px;" class="imp_msg">
                                                    <strong>
                                                        This domain extension requires additional attributes to be entered by customer -
                                                        <a href="?cmd=services&action=product&id={$product.id}&make=addextendedform">click here to add them</a>
                                                    </strong>
                                                </div>
                                            {/if}
                                            {include file='ajax.configfields.tpl'}
                                        </td>
                                    </tr>
                                {/if}
                                </tbody>
                                <tbody style="display:none" class="components_content" id="subproducts">
                                <tr id="subprod_options_blank_state"
                                    {if $subproducts_applied}style="display:none"{/if}>
                                    <td colspan="2">
                                        <div class="blank_state_smaller blank_domains">
                                            <div class="blank_info">
                                                <h3>Offer other packages to be purchased and automated with this product, all in one order.</h3>
                                                <div class="clear"></div>
                                                <br/>
                                                <a href="#" class="new_control" onclick="$('#subproducts_options_container').show();$('#subprod_options_blank_state').hide();return false;">
                                                    <span class="addsth">
                                                        <strong>Enable Sub-products</strong>
                                                    </span>
                                                </a>
                                                <div class="clear"></div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="subproducts_options_container" {if !$subproducts_applied}style="display:none"{/if}>
                                    <td colspan="2">
                                        <b>Select packages you wish to offer as a sub-product</b>
                                        <select multiple name="subproducts[]" id="subproducts_op" class="form-control chosenedge multiopt">
                                            {foreach from=$subproducts item=do}
                                                <option value="{$do.id}" {if $product.subproducts.products[$do.id]}selected="selected"{/if}>{$do.category_name} - {$do.name}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
                <tbody class="sectioncontent" style="display:none" >

                    {if $product.id=='new'}
                        <tr>
                            <td align="center" colspan="2">
                                <strong>{$lang.save_product_first}</strong>

                            </td>
                        </tr>
                    {else}
                        <tr id="widgeteditor">

                            <td id="widgeteditor_content" colspan="2">
                                {include file='ajax.productwidgets.tpl'}

                            </td>
                        </tr>
                    {/if}


                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td class="nicers" style="border:0px" colspan="2">
            <a class="new_dsave new_menu" href="#" onclick="return saveProductFull();">
                <span>{$lang.savechanges}</span>
            </a>
        </td>

    </tr>
</table>


<div class="clear"></div>
<script type="text/javascript">
    lang['Redemption'] = '{$lang.Redemption}';
    lang['Register'] = '{$lang.Register}';
    lang['Transfer'] = '{$lang.Transfer}';
    lang['Renew'] = '{$lang.Renew}';
    lang['Years'] = '{$lang.Years}';
    {if $alerttab}
    $('#newshelfnav li').eq({$alerttab.eq}).find('span').addClass('notification');
    {/if}
    {literal}

    function loadDomainModule(sel) {
        var v = $(sel).val();
        if (v == 'new') {
            $(sel).val(0);
            window.location = '?cmd=managemodules&action=domain&do=inactive';
            return false;
        } else {
            ajax_update('?cmd=services&action=showdomainmodule', {
                id: v,
                product_id: $('#product_id').val()
            }, '#app_picker');
        }
        return false;
    }

    function activateDomainModule(frm) {
        $('#facebox .spinner').show();
        $('#picked_tab').val(1);
        var m = $(frm).find('input[name=modulename]').val();
        if (m) {
            $(document).bind('close.facebox', function () {
                window.location = '?cmd=services&action=product&picked_tab=1&id=' + $('#product_id').val()
            });
            $.post('?cmd=managemodules&action=quickactivate&type=domain', {
                fname: m,
                product_id: $('#product_id').val()
            }, function (data) {
                $('#facebox .spinner').hide();
                var resp = parse_response(data);
                if (typeof (resp) != 'boolean') {
                    $('#facebox .content').html(resp);
                } else {
                    window.location = '?cmd=services&action=product&picked_tab=1&id=' + $('#product_id').val();
                    return false;
                }
            });
        } else {
            $(document).trigger('close.facebox');
        }
        return false;
    }

    $('#components_menu').TabbedMenu({
        elem: '.components_content',
        picker_id: "picked_subtab",
        picker: '.list-3 li',
        picked: picked.sub || 0
    });

    {/literal}
</script>