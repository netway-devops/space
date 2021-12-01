{if $action=='getaddform' || $action=='field' ||  $action=='getduplicateform'  ||  $action=='addconfig' || $action=='previewfields'}{literal}
    <style type="text/css">

        .alert {
            position: relative;
            padding: .75rem 1.25rem;
            margin: 1.2rem 0;
            border: 1px solid transparent;
            border-radius: .25rem;
        }

        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }

        .alert-warning {
            color: #856404;
            background-color: #fff3cd;
            border-color: #ffeeba;
            margin-bottom: 0 !important;
        }

        .pricingtable input {
            float: none !important;
            margin: 0px !important;
        }

        .formbilling-head {
            text-align: left;
            clear: both;
            line-height: 23px;
            border-bottom: 1px solid #d9d9d9;
            margin: 0 0 15px 0;
        }

        .formbilling-head a {
            padding: 4px 15px;
            text-transform: capitalize;
        }

        .formbilling-head a.active {
            border-bottom: 3px solid #C2C3C4 /*#3491DF*/;
            text-decoration: none;
            color: black;

        }

        #facebox .tabb.config-fields-advanced .row label {
            margin-bottom: 8px;
        }

        #facebox hr.small {
            margin-bottom: 5px;
            margin-top: 5px;
        }
        .form-options{
            position: relative;
        }
        .form-options .placeHolder,
        .form-options .placeHolder > div{
            min-height: 50px;
        }
        .form-options > .form-option {
            padding: 8px 0 0;
            margin-bottom: -1px;
            width: 100%;
        }

        .form-option input[type=text].form-control {
            height: 24px;
        }

        .form-option .form-option-more {
            padding: 4px 0;
            clear: both;
        }

        .form-option .form-option-more > div {
            border-top: 1px solid #eee;
            margin: 0 10px;
            padding: 5px 0;
        }

        .conv_content.assigned_group {
            padding: 5px 0 0 0;
        }

        .form-settings select {
            padding: 0;
            max-width: 60px;
        }
    </style>
{/literal}
    <script type="text/javascript">
        var configfields_lang = {literal}{}{/literal};
        configfields_lang['premade_over'] = "{$lang.premade_over}";
        configfields_lang['delconf2'] = "{$lang.delconf2}";
    </script>
    <script type="text/javascript" src="{$template_dir}js/configfields.js?v={$hb_version}"></script>
{/if}
{if $action=='loadpremade_field'}
    {if $fields}
        <div class="clear"></div>
        <label>{$lang.premade}
            <small>{$lang.premade_desc}</small>
        </label>
        <select name="premade" style="margin:0 10px;" id="premade_val" onchange="if ($(this).val() == '1')
                    $('#loadurl').show();
                else
                    $('#loadurl').hide()">
            <option value="0">{$lang.none}</option>

            {foreach from=$fields item=f}
                <option>{$f}</option>
            {/foreach}</select>
        <div class="clear"></div>
        <div id="loadurl" style="display:none">
            <label>Step 1.
                <small>Paste <a href="http://hostbillapp.com/fastconfig/forms/" target="_blank">config url</a></small>
            </label>
            <input class="w250" type="text" name="premadeurl" id="premadeurl_val"/>
            <div class="clear"></div>
            <label>Step 2.
                <small>Submit and verify setup</small>
            </label>
            <div style="margin:2px 10px" class="left">
                <span style="" class="bcontainer dhidden"><a onclick="return createField()" href="#"
                                                             class="new_control greenbtn"><span>{$lang.createnewcfield}</span></a></span>
            </div>
        </div>
    {/if}
{elseif ($cmd=='services' && $action=='product') || ($cmd=='configfields' && $loadproduct)}
    <div>
        <script type="text/javascript">  $('body').unbind('ajaxComplete');</script>
        {if $config}
            <div style="padding:10px 4px">
                <a href="#" class="new_control" onclick="return addCustomFieldForm({$product_id});" id="addnew_conf_btn">
                    <span class="addsth"><strong>{$lang.assign_custom_opt}</strong></span>
                </a>
                <script type="text/javascript">$('#preview_forms_shelf').show();</script>
                <a href="?cmd=configfields&product_id={$product_id}&action=previewfields" class="new_control" onclick="return previewCustomForm($(this).attr('href'))"><span class="zoom">{$lang.Preview}</span></a>
                <a href="?cmd=configfields&action=export&id={$product_id}" class="new_control" target="_blank">
                    <span class="disk-export">Export</span>
                </a>
                <a href="#" class="new_control" onclick="$('#importforms').show(); return false">
                    <span class="disk-import">Import from file</span>
                </a>
                <a href="#" class="new_control" onclick="return copyCustomFieldForm({$product_id});">
                    <span class="duplicatesth" style="background-position: left center; padding-left: 15px;">Copy from product</span>
                </a>
            </div>
            <div id="listform">
                <div id="serializeit">
                    <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
                        {foreach from=$config item=field}
                            <li style="background:#ffffff">
                                <div style="border-bottom:solid 1px #ddd;">
                                    <table border="0" width="100%" cellspacing="0" cellpadding="5">
                                        <tr>
                                            <td valign="top" width="140">
                                                <div style="padding:10px 0px;">
                                                    <input type="hidden" name="sortc[]"
                                                           value="{$field.id}"
                                                           class="ser"/>
                                                    <a name="f{$field.id}"></a>
                                                    <a href="#" class="sorter-ha menuitm menu-auto"
                                                       onclick="return false">
                                                        <i class="fa fa-sort"></i>
                                                    </a>
                                                    <a href="#" class="menuitm menu-auto" title="{$lang.Edit}"
                                                       onclick="return editCustomFieldForm({$field.id},{$product_id});"
                                                       style="">
                                                        <i class="fa fa-pencil"></i>
                                                    </a>
                                                    <a href="#" class="menuitm menu-auto" title="{$lang.Duplicate}"
                                                       onclick="return duplicateCustomFieldForm({$field.id},{$product_id});">
                                                        <i class="fa fa-clone"></i>
                                                    </a>
                                                    <a href="?cmd=configfields&make=delete&id={$field.id}&product_id={$product_id}"
                                                       class="menuitm menu-auto" title="{$lang.delete}"
                                                       onclick="return deleteItemConfCat(this)">
                                                        <i class="fa fa-trash-o"></i>
                                                    </a>
                                                </div>
                                            </td>
                                            <td>
                                                {include file=$field.configtemplates.adminlist}
                                                {if $field.variable}
                                                    <input type="hidden" class="config-var"
                                                           data-var="{$field.variable|regex_replace:'/[^a-z0-9A-Z_-]/':''}"
                                                           data-var-name="{$field.name|escape}"
                                                           data-var-id="{$field.id}"
                                                           id="configvar_{$field.variable|regex_replace:'/[^a-z0-9A-Z_-]/':''}"
                                                           value="{$field.id}"/>
                                                {/if}
                                            </td>
                                            <td width="200" style="background:#F0F0F3;color:#767679;font-size:11px"
                                                valign="top">
                                                <div class="">
                                                    Field type:
                                                    <strong>
                                                        {if $lang[$field.type.langid]}{$lang[$field.type.langid]}
                                                        {else}{$field.type.type}
                                                        {/if}
                                                    </strong>
                                                </div>
                                                {if $field.group_id}
                                                    <div class="">
                                                        Form group:
                                                        <a target="_blank" href="?cmd=formgroups&action=form_group&id={$field.group_id}">{$field.group_name}</a>
                                                    </div>
                                                {/if}
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        {else}
            <div class="blank_state_smaller blank_forms">
                <div class="blank_info">
                    <h3>{$lang.formsbs}</h3>
                    <span class="fs11">{$lang.bsdescription}</span>
                    <div class="clear"></div>
                    <br/>
                    <a href="#" class="new_control" onclick="return addCustomFieldForm({$product_id});">
                        <span class="addsth"><strong>{$lang.assign_custom_opt}</strong></span>
                    </a>
                    <span class="orspace">{$lang.Or}</span>
                    <a href="#" class="new_control" onclick="$('#importforms').show(); return false">
                        <span class="disk-import">Import</span>
                    </a>
                    <a href="#" class="new_control" onclick="return copyCustomFieldForm({$product_id});">
                        <span class="duplicatesth" style="background-position: left center; padding-left: 15px;">Copy from product</span>
                    </a>
                    <div class="clear">

                    </div>

                </div>
            </div>
        {/if}
        {literal}
        <script type="text/x-handlebars-template" id="config-var-tpl">
            <em class="fs11 form-var-active">
                Set by client using
                <a href="#" title="Edit" onclick="return editCustomFieldForm({{varId}},{{product_id}});">
                    Forms: {{varName}}
                </a>
                (<a href="?cmd=configfields&make=delete&id={{varId}}&product_id={{product_id}}" class="editbtn"
                    onclick="deleteItemConfCat(this); return false;">remove</a>)
            </em>
        </script>

        <script type="text/javascript">
            function saveOrder2() {
                var sorts = $('#customitemseditor input.ser2').serialize();
                ajax_update('?cmd=configfields&action=changeorder&' + sorts, {});
            }
            ;

            function latebindme() {
                $("#grab-sorter").dragsort({
                    dragSelector: "a.sorter-ha",
                    dragBetween: false,
                    dragEnd: saveOrder,
                    placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
                });
                $("#customitemseditor").dragsort({
                    dragSelector: "a.sorter-ha",
                    dragBetween: false,
                    dragEnd: saveOrder2,
                    placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
                });
            }

            if (typeof saveOrder == 'function' && typeof $("#customitemseditor").dragsort == 'function') {
                latebindme();
            }

            function refreshConfigView(pid) {
                if (pid)
                    ajax_update("?cmd=configfields", {action: "loadproduct", product_id: pid}, '#configeditor_content');
                return false;
            }

            function addCustomFieldForm(pid) {
                $.facebox({
                    ajax: "?cmd=configfields&action=addconfig&product_id=" + pid,
                    width: 900,
                    nofooter: true,
                    opacity: 0.5,
                    addclass: 'modernfacebox'
                });
                return false;
            }

            function previewCustomForm(url) {
                $.facebox({ajax: url, width: 900, nofooter: true, opacity: 0.5, addclass: 'modernfacebox'});
                return false;

            }

            function editCustomFieldForm(id, pid) {
                $.facebox({
                    ajax: "?cmd=configfields&action=field&id=" + id + "&product_id=" + pid + '&paytype=' + $('input[name=paytype]:checked').val(),
                    width: 900,
                    nofooter: true,
                    opacity: 0.5,
                    addclass: 'modernfacebox'
                });
                return false;
            }

            function duplicateCustomFieldForm(id, pid) {
                ajax_update("?cmd=configfields&action=duplicatefield&id=" + id + "&product_id=" + pid, {}, function () {
                    refreshConfigView(pid);
                });

                return false;
            }

            function deleteItemConf(el) {
                if (confirm('{/literal}{$lang.delconf2}{literal}')) {
                    ajax_update($(el).attr('href'), {}, '#configeditor_content');

                }
                return false;
            }

            function deleteItemConfCat(el) {
                if (confirm('{/literal}{$lang.delconf1}{literal}')) {
                    var href = $(el).attr('href'),
                        id = href.match(/[?&]id=(\d+)/);

                    if(id){
                        destroyProductOptionForm(id[1]);
                    }
                    ajax_update(href, {}, '#configeditor_content');
                }
                return false;
            }

            function destroyProductOptionForm(id){
                var conf = $('.config-var[value='+id+']');
                if(!conf.length)
                    return false;

                var cfdata = conf.data(),
                    config = $('#config_' + cfdata.var);

                if(!config.length)
                    return false;

                config.find('.form-var-old').show();
                config.find('.form-var-active').remove();
                config.find('input.formchecker').prop('checked',false);
                config.find('a.orspace').remove();
            }

            var confvattpl = Handlebars.compile(document.getElementById('config-var-tpl').innerHTML);

            function initItemConfCat() {
                $('.config-var').each(function () {
                    var cfdata = $(this).data(),
                        config = $('#config_' + cfdata.var),
                        metered = $('#checkb_' + cfdata.var);

                    cfdata.product_id = $('#product_id').val();
                    if(metered.length) {
                        metered.attr('checked','checked');
                    }
                    if (!config.length) {
                        return;
                    }

                    var old = config.find('.form-var-old'),
                        actv = config.find('.form-var-active');



                    if(actv.length)
                        return;

                    if(old.length){
                        old.hide()
                    }else{
                        config.children().wrap('<div class="form-var-old" style="display: none;"></div>');
                    }

                    config.append(confvattpl(cfdata));
                    $('#config_' + cfdata.var + '_descr').hide();
                })
            }

            function copyCustomFieldForm(pid) {
                $.facebox({
                    ajax: "?cmd=configfields&action=getduplicateform&product_id=" + pid,
                    width: 900,
                    nofooter: true,
                    opacity: 0.5,
                    addclass: 'modernfacebox'
                });
                return false;
            }

            $(function () {
                initItemConfCat();
            })
            {/literal}
        </script>


        {if $config}
            <div style="padding:10px 4px">
                <a href="#" class="new_control" onclick="return addCustomFieldForm({$product_id});" id="addnew_conf_btn">
                    <span class="addsth"><strong>{$lang.assign_custom_opt}</strong></span>
                </a>
                <script type="text/javascript">$('#preview_forms_shelf').show();</script>
                <a href="?cmd=configfields&product_id={$product_id}&action=previewfields" class="new_control" onclick="return previewCustomForm($(this).attr('href'))"><span class="zoom">{$lang.Preview}</span></a>
                <a href="?cmd=configfields&action=export&id={$product_id}" class="new_control" target="_blank">
                    <span class="disk-export">Export</span>
                </a>
                <a href="#" class="new_control" onclick="$('#importforms').show(); return false">
                    <span class="disk-import">Import from file</span>
                </a>
                <a href="#" class="new_control" onclick="return copyCustomFieldForm({$product_id});">
                    <span class="duplicatesth" style="background-position: left center; padding-left: 15px;">Copy from product</span>
                </a>
            </div>
        {/if}
    </div>
{elseif $action=='previewfields'}
    <div id="formloader" style="background:#fff;padding:10px;">

        <link href="{$template_dir}css/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all"/>
        {if $custom}
            <table border="0" width="100%" cellspacing="0" cellpadding="3">
                {foreach from=$custom item=cf}
                    {if $cf.items}
                        <tr>
                            <td colspan="2" class="{$cf.key} cf_option">

                                <label for="custom[{$cf.id}]" class="styled"><b>{$cf.name} {if $cf.options &1}*{/if}</b></label><br/>
                                {if $cf.description!=''}
                                    <div class="fs11 descr" style="color:#808080">{$cf.description}</div>{/if}

                                {include file=$cf.configtemplates.cart}

                            </td>
                        </tr>
                    {/if}
                {/foreach}
            </table>
        {/if}
    </div>
    {if $ajax}
        <div class="dark_shelf dbottom">

            <div class="right">
                <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');
                            return false;"><span>{$lang.Close}</span></a></span>


            </div>
            <div class="clear"></div>
        </div>
    {/if}
{elseif $action=='field' || $action=='getaddform' || $action=='duplicatefield'}
    <div id="formloader">
        <form id="saveform" method="post" action="">
            <input type="hidden" name="type" value="{if $type}{$type}{else}{$field.type.type}{/if}"/>
            <input type="hidden" name="id" value="{$field.id}" id="field_category_id"/>
            <input type="hidden" name="make" value="{if $field.id=='new'}addfield{else}editfield{/if}"/>
            <input type="hidden" name="action" value="field"/>
            <input type="hidden" name="product_id" value="{$product_id}"/>


            <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td width="140" id="s_menu" style="" valign="top">
                        <div id="lefthandmenu">
                            <a class="tchoice" {if $field.group_options & 1} data-warnmessage="1" {/if} href="#Basic">Basic settings</a>
                            {if $field.type.info.subitems}
                                <a class="tchoice" {if $field.group_options & 16} data-warnmessage="1" {/if} href="#Values">Values</a>
                            {/if}
                            {if $field.type.info.pricing && !$field.type.info.subitems}
                                <a class="tchoice" {if $field.group_options & 2} data-warnmessage="1" {/if} href="#Pricing">Pricing</a>
                            {/if}
                            {if $field.type.info.validation}
                                <a class="tchoice" {if $field.group_options & 8} data-warnmessage="1" {/if} href="#Validation">Validation</a>
                            {/if}
                            <a class="tchoice" {if $field.group_options & 4} data-warnmessage="1" {/if} href="#Advanced">Advanced</a>
                            {foreach from=$field.type.templates item=tp key=tpname}
                                <a class="tchoice" {if $field.group_options & 8} data-warnmessage="1" {/if} href="#{$tpname}">{$tpname}</a>
                            {/foreach}

                        </div>
                    </td>
                    <td class="conv_content form {if $field.group_id} assigned_group {/if}" valign="top">
                        <div class="tabb">
                            <input type="hidden" name="copy_of" value="{$field.copy_of}"/>
                            <h3 style="margin-bottom:0px;">
                                <img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png"
                                     alt="" style="margin-right:5px" class="left"/>
                                {if $lang[$field.type.langid]}{$lang[$field.type.langid]}
                                {else}{$field.type.type}
                                {/if}
                                &raquo; Basic settings
                            </h3>
                            <div class="clear">
                                <small>{$lang[$field.type.description]}</small>
                            </div>

                            <div style="display:none;" class="clear alert alert-danger" id="lengthwarning">
                                Your php.ini setting <b>max_input_vars</b> is too low to properly save this form element.
                                <a href="http://wiki.hostbillapp.com/index.php?title=Forms:_Fix_not_saving_forms_configuration" target="_blank">How to fix this.</a>
                            </div>

                            <div class="clear">
                                <label class="nodescr">Field name</label>
                                {hbinput value=$field.tag_name
                                class="w250" name="name" style="margin:0px;"  wrapper="div"  wrapper_class="w250 left"
                                wrapper_style="clear:right;margin: 2px 0 10px 10px;"}
                            </div>

                            <div class="clear">
                                <label for="check-required">Required field</label>
                                <input id="check-required" type="checkbox" name="options[]" value="1" {if $field.options & 1}checked="checked"{/if}/>
                            </div>
                            <div class="clear">
                                <label>Description</label>
                                <div class="" style="display:block;margin: 2px 0 10px 10px;">
                                    {if $field.description!=''}
                                        {hbwysiwyg value=$field.tag_description style="margin:0px;width:250px" blockwysiwyg="true" class="w250"  name="description" wrapper_id="prod_desc_cx" wrapper="div"  wrapper_class="w250 left" wrapper_style="clear:right;margin: 2px 0 10px 10px;"}
                                    {else}
                                        <a href="#" onclick="$(this).hide();$('#prod_desc_cx').show();return false;" style="padding-left:10px;">
                                            <strong>{$lang.adddescription}</strong>
                                        </a>
                                        {hbwysiwyg value=$field.tag_description style="margin:0px;width:250px" class="inp wysiw_editor"
                                        name="description" blockwysiwyg="true" wrapper_id="prod_desc_cx" wrapper="div"
                                        wrapper_class="w250 left" wrapper_style="display:none;clear:right;margin: 2px 0 10px 10px;"}
                                    {/if}
                                </div>
                            </div>
                            <div class="clear">
                                <label class="nodescr" for="group_id">Form group</label>
                                <select id="field-type" name="group_id">
                                    <option value="0">--None--</option>
                                {foreach from=$form_groups item=gr}
                                    <option value="{$gr.id}" {if $gr.id == $field.group_id}selected{/if}>{$gr.name}</option>
                                {/foreach}
                                </select>
                            </div>
                        </div>

                        {if $field.type.info.subitems}
                            <div class="tabb" style="display:none">
                                <h3>
                                    <img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png"
                                         alt="" style="margin-right:5px" class="left"/>
                                    {if $lang[$field.type.langid]}{$lang[$field.type.langid]}
                                    {else}{$field.type.type}
                                    {/if} &raquo; Values
                                </h3>

                                <div id="subitems_editor">
                                    {include file='ajax.configdrawsort.tpl'}
                                </div>

                            </div>
                        {/if}

                        {if $field.type.info.pricing && !$field.type.info.subitems}
                            <div class="tabb" style="display:none">
                                <h3>
                                    <img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"/>
                                    {if $lang[$field.type.langid]}{$lang[$field.type.langid]}
                                    {else}{$field.type.type}
                                    {/if} &raquo; Pricing
                                </h3>
                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="items[{$k}][pricing]" value="1"
                                                   {if $field.items[0].pricing_enabled}checked="checked"{/if}
                                                   onclick="$('.formbilling, .pricingtable', '#facebox').toggle()"/>
                                            <strong>{$lang.enablepricing}</strong>
                                        </label>
                                        <div class="help-block">
                                            {$lang.chargeforvalue}
                                        </div>
                                    </div>
                                </div>
                                {foreach from=$field.items item=item key=k}
                                    <div class="formbilling formbilling-head" {if !$field.items[0].pricing_enabled}style="display: none"{/if}>
                                        <a href="#{$paytypeform}" {if !$item.paytype || $item.paytype == $paytypeform}class="active"{/if}onclick="formbilling(this);return false">Regular</a>
                                        {foreach from=$field.type.info.adformbilling item=formbilling}
                                            <a href="#{$formbilling}" {if $item.paytype == $formbilling}class="active"{/if} onclick="formbilling(this);return false">
                                                {if $lang[$formbilling]}{$lang[$formbilling]}
                                                {else}{$formbilling}
                                                {/if}
                                            </a>
                                        {/foreach}
                                    </div>
                                    <div class="clearfix formbilling" id="formbilling" {if !$field.items[0].pricing_enabled}style="display: none"{/if}>
                                        <input type="hidden" name="items[{$k}][id]" value="{$item.id}"/>
                                        <input type="hidden" name="items[{$k}][copy_of]" value="{$item.copy_of}"/>
                                        <input type="hidden" name="items[{$k}][group_id]" value="{$item.group_id}"/>
                                        <input class="formbilling-paytype" type="hidden" name="items[{$k}][paytype]" value="{$item.paytype}"/>
                                        <div id="formbilling_{$paytypeform}" {if $item.paytype && $item.paytype != $paytypeform}style="display: none"{/if}>
                                            {if $paytypeform}
                                                {include file="formbilling_`$paytypeform`.tpl"}
                                            {else}
                                                {include file='formbilling_Regular.tpl'}
                                            {/if}
                                        </div>
                                        {if $field.type.info.adformbilling}
                                            {foreach from=$field.type.info.adformbilling item=formbilling}
                                                <div id="formbilling_{$formbilling}" {if $item.paytype != $formbilling}style="display: none"{/if}>
                                                    {include file="formbilling_`$formbilling`.tpl"}
                                                </div>
                                            {/foreach}
                                        {/if}
                                    </div>
                                {/foreach}
                            </div>
                            <script type="text/javascript">updatePricingForms();</script>
                        {/if}
                        {if $field.type.info.validation}
                            <div class="tabb" style="display:none">
                                <h3>
                                    <img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png"
                                         alt="" style="margin-right:5px"
                                         class="left"/> {if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if}
                                    &raquo; Validation
                                </h3>
                                <div class="clear">
                                    <label>Minimum value
                                        <small>must be greater than or equal to this value</small>
                                    </label>
                                    <input type="text" size="4" name="config[minvalue]" id="configMinvalue"
                                           value="{$field.config.minvalue}"/>
                                </div>
                                <div class="clear">
                                    <label>Maximum value
                                        <small>Leave blank for no limit</small>
                                    </label>
                                    <input type="text" size="4" name="config[maxvalue]" id="configMaxvalue"
                                           value="{$field.config.maxvalue}"/>
                                </div>
                            </div>
                        {/if}
                        <div class="tabb config-fields-advanced" style="display:none">
                            <h3>
                                <img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"/>
                                {if $lang[$field.type.langid]}{$lang[$field.type.langid]}
                                {else}{$field.type.type}
                                {/if} &raquo; Advanced settings
                            </h3>
                            {if $types}
                                <div class="clear">
                                    <label class="nodescr" for="field-type">Field Type</label>
                                    <select id="field-type" name="type" style="margin: 2px 0 10px 10px;">
                                        {foreach from=$types item=ft}
                                            <option value="{$ft.type}" {if $ft.type == $field.type.type}selected{/if}>
                                                {if $lang[$ft.langid]}{$lang[$ft.langid]}
                                                {else}{$ft.type}
                                                {/if}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            {/if}
                            <div class="clear">
                                <label for="css-text-key">
                                    CSS Class
                                    <small>
                                        Field container will be displayed with this css class
                                    </small>
                                </label>
                                <input id="css-text-key" type="text" class="w250" name="key" value="{$field.key|escape}"/>
                            </div>
                            <div class="clear">
                                <label for="text-category">
                                    Group
                                    <small>Supported by some order pages to group options</small>
                                </label>
                                <input id="text-category" type="text" class="w250" name="category" value="{$field.category|escape}"/>
                            </div>
                            <div class="clear">
                                <label for="text-variable">
                                    Variable name
                                    <small>To use in emails, custom modules</small>
                                </label>
                                <input id="text-variable" type="text" class="w250" name="variable" value="{$field.variable|escape}"/>
                            </div>
                            <div class="clear form-settings">
                                <div class="row no-gutter">
                                    <div class="col-md-4">
                                        <label for="check-admin">
                                            Admin only
                                            <small>Only admin can see this field</small>
                                        </label>
                                        <input id="check-admin" type="checkbox" name="options[]" value="4" {if $field.options & 4}checked="checked"{/if}/>
                                    </div>
                                    {if $field.type.info.upgrades}
                                        <div class="col-md-4">

                                            <label for="check-upgrade">
                                                Allow Upgrades
                                                <small>Can client upgrade after order</small>
                                            </label>
                                            <input id="check-upgrade" class="check-clientarea" type="checkbox" name="options[]" value="16" {if $field.options & 16 || ($field.options=='')}checked="checked"{/if}/>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="clear"></div>
                                            <label for="check-down">
                                                Allow Downgrades
                                                <small>Can client downgrade this field</small>
                                            </label>
                                            <input id="check-down" class="check-clientarea" type="checkbox" name="options[]" value="32" {if $field.options & 32 || ($field.options=='')}checked="checked"{/if}/>
                                        </div>
                                    {/if}
                                    <div class="col-md-4">
                                        <label for="check-show">Show in cart
                                            <small>
                                                Display this option during order
                                            </small>
                                        </label>
                                        <input id="check-show" class="check-clientarea" type="checkbox" name="options[]" value="2" {if $field.options & 2 || ($field.options=='')}checked="checked"{/if}/>

                                    </div>

                                    {if $field.type.info.clientedit }
                                        <div class="col-md-4">
                                            <label for="check-edit">
                                                Client edit
                                                <small>
                                                    Allow edit this field by client after order
                                                    using Client Function
                                                </small>
                                            </label>
                                            <input id="check-edit" class="check-clientarea" type="checkbox" name="options[]" value="8" {if $field.options & 8}checked="checked"{/if}/>
                                        </div>
                                    {/if}

                                    {if $field.type.info.pricing || $field.type.info.subitems}
                                        <div class="col-md-4">
                                            <label for="check-no-discount">
                                                Don't discount
                                                <small>
                                                    When enabled promocodes will not
                                                    discount this field
                                                </small>
                                            </label>
                                            <input id="check-no-discount" class="check-clientarea" type="checkbox" name="options[]" value="512" {if $field.options & 512}checked="checked"{/if}/>
                                        </div>
                                    {/if}

                                    {if $field.type.info.searchable }
                                        <div class="col-md-4">
                                            <label for="check-searchable">
                                                Searchable
                                                <small>
                                                    Make value of this field searchable
                                                </small>
                                            </label>
                                            <input id="check-searchable" type="checkbox" name="options[]" value="1024" {if $field.options & 1024}checked="checked"{/if}/>
                                        </div>
                                    {/if}
                                    <div class="col-md-4">
                                        <label for="check-invoice">
                                            Show in Invoice
                                            <small>
                                                When to add field description to invoice line
                                            </small>
                                        </label>
                                        <select name="options[]">
                                            <option value="" >
                                                Default - show when priced or enabled in cart and not empty
                                            </option>
                                            <option value="4096" {if $field.options & 4096}selected{/if}>
                                                Priced - show when selected value isn't free
                                            </option>
                                            <option value="256" {if $field.options & 256}selected{/if}>
                                                Force - show even when it's empty or free
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                {if $field.type.info.upgrades}
                                    <div class="row no-gutter">
                                        <div class="col-md-4">
                                            <label for="check-charge">
                                                Upgrade setup fee
                                                <small>
                                                    Charge setup fee on upgrades&nbsp;or&nbsp;downgrades
                                                </small>
                                            </label>
                                            <select id="check-charge" class="check-clientarea inp" name="options[]" >
                                                <option value="" {if !($field.options & 64) && !($field.options & 128) }selected="selected"{/if}>No</option>
                                                <option value="64" {if $field.options & 64 }selected="selected"{/if}>Price difference</option>
                                                <option value="192" {if ($field.options & 192) == 192 }selected="selected"{/if}>Full</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="css-text-key">
                                                Upgrade fee
                                                <small>
                                                    Set to non-zero value for additional flat upgrade charge
                                                </small>
                                            </label>
                                            <input id="upgrade-fee" type="text" size="3" name="config[upgradefee]" value="{$field.config.upgradefee|price:$currency:0}"/>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="css-text-key">
                                                Downgrade fee
                                                <small>
                                                    Set to non-zero value for additional flat downgrade charge
                                                </small>
                                            </label>
                                            <input id="downgrade-fee" type="text" size="3" name="config[downgradefee]" value="{$field.config.downgradefee|price:$currency:0}"/>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="check-charge">
                                                Upgrade pro-rata
                                                <small>
                                                    Calculate prorata on upgrades&nbsp;or&nbsp;downgrades
                                                </small>
                                            </label>
                                            <select id="check-prorata" class="check-clientarea inp"
                                                    name="options[]" >
                                                <option value=""
                                                        {if !($field.options & 2048) }selected="selected"{/if}>
                                                    Yes
                                                </option>
                                                <option value="2048"
                                                        {if ($field.options & 2048) == 2048 }selected="selected"{/if}>No
                                                </option>
                                            </select>
                                        </div>
                                    </div>



                                {/if}
                            </div>
                        </div>

                        {foreach from=$field.type.templates item=tp key=tpname}
                            <div class="tabb" style="display:none">
                                <h3>
                                    <img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"/>
                                    {if $lang[$field.type.langid]}{$lang[$field.type.langid]}
                                    {else}{$field.type.type}
                                    {/if} &raquo; {$tpname}
                                </h3>
                                {include file=$tp}
                            </div>
                        {/foreach}

                        {if $field.group_id}
                            <div class="alert alert-warning group_warn_message" style="display: none;">
                                <b>Note!</b> This form field is assigned to the form group. Changes made here will be duplicated in other fields in group.
                                <a href="?cmd=formgroups&action=form_group&id={$field.group_id}" target="_blank">Go to group</a>
                            </div>
                        {/if}
                    </td>
                </tr>
            </table>
            {securitytoken}
        </form>
    </div>
{literal}
    <script type="text/javascript">
        (function () {

            var inputvars = {/literal}{$max_input_vars|default:-1}{literal};
            if (inputvars >= 0) {
                var inputs = $('input,select', '#facebox').length;
                if (inputs > inputvars)
                    $('#lengthwarning').show();
            }

            var lastTab = $('#facebox').data('last-tab'),
                picked = lastTab ? $('#lefthandmenu a[href="' + lastTab + '"]').index() || 0 : 0;

            $('#lefthandmenu').TabbedMenu({elem: '.tabb', picked: picked});
            $('#check-admin').on('change', function () {
                $('.check-clientarea').prop('disabled', this.checked);
            }).trigger('change');

            $('#lefthandmenu .tchoice').on('click', function () {
                $('.group_warn_message').hide();
                if ($(this).attr('data-warnmessage') == '1') {
                    $('.group_warn_message').show();
                }
            });
            $('#lefthandmenu .tchoice.picked').trigger('click');
        })()
    </script>
{/literal}
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            {if $field.id!='new'}
                <span class="bcontainer ">
                    <a href="?cmd=configfields&product_id={$product_id}&action=previewfields&highlight={$field.id}"
                       class="new_control" target="_blank">
                        <span class="zoom">{$lang.Preview}</span>
                    </a>
                </span>
            {/if}
            <span class="bcontainer ">
                <a class="new_control greenbtn" href="#" onclick="saveChangesField();
                                            return false"><span>{$lang.savechanges}</span>
                </a>
            </span>
            <span>{$lang.Or}</span>
            <span class="bcontainer">
                <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');
                                        return false;">
                    <span>{$lang.Close}</span>
                </a>
            </span>


        </div>
        <div class="clear"></div>
    </div>
{elseif $action=='getduplicateform'}
    <div id="formloader">
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td width="180" id="s_menu" style="padding-top:40px;" valign="top">
                    <div id="initial-desc">To save time you can use one fields you've configured before</div>
                </td>
                <td class="conv_content" valign="top">
                    <h3>Duplicate existing field</h3>
                    {if $fields}
                        <div class="form" style="margin-top: 20px;">
                            <form id="duplicatefield" class="form-horizontal container-fluid" action="" method="post">
                                <input type="hidden" name="product_id" value="{$product_id}"/>
                                <input type="hidden" name="action" value="duplicatefield"/>
                                <input type="hidden" name="cmd" value="configfields"/>
                                <input type="hidden" name="type" value="{$type}"/>
                                <div class="form-group row">
                                    <div class="col-sm-3">
                                        <label for="dup_category_select">Category</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select class="form-control chosen" data-chosen data-placeholder="Select category" id="dup_category_select">
                                            <option disabled="disabled" selected="selected">--Select category--</option>
                                            {foreach from=$fields.categories item=cat}
                                                <option value="{$cat.id}">{$cat.name|escape}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row" style="display: none">
                                    <div class="col-sm-3">
                                        <label for="dup_product_select">Product</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select name="from_product_id" class="form-control chosen" data-chosen data-placeholder="Select product" id="dup_product_select">
                                            <option disabled="disabled" selected="selected">--Select product--</option>
                                            {foreach from=$fields.products item=prod}
                                                <option data-parent="{$prod.parent_id}" disabled="disabled" value="{$prod.id}">{$prod.name|escape}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row" style="display: none">
                                    <div class="col-sm-3">
                                        <label for="dup_form_select">Form</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select name="id" class="form-control chosen" data-chosen data-placeholder="Select form" id="dup_form_select">
                                            <option disabled="disabled" selected="selected">--Select form--</option>
                                            <option value="selectall">--Select all--</option>
                                            {foreach from=$fields.forms item=form}
                                                <option data-parent="{$form.parent_id}" disabled="disabled" value="{$form.id}">{$form.name|escape}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                {securitytoken}
                            </form>
                            {literal}
                                <script>
                                    //chosen-container-active chosen-with-drop
                                    bindParseDuplicateForm();
                                </script>
                                <style>
                                    #duplicatefield .disabled-result {
                                        display: none;
                                    }
                                </style>
                            {/literal}
                        </div>
                    {else}
                        <form id="addform" method="post" action="">
                            <input type="hidden" name="product_id" value="{$product_id}"/>
                            <input type="hidden" name="type" value="{$type}"/>
                            <input type="hidden" name="cmd" value="configfields"/>
                            <input type="hidden" name="action" value="getaddform"/>
                            {securitytoken}
                        </form>
                        <div>
                            There is no field of this type added yet<br/>
                            <a href="#" onclick="return createField()">{$lang.createnewcfield}</a>
                        </div>
                    {/if}
                </td>
            </tr>
        </table>
    </div>
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            {if $fields}
                <span class="bcontainer">
                    <a href="#" class="new_control greenbtn" onclick="return duplicateFieldSubmit()">
                        <span>{$lang.Duplicate}</span>
                    </a>
                </span>
                <span class="">{$lang.Or}</span>
            {/if}
            <span class="bcontainer">
                <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;">
                    <span>{$lang.Close}</span>
                </a>
            </span>
        </div>
        <div class="clear"></div>
    </div>
{elseif $action=='addconfig'}
    <div id="formcontainer">
        <form id="addform" method="post" action="">
            <input type="hidden" name="product_id" value="{$product_id}"/>
            <input type="hidden" name="type" value=""/>
            <input type="hidden" name="cmd" value="configfields"/>
            <input type="hidden" name="action" value="getaddform"/>
            <input type="hidden" name="premade" value="" id="premade_to_fill"/>
            <input type="hidden" name="premadeurl" value="" id="premadeurl_to_fill"/>
            {securitytoken}</form>
        <form id="duplicateform" method="post" action="">
            <input type="hidden" name="product_id" value="{$product_id}"/>
            <input type="hidden" name="type" value=""/>
            <input type="hidden" name="cmd" value="configfields"/>
            <input type="hidden" name="action" value="getduplicateform"/>
            {securitytoken}</form>
        <div id="formloader" class="form-horizontal">
            <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td width="180" id="s_menu" style="" valign="top">
                        <div id="initial-desc">Start by selecting field type, you will be able to configure it, add
                            pricing, validation etc. in next steps.
                        </div>
                        {foreach from=$fields item=f key=ft}{foreach from=$f item=field}
                            <div style="display:none" class="description" id="{$field.type}-description">{$lang[$field.description]}</div>
                        {/foreach}{/foreach}
                        {foreach from=$fields item=f key=ft}{foreach from=$f item=field}
                            <div class="descr_image" id="{$field.type}-descr_image" style="display:none;background:url('{$field.image}') no-repeat top left;"></div>
                        {/foreach}{/foreach}
                    </td>
                    <td class="conv_content" valign="top">
                        <h3>
                            Select field type
                        </h3>
                        {foreach from=$fields item=f key=ft}
                            <fieldset>
                                <legend>{$lang[$ft]}</legend>
                                {foreach from=$f item=field}
                                    <div class="fselect">
                                        <input type="radio" value="{$field.type}" name="type" id="field{$field.type}" onclick="fieldclick('{$field.type}');"/>
                                        <label for="field{$field.type}">{if $lang[$field.langid]}{$lang[$field.langid]}{else}{$field.type}{/if}</label>
                                    </div>
                                {/foreach}
                                <div class="clear"></div>
                            </fieldset>
                        {/foreach}
                        <div class="form shownice tabb" id="premadeloader" style="display:none"></div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="dark_shelf dbottom">
            <div class="left spinner"><img src="ajax-loading2.gif"></div>
            <div class="right">
                <span class="bcontainer dhidden" style="display:none">
                    <a class="new_control greenbtn" href="#" onclick="return createField()">
                        <span>{$lang.createnewcfield}</span>
                    </a>
                </span>
                <span class="bcontainer dhidden" style="display:none"><a href="#" class="submiter menuitm" onclick="return duplicateField()">
                        <span>Duplicate existing field</span>
                    </a>
                </span>
                <span class="dhidden" style="display:none">{$lang.Or}</span>
                <span class="bcontainer">
                    <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox'); return false;">
                        <span>{$lang.Close}</span>
                    </a>
                </span>
            </div>
            <div class="clear"></div>
        </div>
    </div>
{elseif $action=='helper'}
    {if $do=='getotherfields'}
        {if $fields}
            <select style="margin: 26px 0px 0px;;float:left;" id="condition_field_target" name="config[conditional][new][target]" onchange="$('#condition_field_targetname').val($('#condition_field_target option[value=' + $(this).val() + ']').text());">
                {foreach from=$fields item=f}
                    <option value="{$f.copy_of}">{$f.name}</option>
                {/foreach}
            </select>
            <input type="hidden" name="config[conditional][new][targetname]" id="condition_field_targetname" value="{$fields[0].name|escape}"/>
        {else}
            Add other fields first.
        {/if}
        {if $fields && $setval}
            <div class="padding:5px 2px;float:left">To</div>
            <input type="text" size="3" id="condition_field_value" style="margin:0px;float:left;" name="config[conditional][new][targetval]"/>
        {/if}
    {/if}
{/if}