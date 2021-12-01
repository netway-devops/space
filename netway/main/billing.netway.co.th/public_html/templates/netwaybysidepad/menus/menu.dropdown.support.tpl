


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
                    <li><a href="{$ca_url}tickets/new/">Open New Support Ticket</a></li>
                    <li><a href="{$zendeskSSOUrl}">Tickets Archive<span></span></a></l
                </ul>
            </div>
        </div>
        
        <!-- Second box with links-->
        {if $enableFeatures.kb!='off'}
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">{$lang.knowledgebase}</li>
                    <li><a href="{$ca_url}knowledgebase/">{$lang.vsarticles}<span></span></a></li>
                </ul>
            </div>
        </div>
        {/if}
        
        <!-- Third box with links-->
        {if $enableFeatures.downloads!='off'}
        <div class="nav nav-list" style="display:none">
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
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li><a href="{$ca_url}chat/">{$lang.chat}<span></span></a></li>
                </ul>
            </div>
        </div>
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
        
        <div class="center-btn" style="display:none">
        <a href="{$ca_url}support/" class="btn support-btn l-btn">
            <i class="icon-support-home"></i>
            {$lang.supporthome}
        </a>
        </div>
       
    </div>