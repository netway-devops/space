<div class="bordered-section article">
    <h2 class="bbottom">{$lang.cancellrequest}</h2>
    <form action="" method="post" class="p19">
        <input type="hidden" value="cancel" name="make"/>

        <p>
            {$lang.cancel_for}
            {if $domain.id}
                <strong><a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/">{$domain.name}</a></strong>
            {elseif $service.id}
                <strong><a href="{$ca_url}clientarea&amp;action=services&amp;service={$service.id}">{$service.catname} - {$service.name}</a></strong>
            {/if}
        </p>
        <table width="100%" align="center">
            <tbody>
                <tr><td colspan="2">{if $reasons}{$lang.cancel_describe2}{else}{$lang.cancel_describe}{/if}</td></tr>
                <tr>
                    <td colspan="2">
                        {if $reasons}
                            {foreach from=$reasons item=reason name=foo}
                                <div class="radio" {if $smarty.foreach.foo.first}style="margin-top: 0;" {/if}>
                                    <label>
                                        <input type="radio" name="reason" value="{$reason.id}" onclick="$('textarea[name=other_reason]').prop('required', false).prop('disabled', true);">
                                        {$reason.reason}
                                    </label>
                                </div>
                            {/foreach}
                            <div class="radio">
                                <label>
                                    <input type="radio" name="reason" value="other" onchange="$('textarea[name=other_reason]').prop('required', true).prop('disabled', false);">
                                    {$lang.other}
                                </label>
                            </div>
                            <textarea style="width: 99%;" rows="6" name="other_reason" disabled></textarea>
                        {else}
                            <textarea style="width: 99%" rows="6" name="reason"></textarea>
                        {/if}
                    </td>
                </tr>
                <tr><td >{$lang.canceltype}
                        <select name="type">
                            {foreach from=$cancelopt item=name key=opt}
                                <option value="{$opt}">{if $lang[$name]}{$lang[$name]}{else}{$name}{/if}</option>
                            {/foreach}
                        </select></td>
                        <td align="right"> <input type="submit" value="{$lang.cancelrequest}" class="btn btn-danger btn-large" />
                            {$lang.or}
                            {if $domain.id}
                                <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/">{$lang.backtoservice}</a>
                            {elseif $service.id}
                                <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$lang.backtoservice}</a>
                            {/if}
                        </td>
                </tr>
            </tbody></table>

        {securitytoken}
    </form>
</div>