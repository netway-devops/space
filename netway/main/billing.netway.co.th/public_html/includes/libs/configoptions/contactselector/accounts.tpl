{foreach from=$c.items item=cit}
    <select name="custom[{$kk}][{$cit.id}]">
        <option value="main" {foreach from=$c.data item=d}{if $d == 'main'}selected="selected"{/if}{/foreach}>{$lang.mainprofiledetails}</option>
        {foreach from=$c.contacts item=cont name=foo}
            <option value="{$cont.id}" {foreach from=$c.data item=d}{if $d == $cont.id}selected="selected"{/if}{/foreach}>
               #{$cont.id} {$cont.firstname} {$cont.lastname}
            </option>
        {/foreach}
    </select>
{/foreach}