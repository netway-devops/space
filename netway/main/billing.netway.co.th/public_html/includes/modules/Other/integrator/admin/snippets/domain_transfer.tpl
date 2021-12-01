<form method="post" action="{$system_url}?cmd=checkdomain" target="_blank">
    <input type="hidden" value="checkdomain" name="action">
    <input type="hidden" value="1" name="singlecheck">
    <input type="hidden" value="1" name="transfer">
    <input type="hidden" value="{$c.realid}" name="domain_cat">
    Domain: <input value=""  name="sld">
    <select  name="tld">{foreach from=$c.tlds item=tkd}<option value="{$tkd.name}">{$tkd.name}</option>
        {/foreach}</select>
    <input type="submit"  value="Transfer">
</form>