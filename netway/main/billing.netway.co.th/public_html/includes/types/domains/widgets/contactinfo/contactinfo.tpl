<div class="wbox" id="contactinfoeditor">
    <div class="wbox_header">{$lang.contactinfo}:</div>
    <div  class="wbox_content">
        <form action="" method="post">
            <input type="hidden" name="submit" value="1" />
            <input type="hidden" name="widgetdo" value="updateContactInfo" />
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
                <tr  class="even">
                    <td align="right" width="160"><strong>{$lang.registrantinfo}</strong></td>
                    <td >
                        <input type="radio" {if !$ContactInfo.registrant.action}checked="checked"{/if}  name="updateContactInfo[registrant][action]" value="custom" id="registrant_action_custom" onclick="sh_contacts('registrant', true);"/> <label for="registrant_action_custom">{$lang.custom}</label>
                        <input type="radio" {if $ContactInfo.registrant.action=='premade'}checked="checked"{/if} name="updateContactInfo[registrant][action]" value="premade" id="registrant_action_premade"  onclick="sh_contacts('registrant', false, true);" /> <label for="registrant_action_premade">{$lang.usefollowingcontact}</label>
                        <select class="form-control w-auto d-inline-block" name="updateContactInfo[registrant][contactid]" onchange="contact_change(this)" id="registrant_contactid">
                            {foreach from=$premadecontact item=p}
                                <option value="{$p.id}" {if $ContactInfo.registrant.contactid==$p.id}selected="selected"{/if}>{if $p.maincontact}{$lang.maincontact}{/if} {$p.firstname} {$p.lastname}</option>
                            {/foreach}
                            <option value="new" style="font-weight:bold;">{$lang.createnewcontact}</option>
                        </select>
                    </td>
                </tr>
                <tbody id="registrant_preview" style="display:none;background:#f9f9f9">
                    <tr><td></td><td class="fs11" style="color:#505050"></td></tr>
                </tbody>
                {include file="`$widgetdir`/form.tpl" info=$ContactInfo.registrant type=registrant}
                {if $ContactInfo.admin}
                <tr  class="even">
                    <td align="right" width="160"><strong>{$lang.admincontact}</strong></td>
                    <td >
                        <input type="radio" {if !$ContactInfo.admin.action}checked="checked"{/if} name="updateContactInfo[admin][action]" value="custom" id="admin_action_custom" onclick="sh_contacts('admin', true);"/> <label for="admin_action_custom">{$lang.custom}</label>
                        <input {if $ContactInfo.admin.action=='registrant'}checked="checked"{/if} type="radio" name="updateContactInfo[admin][action]" value="registrant" id="admin_action_registrant" onclick="sh_contacts('admin', false);"/> <label for="admin_action_registrant">{$lang.sameasreg}</label>
                        <input type="radio" {if $ContactInfo.admin.action=='premade'}checked="checked"{/if} name="updateContactInfo[admin][action]" value="premade" id="admin_action_premade"  onclick="sh_contacts('admin', false, true);" /> <label for="admin_action_premade">{$lang.usefollowingcontact}</label>
                        <select class="form-control w-auto d-inline-block" name="updateContactInfo[admin][contactid]" onchange="contact_change(this)" id="admin_contactid">
                            {foreach from=$premadecontact item=p}
                                <option value="{$p.id}"  {if $ContactInfo.admin.contactid==$p.id}selected="selected"{/if}>{if $p.maincontact}{$lang.maincontact}{/if} {$p.firstname} {$p.lastname}</option>
                            {/foreach}
                            <option value="new" style="font-weight:bold;">{$lang.createnewcontact}</option>
                        </select>
                    </td>
                </tr>
                <tbody id="admin_preview" style="display:none;background:#f9f9f9">
                    <tr><td></td><td class="fs11" style="color:#505050"></td></tr>
                </tbody>
                {include file="`$widgetdir`/form.tpl" info=$ContactInfo.admin type=admin}
                {/if}
                {if $ContactInfo.tech}
                <tr  class="even">
                    <td align="right" width="160"><strong>{$lang.techinfo}</strong></td>
                    <td >
                        <input {if !$ContactInfo.tech.action}checked="checked"{/if} type="radio" name="updateContactInfo[tech][action]" value="custom" id="tech_action_custom" onclick="sh_contacts('tech', true);"/> <label for="tech_action_custom">{$lang.custom}</label>
                        <input {if $ContactInfo.tech.action=='registrant'}checked="checked"{/if} type="radio" name="updateContactInfo[tech][action]" value="registrant" id="tech_action_registrant" onclick="sh_contacts('tech', false);"/> <label for="tech_action_registrant">{$lang.sameasreg}</label>
                        <input type="radio" {if $ContactInfo.tech.action=='premade'}checked="checked"{/if} name="updateContactInfo[tech][action]" value="premade" id="tech_action_premade"  onclick="sh_contacts('tech', false, true);" /> <label for="tech_action_premade">{$lang.usefollowingcontact}</label>
                        <select class="form-control w-auto d-inline-block" name="updateContactInfo[tech][contactid]" onchange="contact_change(this)" id="tech_contactid">
                            {foreach from=$premadecontact item=p}
                                <option value="{$p.id}"  {if $ContactInfo.tech.contactid==$p.id}selected="selected"{/if}>{if $p.maincontact}{$lang.maincontact}{/if} {$p.firstname} {$p.lastname}</option>
                            {/foreach}
                            <option value="new" style="font-weight:bold;">{$lang.createnewcontact}</option>
                        </select>
                    </td>
                </tr>

                <tbody id="tech_preview" style="display:none;background:#f9f9f9">
                    <tr><td></td><td class="fs11" style="color:#505050"></td></tr>
                </tbody>
                {include file="`$widgetdir`/form.tpl" info=$ContactInfo.tech type=tech}
                {/if}

                {if $ContactInfo.billing}
                <tr  class="even">
                    <td align="right" width="160"><strong>{$lang.billinginfo}</strong></td>
                    <td >
                        <input {if !$ContactInfo.billing.action}checked="checked"{/if} type="radio" name="updateContactInfo[billing][action]" value="custom" id="billing_action_custom" onclick="sh_contacts('billing', true);"/> <label for="billing_action_custom">{$lang.custom}</label>
                        <input {if $ContactInfo.billing.action=='registrant'}checked="checked"{/if} type="radio" name="updateContactInfo[billing][action]" value="registrant" id="billing_action_registrant" onclick="sh_contacts('billing', false);"/> <label for="billing_action_registrant">{$lang.sameasreg}</label>
                        <input type="radio" {if $ContactInfo.billing.action=='premade'}checked="checked"{/if} name="updateContactInfo[billing][action]" value="premade" id="billing_action_premade"  onclick="sh_contacts('billing', false, true);" /> <label for="billing_action_premade">{$lang.usefollowingcontact}</label>
                        <select class="form-control w-auto d-inline-block" name="updateContactInfo[billing][contactid]" onchange="contact_change(this)" id="billing_contactid">
                            {foreach from=$premadecontact item=p}
                                <option value="{$p.id}"  {if $ContactInfo.billing.contactid==$p.id}selected="selected"{/if}>{if $p.maincontact}{$lang.maincontact}{/if} {$p.firstname} {$p.lastname}</option>
                            {/foreach}
                            <option value="new" style="font-weight:bold;">{$lang.createnewcontact}</option>
                        </select>
                    </td>
                </tr>
                <tbody id="billing_preview" style="display:none;background:#f9f9f9">
                    <tr><td></td><td class="fs11" style="color:#505050"></td></tr>
                </tbody>
                {include file="`$widgetdir`/form.tpl" info=$ContactInfo.billing type=billing}
                {/if}

                <tr  class="even"><td colspan="2" align="center"> <input type="submit" class=" btn btn-primary" value="{$lang.savechanges}" style="font-weight:bold"/>
                        <span class="fs11">{$lang.or}</span> <a href="{$ca_url}clientarea/domains/{if $details}{$details.id}/{$details.name}/{/if}" class="fs11">{$lang.cancel}</a></td></tr>
            </table>


        </form>
    </div>
</div>
<script type="text/javascript">
    {literal}
        function sh_contacts(c, a, t) {
            $('#' + c + '_preview').hide();
            if (a) {
                $('#' + c + '_contact').show();
            } else {
                $('#' + c + '_contact').hide();
                if (t) {
                    //load preview
                    $('#' + c + '_preview td').html('');
                    ajax_update('?cmd=profiles&action=preview', {id: $('#' + c + '_contactid').val()}, '#' + c + '_preview td.fs11');
                    $('#' + c + '_preview').show();
                }

            }
        }
        function contact_change(el) {
            if ($(el).val() == 'new') {
                window.location = '?cmd=profiles&action=add';
            } else {
                var i = $(el).attr('id').split("_");
                var c = i[0];
                if (!c)
                    return false;
                if (!$('#' + c + '_action_premade').is(':checked'))
                    return false;
                $('#' + c + '_preview td').html('');
                ajax_update('?cmd=profiles&action=preview', {id: $('#' + c + '_contactid').val()}, '#' + c + '_preview td.fs11');
                $('#' + c + '_preview').show();
            }
        }


        $('#contactinfoeditor input[type=radio]:checked').click();
    {/literal}
</script>