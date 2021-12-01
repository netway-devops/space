{*

Browse logs related to client

*}

<article>
    <h2><i class="icon-dboard"></i> {$lang.accounthistory}</h2>
    <p>{$lang.account_descr}</p>
    <ul id="support-tab" class="nav nav-tabs table-nav">
        <li><a href="{$ca_url}clientarea/emails/" ><div class="tab-left"></div> {$lang.myemails}<div class="tab-right"></div></a></li>
        <li class="active"><a href="#" ><div class="tab-left"></div> {$lang.logs}<div class="tab-right"></div></a></li>
    </ul>

    <!-- Tab Content-->
    <div class="tab-content account-history">
        <!-- Tab #1 -->
        <div class="tab-pane active" id="tab1">
            <div class="p15">

                <h2>{$lang.myhistory}</h2>
                <p>{$lang.accountlogssectionhistory}</p>

                <div class="table-box m15 overflow-h">
                    <div class="table-header">
                    </div>
                    <a href="{$ca_url}clientarea&action=history" id="currentlist" style="display:none" updater="#updater"></a>
                    <input type="hidden" id="currentpage" value="0" />
                    <table class="table table-header-fix table-striped p-td">
                        <tr>
                            <th><a href="{$ca_url}clientarea&action=history&orderby=date|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.date}</a></th>
                            <th class="w60"><a href="{$ca_url}clientarea&action=history&orderby=description|ASC" class="sortorder"><i class="icon-sort"></i>{$lang.Description}</a></th>
                            <th><a href="{$ca_url}clientarea&action=history&orderby=result|ASC"  class="sortorder"><i class="icon-sort"></i>{$lang.status}</a></th>
                            <th class="w10"></th>
                        </tr>
                        <tbody id="updater">
                            {include file='ajax/ajax.history.tpl'}
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
</article>