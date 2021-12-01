<section class="section-account-header">
    <h1>{$lang.accountdetails}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="details"}

<section class="section-account">
    <div class="table-responsive table-borders table-radius mb-4">
        <table class="table layout-fixed stackable">
            <thead>
            <tr>
                <th class="inline-row">{$lang.information_type}</th>
                <th class="inline-row">{$lang.clientdata}</th>
                <th><span class="d-none d-md-block">{$lang.purpose}</span></th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$fields item=field key=k}
                <tr data-code="{$field.code}">
                    <td class="inline-row">
                        <b>
                            {if $field.options & 1}{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                            {else}{$field.name}
                            {/if}
                        </b>
                    </td>
                    <td class="inline-row">
                        {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}{$client[$k]}
                        {elseif $field.field_type=='Password'}
                        {elseif $field.code=='type'}
                            {if $client.company=='0'}{$lang.Private}{/if}
                            {if $client.company=='1'}{$lang.Company}{/if}
                        {elseif $field.field_type=='Select'}
                            {foreach from=$field.default_value item=fa}
                                {if $client[$k]==$fa}{$fa}{/if}
                            {/foreach}
                        {elseif $field.field_type=='Check'}
                            {foreach from=$field.default_value item=fa}
                                {if in_array($fa,$client[$k])}{$fa}<br/>{/if}
                            {/foreach}
                        {elseif $field.field_type=='File'}
                            {if $client[$k]}
                                <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$client[$k]}" target="_blank">
                                    <i class="material-icons icon-info-color mr-3">cloud_download</i>
                                    <span class="text-small">{$lang.download}</span>
                                </a>
                            {else} - {/if}
                        {elseif $field.field_type=='Contact'}
                            {foreach from=$field.default_value item=fa key=id}
                                {if $client[$k] == $id}{$fa}{/if}
                            {/foreach}
                        {/if}
                    </td>
                    <td>
                        <div class="d-none d-md-block">
                            {if $field.options & 4}
                                {$lang.billing}
                            {else}
                                {$field.description|escape}
                            {/if}
                        </div>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    <p>{$lang.download_overview_json}</p>
    <a href="{$ca_url}clientarea/{$action}/&download" target="_blank" class="btn btn-primary">{$lang.download}</a>
    {if $canDelete}
        <hr>
        <p>
            <a href="{$ca_url}clientarea/delete" class="btn btn-danger">{$lang.delete_account}</a>
        </p>
    {/if}
    {securitytoken}
</section>