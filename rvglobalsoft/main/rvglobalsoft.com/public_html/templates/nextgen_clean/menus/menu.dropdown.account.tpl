<div class="cntn">
    <div class="row">
        <div class="span8">
            <div class="row ">
                <div class="span5">
                    <ul class="span2">
                        <li class="nav-header span2">{$lang.mainaccount}</li>
                        {foreach from=$sitemap.account.pages item=link}
                            {if $link.mainmenu && $link.group=='general'}
                                <li>
                                    <a {if $link.active}class="active"{/if} href="{$link.url}">
                                        {$lang[$link.lang]}
                                    </a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>

                    <ul class="span2">
                        <li class="nav-header span2">{$lang.billing}</li>
                        {foreach from=$sitemap.account.pages item=link}
                            {if $link.mainmenu && $link.group=='billing'}
                                <li>
                                    <a {if $link.active}class="active"{/if} href="{$link.url}">
                                        {$lang[$link.lang]}
                                    </a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>

                    <ul class="span2">
                        <li class="nav-header span2">{$lang.userhistory}</li>
                        {foreach from=$sitemap.account.pages item=link}
                            {if $link.mainmenu && $link.group=='history'}
                                <li>
                                    <a {if $link.active}class="active"{/if} href="{$link.url}">
                                        {$lang[$link.lang]}
                                    </a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </div>
                <div class="span3">
                    <center>
                        <div class="iconwrap"><span style="" class="iconfont-card iconfont-size5 silver"></span><br/></div>
                        <p class="silver">{$lang.managedetailsinfo}</p>
                        <button href="{$ca_url}clientarea/" class="btn btn-success"><i class="icon-user icon-white"></i> {$lang.dashboard}</button>
                    </center>
                </div>
            </div>
        </div>
    </div>
</div>