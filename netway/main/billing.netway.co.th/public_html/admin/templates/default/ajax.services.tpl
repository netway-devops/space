{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.services.tpl.php');
{/php}

{if $action=='default' || $action=='addcategory' || $action=='editcategory' || $action=='category'}
    <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
    <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
{/if}
{if ($action=='category' || $action=='editcategory') && $category}
    {include file='services/category.tpl'}
{elseif $action=='default' || $action=='addproduct' || $action=='addcategory'}
    {include file="services/categories.tpl"}
{elseif $action=='newpageextra'}

{elseif $action=='addonseditor'}
    {if $addons.addons || $addons.applied}{if $addons.applied}<div class="p5">

                <table border="0" cellpadding="6" cellspacing="0" width="100%" >

                    {foreach from=$addons.addons item=f}
                        {if $f.assigned}<tr class="havecontrols">
                                <td width="16">
                                    <div class="controls"><a href="#" class="rembtn"  onclick="return removeadd('{$f.id}')">{$lang.Remove}</a></div></td>
                                <td align="left">{$lang.Addon}: <strong>{$f.name}</strong>
                                </td>
                                <td align="right">
                                    <div class="controls fs11">
                                        {$lang.goto}
                                        <a href="?cmd=productaddons&action=addon&id={$f.id}" class="editbtn editgray" style="float:none" target="_blank">{$lang.addonpage}</a>
                                    </div>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                </table>
            </div>
            <div style="padding:10px 4px">
                {if $addons.available}
                    <a href="#" class="new_control" onclick="$(this).hide();
                            $('#addnew_addons').ShowNicely();
                            return false;"  id="addnew_addon_btn">
                        <span class="addsth" >{$lang.assign_new_addons}</span>
                    </a>
                {/if}
            </div>
        {else}
            <div class="blank_state_smaller blank_forms">
                <div class="blank_info">
                    <h3>{$lang.offeraddons}</h3>
                    <div class="clear"></div>
                    <br/>
                    {if $addons.available}
                        <a  href="#" class="new_control"  onclick="$('#addnew_addons').ShowNicely();
                                return false;" ><span class="addsth" ><strong>{$lang.assign_new_addons}</strong></span></a>
                                {else}
                        <a href="?cmd=productaddons&action=addon&id=new"class="new_control"   target="_blank"><span class="addsth" ><strong>{$lang.createnewaddon}</strong></span></a>
                                {/if}
                    <div class="clear"></div>
                </div>
            </div>
        {/if}

        {if $addons.available}
            <div class="p6" id="addnew_addons" {if $addons.applied}style="display:none"{/if}>
                <table  cellpadding="3" cellspacing="0">
                    <tr>
                        <td>
                            {$lang.Addon}: <select name="addon_id">
                                {foreach from=$addons.addons item=f}
                                    {if !$f.assigned}
                                        <option value="{$f.id}">{$f.name}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </td>
                        <td >
                            <input type="button" value="{$lang.Add}" style="font-weight:bold" onclick="return addadd()"/>
                            <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#addnew_addons').hide();
                                    $('#addnew_addon_btn').show(); return false;" class="editbtn">{$lang.Cancel}</a>
                        </td>
                    </tr>

                </table>
            </div>
        {/if}
    {else}

        <div class="blank_state_smaller blank_forms">
            <div class="blank_info">
                <h3>{$lang.noaddonsyet}</h3>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    {literal}
        <script type="text/javascript">
            $('#addonsditor_content .havecontrols').hover(function () {
                $(this).find('.controls').show();
            }, function () {
                $(this).find('.controls').hide();
            });
        </script>
    {/literal}

{elseif ($action=='category' || $action=='editcategory') && $category}
    <div class="nicerblu">
        <div id="cinfo0" {if $action=='editcategory'}style="display:none"{/if}>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                <tr >
                    <td>
                        <table border="0" cellpadding="6" cellspacing="0" width="100%" >
                            <tr >
                                <td class="havecontrols">
                                    <span class="left">
                                        <strong style="font-size:16px">
                                            {$category.name}
                                        </strong>
                                        {if $lang[$category.otype]} {$lang[$category.otype]}
                                        {elseif $category.template=='custom'} {$lang.typespecificcheckout}
                                        {/if}
                                    </span>
                                    <span class="controls">
                                        <a href="#" class="editbtn" onclick="return editcat();">{$lang.Edit}</a>
                                    </span>
                                </td>
                            </tr>
                            {if $category.description!=''}
                                <tr >
                                    <td class="havecontrols"><span class="left">{$category.description|strip_tags}</span><span class="controls"><a href="#" class="editbtn" onclick="return editcat();">{$lang.Edit}</a></span></td>
                                </tr>
                            {/if}
                        </table>
                    </td>
                    <td valign="top" width="30%" style="padding:10px" class="fs11">
                        {*
                        {assign var="descr" value="_descr"}
                        {assign var="bescr" value=$category.otype}
                        {assign var="baz" value="$bescr$descr"}
                        <!-- {$lang[$baz]} -->*}
                    </td>
                    <td valign="top" width="20%" style="padding-left:10px">

                    </td>
                </tr>
            </table>

        </div>

        <div id="cinfo1" {if $action!='editcategory'}style="display:none"{/if}>
            <form action="" name="" method="post" enctype="multipart/form-data">
                <input type="hidden" name="make" value="editcategory"/>
                <input type="hidden" name="cat_id" value="{$category.id}"/>

                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    <tbody>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.Name}:</strong></td>
                            <td width="400">
                                {hbinput value=$category.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="60" name="name" id="categoryname"}
                            </td>
                            <td></td>
                        </tr>
                    </tbody>
                    <tbody id="hints">
                        <tr >
                            <td width="160" align="right" class="fs11">Order page url: </td>
                            <td class="fs11" colspan="2"><a href="{$system_url}{$ca_url}cart/{$category.slug}/" target="_blank">{$system_url}{$ca_url}cart/<span class="changemeurl">{$category.slug}</span></a><input  name="slug" type="text" class="" value="{$category.slug}" id="category_slug_edit" style="display:none" />/ <a class="editbtn" onclick="return editslug(this)" href="#">{$lang.Edit}</a></td>
                        </tr>
                    </tbody>
                    <tbody id="template_descriptions">
                        {include file="ajax.services.tpl" action='newpageextra'}
                    </tbody>
                    <tbody>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.Description}:</strong></td>
                            <td colspan="2">
                                {if $category.description!=''}
                                    {hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description"  featureset="simple"}
                                {else}
                                    <a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;"><strong>{$lang.adddescription}</strong></a>
                                    <div id="prod_desc_c" style="display:none">{hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="simple"}</div>
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.Advanced}:</strong></td>
                            <td colspan="2">
                                <a href="#" onclick="$('#advanced_scenarios').show();$(this).hide();return false;">{$lang.show_advanced}</a>
                                <div id="advanced_scenarios" style="display:none">
                                    <strong>{$lang.order_scenario}:</strong> <a class="editbtn" href="?cmd=configuration&action=orderscenarios" target="_blank">[?]</a>
                                    <select name="scenario" class="inp">
                                        {foreach from=$scenarios item=scenario name=scloop}
                                            <option value="{$scenario.id}" {if $category.scenario_id==$scenario.id}selected="selected"{/if}>{$scenario.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </td>
                        </tr>
                    </tbody>

                    
                </table>
                
                <p align="center">
                    <input type="submit" value="{$lang.savechanges}" class="submitme" />
                    <span class="orspace">{$lang.Or}</span> <a href="?cmd=services"  class="editbtn" onclick="$('#cinfo1').toggle();$('#cinfo0').toggle();return false;">{$lang.Cancel}</a>
                </p>
                {securitytoken}
            </form>
        </div>
    </div>
    {literal}
        <script type="text/javascript">

        function sl(el) {
            ajax_update('?cmd=services&action=newpageextra',{ptype:$(el).val(),selected:$('#wiz_options input:checked').val()},function(data){$('#template_descriptions').html(data);if($('#template_descriptions input:checked').length==0){$('#template_descriptions input:first').click()}});
            return false;
        }
        function editcat() {
            $('#cinfo1').toggle();
            $('#cinfo0').toggle();
            return false;
        }
        $(document).ready(function(){
            $('#categoryname').bind('keyup keydown change',function(){
                if($(this).val()!='') {
                    $('#hints').slideDown('fast');
                    var w=$(this).val().replace(/[^a-zA-Z0-9-_\s]+/g,'-').replace(/[\s]+/g,'-').toLowerCase();
                    if(!$('#category_slug_edit').is(':visible')) {
                        $('#category_slug_edit').val(w);
                    }
                    $('#hints .changemeurl').html(w);
                } else {
                    $('#hints').slideUp('fast');
                }
            });
        });
        </script>
    {/literal}
    <div class="blu">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td ><a href="?cmd=services"  class="tload2"><strong>{$lang.orpages}</strong></a> &raquo; <strong>{$category.name}</strong></td>

                <td align="right"><a href="?cmd=services&action=editcategory&id={$category.id}" class="editbtn" onclick="return editcat();">{$lang.editthisorpage}</a></td>
            </tr>
        </table>
    </div>
    {if $products}<pre>{*$products|@print_r*}</pre>{assign var=isDomain value=0}
    {foreach from=$products item=prod name=prods}
        {if $prod.paytype == 'DomainRegular'}{assign var=isDomain value=1}{break}{/if}
    {/foreach}
        <form id="serializeit">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                <tbody>
                    <tr>
                        <th width="20"></th>
                        <th >{$lang.Name}</th>

                        <th width="80">{$lang.Accounts}</th>
                        {if $isDomain == 1}
                        <th width="80">Active</th>
                        <th width="80">Pending</th>
                        <th width="80">Pending Transfer</th>
                        <th width="80">Expired</th>
                        <th width="80">Cancelled</th>
                        {else}
                        <th width="80">Active</th>
                        <th width="80">Pending</th>
                        <th width="80">Suspended</th>
                        <th width="80">Terminated</th>
                        <th width="80">Cancelled</th>
                        {/if}
                        <th width="30"></th>
                        <th width="100">&nbsp;</th>
                    </tr>
                </tbody>
            </table>
            <ul id="grab-sorter" style="width:100%">
                {foreach from=$products item=prod name=prods}
                    <li {if $prod.visible=='0'}class="hidden"{/if}  ><div ><table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                                <tr  class="havecontrols">
                                    <td width="20"><input type="hidden" name="sort[]" value="{$prod.id}" />
                                        <div class="controls">
                                            <a class="sorter-handle" >{$lang.move}</a>
                                        </div>
                                    </td>
                                    <td ><a href="?cmd=services&action=product&id={$prod.id}">{if $prod.visible=='0'}<em class="hidden">{/if}{$prod.name}{if $prod.visible=='0'}</em>{/if}</a> {if $prod.visible=='0'}<em class="hidden fs11">{$lang.hidden}</em>{/if}</td>
                                    <td width="80" align="center">{if $prod.accounts}<a  href="?cmd=accounts&filter[product_id]={$prod.id}" target="_blank">{$prod.accounts}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                    {if $isDomain == 1}
                                    <td width="80" align="center">{if $aProductsStatus_d[$prod.id].active.activeAcc}<a  href="?cmd=domains&filter[tld_id]={$prod.id}&&list=active" target="_blank">{$aProductsStatus_d[$prod.id].active.activeAcc}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus_d[$prod.id].pending.pendingAcc}<a  href="?cmd=domains&filter[tld_id]={$prod.id}&&list=pending" target="_blank">{$aProductsStatus_d[$prod.id].pending.pendingAcc}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus_d[$prod.id].pendingTransfer.pendingTransferAcc}<a  href="?cmd=domains&filter[tld_id]={$prod.id}&&list=pending_transfer" target="_blank">{$aProductsStatus_d[$prod.id].pendingTransfer.pendingTransferAcc}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus_d[$prod.id].expired.expiredAcc}<a  href="?cmd=domains&filter[tld_id]={$prod.id}&&list=expired" target="_blank">{$aProductsStatus_d[$prod.id].expired.expiredAcc}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus_d[$prod.id].cancelled.cancelledAcc}<a  href="?cmd=domains&filter[tld_id]={$prod.id}&&list=cancelled" target="_blank">{$aProductsStatus_d[$prod.id].cancelled.cancelledAcc}</a>{else}0{/if}</td>
                                    {else}
                                    <td width="80" align="center">{if $aProductsStatus[$prod.id].active.activeAcc}<a  href="?cmd=accounts&list=all_active&filter[product_id]={$prod.id}" target="_blank">{$aProductsStatus[$prod.id].active.activeAcc}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus[$prod.id].pending.pendingAcc}<a  href="?cmd=accounts&list=all_pending&filter[product_id]={$prod.id}" target="_blank">{$aProductsStatus[$prod.id].pending.pendingAcc}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus[$prod.id].suspended.suspendedAcc}<a  href="?cmd=accounts&list=all_suspended&filter[product_id]={$prod.id}" target="_blank">{$aProductsStatus[$prod.id].suspended.suspendedAcc}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus[$prod.id].terminated.terminatedAcc}<a  href="?cmd=accounts&list=all_terminated&filter[product_id]={$prod.id}" target="_blank">{$aProductsStatus[$prod.id].terminated.terminatedAcc}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                    <td width="80" align="center">{if $aProductsStatus[$prod.id].cancelled.cancelledAcc}<a  href="?cmd=accounts&list=all_cancelled&filter[product_id]={$prod.id}" target="_blank">{$aProductsStatus[$prod.id].cancelled.cancelledAcc}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                    {/if}
                                    <td width="30">{if $prod.stock=='1'}{$lang.qty} {$prod.qty}{/if}</td>
                                    <td width="20"><a href="?cmd=services&action=product&id={$prod.id}" class="editbtn">{$lang.Edit}</a></td>
                                    <td width="30"><a class="editbtn editgray" href="?cmd=services&amp;make=duplicate&id={$prod.id}&security_token={$security_token}">{$lang.Duplicate}</a></td>
                                    <td width="20"><a href="?cmd=services&make=deleteproduct&id={$prod.id}&cat_id={$category.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteproductconfirm}');" class="delbtn">{$lang.Delete}</a> </td>
                                </tr>
                            </table>
                        </div>
                    </li>
                {/foreach}
            </ul>
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                <tbody>
                    <tr>
                        <th width="30"></th>
                        <th width="100"><a class="editbtn" href="?cmd=services&action=product&id=new&cat_id={$category.id}">{$lang.addnewproduct}</a></th>
                        <th ><a class="editbtn" href="?cmd=services&action=updateprices&cat_id={$category.id}">Bulk price update</a></th>
                    </tr>
                </tbody>
            </table>
            {securitytoken}
        </form>

        <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
        {literal}
            <script type="text/javascript">
                $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });

                function saveOrder() {
                var sorts = $('#serializeit').serialize();
                ajax_update('?cmd=services&action=listprods&'+sorts,{});
                };
            </script>
        {/literal}
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>{$lang.orpage_blank2}</h1>

                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><a class="new_add new_menu" href="?cmd=services&action=product&id=new&cat_id={$category.id}"  style="margin-top:5px"><span>{$lang.addnewproduct}</span></a>
                        </td>
                        <td></td>
                    </tr>
                </table>

                <div class="clear"></div>

            </div>
        </div>

    {/if}

