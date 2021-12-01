{if $cmd=='knowledgebase' || ( $enableFeatures.kb!='off' && ($cmd=='support' || $cmd=='downloads') )}
    <div>
        <h2>{$lang.supportpanel}</h2>
        <p class="no-icon">{$lang.basiciformations}</p>
        <form action="{$ca_url}knowledgebase/search/" method="post" class="form-inline">
            <div class="affiliates-panel">
                <div class="content-search">
                    <button type="submit" name="resetfilter=1" class="btn c-green-btn btn-rds pull-right">{$lang.Go}</button>
                    <i class="icon-search pull-left"></i>
                    <div class="overflow-hidden">
                    <input name="query"  value="{$query}" type="text" placeholder="{$lang.search_article}">
                    </div>
                </div>
            </div>
        </form>
    </div>
{/if}
{if $cmd=='tickets' || ($enableFeatures.kb=='off' && $cmd=='support' )}
    <div>
        <h2>{$lang.ticketspanel}</h2>
        <p class="no-icon">{$lang.searchcreatedeleteticketshere}</p>

        <div class="affiliates-panel">
            <form action="{$ca_url}tickets/" method="post" class="form-inline">
                <div class="content-search">
                    <button type="submit" name="resetfilter=1" class="btn c-green-btn btn-rds pull-right">{$lang.Go}</button>
                    <i class="icon-search pull-left"></i>
                    <div class="overflow-hidden">
                    <input type="text" name="filter[subject]" value="{$currentfilter.subject}" placeholder="{$lang.filtertickets}">
                    </div>
                </div>
            </form>
        </div>

        <div class="add-new-service">
            <a href="{$ca_url}tickets/new/" class="btn new-ticket-btn"><i class="icon-new-ticket"></i> {$lang.openticket}</a>
        </div>

        <div class="support-info">
            <i class="icon-support-info"></i>
            <p>{$lang.newticket_desc}</p>
        </div>
    </div>
    <div class="short-separator"> </div>
{/if}

<!-- Quick Menu -->
<div>
    <h2>{$lang.quicklinks}</h2>
    <p class="no-icon">{$lang.supportsmostimportantlinks}</p>
    <div class="quick-menu">
        <ul class="link-list">
            <li {if $cmd == 'support'}class="active"{/if}>
                <a href="{$ca_url}support/">
                    <i class="icon icon-qm-dashboard"></i>
                    <p>{$lang.supporthome}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            <li {if $cmd == 'tickets'}class="active"{/if}>
                <a href="{$ca_url}tickets/">
                    <i class="icon icon-qm-she"></i>
                    <p>{$lang.tickets}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            {if $enableFeatures.kb!='off'}
                <li {if $cmd == 'knowledgebase'}class="active"{/if}>
                    <a href="{$ca_url}knowledgebase/">
                        <i class="icon icon-qm-logs"></i>
                        <p>{$lang.knowledgebase}</p>
                        <span>
                            <i class="icon-single-arrow"></i>
                        </span>
                    </a>
                </li>
            {/if}
            {if $enableFeatures.downloads!='off'}
            <li {if $cmd == 'downloads'}class="active"{/if}>
                <a href="{$ca_url}downloads/">
                    <i class="icon icon-qm-download"></i>
                    <p>{$lang.downloads}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            {/if}
            {if $enableFeatures.netstat!='off'}
                <li>
                    <a href="{$ca_url}netstat/">
                        <i class="icon icon-qm-server"></i>
                        <p>{$lang.netstat}</p>
                        <span>
                            <i class="icon-single-arrow"></i>
                        </span>
                    </a>
                </li>
            {/if}
        </ul>
    </div>
</div>
