{foreach from=$fields item=field key=k name=floop}
    <div class="form-group col-sm-6 col-md-4 col-lg-4 {if $field.type=='Company'}iscomp{elseif $field.type=='Private'}ispr{/if}">
        <div class="row no-gutter">
            <div class="col-md-6 lite text-right" style="color: #777">
                {if $k=='type'}
                    {$lang.clacctype}
                {elseif $field.options & 1}
                    {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                {else}
                    {$field.name}
                {/if} : &nbsp;
            </div>
            {if !$showforms}
                <div class="col-md-6">
                    <span class="livemode">
                        {if $k=='type'}{if $client.company=='0'}{$lang.Private}{/if}
                            {if $client.company=='1'}{$lang.Company}{/if}

                        {elseif $k=='country'}
                            {$client.country} - {$client.countryname}
                        {else}
                            {if $field.field_type=='Password'}
                            {elseif $field.field_type=='Check'}
                                {foreach from=$field.default_value item=fa}
                                    {if in_array($fa,$client[$k])}{$fa},{/if}
                                {/foreach}
                            {else}
                                {$client[$k]}
                            {/if}
                        {/if}
                    </span>
                </div>
            {else}
                {if $k=='type'}
                {elseif $k=='country'}
                    <select name="country" class="form-control" id="field_live_{$field.code}">
                        {foreach from=$countries key=k item=v}
                            <option value="{$k}" {if $k==$client.country} selected="Selected"{/if}>{$v}</option>
                        {/foreach}
                    </select>
                {else}
                    {if $field.field_type=='Password'}
                    {elseif $field.field_type=='Input'}
                        <input type="text" value="{$client[$field.code]}" class="form-control" id="field_live_{$field.code}"
                               name="{$field.code}"/>
                    {elseif $field.field_type=='Check'}
                        {foreach from=$field.default_value item=fa}
                            <div class="dropdown">
                                <label>
                                    <input type="checkbox" name="{$field.code}[{$fa}]" value="1"
                                           {if in_array($fa,$client[$field.code])}checked="checked"{/if}/>
                                    {$fa}
                                </label>
                            </div>
                        {/foreach}
                    {elseif $field.field_type == 'Contact'}
                        <select name="{$field.code}" id="field_live_{$field.code}">
                            {foreach from=$field.default_value item=fa key=id}
                               <option value="{$id}" {if $client[$field.code]==$id}selected="selected"{/if}>{$fa}</option>
                            {/foreach}
                        </select>
                    {else}
                        <select name="{$field.code}" id="field_live_{$field.code}" class="form-control" >
                            {foreach from=$field.default_value item=fa}
                                <option {if $client[$field.code]==$fa}selected="selected"{/if}>{$fa}</option>
                            {/foreach}
                        </select>
                    {/if}
                {/if}
            {/if}
        </div>
    </div>
{/foreach}
<div class="form-group col-sm-6 col-md-4 col-lg-4">
    <label>{$lang.clacctype}</label>
    {if !$showforms}
        <span class="livemode">
            {if $client.company=='0'}{$lang.Private}{/if}
            {if $client.company=='1'}{$lang.Company}{/if}
        </span>
    {else}
        <select name="type" class="form-control" onchange="{literal}if ($(this).val() == 'Private') {
                                                                    $('.iscomp').hide();
                                                                    $('.ispr').show();
                                                                } else {
                                                                    $('.ispr').hide();
                                                                    $('.iscomp').show();
                                                                }{/literal}">
            <option value="Private" {if $client.company=='0'}selected="selected"{/if}>{$lang.Private}</option>
            <option value="Company" {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
        </select>
    {/if}
</div>
{if count($currencies)>1}
    <div class="form-group col-sm-6 col-md-4 col-lg-4">
        <label>{$lang.currency}</label>
        {if !$showforms}
            <span class="livemode">
                {foreach from=$currencies item=curre}
                    {if $client.currency_id==$curre.id}{$curre.code}{/if}
                {/foreach}
            </span>
        {else}
            <select name="currency_id" class="form-control" id="currency_id">
                {foreach from=$currencies item=curre}
                    <option value="{$curre.id}"
                            {if $client.currency_id==$curre.id}selected="selected"{/if}>{if $curre.iso}{$curre.iso}{else}{$curre.code}{/if}</option>
                {/foreach}
            </select
        {/if}
    </div>
{else}
    <input type="hidden" id="currency_id" value="{$client.currency_id}"/>
{/if}

<div class="form-group col-sm-6 col-md-4 col-lg-4">
    <label>{$lang.Status}</label>

    {if !$showforms}
        <span class="{$client.status} livemode ">{$lang[$client.status]}</span>
    {else}
        <div style="display: none;">
            <select name="status" class="form-control">
                <option value="Active" {if $client.status=='Active'}selected="selected"{/if}>{$lang.Active}</option>
                <option value="Closed" {if $client.status=='Closed'}selected="selected"{/if}>{$lang.Closed}</option>
            </select>
        </div>
    {/if}
</div>
<div class="form-group col-sm-6 col-md-4 col-lg-4">
    <label>{$lang.Group}</label>
    {if !$showforms}
        <span style="color:{$client.group_color}"
              class="livemode">{$client.group_name}</span>
    {else}
        <select name="group_id" class="form-control">
            <option value="0" {if $client.group_id=='0'}selected="selected"{/if}>{$lang.none}</option>
            {foreach from=$groups item=group}
                <option value="{$group.id}" style="color:{$group.color}"
                        {if $client.group_id==$group.id}selected="selected"{/if}>{$group.name}</option>
            {/foreach}
        </select>
    {/if}
</div>

