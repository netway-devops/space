



<div class="submenu">
    <div class="submenu-header">
        <h4>Reseller Tools</h4>
        <p>&nbsp;</p>
    </div>
        <!-- First box with links-->
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">Reseller Tools</li>
					<!-- <li><a {if $cmd == 'clientarea' && $REQUEST.rvaction == 'rootcommission'}class=""{/if} href="index.php?cmd=clientarea&rvaction=rootcommission">Root Commission<span></span></a></li> -->
					<li><a {if $cmd == 'clientarea' && $REQUEST.rvaction == 'apikey'}class=""{/if} href="index.php?cmd=clientarea&rvaction=apikey">API Key<span></span></a></li>
                </ul>
            </div>
        </div>


        <div class="center-btn">
        <a href="{$ca_url}clientarea/" class="btn support-btn l-btn">
            <i class="icon-support-home"></i>
            {$lang.dashboard}
        </a>
        </div>

    </div>