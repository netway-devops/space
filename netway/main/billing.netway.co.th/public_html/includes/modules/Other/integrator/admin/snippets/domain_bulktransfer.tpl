<form method="post" action="{$system_url}?cmd=checkdomain">

    <input type="hidden" value="checkdomain" name="action">
    <input type="hidden" value="true" name="bulk">
    <input type="hidden" value="{$c.realid}" name="domain_cat">
    <input type="hidden" value="1" name="transfer">
    <table border="0" width="100%">
        <tr>
            <td valign="top">Domain: <textarea  name="sld"></textarea>  <input type="submit"  value="Check Availability"/></td>
            <td valign="top">{foreach from=$c.tlds item=tkd name=floop}<span style="float:left;width:70px"><input type="checkbox" value="{$tkd.name}" name="tld[]"/> {$tkd.name}</span>{/foreach}
                <span style="clear:both"></span></td>
        </tr>
    </table>


</form>