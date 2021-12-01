			<div class="sitemap">
				<div>
					<div class="left"><img src="{$template_dir}images/netway_logo.jpg" width="249" height="83" alt=""></div>
					<div class="right padtop"><a href="{$ca_url}{$paged.url}sitemap">Sitemap</a> <img src="{$template_dir}images/bar.gif" width="2" height="27" alt="" /> 
						<div class="btn-group">
                                <button id="bg" data-toggle="dropdown">

                                    {if $logged=='1'}
                                    <i></i> {$login.firstname} {$login.lastname}
                                    {else}
                                    <i></i> {$lang.login}
                                    {/if}
                                    <span class="caret"></span></button>
                                <ul class="dropdown-menu  pull-right">

                                    {if $logged!='1'}
                                    <li><a href="{$ca_url}signup/">{$lang.createaccount}</a></li>
                                    <li><a href="{$ca_url}clientarea/">{$lang.login}</a></li>
                                    {else}
                                    <li><a href="{$ca_url}clientarea/details/">{$lang.manageaccount}</a></li>
                                    <li><a href="?action=logout">{$lang.logout}</a></li>
                                    {/if}
                                    {if $adminlogged}
                                    <li class="divider"></li>
                                    <li><a  href="{$admin_url}/index.php{if $login.id}?cmd=clients&amp;action=show&amp;id={$login.id}{/if}">{$lang.adminreturn}</a></li>
                                    {/if}

                                </ul>
                            </div>					
						</div>
				</div>
			</div>
			<div class="clearit"></div>	
				