{elseif $action=='product' }

    <form action="" method="post" name="productedit" id="productedit" onsubmit="selectalladdons()" enctype="multipart/form-data">
        <input type="hidden" name="make" value="editproduct"/>
        <input type="hidden" name="id" value="{$product.id}"/>

        <div>
            {if $maintpl}
                {include file=$maintpl}
            {else}
                {include file='newservices.tpl'}
            {/if}
        </div>

        <script type="text/javascript">
                var zero_value = '{0|price:$currency:false:false}';
                var picked = {literal}{{/literal}
                    main: {$picked_tab|default:0},
                    sub: {$picked_subtab|default:0}
            {literal}};{/literal}

{* custom code จัดการ cpanel ของ RV *}

        </script>

        <script type="text/javascript" src="{$template_dir}js/services_product.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/gui.elements.js?v={$hb_version}"></script>
        <link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
        <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>


        {securitytoken}
    </form>
{elseif $action == 'bulkupdate'}
    {include file='services/ajax.bulkupdate.tpl'}
{elseif $action=='updatetags'}
    {include file='services/ajax.updatetags.tpl'}

{elseif $action=='default' || $action=='addproduct' || $action=='addcategory'}

    <div  id="addcategory" style="{if $action!='addcategory'}display:none{/if}">
        <div class="blu"><strong>{$lang.addneworpage}</strong></div>

        <div class="nicerblu">
            <form action="" name="" method="post" enctype="multipart/form-data">
                <input type="hidden" name="make" value="addcategory"/>

                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    <tbody>
                        <tr class="step0">
                            <td width="160" align="right"><strong>{$lang.Name}:</strong></td>
                            <td width="400">{hbinput value=$category.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="60" name="name" id="categoryname"}</td>
                            <td></td>
                        </tr>
                    </tbody>
                    <tbody id="hints" style="display:none">
                        <tr >
                            <td width="160" align="right" class="fs11">{$lang.orderpageurl} </td>
                            <td class="fs11" colspan="2">{$system_url}{$ca_url}cart/<span class="changemeurl">{$category.slug}</span><input  name="slug" type="text" class="" value="{$category.slug}" id="category_slug_edit" style="display:none" />/ <a class="editbtn" onclick="return editslug(this)" href="#">{$lang.Edit}</a></td>
                        </tr>
                    </tbody>
                    <tbody id="template_descriptions" class="step1">
                        <tr>
                            <td width="160" align="right" valign="top" style="padding-top:12px;">
                                <strong>{$lang.ordertype}</strong>
                            </td>
                            <td>
                                <div id="template_wizard">
                                    <select name="ptype"  class="inp template " onchange="sl(this)"  style="font-weight:bold;font-size:14px !important;" id="ptypechange">
                                        <option value="0" selected="selected">{$lang.selectone}</option>
                                        {foreach from=$ptypes item=ptype name=lop}
                                            <option value="{$ptype.id}">
                                                {assign var="descr" value="_hosting"}{assign var="bescr" value=$ptype.lptype}{assign var="baz" value="$bescr$descr"}
                                                {if $lang.$baz}{$lang.$baz}
                                                {else}{$ptype.type}
                                                {/if}
                                            </option>
                                        {/foreach}
                                    </select> {if $countinactive}<div class="fs11 tabb" >Note: There are <b>{$countinactive}</b> inactive order types, you can enable them by activating related <a href="?cmd=managemodules&action=hosting" target="_blank">hosting modules</a> </div>{/if}
                                </div>
                                <div id="wiz_options"></div>
                            </td>
                            <td valign="top"></td>
                        </tr>
                    </tbody>
                    <tbody>
                        <tr class="step1">
                            <td width="160" align="right"><strong>{$lang.Description}:</strong></td>
                            <td colspan="2">
                                <a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;"><strong>{$lang.adddescription}</strong></a>
                                <div id="prod_desc_c" style="display:none">{hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="simple"}</div>
                            </td>
                        </tr>
                         <tr class="step1">
                            <td width="160" align="right"><strong>{$lang.Advanced}:</strong></td>
                            <td colspan="2">
                                <a href="#" onclick="$('#advanced_scenarios').show();$(this).hide();return false;">{$lang.show_advanced}</a>
                                <div id="advanced_scenarios" style="display:none">
                                    <strong>{$lang.order_scenario}:</strong> <a class="editbtn" href="?cmd=configuration&action=orderscenarios" target="_blank">[?]</a>
                                    <select name="scenario" class="inp">
                                        {foreach from=$scenarios item=scenario name=scloop}
                                            <option value="{$scenario.id}" {if $category.scenario_id==$scenario.id}selected="selected"{/if}>{$scenario.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    
                </table>

                <p align="center">
                    <input type="submit" value="{$lang.addneworpage}" class="submitme" disabled="disabled" id="submitbtn"/>
                    <span class="orspace">{$lang.Or}</span> <a href="?cmd=services"  class="editbtn">{$lang.Cancel}</a>

                </p>

                {securitytoken}
            </form>
            {literal}
                <script type="text/javascript">
                function prswitch(id,el) {
                    $('#subwiz_opt span').removeClass('active');
                    $(el).parent().addClass('active');
                    $('.pr_desc').hide();
                    $('#pr_desc'+id).show();
                }
                function sl(el) {
                    ajax_update('?cmd=services&action=newpageextra',{
                        ptype:$(el).val(),
                        selected:$('#wiz_options input:checked').val(),
                        addcategory:true},
                    function(data){
                        $('#template_descriptions').html(data);
                        if($('#template_descriptions input:checked').length==0){
                            $('#template_descriptions input:first').click()}});
                    $('#submitbtn').removeAttr('disabled');
                    return false;
                }
                $(document).ready(function(){
                    $('.step1').css('opacity',0.2);

                    $('#categoryname').bind('keyup keydown change',function(){
                        if($(this).val()!='') {
                        if($('select[name=ptype]').val()!='0')
                            $('#submitbtn').removeAttr('disabled');
                            $('.step1').css('opacity',1);
                            $('#hints').slideDown('fast');
                            var w=$(this).val().replace(/[^a-zA-Z0-9-_\s]+/g,'-').replace(/[\s]+/g,'-').toLowerCase();
                            if(!$('#category_slug_edit').is(':visible')) {
                                $('#category_slug_edit').val(w);
                            }
                            $('#hints .changemeurl').html(w);
                        } else {
                            $('.step1').css('opacity',0.2);
                                                        $('#hints').slideUp('fast');
                            $('#submitbtn').attr('disabled','disabled');
                        }
                    });

                });
                </script>
            {/literal}
        </div>
    </div>
    <div id="listproducts" {if $action!='default'}style="display:none"{/if}>
        {if $categories}
            <div class="blu"><strong>{$lang.orpages}</strong></div>

            <form id="serializeit" method="post">

                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                    <tbody>
                        <tr>
                            <th width="20"></th>
                            <th width="20%">{$lang.Name}</th>
                            <th width="120" >{$lang.numofprod}</th>
                            <th >{$lang.ordertype}</th>
                            <th width="100">&nbsp;</th>
                        </tr>
                    </tbody>
                </table>
                <ul id="grab-sorter" style="width:100%">
                    {foreach from=$categories item=i name=cat}
                        <li {if $i.visible=='0'}class="hidden"{/if}  >
                            <div >
                                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                                    <tr  class="havecontrols">
                                        <td width="20">
                                            <input type="hidden" name="sort[]" value="{$i.id}" /><div class="controls"><a class="sorter-handle" >{$lang.move}</a></div>
                                        </td>
                                        <td width="20%"><a href="?cmd=services&action=category&id={$i.id}" class="direct">{if $i.visible=='0'}<em class="hidden">{/if}{$i.name}{if $i.visible=='0'}</em>{/if}</a> {if $i.visible=='0'}<em class="hidden fs11">{$lang.hidden}</em>{/if}</td>
                                        <td width="120"><a href="?cmd=services&action=category&id={$i.id}" class="direct">{$i.products}</a></td>
                                        <td >
                                            {if count($aProducts[$i.id])}
                                            <a href="javascript:void(0);" onclick="$('#productList_{$i.id}').toggle();">list product</a> &nbsp;&nbsp;&nbsp; 
                                            <div id="productList_{$i.id}" style="padding:5px; padding-left:25px; display:none; border: 1px dotted #6694E3; background-color: #E0ECFF;">
                                                {assign var="aLists" value=$aProducts[$i.id]}
                                                {foreach from=$aLists key=pId item=aList}
                                                <a href="?cmd=services&action=product&id={$pId}" target="_blank">{$aList.name}</a><br />
                                                {/foreach}
                                            </div>
                                            {/if}
                                            
                                            {*{assign var="descr" value="_hosting"}{assign var="bescr" value=$i.lptype}{assign var="baz" value="$bescr$descr"}
                                            {if $lang.$baz}
                                            {$lang.$baz}
                                            {else}
                                            {$i.ptype}
                                            {/if}*}
                                            {if $lang[$i.otype]} {$lang[$i.otype]}
                                            {elseif $i.template=='custom'}{$lang.typespecificcheckout}
                                            {else}{$i.otype}
                                            {/if}
                                        </td>
                                        <td width="20"><a href="?cmd=services&action=editcategory&id={$i.id}" class="editbtn">{$lang.Edit}</a></td>
                                        <td width="33">{if $i.visible=='0'}<a href="?cmd=services&make=showcat&id={$i.id}&security_token={$security_token}" class="editbtn editgray">{$lang.Show}</a>{else}<a href="?cmd=services&make=hidecat&id={$i.id}&security_token={$security_token}" class="editbtn editgray">{$lang.Hide}</a>{/if}</td>
                                        <td width="20"><a href="?cmd=services&make=deletecat&id={$i.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletecategoryconfirm}');" class="delbtn">{$lang.Delete}</a> </td>
                                    </tr>
                                </table>
                            </div>
                        </li>
                    {/foreach}
                </ul>
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                    <tbody>
                        <tr>
                            <th width="20"></th>
                            <th ><a class="editbtn" href="?cmd=services&action=addcategory">{$lang.addneworpage}</a></th>

                        </tr>
                    </tbody>
                </table>
                <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
                {literal}
                    <script type="text/javascript">
                        $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });

                        function saveOrder() {
                        var sorts = $('#serializeit').serialize();
                        ajax_update('?cmd=services&action=listcats&'+sorts,{});
                        };
                    </script>
                {/literal}
                {securitytoken}
            </form>
        {else}
            <div class="blank_state blank_services">
                <div class="blank_info">
                    <h1>{$lang.orpage_blank1}</h1>
                    <div class="clear">{$lang.orpage_blank1_desc}</div>

                    <a class="new_add new_menu" href="?cmd=services&action=addcategory"  style="margin-top:10px">
                        <span>{$lang.addneworpage}</span></a>
                    <div class="clear"></div>

                </div>
            </div>
        {/if}
    </div>

{elseif $action=='updateprices'}
    {include file='services/ajax.updateprices.tpl'}
{/if}


{if $action=='default' || $action=='addcategory' || $action=='editcategory' || $action=='category'}
    <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js"></script>
    <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js"></script>
    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
    {literal}
        <script type="text/javascript">
        function get_descr(el) {
            $('#wiz_options li').removeClass('activated');
            $(el).prop('checked', true).parent().addClass('activated');
            $('.gallery .gal_slide').hide();
            $('#o' + $(el).attr('id')).show();

        }

        function editslug(el) {
            $(el).hide();
            $('#category_slug_edit').show();
            $('.changemeurl').hide();
            return false;

        }

        var HBServices = {
            customize: function () {
                var op = $('input[name=otype]:checked').val();
                if (!op) return false;
                var cid = $('input[name=cat_id]').val();
                if (!cid) {
                    alert('Please add your orderpage first');
                    return false;
                }

                $.facebox({
                    ajax: "?cmd=services&action=opconfig&tpl=" + op + "&id=" + cid,
                    width: 860,
                    nofooter: true,
                    overlay :false,
                    opacity: 0.8,
                    addclass: 'modernfacebox'
                  
                });
                return false;
            }
        };
        </script>
    {/literal}
{/if}
