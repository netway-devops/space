<span class="domain-contact">
    <input type="checkbox" name="contacts[usemy]" value="1" {foreach from=$cart_contents[2] item=doms}{if !$doms.extended}checked="checked"{else}{assign value=$doms.extended var=set_contacts}{/if}{break}{/foreach} />
    {if $logged=="1"} {$lang.domcontact_loged}
    {else} {$lang.domcontact_checkout}
    {/if}
</span>
<div {if !$set_contacts}style="display: none;"{/if} id="newContacts">
    <div class="my-3 form-contact">
        <div class="form-inline">
            <div class="form-group">
                <label class="mr-3 justify-content-start" style="width: 240px;">{$lang.registrantinfo}</label>
                <select {if $logged!="1" || !$contacts}style="display:none"{/if} class="form-control contact-selection" name="contacts[registrant]">
                    <option value="new">{$lang.definenew}</option>
                    {if $logged=="1"}
                        {foreach from=$contacts item=contact name=contacts}
                            <option {if $set_contacts.registrant == $contact.id}selected="selected"{/if} value="{$contact.id}">
                                {if $contact.companyname}
                                    #{$smarty.foreach.contacts.index+1} {$contact.companyname}  ({$contact.email})
                                {else}
                                    #{$smarty.foreach.contacts.index+1} {$contact.firstname} {$contact.lastname}  ({$contact.email})
                                {/if}
                            </option>
                        {/foreach}
                    {/if}
                </select>
            </div>
        </div>
        <div class="sing-up my-4" data-c-type="registrant">
            {if is_array($set_contacts.registrant)}
                {include file="ajax.signup.tpl" submit=$set_contacts.registrant fields=$singupfields}
            {/if}
        </div>
    </div>
    <div  class="my-3 form-contact">
        <div class="form-inline">
            <div class="form-group">
                <label class="mr-3 justify-content-start" style="width: 240px;">{$lang.admininfo}</label>
                <select class="form-control contact-selection" name="contacts[admin]">
                    <option value="registrant">{$lang.useregistrant}</option>
                    <option {if is_array($fields.contacts.admin)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                    {if $logged=="1"}
                        {foreach from=$contacts item=contact}
                            <option {if $set_contacts.admin == $contact.id}selected="selected"{/if} value="{$contact.id}">
                                {if $contact.companyname}
                                    #{$smarty.foreach.contacts.index+1} {$contact.companyname}  ({$contact.email})
                                {else}
                                    #{$smarty.foreach.contacts.index+1} {$contact.firstname} {$contact.lastname}  ({$contact.email})
                                {/if}
                            </option>
                        {/foreach}
                    {/if}
                </select>
            </div>
        </div>
        <div class="sing-up my-4" data-c-type="admin">
            {if is_array($fields.contacts.admin)}
                {include file="ajax.signup.tpl" submit=$set_contacts.admin fields=$singupfields}
            {/if}
        </div>
    </div>
    <div class="my-3 form-contact">
        <div class="form-inline">
            <div class="form-group">
                <label class="mr-3 justify-content-start" style="width: 240px;">{$lang.techinfo}</label>
                <select class="form-control contact-selection" name="contacts[tech]">
                    <option value="registrant">{$lang.useregistrant}</option>
                    <option {if is_array($fields.contacts.tech)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                    {if $logged=="1"}
                        {foreach from=$contacts item=contact}
                            <option {if $set_contacts.tech == $contact.id}selected="selected"{/if} value="{$contact.id}">
                                {if $contact.companyname}
                                    #{$smarty.foreach.contacts.index+1} {$contact.companyname}  ({$contact.email})
                                {else}
                                    #{$smarty.foreach.contacts.index+1} {$contact.firstname} {$contact.lastname}  ({$contact.email})
                                {/if}
                            </option>
                        {/foreach}
                    {/if}
                </select>
            </div>
        </div>
        <div class="sing-up my-4" data-c-type="tech">
            {if is_array($fields.contacts.tech)}
                {include file="ajax.signup.tpl" submit=$set_contacts.tech fields=$singupfields}
            {/if}
        </div>
    </div>
    <div class="my-3 form-contact">
        <div class="form-inline">
            <div class="form-group">
                <label class="mr-3 justify-content-start" style="width: 240px;">{$lang.billinginfo}</label>
                <select class="form-control contact-selection" name="contacts[billing]">
                    <option value="registrant">{$lang.useregistrant}</option>
                    <option {if is_array($fields.contacts.billing)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                    {if $logged=="1"}
                        {foreach from=$contacts item=contact}
                            <option {if $set_contacts.billing == $contact.id}selected="selected"{/if} value="{$contact.id}">
                                {if $contact.companyname}
                                    #{$smarty.foreach.contacts.index+1} {$contact.companyname}  ({$contact.email})
                                {else}
                                    #{$smarty.foreach.contacts.index+1} {$contact.firstname} {$contact.lastname}  ({$contact.email})
                                {/if}
                            </option>
                        {/foreach}
                    {/if}
                </select>
            </div>
        </div>
        <div class="sing-up my-4" data-c-type="billing">
            {if is_array($fields.contacts.billing)}
                {include file="ajax.signup.tpl" submit=$set_contacts.billing fields=$singupfields}
            {/if}
        </div>
    </div>
</div>
{literal}
<script type="text/javascript">
    $(function () {
        var nc = $('#newContacts');
        function updateNames(form, prefix) {
            form.find('input, select, textarea').each(function () {
                var field = $(this);
                field.attr('name', prefix + '[' + field.attr('name') + ']');
            })
        }
        function contacts_singupform(select) {
            var self = $(select),
                target = self.closest('.form-contact').find('.sing-up'),
                pref = self.attr('name');
            self.parent().addLoader();
            $.get('?cmd=signup&contact&private', function (resp) {
                $('#preloader').remove();
                var form = $('<div></dv>')
                form.append('<input type="hidden" name="__nocontact" value="1" />');
                form.append('<input type="checkbox" name="__nocontact" value="0" checked="checked" /> <label>{/literal}{$lang.addthiscontact|escape:'javascript'}{literal}</label>');
                form.append(parse_response(resp));
                updateNames(form, pref)
                target.html('');
                form.appendTo(target);
            });
        }
        $('input[name="contacts[usemy]"]').on('change', function () {
            if (!this.checked) {
                contacts_singupform($('.contact-selection').first());
                nc.slideDown('fast');
            } else {
                $('.sing-up').html('');
                nc.slideUp('fast');
            }
        });
        $('.contact-selection').each(function () {
            var self = $(this),
                target = $(self).closest('.form-contact').find('.sing-up');
            $(self).on('change',function () {
                console.log($(target));
                if (self.val() == 'new')
                    contacts_singupform(this);
                else
                    $(target).html('');
            });
        });
        $('[data-c-type]').each(function () {
            var self = $(this),
                type = self.data('c-type');
            updateNames(self, 'contacts[' + type + ']')
        })
    })
</script>
{/literal}