{if $contacts}
    <label>{$lang.assignto}</label>
    <select name="contact_id" class="form-control">
        <option value="{$client_id}" {if $client_id == $contact_id}selected{/if}>Main contact</option>
        {foreach from=$contacts item=contact}
            <option value="{$contact.id}" {if $contact.id == $contact_id}selected{/if}>#{$contact.id} {$contact.firstname} {$contact.lastname}</option>
        {/foreach}
    </select>

    {include file='support/ajax.contactstable.tpl'}
    {literal}
        <script>
            $('select[name=contact_id]').chosensearch({width: "100%"});
        </script>
    {/literal}
{/if}