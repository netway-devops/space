<span class="domain-contact openSansSemiBold">
    <input type="checkbox" name="contacts[usemy]" value="1" {foreach from=$cart_contents[2] item=doms}{if !$doms.extended}checked="checked"{else}{assign value=$doms.extended var=set_contacts}{/if}{break}{/foreach} />
    {if $logged=="1"} {$lang.domcontact_loged}      
    {else} {$lang.domcontact_checkout}
    {/if}
</span>
<div {if !$set_contacts}style="display: none;"{/if} id="newContacts" class="border-top">
    <div>
        <div class="lh28 mt-2"><b>{$lang.registrantinfo}</b></div>
        <select {if $logged!="1" || !$contacts}style="display:none"{/if} class="form-control contact-selection my-2" name="contacts[registrant]">
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
        <div class="sing-up" data-c-type="registrant">
            {if is_array($fields.contacts.registrant)}
                {include file="ajax.signup.tpl" submit=$fields.contacts.registrant fields=$singupfields}
            {elseif is_array($set_contacts.registrant)}
                {include file="ajax.signup.tpl" submit=$set_contacts.registrant fields=$singupfields}
            {/if}
        </div>
    </div>
    <div class="clear">
        <div class="lh28 mt-2"><b>{$lang.admininfo}</b></div>
        <select class="form-control contact-selection my-2" name="contacts[admin]">
            <option value="registrant">{$lang.useregistrant}</option>
            <option {if is_array($fields.contacts.admin) || is_array($set_contacts.admin)}selected="selected"{/if} value="new">{$lang.definenew}</option>
            {if $logged=="1"}
                {foreach from=$contacts item=contact name=contacts}
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
        <div class="sing-up" data-c-type="admin">
            {if is_array($fields.contacts.admin)}
                {include file="ajax.signup.tpl" submit=$fields.contacts.admin fields=$singupfields}
            {elseif is_array($set_contacts.admin)}
                {include file="ajax.signup.tpl" submit=$set_contacts.admin fields=$singupfields}
            {/if}
        </div>
    </div>
    <div class="clear">
        <div class="lh28 mt-2"><b>{$lang.techinfo}</b></div>
        <select class="form-control contact-selection my-2" name="contacts[tech]">
            <option value="registrant">{$lang.useregistrant}</option>
            <option {if is_array($fields.contacts.tech) || is_array($set_contacts.tech)}selected="selected"{/if} value="new">{$lang.definenew}</option>
            {if $logged=="1"}
                {foreach from=$contacts item=contact name=contacts}
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
        <div class="sing-up" data-c-type="tech">
            {if is_array($fields.contacts.tech)}
                {include file="ajax.signup.tpl" submit=$fields.contacts.tech fields=$singupfields}
            {elseif is_array($set_contacts.tech)}
                {include file="ajax.signup.tpl" submit=$set_contacts.tech fields=$singupfields}
            {/if}
        </div>
    </div>
    <div class="clear">
        <div class="lh28 mt-2"><b>{$lang.billinginfo}</b></div>
        <select class="form-control contact-selection my-2" name="contacts[billing]">
            <option value="registrant">{$lang.useregistrant}</option>
            <option {if is_array($fields.contacts.billing) || is_array($set_contacts.billing)}selected="selected"{/if} value="new">{$lang.definenew}</option>
            {if $logged=="1"}
                {foreach from=$contacts item=contact name=contacts}
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
        <div class="sing-up" data-c-type="billing">
            {if is_array($fields.contacts.billing)}
                {include file="ajax.signup.tpl" submit=$fields.contacts.billing fields=$singupfields}
            {elseif is_array($set_contacts.billing)}
                {include file="ajax.signup.tpl" submit=$set_contacts.billing fields=$singupfields}
            {/if}
        </div>
    </div>
</div>
{literal}
    <script type="text/javascript">
        $(function () {
            var nc = $('#newContacts'),
                usemy = $('input[name="contacts[usemy]"]');

            function updateNames(form, prefix) {
                form.find('input, select, textarea').each(function () {
                    var field = $(this);
                    if (field.attr('type') === 'checkbox') {
                        field.attr('name', prefix + '[' + field.attr('name').replace('[', ']['));
                    } else {
                        field.attr('name', prefix + '[' + field.attr('name') + ']');
                    }

                })
            }
            function contacts_singupform(select) {
                var self = $(select),
                    target = self.siblings('.sing-up'),
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

                    toggle_contacts();

                    $(target).find('.form-label-group').each(function () {
                        var u = '_' + Date.now() + Math.random();
                        var lab_for = $(this).find('label').attr('for');
                        $(this).find('label').attr('for', lab_for + u);
                        var inp_id = $(this).find('input').attr('id');
                        $(this).find('input').attr('id', inp_id + u);
                        var txarea_id = $(this).find('textarea').attr('id');
                        $(this).find('textarea').attr('id', txarea_id + u);
                        var slct_id = $(this).find('select').attr('id');
                        $(this).find('select').attr('id', slct_id + u);
                    })
                });
            }

            function toggle_contacts(){
                nc.find('.sing-up [required]')
                    .prop('disabled', usemy.is(':checked'));
            }

            usemy.on('init change', function () {
                if (!this.checked) {
                    nc.slideDown('fast');
                    toggle_contacts();
                }else {
                    nc.slideUp('fast');
                    toggle_contacts();
                }
            }).trigger('init');

            $('.contact-selection').each(function () {
                var self = $(this),
                    target = self.siblings('.sing-up');

                self.on('change', function () {
                    if (self.val() == 'new')
                        contacts_singupform(this);
                    else
                        target.html('');
                })
                if (self.val() == 'new' && !target.children().length)
                    contacts_singupform(this);
            })


            $('[data-c-type]').each(function () {
                var self = $(this),
                    type = self.data('c-type');
                updateNames(self, 'contacts[' + type + ']')
            })
        })
    </script>
{/literal}