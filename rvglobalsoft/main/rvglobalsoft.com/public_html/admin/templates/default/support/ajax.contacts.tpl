{if !$contacts}
    None, send to main profile
{else}
    <select name="contact_id" class="form-control">
        <option value="0">None, send to main profile</option>
        {foreach from=$contacts item=contact}
            <option value="{$contact.id}">#{$contact.id} {$contact.firstname} {$contact.lastname}</option>
        {/foreach}
    </select>
{/if}