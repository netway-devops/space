<div class="wbox">
    <div class="wbox_header">{$lang.DomainForwarding}</div>
    <div  class="wbox_content">
<form action="" method="post">
            <input type="hidden" name="submit" value="1" />
            <input type="hidden" name="widgetdo" value="updateDomainForwarding" />
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
                <tr><td>{$lang.Destination}:</td><td><select name="updateDomainForwarding[destination_prefix]" class="span2 styled"><option>http://</option><option>https://</option></select><input type="text" size="30" value="" name="updateDomainForwarding[destination]"/></td></tr>
                <tr class="even"><td>{$lang.urlmasking}:</td><td><input type="checkbox" value="1" name="updateDomainForwarding[urlmasking]" /></td></tr>
                <tr><td>{$lang.subdomainfwd}:</td><td><input type="checkbox" value="1" name="updateDomainForwarding[subdomainfwd]" /></td></tr>

                <tr class="even"><td colspan="3" align="center"> <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class=" btn btn-primary"/>
                    <span class="fs11">{$lang.or}</span> <a href="{$ca_url}clientarea/domains/{if $details}{$details.id}/{$details.name}/{/if}" class="fs11">{$lang.cancel}</a></td></tr>
            </table>
         </form> </div>
</div>
