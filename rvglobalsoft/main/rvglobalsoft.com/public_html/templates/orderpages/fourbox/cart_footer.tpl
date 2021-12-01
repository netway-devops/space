
	<div id="footer">
		<div id="cFooter">
			<div class="info">
				<h1>{$lang.aboutcompany}</h1>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
			</div>
			<div class="links">
				<h1>{$lang.quicklinks}</h1>
				<ul>
                                    <li ><a href="index.php">{$lang.homepage}</a></li>
                                    <li><a href="{$ca_url}clientarea/">{$lang.clientarea}</a></li>
                                    <li ><a href="{if $logged=='1'}{$ca_url}support/{elseif $enableFeatures.kb!='off'}{$ca_url}knowledgebase/{else}{$ca_url}tickets/new/{/if}"  >{$lang.support}</a></li>
                                    {if $enableFeatures.affiliates!='off'}<li><a href="{$ca_url}affiliates/" >{$lang.affiliates}</a></li>{/if}
                                    {if $enableFeatures.chat!='off'}<li><a href="{$ca_url}chat/" {if $cmd=='cart'}target="_blank"{/if}>{$lang.chat}</a></li>{/if}
				</ul>
			</div>
			<div class="contact">
				<a href="{$ca_url}cart/"><img src="{$orderpage_dir}fourbox/images/web_logo.png" alt=""/></a>
				
				<p class="p2"></p>
			</div>
			<p id="copyright">Copyright &#169; {$business_name} {'Y'|date}. All rights reserved</p>
		</div>
	</div>