<article>
    <div class="pull-right">
        <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" class="btn c-white-btn"><i class="icon-back"></i>{$lang.back}</a>
    </div>
    <h2><i class="icon-lastest-news"></i> {$lang.cancellrequest}</h2>
    <p>
        {$lang.cancel_for} 
        {if $service.domain} {$service.name} - {$service.domain}
        {else}
            {$service.catname} - {$service.name}
        {/if}
    </p>

    <form action="" method="post" class="form-inline">
        <input type="hidden" value="cancel" name="make"/>
        <div class="table-box m15 overflow-h">
            <div class="table-header"></div>
            <table class="table table-header-fix table-striped p-td">
                <tbody>
                    <tr><th colspan="2">{$lang.cancel_describe}</th></tr>
                    <tr>
                        <td colspan="2">
                            <textarea style="width: 882px;" rows="6" name="reason"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td >{$lang.canceltype}
                            <select name="type">
                                <option value="Immediate">{$lang.immediate}</option>
                                <option value="End of billing period">{$lang.endofbil}</option>
                            </select>
                        </td>
                        <td align="right"> 
                            <input type="submit" value="{$lang.cancelrequest}" class="btn c-orange-btn" />
                            <a class="btn c-green-btn" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$lang.backtoservice}</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
        {securitytoken}
    </form>
</article>
