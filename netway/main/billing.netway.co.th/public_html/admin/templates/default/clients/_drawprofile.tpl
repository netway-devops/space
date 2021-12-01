<div class="row light-labels">
    <div class="col-lg-8">
        {foreach from=$fields key=gk item=group}
            <div class="box box-primary clientdetails-group">
                {if $group.id}
                    <div class="box-header collapsed clientdetails-group-header" style="padding: 5px 15px;border-bottom: 1px solid #ddd;" data-group-id="{$group.id}" href="#collapseGroupShow-{$group.id}" role="button" data-toggle="collapse" aria-expanded="true" aria-controls="collapseGroupShow-{$group.id}" onclick="ClientDetailsGroups.toggleClientDetailsGroup(this)">
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
                <div class="{if $group.id}collapse in{/if} clientdetails-group-body" {if $group.id}id="collapseGroupShow-{$group.id}"{/if}>
                    <div class="panel-body">
                        <div class="row light-labels">
                        {foreach from=$group.fields item=field key=k name=floop}
                            <div class="col-md-6">
                                <div {if $field.type=='Company'}class="iscomp form-group"
                                     style="{if  $client.company!='1'}display:none{/if}"
                                     {elseif $field.type=='Private'}class="ispr form-group"
                                     style="{if $client.company=='1'}display:none{/if}" {else} class="form-group" {/if} >
                                    <label for="{$k}">
                                        {if $k=='type'}
                                            {$lang.clacctype}
                                        {elseif $field.options & 1}
                                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                        {else}
                                            {$field.name}
                                        {/if}
                                        {if $field.description}
                                            <i class="vtip_description" style="font-size:inherit" title="{$field.description}"></i>
                                        {/if}
                                    </label>
                                    <div class="form-plaintext form-plaintext-live">
                                        {if $k=='type'}
                                        {elseif $k=='country'}
                                            {$client.country} - {$countries[$client.country]}
                                        {else}
                                            {if $field.field_type=='Input'}
                                                {$client[$k]}
                                            {elseif $field.field_type=='Password'}
                                                ***
                                            {elseif $field.field_type=='Select'}
                                                {$client[$k]}
                                            {elseif $field.field_type=='Check'}
                                                {foreach from=$field.default_value item=fa}
                                                    {if in_array($fa,$client[$k])}{$fa},{/if}
                                                {/foreach}
                                            {elseif $field.field_type=='File'}
                                                {if $client[$k]}
                                                    <a class="left"
                                                       href="?cmd=root&amp;action=download&amp;type=downloads&amp;id={$client[$k]}">Download</a>
                                                {else}
                                                    {$lang.none}
                                                {/if}
                                            {elseif $field.field_type == 'Contact'}
                                                {foreach from=$field.default_value item=fa key=id}
                                                    {if $client[$field.code]==$id}{$fa}{/if}
                                                {/foreach}
                                            {else}
                                                {$client[$k]}
                                            {/if}
                                        {/if}
                                    </div>
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
                           <div class="form-plaintext form-plaintext-live">
                               {if $client.company!='1'}{$lang.Private}{else}{$lang.Company}{/if}
                           </div>
                       </div>
                   </div>
                   <div class="col-md-6">
                       <div class="form-group">
                           <label>
                               {$lang.Status}:
                               <span class="vtip_description" style="font-size:inherit">
                    <span>
                        <b>{$lang.Active}</b> - Regular status<br>
                        {if !$parent.id}
                            <b>{$lang.Closing}</b>
                             - Client can manage current services, but is not
                        allowed to order new ones

                            <br>
                        {/if}
                        <b>{$lang.Closed}</b> - Client won't be able to login<br>
                        {if !$parent.id}
                            <b>{$lang.PendingRemoval}</b>

- Client account is

                            <b>{$lang.Closed}</b>

,
                        and will be removed within few days

                            <br>
                            <b>{$lang.Archived}</b>
                            - Client account is archived{/if}
                    </span>
                </span>
                           </label>
                           <div class="form-plaintext form-plaintext-live ">
                               <span class="{$client.status}">{$lang[$client.status]}</span>
                           </div>
                       </div>
                   </div>

                   {if !$parent.id}
                       {if count($currencies)>1}
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>{$lang.currency}:</label>
                                   <div class="form-plaintext form-plaintext-live ">
                                       {foreach from=$currencies item=curre}
                                           {if $client.currency_id==$curre.id}{$curre.code}{/if}
                                       {/foreach}
                                   </div>
                               </div>
                           </div>
                       {/if}
                       {if $groups}
                           <div class="col-md-6">
                               <div class="form-group">
                                   <label>Group:</label>
                                   <div class="form-plaintext form-plaintext-live " style="color:{$client.group_color}">
                                       {$client.group_name}
                                   </div>
                               </div>
                           </div>
                       {/if}
                       <div class="col-md-6">
                           <div class="form-group">
                               <label>{$lang.defaultlanguage}:</label>
                               <div class="form-plaintext form-plaintext-live ">
                                   {$client.language}
                               </div>
                           </div>
                       </div>
                       <div class="col-md-6">
                           <div class="form-group">
                               <label>
                                   Billing contact:
                                   <i class="vtip_description" style="font-size:inherit"
                                      title="Used for credit card / gateway payments"></i>
                               </label>
                               <div class="form-plaintext form-plaintext-live ">
                                   {if !$client.billing_contact_id}Default{else}#{$client.billing_contact.id} {$client.billing_contact.firstname} {$client.billing_contact.lastname} {/if}
                               </div>
                           </div>
                       </div>
                   {/if}

                   <div class="col-md-6">
                       <div class="form-group">
                           <label>{$lang.password}:</label>
                           <div class="form-plaintext form-plaintext-live  ">
                               ****
                           </div>
                       </div>
                   </div>
               </div>
            </div>
        </div>
    </div>
</div>