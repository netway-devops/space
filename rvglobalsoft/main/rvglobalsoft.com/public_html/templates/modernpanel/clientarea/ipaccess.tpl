{*

Security/IP access settings

*}

<article>
    <h2><i class="icon-acc"></i> {$lang.account}</h2>
    <p>{$lang.account_descr}</p>
    <div class="account-info-box">
        {include file='clientarea/leftnavigation.tpl'}

        <div class="account-info-container">
            <div class="padding">
                <div class="header-p pull-right">{$lang.currentipadd} {$yourip}</div>
                <h2>{$lang.ipaccess}</h2>

                <div class="clearfix">
                    <div class="well m15">
                        <form method="post" action="">
                            <input type="hidden" name="make" value="addrule" />
                            {*
                            <button type="submit" class="btn c-green-btn"><i class="icon-add"></i> {$lang.addipsubnet}</button>
                           *}
                            <div class="well-info">

                                {$lang.ipsubnet}
                                <span class="row">
                                    <input name="rule" type="text" class="span4" placeholder="eg. {$yourip}">
                                    <div class="pull-right ">
                                    <button type="submit" class="btn c-green-btn"><i class="icon-add"></i> {$lang.addipsubnet}</button>
                                     </div>
                                </span>
                            </div>
                            {securitytoken}
                        </form>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-box">
                    <div class="table-header">
                        <p>{$lang.ipsubnet}</p>
                    </div>
                    <div class="table-content">
                        {foreach from=$rules item=rule name=rules}
                            <p>
                                {if $rule.rule == 'all'}
                                    {$lang.allaccess} - 
                                {else}
                                    {$rule.rule} - 
                                {/if}
                                <a class="deleteico" href="{$ca_url}{$cmd}/{$action}/&make=delrule&id={$rule.id}">{$lang.delete}</a>
                            </p>
                        {foreachelse}
                            <p>{$lang.norules} - {$lang.allaccess}</p>
                        {/foreach}
                    </div>
                </div>
                <!-- End of Table -->

                <div class="separator-line"></div>

                <ul class="rules-list">
                    <li class="header-list"><strong>{$lang.ruleformat}:</strong></li>
                    <li><strong>all</strong> - {$lang.keywordmatchingall}</li>
                    <li><strong>xxx.xxx.xxx.xxx</strong> - {$lang.singleiprule}</li>
                    <li><strong>xxx.xxx.xxx.xxx/M</strong> - {$lang.ipmaskrule}</li>
                    <li><strong>xxx.xxx.xxx.xxx/mmm.mmm.mmm.mmm</strong></li>
                    <li>{$lang.ipmaskruledoted}</li>
                </ul>

                <ul class="rules-list rules-m">
                    <li class="header-list"><strong>{$lang.examplerules}:</strong></li>
                    <li>{$lang.ruleexample1}</li>
                    <li>{$lang.ruleexample2}</li>
                </ul>
            </div>
        </div>
    </div>     
</article>

