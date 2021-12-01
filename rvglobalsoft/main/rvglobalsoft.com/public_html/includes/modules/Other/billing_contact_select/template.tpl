<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.selectbillingcontact}</strong>
    </div>

    <div class="wbox_content">
        <select name="cart_billing_contact_id" class="left">
            {foreach from=$contacts item=contact key=id}
                <option value="{$id}">{$contact.firstname} {$contact.lastname}</option>
            {/foreach}
        </select>
        <a href="/?cmd=profiles" target="_blank" class="right">{$lang.managecontacts}</a>
        <div class="clear"></div>
    </div>
</div>