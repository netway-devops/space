<div class="row">
    <div class="col-lg-8">
        {foreach from=$fields key=gk item=group}
            <div class="box box-primary clientdetails-group">
                {if $group.id}
                    <div class="box-header collapsed clientdetails-group-header" style="padding: 5px 15px;border-bottom: 1px solid #ddd;" data-group-id="{$group.id}" href="#collapseGroupEdit-{$group.id}" role="button" data-toggle="collapse" aria-expanded="true" aria-controls="collapseGroupEdit-{$group.id}" onclick="ClientDetailsGroups.toggleClientDetailsGroup(this)">
                        <div style="display:flex;flex-direction:row;align-items:center;justify-content:space-between;">
                            <h2 style="margin: 5px 0">
                                {$group.name}
                                {if $group.description}
                                    <span class="vtip_description" title="{$group.description}"></span>
                                {/if}
                            </h2>
                            <i class="fa fa-chevron-up arrow_icon" style="font-size: 16px"></i>
                        </div>
                    </div>
                {/if}
                <div class="{if $group.id}collapse in{/if} clientdetails-group-body" {if $group.id}id="collapseGroupEdit-{$group.id}"{/if}>
                    <div class="panel-body">
                        <div class="row">
                            {foreach from=$group.fields item=field key=k name=floop}
                                <div class="col-md-6">
                                    <div {if $field.type=='Company'}class="iscomp form-group"
                                         style="{if  $client.company!='1'}display:none{/if}"
                                         {elseif $field.type=='Private'}class="ispr form-group"
                                         style="{if $client.company=='1'}display:none{/if}"
                                            {else}
                                         class="form-group"
                                            {/if} >
                                        <label for="{$k}">{if $k=='type'}
                                                {$lang.clacctype}
                                            {elseif $field.options & 1}
                                                {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                            {else}
                                                {$field.name}
                                            {/if}{if $field.description} <i class="vtip_description" style="font-size:inherit" title="{$field.description}"></i>{/if}</label>

                                        {if $k=='type'}
                                        {elseif $k=='country'}
                                            <select name="country" class="form-control">
                                                {foreach from=$countries key=k item=v}
                                                    <option value="{$k}" {if $k==$client.country  || (!$client.country && $k==$defaultCountry)} selected="selected"{/if}>{$v}</option>
                                                {/foreach}
                                            </select>
                                        {else}
                                        {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}
                                        <input type="text" value="{$client[$k]}" class="form-control" id="field_live_{$k}" name="{$k}"
                                               data-initial-country="{$client.country|default:$default_country}"/>

                                        {if $k=='phonenumber' || $field.field_type=='Phonenumber'}
                                            <script>initPhoneNumberField($('#field_live_{$k}'));</script>
                                        {/if}
                                        {elseif $field.field_type=='Password'}
                                        <input type="password" autocomplete="off" value="" class="form-control" name="{$k}" class="styled"/>
                                        {elseif $field.field_type=='Select' || $field.field_type == 'Contact'}
                                            <select name="{$k}" class="form-control" id="field_live_{$k}">
                                                {foreach from=$field.default_value item=fa}
                                                    <option {if $client[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                                {/foreach}
                                            </select>
                                        {elseif $field.field_type=='Check'}
                                            <div class="checkbox">
                                                {foreach from=$field.default_value item=fa key=fk}
                                                    <label>
                                                        <input type="checkbox" name="{$field.code}[{$fk}]" value="1"
                                                               {if in_array($fa,$client[$field.code])}checked="checked"{/if}/>{$fa}
                                                    </label>
                                                {/foreach}
                                            </div>
                                        {elseif $field.field_type=='File'}
                                        {foreach from=$field.default_value item=fa key=fk}
                                        <input type="file" name="{$field.code}">
                                        {/foreach}
                                        {/if}
                                        {/if}
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
    </div>

    <div class="col-lg-4">
        <div class="box box-primary">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.clacctype}</label>
                        <select name="type" class="form-control" onchange="{literal}if ($(this).val() == 'Private') {
                                                                $('.iscomp').hide();
                                                                $('.ispr').show();
                                                            } else {
                                                                $('.ispr').hide();
                                                                $('.iscomp').show();
                                                            }{/literal}">
                            <option value="Private" {if $client.company!='1'}selected="selected"{/if}>{$lang.Private}</option>
                            <option value="Company" {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                        </select>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.Status}: <span class="vtip_description" style="font-size:inherit">
                                            <span>
                                                <b>{$lang.Active}</b> - Regular status<br>
                                                <b>{$lang.Closing}</b> - Client can manage current services, but is not
                                                allowed to order new ones<br>
                                                <b>{$lang.Closed}</b> - Client won't be able to login<br>
                                                <b>{$lang.PendingRemoval}</b> - Client account is <b>{$lang.Closed}</b>,
                                                and will be removed within few days<br>
                                                <b>{$lang.Archived}</b> - Client account is archived
                                            </span>
                                        </span></label>
                        <select name="status" id="status" class="form-control">
                            {foreach from=$client_status item=status}
                                <option value="{$status}"
                                        {if $client.status==$status}selected="selected"{/if}>{$lang[$status]}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>


                {if !$parent.id}
                    {if count($currencies)>1}
                        <div class="col-md-6">

                            <div class="form-group">
                                <label>{$lang.currency}:</label>
                                <select name="currency_id" id="currency_id" class="form-control">
                                    {foreach from=$currencies item=curre}
                                        <option value="{$curre.id}"
                                                {if $client.currency_id==$curre.id}selected="selected"{/if}>{if $curre.code}{$curre.code}{else}{$curre.iso}{/if}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    {/if}
                    {if $groups}
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Group:</label>
                                <select name="group_id" id="group_id" class="form-control">
                                    <option value="0">{$lang.none}</option>
                                    {foreach from=$groups item=group}
                                        <option value="{$group.id}" style="color:{$group.color}"
                                                {if $client.group_id==$group.id}selected="selected"{/if}>{$group.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    {/if}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{$lang.defaultlanguage}:</label>
                            <select name="language" id="language" class="form-control">
                                {foreach from=$client_languages key=k item=v}
                                    <option {if $v==$client.language} selected="selected"{/if}>{$v}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Billing contact: <i class="vtip_description" style="font-size:inherit"
                                                       title="Used for credit card / gateway payments"></i></label>

                            <select name="billing_contact_id" id="billing_contact_id" class="form-control">
                                <option value="0" {if !$client.billing_contact_id}selected{/if}>Default (this profile)</option>
                                {foreach from=$contacts item=v}
                                    <option {if $v.id==$client.billing_contact_id} selected="selected"{/if} value="{$v.id}">
                                        #{$v.id} {$v.firstname} {$v.lastname}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                {/if}

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.newpass}:</label>
                        <input name="password" type="password" autocomplete="off" class="form-control"/>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{$lang.repeatpass}:</label>
                        <input name="password2" type="password" autocomplete="off" class="form-control"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>