


<div class="submenu">
    <div class="submenu-header">
        <h4>{$lang.tickets}</h4>
        <p>{$lang.wereherephrase}</p>
    </div>
        <!-- First box with links-->
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">{$lang.tickets}</li>
                    <li><a href="{$ca_url}tickets/new/">{$lang.openticket}<span></span></a></li>
                    <li><a href="https://rvglobalsoft.zendesk.com/hc/en-us/requests">{$lang.ticketarchive}<span></span></a></li>
                </ul>
            </div>
        </div>
        
        <!-- Second box with links-->
        {if $enableFeatures.kb!='off'}
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">{$lang.knowledgebase}</li>
                    <li><a href="https://rvglobalsoft.zendesk.com/hc/en-us">{$lang.vsarticles}<span></span></a></li>
                </ul>
            </div>
        </div>
        {/if}
        
        <!-- Third box with links-->
        {if $enableFeatures.downloads!='off'}
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">{$lang.downloads}</li>
                    <li><a href="{$ca_url}downloads/">{$lang.browsedownloads}<span></span></a></li>
                </ul>
            </div>
        </div>
        {/if}
        
        <!-- Fourth box with links-->
        {if $enableFeatures.chat!='off'}
		<!--
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li><a href="{$ca_url}chat/">{$lang.chat}<span></span></a></li>
                </ul>
            </div>
        </div>
		-->
        {/if}
        
        {if $enableFeatures.netstat!='off'}
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li><a href="{$ca_url}netstat/">{$lang.netstat}<span></span></a></li>
                </ul>
            </div>
        </div>
        {/if}
        
        <div class="center-btn">
        <a href="https://rvglobalsoft.zendesk.com/hc/en-us/requests" class="btn support-btn l-btn">
            <i class="icon-support-home"></i>
            {$lang.supporthome}
        </a>
        </div>
       
    </div>