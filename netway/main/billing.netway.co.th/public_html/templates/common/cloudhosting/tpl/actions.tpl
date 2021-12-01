{if $custom_overrides.cloud_server_actions}
    {include file=$custom_overrides.cloud_server_actions}
    {end}
{/if}

<div id="lock" {if $cloud.action_lock.enabled}style="display:block" class="active"{/if}>
    <img src="templates/common/cloudhosting/images/ajax-loader.gif" alt="">
    {$cloud.action_lock.text}
    {foreach from=$cloud.action_lock.actions item=action}
    <a href="{$action.url}" class="btn btn-mini btn-default {$action.class}">
        {$action.text|capitalize}
    </a>
    {/foreach}
</div>

<ul id="vm-menu">
    {foreach from=$cloud.actions item=action}
        <li>
            <a href="{$action.url}" title="{$action.text|escape}"
                    {if $action.class} class="{$action.class}"{/if} {if $action.id} id="{$action.id}"{/if}
                    {if $action.confirm} onclick="return confirm('{$action.confirm|escape:javascript}')"{/if}
                    {if $action.onclick} onclick="{$action.onclick}"{/if}
            >
                {if $action.img}
                    <div class="vpsdo-icon src-{$action.img.class}">
                        <img src="{$action.img.url}" {if $action.img.alt}alt="{$action.img.alt}"{/if}>
                    </div>
                {/if}
                <span class="vpsdo-decr">
                    {$action.text}
                </span>
            </a>
        </li>
    {/foreach}
</ul>

<script>$(document).trigger('cloud.loaded.actions')</script>