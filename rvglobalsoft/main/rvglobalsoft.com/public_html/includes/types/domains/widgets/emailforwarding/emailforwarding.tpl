<div class="wbox">
    <div class="wbox_header">{$lang.emailfwdtitle}:</div>
    <div  class="wbox_content">
        {if $EmailForwarding.redirect}
            <div style="text-align: center; padding: 20px;">
                {if $EmailForwarding.url}{$lang.Click} <a href="{$EmailForwarding.url}" target="_blank">{$lang.here}</a> {$lang.tomanage}
                {else}{$lang.tryagainorsup}{/if}
            </div>
        {else}
        {if !$details}
            {$lang.emailfowardnotebulk}
        {/if}
            <form action="" method="post">
            <input type="hidden" name="submit" value="1" />
            <input type="hidden" name="widgetdo" value="updateEmailForwarding" />

            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
            <tr>
                <td><strong></strong></td>
                <td><strong></strong></td>
                <td><strong>{$lang.fwdto}</strong></td>
            </tr>

            {foreach from=$EmailForwarding key=number item=Forwarding  name=frea}
                <tr {if $smarty.foreach.frea.iteration%2==0}class="even"{/if}>

                <td><input type="text" class="styled" size="15" value="{$Forwarding.address}" name="updateEmailForwarding[ForwardAddress{$number}]"/></td>
				<td>@ {if $details}{$details.name}{else}[DOMAIN]{/if} =></td>
                <td><input type="text" class="styled" size="30" value="{$Forwarding.forwardto}" name="updateEmailForwarding[ForwardTo{$number}]"/></td>
                </tr>
            {/foreach}
            <tr>
                <td><input type="text" class="styled" size="15" value="" name="updateEmailForwarding[newForwardAddress]"/></td>
				<td>@ {if $details}{$details.name}{else}[DOMAIN]{/if} =></td>
                <td><input type="text" class="styled" size="30" value="" name="updateEmailForwarding[newForwardTo]"/></td>
            </tr>

<tr  class="even"><td colspan="3" align="center"> <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class=" btn btn-primary"/>
        <span class="fs11">{$lang.or}</span> <a href="{$ca_url}clientarea/domains/{if $details}{$details.id}/{$details.name}/{/if}" class="fs11">{$lang.cancel}</a></td></tr>
            </table>


             </form>
         {/if}
    </div>
</div>