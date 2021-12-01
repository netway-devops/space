{*

Browse email history

*}
<article>
    {if $email}
        <div class="pull-right">
            <a href="{$ca_url}{$cmd}/{$lang.$action}/" class="btn c-white-btn"><i class="icon-back"></i>{$lang.back}</a>
        </div>
        <h2><i class="icon-dboard"></i> {$email.subject}</h2>
        <p>{$lang.sent} {$email.date|dateformat:$date_format}</p>
        <h5>{$email.subject}</h5>

        <div class="p19">
            <p >{$email.message}</p>
        </div>

    {else}
        <h2><i class="icon-dboard"></i> {$lang.accounthistory}</h2>
        <p>{$lang.account_descr}</p>
        <ul id="support-tab" class="nav nav-tabs table-nav">
            <li class="active"><a href="#" ><div class="tab-left"></div> {$lang.myemails}<div class="tab-right"></div></a></li>
            <li><a href="{$ca_url}clientarea/history/" ><div class="tab-left"></div> {$lang.logs}<div class="tab-right"></div></a></li>
        </ul>

        <!-- Tab Content-->
        <div class="tab-content account-history">
            <!-- Tab #1 -->
            <div class="tab-pane active" id="tab1">
                <div class="p15">
                    <div class="pull-right">
                        <form class="form-inline" href="{$ca_url}clientarea/emails/" method="post">
                            <div class="content-search">
                                <button type="submit" name="resetfilter=1" class="btn c-green-btn btn-rds pull-right">{$lang.Go}</button>
                                <i class="icon-search pull-left"></i>
                                <div class="overflow-hidden">
                                    <input type="text" placeholder="Search e-mails..." name="filter[subject]" value="{$currentfilter.subject}" id="d_filter">
                                </div>
                            </div>

                        </form>
                    </div>
                    <h2>{$lang.emhistory}</h2>
                    <p>{$lang.email_info}</p>

                    <div class="table-box m15 overflow-h">
                        <div class="table-header">
                        </div>
                        <a href="{$ca_url}clientarea&amp;action=emails" id="currentlist" style="display:none" updater="#updater"></a>
                        <input type="hidden" id="currentpage" value="0" />
                        <table class="table table-header-fix table-striped p-td">
                            <tr>
                                <th class="w80"><a href="{$ca_url}clientarea&amp;action=emails&amp;orderby=subject|ASC" class="sortorder"><i class="icon-sort"></i>{$lang.subject}</a></th>
                                <th><a href="{$ca_url}clientarea&amp;action=emails&amp;orderby=date|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.date_sent}</a></th>
                            </tr>
                            <tbody id="updater">
                                {include file='ajax/ajax.emails.tpl'}
                            </tbody>
                        </table>
                    </div> 
                </div> 
            </div>
        </div>
        <div class="pagination c-pagination clearfix">
            <ul rel="{$totalpages}">
                <li class="pull-left dis"><a href="#"><i class="icon-pagin-left"></i> {$lang.previous}</a></li>
                <li class="pull-right dis"><a href="#">{$lang.next}<i class="icon-pagin-right"></i></a></li>
            </ul>
        </div>
    {/if}
</article>