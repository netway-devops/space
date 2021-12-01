<script type="text/javascript" src="{$template_dir}js/formgroups.js?v={$hb_version}"></script>
<form method="post">
    <input type="hidden" name="make" value="{if $group.id && $group.id != 'new'}edit{else}add{/if}"/>
    <div class="lighterblue2">
        <div class="row">
            <div class="col-md-6">
                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    <tr>
                        <td width="200" align="right"><strong>Name</strong></td>
                        <td>
                            <input type="text" name="name" id="name" style="font-weight:bold; width: 100%;"
                                   value="{$group.name}" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <td width="200" align="right"><strong>Description</strong></a></td>
                        <td>
                            <textarea name="description" rows="10" style="width: 100%;"
                            >{if $group.description}{$group.description}{/if}</textarea>
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
                            <span>
                                If change the name, or add a new option, this operation will be
                                repeated in the related forms
                            </span>
                        </span>
                        <input type="checkbox" class="can_view" {if in_array(16,$group.flags)}
                            checked="checked" {/if} name="flags[]" value="16" /> Items basic
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                           <span>
                                Linking the variables items to each other. For example,
                                if change the variable name from centos-7 to centos-71,
                                in all related items variable name will be changed to centos-71.
                           </span>
                        </span>
                        <input type="checkbox" class="if_can_view" {if in_array(32,$group.flags)} checked="checked" {/if} name="flags[]" value="32" /> Items variables
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                           <span>
                                If the price of some items has been changed,
                                then related items in other forms from the group will also have edited pricing
                           </span>
                        </span>
                        <input type="checkbox" class="if_can_view" {if in_array(64,$group.flags)} checked="checked" {/if} name="flags[]" value="64" /> Items pricing
                    </div>
                    <div class="checkbox">
                        <span class="vtip_description" style="margin-right: 25px;">
                            <span>
                                Removing item from form will propagate to other forms in this group
                            </span>
                        </span>
                        <input type="checkbox" class="if_can_view" {if in_array(128,$group.flags)} checked="checked" {/if} name="flags[]" value="128" /> Items deletion
                    </div>
                </div>
            </div>
        </div>
        <div id="form_item_group_applies">
            {include file="formgroups/ajax.form_item_group_applies.tpl"}
        </div>
    </div>
    {literal}
        <style>
            .section-applies {
                max-height: 800px;
                overflow-y: auto;
                overflow-x: hidden;
            }
        </style>
    {/literal}
    <div class="blu">
        <table border="0" cellpadding="2" cellspacing="0">
            <tr>
                <td>
                    <button type="submit" class="btn btn-primary">
                        {if $action=='add_form_item_group'}Add group{else}Save changes{/if}
                    </button>
                </td>
            </tr>
        </table>
    </div>
    {securitytoken}
</form>