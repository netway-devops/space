
	<div id="footer">
		<div id="cFooter">
			<div class="info">
				{if $opconfig.footerheader}<h1>{$opconfig.footerheader}</h1>{/if}
				{if $opconfig.footertext}<p>{$opconfig.footertext}</p>{/if}
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
				<a href="{$ca_url}cart/"><img src="{$orderpage_dir}dedicated/images/web_logo.png" alt=""/></a>
				
				<p class="p2"></p>
			</div>
			{if $opconfig.copyright}<p id="copyright">{$opconfig.copyright}</p>{/if}
		</div>
	</div>