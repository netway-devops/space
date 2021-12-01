<section class="section-account-header">
    <h1>{$lang.userhistory}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="history"}

<section class="section-account">
    {if $email}
        <div class="mb-4">
            <a href="{$ca_url}clientarea/emails/" class="btn-link my-5"><small>{$lang.back_to_emails}</small></a>
        </div>
        <div class="d-flex flex-row justify-content-between align-items-end">
            <div class="align-bottom">
                <h2 class="align-bottom break-word">{$email.subject}</h2>
            </div>
        </div>

        <div class="content-view-details bordered-section d-flex flex-column justify-content-between p-3 mb-4 text-small">
            <div class="row mb-1"><div class="text-muted col-md-2">{$lang.date}</div> <div >{$email.date|dateformat:$date_format}</div></div>
            <div class=" row mb-1"><div class="text-muted col-md-2">{$lang.email}</div> <div>{$email.email}</div></div>
            <div class=" row "><div class="text-muted col-md-2">{$lang.status}</div> <div>{if $email.status =='1'}<span class="badge badge-Open">{$lang.Sent}</span>{else}<span class="badge badge-danger">{$lang.emaildeliveryfailed}</span>{/if}</div></div>

        </div>
        <div class="my-4">
            <p>{$email.message|httptohref}</p>
        </div>
    {else}
        <h5 class="my-5">{$lang.email_info}</h5>
        <a href="{$ca_url}clientarea/emails/" id="currentlist" style="display:none" updater="#updater"></a>
        <input type="hidden" id="currentpage" value="0" />
        <div class="table-responsive table-borders table-radius">
            <table class="table tickets-table position-relative stackable">
                <thead>
                    <tr>
                        <th class="w-25"><a href="{$ca_url}clientarea&amp;action=emails&amp;orderby=email|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.email}</a></th>
                        <th class="w-50"><a href="{$ca_url}clientarea&amp;action=emails&amp;orderby=subject|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.subject}</a></th>
                        <th><a href="{$ca_url}clientarea&amp;action=emails&amp;orderby=date|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.date_sent}</a></th>

                    </tr>
                </thead>
                <tbody id="updater">
                {include file='ajax/ajax.emails.tpl'}
                </tbody>
            </table>
        </div>
        {include file="components/pagination.tpl"}
    {/if}
</section>