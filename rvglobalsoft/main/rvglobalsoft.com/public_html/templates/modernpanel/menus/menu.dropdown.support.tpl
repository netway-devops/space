<div class="dropdown-menu submenu white-space" style="width:600px">
    <div class="wrapper">
        <ul class="nav nav-pills nav-stacked submenu-account-nav">
            <li class="nav-header">{$lang.tickets}</li>
            <li><a href="{$ca_url}tickets/new/">{$lang.openticket}</a></li>
            <li><a href="{$ca_url}tickets/">{$lang.ticketarchive}</a></li>
            <li class="empty-row"></li>
            {if $enableFeatures.netstat!='off'}
                <li><a href="{$ca_url}netstat/">{$lang.netstat}</a></li>
            {/if}
            {if $enableFeatures.chat!='off'}
                <li><a href="{$ca_url}chat/">{$lang.chat}</a></li>
            {/if}
        </ul> 
        {if $enableFeatures.kb!='off'}
            <ul class="nav nav-pills nav-stacked submenu-account-nav">
                <li class="nav-header">{$lang.knowledgebase}</li>
                <li><a href="{$ca_url}knowledgebase/">{$lang.vsarticles}</a></li>
            </ul>
        {/if}
        {if $enableFeatures.downloads!='off'}
            <ul class="nav nav-pills nav-stacked submenu-account-nav">
                <li class="nav-header">{$lang.downloads}</li>
                <li><a href="{$ca_url}downloads/">{$lang.browsedownloads}</a></li>
            </ul>
        {/if}
        <div class="submenu-support-bg"></div>
    </div>
</div>