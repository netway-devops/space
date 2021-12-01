<div class="row flex-container ">
    <div class="span2  flex-box-1 box-feature-small">
        {include file='clientarea/leftnavigation.tpl'}
    </div>
    <div class="span12  flex-box-1 bordered-section article iep">

        <h2>{$lang.overview}</h2>
        <div class="brcrm">{$lang.overview_d}</div>
        <div class="p19">
            <table class="table table-striped" style="table-layout: fixed">
                <thead>
                    <tr>
                        <th>{$lang.information_type}</th>
                        <th>{$lang.clientdata}</th>
                        <th>{$lang.purpose}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$fields item=field key=k}
                        <tr>
                            <td>
                                {if $field.options & 1}{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                {else}{$field.name}
                                {/if}
                            </td>
                            <td>
                                {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}{$client[$k]}
                                {elseif $field.field_type=='Password'}
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
                                {if $field.options & 4}
                                    {$lang.billing}
                                {else}
                                    {$field.description|escape}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>


            <div class="form-actions">
                <p>{$lang.download_overview_json}</p>
                <a href="{$ca_url}clientarea/{$action}/&download" class="btn btn-info">{$lang.download}</a>
            </div>
            {if $canDelete}
            <hr/>
            <p>
                <a href="{$ca_url}clientarea/delete" class="btn btn-danger">{$lang.delete_account}</a>
            </p>
            {/if}
            {securitytoken}
        </div>

    </div>
</div>