<div class="form-check domain-contact">
    <input id="usemy" type="checkbox" name="contacts[usemy]" value="1" {foreach from=$cart_contents[2] item=doms}{if !$doms.extended}checked="checked"{else}{assign value=$doms.extended var=set_contacts}{/if}{break}{/foreach} />
    <label class="form-check-label" for="usemy">
        {if $logged=="1"} {$lang.domcontact_loged}
        {else} {$lang.domcontact_checkout}
        {/if}
    </label>
</div>


<div {if !$set_contacts}style="display: none;"{/if} id="newContacts">
    <div class="nav-tabs-wrapper">
        <ul class="nav nav-tabs init-by-hash nav-slider horizontal d-flex justify-content-between flex-nowrap align-items-center" role="tablist">
            <li>
                <ul class="nav nav-slider" id="ContactsTabs">
                    <li class="nav-item active"><a class="nav-link nav-link-slider" id="registrantinfo-tab" data-toggle="tab" href="#registrantinfo" role="tab" aria-controls="registrantinfo" aria-selected="true">{$lang.registrantinfo|replace:':':''}</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-slider" id="admininfo-tab" data-toggle="tab" href="#admininfo" role="tab" aria-controls="admininfo" aria-selected="false">{$lang.admininfo|replace:':':''}</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-slider" id="techinfo-tab" data-toggle="tab" href="#techinfo" role="tab" aria-controls="techinfo" aria-selected="false">{$lang.techinfo|replace:':':''}</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-slider" id="billinginfo-tab" data-toggle="tab" href="#billinginfo" role="tab" aria-controls="billinginfo" aria-selected="false">{$lang.billinginfo|replace:':':''}</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="tab-content" id="ContactsContent">
        <div class="tab-pane fade show active" id="registrantinfo" role="tabpanel" aria-labelledby="registrantinfo-tab">
            <select {if $logged!="1" || !$contacts}style="display:none"{/if} class="form-control w-auto mb-3 contact-selection" name="contacts[registrant]">
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
                {if is_array($set_contacts.registrant)}
                    {include file="ajax.signup.tpl" submit=$set_contacts.registrant fields=$singupfields}
                {/if}
            </div>
        </div>
        <div class="tab-pane fade" id="admininfo" role="tabpanel" aria-labelledby="admininfo-tab">
            <select class="form-control w-auto mb-3 contact-selection" name="contacts[admin]">
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

            <div class="sing-up" data-c-type="admin">
                {if is_array($fields.contacts.admin)}
                    {include file="ajax.signup.tpl" submit=$set_contacts.admin fields=$singupfields}
                {/if}
            </div>
        </div>
        <div class="tab-pane fade" id="techinfo" role="tabpanel" aria-labelledby="techinfo-tab">
            <select class="form-control w-auto mb-3 contact-selection" name="contacts[tech]">
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
            <div class="sing-up" data-c-type="tech">
                {if is_array($fields.contacts.tech)}
                    {include file="ajax.signup.tpl" submit=$set_contacts.tech fields=$singupfields}
                {/if}
            </div>
        </div>
        <div class="tab-pane fade" id="billinginfo" role="tabpanel" aria-labelledby="billinginfo-tab">
            <select class="form-control w-auto mb-3 contact-selection" name="contacts[billing]">
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
            <div class="sing-up" data-c-type="billing">
                {if is_array($fields.contacts.billing)}
                    {include file="ajax.signup.tpl" submit=$set_contacts.billing fields=$singupfields}
                {/if}
            </div>
        </div>
    </div>
</div>