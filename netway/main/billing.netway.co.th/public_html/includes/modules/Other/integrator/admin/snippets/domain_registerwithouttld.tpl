<form method="post" action="{$system_url}?cmd=checkdomain" target="_blank">
    <input type="hidden" value="checkdomain" name="action">
    <input type="hidden" value="1" name="singlecheck">
    <input type="hidden" value="1" name="register">
    <input type="hidden" value="{$c.realid}" name="domain_cat">
    Domain: <input value=""  name="domain" />

    <input type="submit"  value="Check Availability">
</form>