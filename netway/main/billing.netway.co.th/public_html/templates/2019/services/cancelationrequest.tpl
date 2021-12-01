<section class="section-account-header d-flex flex-row justify-content-between align-items-start">
    <div>
        <h2>{$lang.cancellrequest}</h2>
        <h5 class="my-5">
            {$lang.cancel_for}
            <b>
                {if $domain.id}
                    {$domain.name}
                {elseif $service.id}
                    {if $service.domain} {$service.name} - {$service.domain}
                    {else}
                        {$service.catname} - {$service.name}
                    {/if}
                {/if}
            </b>
        </h5>
    </div>
    {if $domain.id}
        <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/" class="btn btn-sm btn-secondary">
            <i class="material-icons size-sm icon-btn-color">chevron_left</i>
            {$lang.back}
        </a>
    {elseif $service.id}
        <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" class="btn btn-sm btn-secondary">
            <i class="material-icons size-sm icon-btn-color">chevron_left</i>
            {$lang.back}
        </a>
    {/if}
</section>

<section class="section-cancelation-request">
    <div class="message-box message-box-file card">
        <div class="card-header">{if $reasons}{$lang.cancel_describe2}{else}{$lang.cancel_describe}{/if}</div>
        <div class="card-body">
            <form action="" method="post">
                <div class="form-group">
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
                        <textarea class="form-control form-control-noborders textarea-autoresize" cols="60" rows="6"  name="other_reason" placeholder="{$lang.writemessage}" disabled="disabled"></textarea>
                    {else}
                        <textarea class="form-control form-control-noborders textarea-autoresize" cols="60" rows="6"  name="reason" placeholder="{$lang.writemessage}" required="required"></textarea>
                    {/if}
                </div>
                <div class="d-flex flex-column-reverse flex-md-row align-items-center justify-content-start w-100">
                    <div class="col-12 col-md-6 col-lg-4 col-xl-3">
                        <button type="submit" class="btn btn-danger mt-3 mt-md-0 w-100">{$lang.cancelrequest}</button>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4 col-xl-3">
                        <select class="form-control ml-0 ml-md-1" name="type">
                            <option value="" disabled>{$lang.canceltype}</option>
                            {foreach from=$cancelopt item=name key=opt}
                                <option value="{$opt}">{if $lang[$name]}{$lang[$name]}{else}{$name}{/if}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <input type="hidden" value="cancel" name="make"/>
                {securitytoken}
            </form>
        </div>
    </div>
</section>

