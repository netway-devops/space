<script type="text/javascript" src="{$template_dir}js/formgroups.js?v={$hb_version}"></script>
<form method="post">
    <input type="hidden" name="make" value="{if $group.id && $group.id != 'new'}edit{else}add{/if}"/>
    <div class="lighterblue2">
        <div class="row">
            <div class="col-md-6">
                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    {if $group.id && $group.id !== 'new'}
                        <tr>
                            <td width="200" align="right">
                                <strong>Group type</strong>
                            </td>
                            <td>
                                {foreach from=$types key=groupname item=grouptypes}
                                    {foreach from=$grouptypes item=type}
                                        {if $group.type_id == $type.type_id}
                                            <b>{if $lang[$groupname]}{$lang[$groupname]}{else}{$groupname}{/if}: </b>
                                            <span id="type_name">
                                                {if $lang[$type.langid]}{$lang[$type.langid]}{else}{$type.type}{/if}
                                            </span>
                                        {/if}
                                    {/foreach}
                                {/foreach}
                                <input type="hidden" name="type_id" value="{$group.type_id}">
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td width="200" align="right">
                            <strong>Name</strong>
                        </td>
                        <td>
                            <input type="text" name="name" id="name" style="font-weight:bold; width: 100%;" value="{$group.name}" class="form-control">
                        </td>
                    </tr>
                    {if !$group.id || $group.id === 'new'}
                        <tr>
                            <td width="200" align="right">
                                <strong>Group type</strong>
                            </td>
                            <td>
                                <select name="type_id" class="form-control chosen" data-chosen data-placeholder="Group type" id="type_id">
                                    {foreach from=$types key=groupname item=grouptypes}
                                        <optgroup label="{if $lang[$groupname]}{$lang[$groupname]} {else}{$groupname} {/if}">
                                            {foreach from=$grouptypes item=type}
                                                <option {if $group.type_id == $type.type_id} selected="selected" {/if} value="{$type.type_id}">
                                                    {if $lang[$type.langid]}{$lang[$type.langid]}
                                                    {else}{$type.type}
                                                    {/if}
                                                </option>
                                            {/foreach}
                                        </optgroup>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td width="200" align="right"><strong>Description</strong></a></td>
                        <td>
                            <textarea name="description" rows="10" style="width: 100%; resize: vertical;">{if $group.description}{$group.description}{/if}</textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label>Apply flags:</label>
                    <div class="checkbox" style="margin: 15px 42px;">
                        <input type="checkbox" id="checkall" /> Check/Uncheck all
                    </div>
                    <div class="checkbox" style="margin-top: 0;">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>Linking the basic options of the form. Eg. "Names, required, description" etc.</span>
                        </span>
                        <input type="checkbox" {if in_array(1,$group.flags)} checked="checked" {/if} name="flags[]" value="1" /> Basic
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>Linking prices, if the form is single-item. Eg. for qty or sliders</span>
                        </span>
                        <input type="checkbox" {if in_array(2,$group.flags)} checked="checked" {/if} name="flags[]" value="2" /> Pricing
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>Linking all options from the "Advanced" tab
                                (upgrades, variable name, downgrades, etc.).</span>
                        </span>
                        <input type="checkbox" {if in_array(4,$group.flags)} checked="checked" {/if} name="flags[]" value="4" /> Advanced
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>
                                Linking all "config" options for a specific type. For example, for the slider
                                it will be "slider step, unit name, dont charge for default, min value, max value" etc.
                            </span>
                        </span>
                        <input type="checkbox" {if in_array(8,$group.flags)} checked="checked" {/if} name="flags[]" value="8" /> Specific
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>
                                If this is turned on, then deleting one thing that has a group assigned to it,
                                will carry out automatically removing from the database all other items that
                                are in this group.
                            </span>
                        </span>
                        <input type="checkbox" {if in_array(512,$group.flags)} checked="checked" {/if} name="flags[]" value="512" /> Deletion
                    </div>

                    <div class="checkbox" style="margin-top: 20px;">
                        <span class="vtip_description" style="margin-right: 25px;">
                           <span>
                                If change the name, or add a new option,
                                this operation will be repeated in the related forms
                           </span>
                        </span>
                        <input class="can_view" type="checkbox" {if in_array(16,$group.flags)} checked="checked" {/if} name="flags[]" value="16" /> Items basic
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>
                                Linking the variables items to each other. For example,
                                if change the variable name from centos-7 to centos-71,
                                in all related items variable name will be changed to centos-71.
                            </span>
                        </span>
                        <input class="if_can_view" type="checkbox" {if in_array(32,$group.flags)} checked="checked" {/if} name="flags[]" value="32" /> Items variables
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>
                                If the price of some items has been changed,
                                then related items in other forms from the group will also have edited pricing
                            </span>
                        </span>
                        <input class="if_can_view" type="checkbox" {if in_array(64,$group.flags)} checked="checked" {/if} name="flags[]" value="64" /> Items pricing
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;"></span>
                        <input class="if_can_view" type="checkbox" {if in_array(128,$group.flags)} checked="checked" {/if} name="flags[]" value="128" /> Items deletion
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>
                                After switching on, any changes in the field logic will be copied to
                                the remaining fields in the group.
                            </span>
                        </span>
                        <input class="if_can_view" type="checkbox" {if in_array(256,$group.flags)} checked="checked" {/if} name="flags[]" value="256" /> Field logic
                    </div>
                </div>
            </div>
        </div>
        <div id="form_group_applies">
            {include file="formgroups/ajax.form_group_applies.tpl"}
        </div>
    </div>
    {literal}
        <style>
            .section-applies {
                max-height: 800px;
                overflow-y: auto;
                overflow-x: hidden;
            }
            select#forms option[disabled] {
                display: none;
            }
            #forms_chosen .disabled-result {
                display: none;
            }
        </style>
    {/literal}
    <div class="blu">
        <table border="0" cellpadding="2" cellspacing="0">
            <tr>
                <td>
                    <button type="submit" class="btn btn-primary">{if $action=='add_form_group'}Add group{else}Save changes{/if}</button>
                </td>
            </tr>
        </table>
    </div>
    {securitytoken}
</form>