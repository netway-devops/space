{if $custom_overrides.cloud_header}
    {include file=$custom_overrides.cloud_header}
    {end}
{/if}

<div class="cloud-top">
    <div class="cloud-header">
        <h1 class="left os-logo {$cloud.header.icon}">{$cloud.header.text}</h1>
        {if $cloud.header_link}
            <a href="{$cloud.header_link.url}" class="left apeded">{$cloud.header_link.text}</a>
        {/if}
    </div>
    <div class="cloud-nav">
        <ul class="level-1">
            {foreach from=$cloud.header_nav item=nav}
                <li class="menu-item{if $nav.active} current-menu-item{/if}{if $nav.items} dropdown{/if}">
                    {if $nav.items}
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            {$nav.text} <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            {foreach from=$nav.items item=subnav}
                                <li {if $subnav.active}class="active"{/if}>
                                    <a href="{$subnav.url}">{$subnav.text}</a>
                                </li>
                            {/foreach}
                        </ul>
                    {else}
                        <a href="{$nav.url}">
                            <span class="{$nav.class}">{$nav.text}</span>
                        </a>
                    {/if}
                </li>
            {/foreach}
        </ul>
    </div>

    <div class="clear"></div>
</div>
