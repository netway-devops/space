{if $action=='field'}
    <div id="formcontainer">
        <div id="formloader">
            <form method="post" action="" id="submitform">
                <input type="hidden" name="make" value="{if $field.id=='new'}add{else}update{/if}"/>
                <input type="hidden" name="field_id" value="{$field.id}"/>
                <input type="hidden" name="id" value="{$field.id}"/>


                <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
                    <tr>
                        <td width="140" id="s_menu" style="" valign="top">
                            <div id="lefthandmenu">
                                <a class="tchoice" href="#">General settings</a>
                                <a class="tchoice" href="#">Advanced</a>
                            </div>
                        </td>
                        <td class="conv_content" valign="top">
                            <div class="tabb">
                                <h3 style="margin-bottom:0px;">General field settings</h3>
                                {if $field.options & 1}
                                    <div class="clear">
                                        <small>This is default HostBill field, it will appear as
                                            <b>{$lang[$field.code]}</b>, you can remove it or replace with custom field
                                        </small>
                                    </div>
                                {/if}
                                <hr/>

                                <div class="form-group">
                                    <label>{$lang.fieldname}</label>
                                    {if $field.options & 1}
                                        {hbinput value=$lang[$field.code]  class="form-control" disabled="disabled" pretag=$field.code}
                                        <input type="hidden" value="{$field.name}" name="name"/>
                                    {else}
                                        {hbinput value=$field.tag_name class="form-control" name="name"}
                                    {/if}
                                </div>

                                <div class="form-group">
                                    <label>Group</label>
                                    <select name="group_id" class="form-control">
                                        <option value="">--{$lang.none}--</option>
                                        {foreach from=$field_groups item=group}
                                            <option value="{$group.id}" {if $group.id == $field.group_id}selected="selected"{/if}>{$group.display_name}</option>
                                        {/foreach}
                                    </select>
                                </div>

                                {if !($field.options & 1)}
                                    <div class="form-group">
                                        <label>{$lang.appliesto}</label>
                                        <select name="type" class="form-control">
                                            <option value="All" {if $field.type=='All'}selected="selected"{/if}>{$lang.All}</option>
                                            <option value="Private" {if $field.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                                            <option value="Company" {if $field.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        {if $field.id=='new'}
                                            <label>{$lang.fieldtype}</label>
                                            <select name="field_type" id="field-type" class="form-control">
                                                <option value="Input" {if $field.field_type=='Input'}selected="selected"{/if}>{$lang.Input}</option>
                                                <option value="Check" {if $field.field_type=='Check'}selected="selected"{/if}>{$lang.Check}</option>
                                                <option value="Select" {if $field.field_type=='Select'}selected="selected"{/if}>{$lang.Select}</option>
                                                <option value="Encrypted" {if $field.field_type=='Encrypted'}selected="selected"{/if}>{$lang.Encrypted}</option>
                                                <option value="File" {if $field.field_type=='File'}selected="selected"{/if}>{$lang.fileupload}</option>
                                                <option value="Contact" {if $field.field_type=='Contact'}selected="selected"{/if}>{$lang.Contact}</option>
                                                <option value="Phonenumber" {if $field.field_type=='Phonenumber'}selected="selected"{/if}>{$lang.phonenumber}</option>
                                            </select>
                                        {elseif $field.field_type === 'Input' || $field.field_type === 'Phonenumber'}
                                            <label>{$lang.fieldtype}</label>
                                            <select name="field_type" id="field-type" class="form-control">
                                                <option value="Input" {if $field.field_type=='Input'}selected="selected"{/if}>{$lang.Input}</option>
                                                <option value="Phonenumber" {if $field.field_type=='Phonenumber'}selected="selected"{/if}>{$lang.phonenumber}</option>
                                            </select>
                                        {else}
                                            <input type="hidden" name="field_type" id="field-type" value="{$field.field_type}">
                                            <label>{$lang.fieldtype}:</label>
                                            <span>{$field.field_type}</span>
                                        {/if}
                                    </div>
                                    <div class="form-group" id="form-extension">
                                        <label>Allowed attachment extension</label>
                                        <input name="extensions" value="{if $field.expression}{$field.expression|escape}{else}.jpg;.gif;.png;.pdf{/if}" type="text" class="form-control"/>
                                        <small class="helper-block">Separate with semicolon (;). <b>Example</b>: .jpg;.gif;.png</small>
                                    </div>
                                    <div class="form-group" id="form-default-value">
                                        <label>Values</label>
                                        <input name="default_value" value="{$field.default_value|escape}" type="text" class="form-control"/>
                                        <small class="helper-block">Separate with semicolon (;)</small>
                                    </div>
                                {elseif $field.field_type === 'Input' || $field.field_type === 'Phonenumber'}
                                    <input type="hidden" name="type" value="{$field.type}" />
                                    <div class="form-group">
                                        <label>{$lang.fieldtype}</label>
                                        <select name="field_type" id="field-type" class="form-control">
                                            <option value="Input" {if $field.field_type=='Input'}selected="selected"{/if}>{$lang.Input}</option>
                                            <option value="Phonenumber" {if $field.field_type=='Phonenumber'}selected="selected"{/if}>{$lang.phonenumber}</option>
                                        </select>
                                    </div>
                                {else}
                                    <input type="hidden" name="type" value="{$field.type}" />
                                    <input type="hidden" value="{$field.field_type}" id="field-type"/>
                                {/if}

                                <div class="form-group" id="form-placeholder">
                                    <label>Placeholder</label>
                                    {hbinput value=$field.tag_placeholder class="form-control" name="placeholder"}
                                </div>

                                {if !($field.options & 256)}
                                    <div class="checkbox">
                                        <label>
                                            <input id="check-required" type="checkbox" name="options[]" value="2"
                                                   {if $field.options & 2}checked="checked"{/if} {if $field.options & 4096}disabled{/if}/>
                                            {$lang.requiredf}
                                        </label>
                                    </div>
                                {else}
                                    <input type="hidden" name="options[]" value="2" style="display:none"/>
                                {/if}

                                <div class="form-group">
                                    <label>Description</label>
                                    {if $field.description!=''}
                                        {hbwysiwyg value=$field.tag_description  blockwysiwyg="true" wrapper="div"
                                        class="form-control wysiw_editor" name="description"}
                                    {else}
                                        <a href="#" onclick="$(this).hide();
                                            $('#prod_desc_c').show();
                                            return false;" style="padding-left:10px;">
                                            <strong>{$lang.adddescription}</strong>
                                        </a>
                                        {hbwysiwyg value=$field.tag_description blockwysiwyg="true"
                                        class="form-control wysiw_editor" name="description"
                                        wrapper_id="prod_desc_c" wrapper="div" wrapper_style="display:none;"}
                                    {/if}
                                </div>

                                {if $field.code=='type'}
                                    <div class="form-group">
                                        <label>Default value</label>
                                        <select name="default_value" id="default_value" class="form-control">
                                            <option value="Private" {if $field.default_value=='Private'}selected="selected"{/if}>Private</option>
                                            <option value="Company" {if $field.default_value=='Company'}selected="selected"{/if}>Organization</option>
                                        </select>
                                    </div>
                                {/if}
                            </div>

                            <div class="tabb" style="display:none;overflow:visible">
                                <h3>Advanced configuration</h3>
                                <hr/>

                                <div class="form-group">
                                    <label>Variable name</label>
                                    <input type="text" class="form-control" name="code"
                                           value="{$field.code}" {if ($field.options & 1)} disabled="disabled" {/if} />
                                    <small>Variable name under which field value will appear in $client data. This can
                                        be used in templates and plugins.
                                    </small>
                                </div>

                                {if !($field.options & 1)}
                                    <div class="checkbox">
                                        <label>
                                            <input id="check-invoice" type="checkbox" name="options[]" value="4"
                                                   {if $field.options & 4}checked="checked"{/if} />
                                            Show on invoice, field value will appear on client invoices.
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input id="check-hidecontacts" type="checkbox" name="options[]" value="512" {if $field.options & 512}checked="checked"{/if} />
                                            Hide for contacts, field will not be visible during client's contact
                                            add/edit
                                        </label>
                                    </div>
                                {/if}

                                <div class="checkbox">
                                    <label>
                                        <input id="check-editable" type="checkbox" name="options[]" value="8"
                                               {if $field.options & 8}checked="checked"{/if}/>
                                        Allow client to edit this field after sign-up
                                    </label>
                                </div>

                                {if !($field.code == 'type')}

                                <div class="checkbox">
                                    <label>
                                        <input id="check-searchable" type="checkbox" name="options[]" value="1024" {if $field.field_type =='Encrypted'}disabled{/if}
                                                {if $field.code == 'firstname' || $field.code == 'lastname' || $field.code == 'email' || $field.code == 'companyname'}
                                            checked="checked" disabled="disabled"
                                                {elseif $field.options & 1024}checked="checked"{/if}/>
                                        Include in search and allow filtering clients by value from this field.
                                    </label>
                                </div>

                                <div class="checkbox">
                                    <label>
                                        <input id="check-adminonly" type="checkbox" name="options[]" value="128"
                                               {if $field.options & 128}checked="checked"{/if}
                                               onclick="$('#check-required, #check-editable, #check-invoice, #check-ordering').prop('checked', !$(this).is(':checked')).prop('disabled', $(this).is(':checked')); $('#check-noregister, #check-ordering').prop('checked', false).prop('disabled', $(this).is(':checked'));"/>
                                        Admin only, this field will be visible only in admin area
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input id="check-noregister" type="checkbox" name="options[]" value="4096"
                                               {if $field.options & 4096}checked="checked"{/if} {if $field.options & 128}disabled{/if}
                                        onclick="$('#check-required').prop('checked', !$(this).is(':checked')).prop('disabled', $(this).is(':checked'));"/>
                                        Hide this field from signup, but make available during edit
                                    </label>
                                </div>

                                {if $field.code!='country' && $field.code!='password' && $field.code!='password2' &&
                                $field.code!='firstname' && $field.code!='lastname' && $field.code!='city' && $field.code!='state' && $field.code!='postcode'}
                                    <div class="checkbox">
                                        <label>
                                            <input id="check-uniquevalue" type="checkbox" name="options[]" value="2048" {if $field.field_type =='Encrypted'}disabled{/if}
                                                   {if $field.options & 2048}checked="checked"{/if}/>
                                            Require unique value for this field
                                        </label>
                                    </div>
                                {/if}
                                <div class="checkbox">
                                    <label>
                                        <input id="check-ordering" type="checkbox" name="options[]" value="8192"
                                               {if $field.options & 8192}checked="checked"{/if}/>
                                        Hide this field in client information when ordering
                                    </label>
                                </div>

                                    {if $field.field_type == "Input"  ||   $field.field_type == "Encrypted"}
                                        <div class="checkbox">
                                            <label>
                                                <input id="check-hideadmin" type="checkbox" name="options[]" value="16384"
                                                       {if $field.options & 16384}checked="checked"{/if}/>
                                                Hide this field from client profile in admin UI
                                            </label>
                                        </div>
                                    {/if}
                                {if $field.code!='country'}
                                    <div class="form-group">
                                        <label>Limit for countries</label>
                                        <select name="country[]" id="countryselector" multiple="multiple">
                                            {foreach from=$countries item=country key=c}
                                                <option value="{$c}"
                                                        {if $field.countries[$c]}selected="selected"{/if}>{$country}</option>
                                            {/foreach}
                                        </select>
                                        <small class="help-block">Select countries this field will appear for</small>
                                    </div>
                                {/if}



                                <div class="form-group" id="form-expression">
                                    <label>Validation pattern</label>
                                    <input id="expression" type="text" name="expression" value="{$field.expression}" class="form-control"/>
                                    <select name="premade_pattern" id="premade_pattern" onchange="$('#expression').val($(this).val());" class="form-control" style="display:none">
                                        <option value="">---select---</option>
                                        <option value="{literal}/^\d{1,3}$/{/literal}">Number 1-3 digits in
                                            length
                                        </option>
                                        <option value="{literal}/^(0?[1-9]|1[012])[\/](0?[1-9]|[12][0-9]|3[01])[\/](19|20)\d\d$/{/literal}">
                                            Date in mm/dd/yyyy
                                        </option>
                                        <option value="{literal}/^(19|20)\d\d[\/](0?[1-9]|1[012])[\/](0?[1-9]|[12][0-9]|3[01])$/{/literal}">
                                            Date in yyyy/mm/dd
                                        </option>
                                        <option value="{literal}/^(0?[1-9]|[12][0-9]|3[01])[\/](0?[1-9]|1[012])[\/](19|20)\d\d$/{/literal}">
                                            Date in dd/mm/yyyy
                                        </option>
                                        <option value="{literal}/^((\(\d{3}\) ?)|(\d{3}[-\s]))?\d{3}[-\s]\d{4}$/{/literal}">
                                            US Phone number
                                        </option>
                                        <option value="{literal}/^\d{5}([\-]\d{4}){0,1}$/{/literal}">US Zip
                                            Code
                                        </option>
                                    </select>

                                    <span class="pull-right">
                                        <a href="#" class="editbtn"
                                           onclick="$(this).hide(); $('#premade_pattern').show(); $('#expression').hide(); return false;">
                                            Premade patterns
                                        </a>
                                    </span>

                                    <small class="help-block">RegEx to validate this field with</small>

                                </div>

                                {/if}
                            </div>
                        </td>
                    </tr>
                </table>
                {securitytoken}
            </form>
        </div>
        {literal}
        <script type="text/javascript">
            $('#countryselector').chosenedge({width: '100%'});
            $('#lefthandmenu').TabbedMenu({
                elem: '.tabb'{/literal}{if $picked_tab},
                picked:{$picked_tab}{/if}{literal}});

            $('#field-type').on('change', function () {
                var val = $(this).val();
                $('#form-default-value').toggle(val != 'Input');
                $('#form-placeholder').toggle(val == 'Input' || val == 'Phonenumber');

                if (val == 'File') {
                    $('#form-default-value').hide();
                    $('#form-extension').show();
                    $('#check-hidecontacts').prop('disabled',true).closest('.checkbox').hide();
                    $('#form-expression').hide();
                } else if (val == 'Contact') {
                    $('#form-default-value').hide();
                    $('#form-extension').hide();
                    $('#check-hidecontacts').prop('disabled',true).closest('.checkbox').hide();
                    $('#check-noregister').prop('disabled',true).closest('.checkbox').hide();
                } else  if (val == 'Encrypted') {
                    $('#form-default-value').show();
                    $('#form-extension').hide();
                    $('#check-uniquevalue').prop('disabled',false);
                    $('#check-searchable').prop('disabled',false);
                    $('#form-expression').show();
                } else {
                    $('#form-default-value').show();
                    $('#form-extension').hide();
                    $('#check-hidecontacts').prop('disabled',false).closest('.checkbox').show();
                    $('#form-expression').show();
                }
            }).trigger('change');

        </script>
        {/literal}
        <div class="dark_shelf dbottom">
            <div class="left spinner"><img src="ajax-loading2.gif"></div>
            <div class="right">

                <span class="bcontainer">
                    <a class="new_control greenbtn" href="#"
                                            onclick="return createField()">
                        <span>{if $field.id=='new'}{$lang.submit}{else}{$lang.savechanges}{/if}</span>
                    </a>
                </span>
                <span class="dhidden">{$lang.Or}</span>
                <span class="bcontainer">
                    <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');
                        return false;">
                        <span>{$lang.Close}</span>
                    </a>
                </span>
            </div>
            <div class="clear"></div>
        </div>
    </div>
{elseif $action=='fieldgroups'}
    <div id="formcontainer">
        <div id="formloader">
            <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td class="conv_content" valign="top">
                        <div class="tabb">
                            <h3 style="margin-bottom:0px;">Manage field groups</h3>
                            <hr/>
                            <a href="#" class="btn btn-default btn-sm btnNewGroup">Add new group</a>
                            <form class="fg-add-group" style="display:none;">
                                <div class="form-group">
                                    <label>Group name</label>
                                    {hbinput class="form-control" name="name"}
                                </div>
                                <div class="form-group">
                                    <label>Description</label>
                                    {hbwysiwyg  blockwysiwyg="true" wrapper="div"
                                    class="form-control wysiw_editor" name="description"}
                                </div>
                                <button type="submit" class="btn btn-primary btn-sm addFieldGroup" style="margin: 10px 0;">Add group</button>
                                {securitytoken}
                            </form>
                            <hr>
                                <div class="table-responsive table-borders">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach from=$groups item=group}
                                            <tr>
                                                <td width="30%">
                                                    <span class="fg_visible">{$group.display_name}</span>
                                                    <span class="fg_hidden" style="display: none;">
                                                        {hbinput value=$group.name class="form-control" name="name" placeholder="Name"}
                                                    </span>
                                                </td>
                                                <td width="55%">
                                                    <span class="fg_visible">{$group.display_description}</span>
                                                    <span class="fg_hidden" style="display: none;">
                                                        {hbwysiwyg value=$group.description  blockwysiwyg="true" wrapper="div"
                                                        class="form-control wysiw_editor" name="description" placeholder="Description"}
                                                    </span>
                                                </td>
                                                <td width="150">
                                                    {securitytoken}
                                                    <input type="hidden" name="group_id" value="{$group.id}">
                                                    <button class="btn btn-sm btn-primary editFieldGroup">Edit</button>
                                                    <button class="btn btn-sm btn-success saveFieldGroup" style="display: none;">Save</button>
                                                    <button class="btn btn-sm btn-danger deleteFieldGroup">Delete</button>
                                                </td>
                                            </tr>
                                        {foreachelse}
                                            <tr>
                                                <td colspan="3" class="text-center" align="center">Nothing found</td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        {literal}
            <script>
                $('.addFieldGroup').click(function () {
                    var btn = $(this);
                    var row = $(btn).closest('.fg-add-group');
                    $(btn).prop('disabled',true);
                    $.post('?cmd=clients&action=fieldgroups', {
                        make: 'add',
                        group: {
                            name: $(row).find('[name="name"]').val(),
                            description: $(row).find('[name="description"]').val(),
                        }
                    }, function (data) {
                        var h = parse_response(data);
                        manageFieldGroups();
                    });
                });
                $('.editFieldGroup').click(function () {
                    $(this).closest('tr').find('.fg_visible').hide();
                    $(this).closest('tr').find('.fg_hidden').show();
                    $(this).closest('tr').find('.editFieldGroup, .deleteFieldGroup').hide();
                    $(this).closest('tr').find('.saveFieldGroup').prop('disabled',false).show();
                });
                $('.saveFieldGroup').click(function () {
                    var btn = $(this);
                    var row = $(btn).closest('tr');
                    $(btn).prop('disabled',true);
                    $.post('?cmd=clients&action=fieldgroups', {
                        make: 'edit',
                        group: {
                            id: $(row).find('[name="group_id"]').val(),
                            name: $(row).find('[name="name"]').val(),
                            description: $(row).find('[name="description"]').val(),
                        }
                    }, function (data) {
                        var h = parse_response(data);
                        updateListing();
                        manageFieldGroups();
                    });
                });
                $('.deleteFieldGroup').click(function () {
                    if (!confirm('Are you sure?'))
                        return false;

                    var btn = $(this);
                    var row = $(this).closest('tr');
                    $(btn).prop('disabled',true);
                    $(this).prop('disabled',true);
                    $.post('?cmd=clients&action=fieldgroups', {
                        make: 'delete',
                        group_id: $(row).find('[name="group_id"]').val()
                    }, function (data) {
                        var h = parse_response(data);
                        updateListing();
                        manageFieldGroups();
                    });
                });
                $('.btnNewGroup').click(function (e) {
                    e.preventDefault();
                    $('.fg-add-group').show();
                    $(this).remove();
                    return false;
                });
            </script>
        {/literal}
        <div class="dark_shelf dbottom">
            <div class="left spinner"><img src="ajax-loading2.gif"></div>
            <div class="right">
                <span class="bcontainer">
                    <a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox'); return false;">
                        <span>{$lang.Close}</span>
                    </a>
                </span>
            </div>
            <div class="clear"></div>
        </div>
    </div>
{elseif $action=='fields'}
{if !$ajax}
{literal}
    <style type="text/css">
        .pricingtable input {
            float: none !important;
            margin: 0px !important;
        }
    </style>
{/literal}
    <div id="customcontainer">
        {/if}
        <div class="blu">
            <div class="left menubar">
                <a onclick="addCustomFieldForm();return false;" class="new_control" href="#"><span class="addsth"><strong>{$lang.addnewfield}</strong></span></a>
                <a class="new_control" href="#" onclick="manageFieldGroups();return false;"><span class="editsth">&nbsp; <strong>Manage field groups</strong></span></a>
                {if $premade}
                    <a onclick="$('#premadefields').toggle();return false;" class="new_control" href="#"><span class="dwd"><strong>Premade field profiles</strong></span></a>
                {/if}
                <a class="new_control" href="{$system_url}?cmd=signup" target="_blank"><span class="zoom">{$lang.Preview}</span></a>
            </div>
            <div class="clear"></div>
        </div>

        <div style="padding:15px;">
            {if $premade}
                <div class="p6" id="premadefields" style="margin-bottom:15px;display:none;">
                    <form onsubmit="return confirm('Are you sure? It will overwrite your current fields');"
                          method="post" action="">
                        <input type="hidden" name="make" value="usepremade"/>
                        <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                            <tbody>
                                <tr>
                                    <td>
                                        Profile: <select class="submitme" name="premade" onchange="$('.pdescriptions').hide();
                                                    $('#pdescription' + $(this).attr('selectedIndex')).show();">
                                            {foreach from=$premade item=p}
                                                <option value="{$p.file}"> {$p.name} </option>
                                            {/foreach}
                                        </select>
                                    </td>
                                    <td>
                                        <input type="submit" style="font-weight:bold" value="Use it">
                                        <span class="orspace">{$lang.Or}</span> <a class="editbtn" onclick="$('#premadefields').hide();
                                                    return false;" href="#">{$lang.Cancel}</a>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                        {foreach from=$premade item=p name=premadelist key=k}
                            <span class="pdescriptions fs11" id="pdescription{$k}"
                                  {if $smarty.foreach.premadelist.first}{else}style="display:none"{/if}><b>{$lang.Description}
                                    :</b> {$p.description} </span>
                        {/foreach}
                        {securitytoken}
                    </form>
                </div>
            {/if}

            <form id="serializeit">
                <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
                    {foreach from=$fields item=field name=fff}
                        <li style="background:#ffffff">
                            <div style="border-bottom:solid 1px #ddd;">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tbody>
                                        <tr class="havecontrols">
                                            {if $field.options & 1}
                                                <td width="120"
                                                    style="{if ($field.options & 16) || ($field.options & 256)}background:#F0F0F3;color:#767679;{/if}padding-left: 10px">
                                                    <div class="btn-group">
                                                        <a class="sorter-ha btn btn-sm btn-default">
                                                            <i class="fa fa-sort"></i>
                                                        </a>
                                                        {if !($field.options & 16)}
                                                            <a class="menuitm btn btn-sm btn-default"
                                                               href="?cmd=clients&action=field&field_id={$field.id}"
                                                               onclick="return editFieldForm('{$field.id}');"
                                                               title="Edit">
                                                                <i class="fa fa-pencil"></i>
                                                            </a>
                                                        {/if}
                                                        {if $field.options & 32}
                                                            <a class="menuitm btn btn-sm btn-default" title="Enable"
                                                               href="?cmd=clients&action=fields&make=delete&field_id={$field.id}"
                                                               onclick="return enable_field('{$field.id}');"><i
                                                                        class="fa fa-toggle-off"></i>
                                                            </a>
                                                        {elseif !($field.options & 64)}
                                                            <a class="menuitm menu-auto" title="Disable"
                                                               href="?cmd=clients&action=fields&make=delete&field_id={$field.id}&system=1"
                                                               onclick="return disable_field('{$field.id}');">
                                                                <i class="fa fa-toggle-on"></i>
                                                            </a>
                                                        {/if}
                                                    </div>
                                                </td>
                                                <td style="{if ($field.options & 16) || ($field.options & 256)}background:#F0F0F3;color:#767679;{/if}{if $field.options & 32}font-style:italic;color:#767679{/if}">
                                                    <input type="hidden" name="sort[]" value="{$field.id}"/>

                                                    {if $lang[$field.code]}
                                                        {$lang[$field.code]}
                                                    {else}
                                                        {$field.name}
                                                    {/if}
                                                    {if $field.code=='type'}
                                                        <em>(Allow client to choose between Company and No-Company
                                                            profile) </em>
                                                    {/if}

                                                </td>
                                            {else}
                                                <td width="120" style="padding-left: 10px">
                                                    <div class="btn-group">
                                                        <a class="sorter-ha btn btn-sm btn-default">
                                                            <i class="fa fa-sort"></i>
                                                        </a>
                                                        {if !($field.options & 16)}
                                                            <a class="menuitm btn btn-sm btn-default"
                                                               href="?cmd=clients&action=field&field_id={$field.id}"
                                                               onclick="return editFieldForm('{$field.id}');"
                                                               title="edit">
                                                                <i class="fa fa-pencil"></i>
                                                            </a>
                                                        {/if}

                                                        {if !($field.options & 64)}
                                                            <a class="btn btn-default btn-sm" title="Delete"
                                                               href="?cmd=clients&action=fields&make=delete&field_id={$field.id}"
                                                               onclick="return delete_field('{$field.id}', 0);"><i
                                                                        class="fa fa-trash-o"></i>
                                                            </a>
                                                        {/if}
                                                    </div>
                                                </td>
                                                <td>
                                                    <input type="hidden" name="sort[]" value="{$field.id}"/>{$field.name}
                                                </td>
                                            {/if}
                                            <td width="300" style="background:#F0F0F3;color:#767679;font-size:12px">
                                                <div style="padding:5px">
                                                    Group: <b>{$field.group_name|default:"-"}</b><br/>
                                                </div>
                                            </td>
                                            <td width="150" style="background:#F0F0F3;color:#767679;font-size:11px">
                                                <div style="padding:5px">
                                                    {$lang.fieldtype}: <b>{if $field.field_type=='Phonenumber'}{$lang.phonenumber}{else}{$lang[$field.field_type]}{/if}</b><br/>
                                                    {$lang.appliesto}: <b>{$lang[$field.type]}</b><br/>
                                                    {if $field.country}For countries: <b>{$field.country|substr_withdots:0:20}</b>{/if}
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </li>
                    {/foreach}
                </ul>
                {securitytoken}
            </form>
        </div>
        {if !$ajax}
    </div>
    <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
{literal}
    <script type="text/javascript">
        function bindSortOrder() {
            $("#grab-sorter").dragsort({
                dragSelector: "a.sorter-ha",
                dragBetween: true,
                dragEnd: saveOrder,
                placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
            });
        }

        bindSortOrder();

        function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=clients&action=listfields&' + sorts, {});
        }
        ;
    </script>
    <script type="text/javascript">
        function shf(id, el) {
            if ($(el).val() == 'Input') {
                $('#dcb').hide();
                $('#' + id).hide();
            } else {
                $('#' + id).show();
                $('#dcb').show();
            }
        }

        function updateListing() {
            $('#customcontainer').addLoader();
            ajax_update('?cmd=clients&action=fields', {updatecontainer: 1}, function () {
                $('#customcontainer').html(this.resp);
                bindSortOrder();
            });
            $('#facebox .body .content').html("");
        }

        function createField() {
            ajax_update('?cmd=clients&action=field', $('#submitform').serializeObject(), '#facebox .body .content');
            return false;
        }

        function editFieldForm(id) {
            $.facebox({
                ajax: "?cmd=clients&action=field&field_id=" + id,
                width: 900,
                nofooter: true,
                opacity: 0.5,
                addclass: 'modernfacebox'
            });
            return false;
        }

        function addCustomFieldForm() {
            $.facebox({
                ajax: "?cmd=clients&action=field&field_id=new",
                width: 900,
                nofooter: true,
                opacity: 0.5,
                addclass: 'modernfacebox'
            });
            return false;
        }

        function disable_field(id) {
            $('#customcontainer').addLoader();
            ajax_update('?cmd=clients&action=fields&make=delete&field_id=' + id, {updatecontainer: 1}, function () {
                $('#customcontainer').html(this.resp);
                bindSortOrder();
            });
            return false;
        }

        function enable_field(id) {
            $('#customcontainer').addLoader();
            ajax_update('?cmd=clients&action=fields&make=enable&field_id=' + id, {updatecontainer: 1}, function () {
                $('#customcontainer').html(this.resp);
                bindSortOrder();
            });
            return false;
        }

        function delete_field(id, system) {
            if (confirm('{/literal}{$lang.confdelf}{literal}')) {
                $('#customcontainer').addLoader();
                ajax_update('?cmd=clients&action=fields&make=delete&field_id=' + id, {
                    updatecontainer: 1,
                    system: system
                }, function () {
                    $('#customcontainer').html(this.resp);
                    bindSortOrder();
                });
            }
            return false;
        }

        function manageFieldGroups() {
            $.facebox({
                ajax: "?cmd=clients&action=fieldgroups",
                width: 900,
                nofooter: true,
                opacity: 0.5,
                addclass: 'modernfacebox'
            });
            return false;
        }

    </script>
{/literal}
{/if}
{/if}