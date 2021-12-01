{*

Security/IP access settings

*}

<div class="text-block clear clearfix">
    <h5>{$lang.account}</h5>
   
    <div class="clear clearfix">
        <div class="account-box">
        
			{include file='clientarea/leftnavigation.tpl'}
            
            <div class="account-content">
            <div class="content-padding">
                <h6>{$lang.ipaccess}</h6>
                <h5 class="pull-right">{$lang.currentipadd}: {$yourip}</h5>
                <div class="overflow-fix">
                <div class="table-box">
                    <div class="table-header">
                        <div class="right-btns-l">
                        <form method="post" action="">
                        <input type="hidden" name="make" value="addrule" />
                            <button type="submit" class="clearstyle green-custom-btn btn l-btn"><i class="icon-white-add"></i> {$lang.addipsubnet}</button>
                        </div>
                        <p class="small-txt">{$lang.ipsubnet}<input class="header-input" type="text" placeholder="eg. {$yourip}"></p>
                        {securitytoken}
                        </form>
                    </div>
                    <div class="content-padding">
                        <div class="well well-small custom-well no-shadow"><strong>{$lang.ipsubnet}</strong></div>
                        {if $rules }
                            {foreach from=$rules item=rule name=rules}
                                <div class="well well-small custom-well no-shadow">
                                    {if $rule.rule == 'all'}
                                        {$lang.allaccess} - 
                                    {else}
                                        {$rule.rule} - 
                                    {/if}
                                    <a class="deleteico" href="{$ca_url}{$cmd}/{$action}/&make=delrule&id={$rule.id}">{$lang.delete}</a>
                                </div>
                            {/foreach}
                        {else}
                        <div class="well well-small custom-well no-shadow">{$lang.norules} - {$lang.allaccess}</div>
                        {/if}
                        <div class="well well-small well-legend clear clearfix">
                            <ul>
                            <li class="header-list"><strong>{$lang.ruleformat}:</strong></li>
                            <li>· <strong>all</strong> - {$lang.keywordmatchingall}</li>
                            <li>· <strong>xxx.xxx.xxx.xxx</strong> - {$lang.singleiprule}</li>
                            <li>· <strong>xxx.xxx.xxx.xxx/M</strong> - {$lang.ipmaskrule}</li>
                            <li>· <strong>xxx.xxx.xxx.xxx/mmm.mmm.mmm.mmm</strong></li>
                            <li>- {$lang.ipmaskruledoted}t</li>
                            </ul>
                            
                            <ul class="rules-list">
                             <li class="header-list"><strong>{$lang.examplerules}:</strong></li>
                             <li>· <strong>{$lang.ruleexample1}</li>
                             <li>· <strong>{$lang.ruleexample2}</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
        
        
    </div>
 </div>
 </div>


