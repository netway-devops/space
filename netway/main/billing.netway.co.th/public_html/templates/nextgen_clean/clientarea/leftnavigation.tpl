{foreach from=$sitemap.account.pages item=link key=type name=leftnav}
    {if $link.visible && $link.subnav}
        <div class="box-feature {if $link.active}active{/if}">
            <a href="{$link.url}">
                <div class="sh-icon">
                    {if $type == 'details'}
                        <span class="iconfont-user iconfont-size4 silver"></span>
                    {elseif $type == 'profilepassword' || $type == 'password'}
                        <span class="iconfont-lock iconfont-size4 silver" ></span>
                    {elseif $type == 'ccard' || $type == 'ach'}
                        <span class="iconfont-card iconfont-size4 silver" ></span>
                    {elseif $type == 'ipaccess'}
                        <span class="iconfont-cloud-upload iconfont-size4 silver" ></span>
                    {elseif $type == 'addfunds'}
                        <span class="iconfont-plus-round iconfont-size4 silver" ></span>
                    {elseif $type == 'profiles'}
                        <span class="iconfont-add-user iconfont-size4 silver" ></span>
                    {elseif $type == 'settings'}
                        <span class="iconfont-gear iconfont-size4 silver" ></span>
                    {else}
                        <span class="iconfont-ellipsis iconfont-size4 silver"></span>
                    {/if}
                </div>
            </a>
            <h4>
                {if $lang[$link.alt_lang]}{$lang[$link.alt_lang]}
                {else}{$lang[$link.lang]}
                {/if}
            </h4>
        </div>
    {/if}
{/foreach}