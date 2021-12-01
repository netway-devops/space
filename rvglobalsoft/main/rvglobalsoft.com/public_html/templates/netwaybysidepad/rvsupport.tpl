 <!-- RVG Support -->
 <div class="container">
	<div class="col-md-12">
		<div class="rv_inpage_support">
			<h1><img src="{$template_dir}images/icon_support.gif" alt="support" width="40" height="40" align="absmiddle" /><span>SUPPORT</span></h1>
			<div class="bgline"></div>
		</div>
		<div class="rvsupport">
			<div class="rvblock marr">
				<div class="bdr-block">
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td align="left" valign="top"><a href="{$ca_url}tickets/"><img class="marl" border="0" src="{$template_dir}images/icon-ticket.gif" alt="support" width="44" height="47" /></a></td>
							<td align="left" valign="top"><a href="{$ca_url}tickets/"><h1 style="margin-top:-15px; margin-bottom:-5px;">Open a Ticket</h1></a><img  src="{$template_dir}images/bullet-arrow.gif" alt="support"  border="0" width="10" height="13" />&nbsp;&nbsp;<a href="{$ca_url}tickets/new/">Send a Ticket.</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="rvblock marr">
				<div class="bdr-block">
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td align="left" valign="top"><a href="{$ca_url}knowledgebase/"><img class="marl" src="{$template_dir}images/icon-know.gif" alt="support"  border="0" width="44" height="47" /></a></td>
							<td align="left" valign="top"><a href="{$ca_url}knowledgebase/"><h1>Knowledgebase</h1></a></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="rvblock">
				<div class="bdr-block">
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td align="left" valign="top"><a href="{$ca_url}clientarea/details/"><img class="marl" src="{$template_dir}images/icon-account.gif" alt="support" border="0" width="57" height="44" /></a></td>
							<td align="left" valign="top"><a href="{$ca_url}clientarea/details/"><h1>My Account</h1></a></td>
						</tr>
					</table>
				</div>
			</div>
			<br clear="all" />
		</div>
		<br clear="all" /> 
		<!-- Services -->
		{if $action=='article'}
			{if $article}
				<div class="text-block clear clearfix">
					<h5>{$article.title|ucfirst}</h5>
					<div class="brcrm clear clearfix">
						<ul class="breadcrumb left">
							<li><a href="{$ca_url}knowledgebase/">{$lang.knowledgebase|capitalize}</a> <span class="divider">/</span></li>
						{foreach from=$path item=p}<li><a href="{$ca_url}knowledgebase/category/{$p.id}/{$p.slug}/">{$p.name}</a> <span class="divider">/</span></li>{/foreach}
						<li class="active">{$article.title}</li>
					</ul>
		
					<div class="clear"></div>
				</div>
				<div class="pt15">
					<p>{$article.body}</p>
				</div>
			</div>
		{/if}
		
		{elseif $action=='category'}
			<div class="text-block clear clearfix">
				<h5 style="float:none">{$lang.knowledgebase|capitalize}: {$category.category.name|capitalize}</h5>
			{if $category.category.description!=''}<p class="p19 pt0">{$category.category.description}</p>{/if}
			<div class="brcrm clear clearfix">
				<ul class="breadcrumb left">
					<li><a href="{$ca_url}knowledgebase/">{$lang.knowledgebase|capitalize}</a> <span class="divider">/</span></li>
				{foreach from=$path item=p}<li><a href="{$ca_url}knowledgebase/category/{$p.id}/{$p.slug}/">{$p.name}</a> <span class="divider">/</span></li>{/foreach}
			</ul>
			<div class="clear"></div>
		</div>
		<div class="pt19 clerfix">
		
		
			{if !$category.categories && !$category.articles}
				<p>{$lang.nothing}</p>
			{/if}
		
			{if $category.categories}
				<div class="s-form">
					<h5>{$lang.categoriesun} {$category.category.name}:</h5>
					<ul class="nav nav-list downloadable-list clear clearfix">
						{foreach from=$category.categories item=i}
							<li><i class="icon-tiny-arrow-r"></i><a href="{$ca_url}knowledgebase/category/{$i.id}/{$i.slug}">{$i.name} <span>({$i.elements})</span></a></li>
		
						{/foreach}
					</ul>
				{/if}
		
		
				{if $category.articles}
				<div class="s-form">
						<h5>{$lang.articlesun} {$category.category.name}</h5>
						<ul class="nav nav-list downloadable-list clear clearfix">
							{foreach from=$category.articles item=i}
								<li><i class="icon-tiny-arrow-r"></i><a href="{$ca_url}knowledgebase/article/{$i.id}/{$i.slug}/">{$i.title}</a></li>
									{/foreach}
						</ul>
				</div>      
				{/if}
		
			</div>
		</div>
		
		{else}
			<div class="text-block clear clearfix">
				<!--<h5>{$lang.knowledgebase|capitalize}</h5>-->
					<div class="clear clearfix">
						<div class="table-box">
						   <!--
							<div class="table-header">
								<p class="small-txt">{$lang.kbwelcome}</p>
							</div>
							-->
						<div class="content-padding s-form">
							<form method="post" action="{$ca_url}knowledgebase/search/">
								<label>{$lang.search_article}</label>
								<div class="input-bg">
		
									<input type="text" name="query" placeholder="{$query}" class="search-field">
									<button type="submit" class="clearstyle"><i class="icon-search"></i></button>
								</div>
								{securitytoken}</form>
							<div class="dotted-line"></div>
		
							{if $action=='search'}
								<h5 style="float:none">{$lang.search_results}</h5>
								{if $results}
									{foreach from=$results item=i}
										<a href="{$ca_url}knowledgebase/article/{$i.id}/{$i.slug}/">{$i.title}</a>
		
										{$i.body|nl2br}<br />
										<br/>
									{/foreach}
		
								{else}
									<p>{$lang.search_nothing}</p>
								{/if}
							{else}
								{if $categories && $categories.categories}
									<h5 class="s-title">{$lang.currentcats}</h5>
									<ul class="nav nav-list downloadable-list clear clearfix">
										{foreach from=$categories.categories item=i}
											<li><i class="icon-tiny-arrow-r"></i><a href="{$ca_url}knowledgebase/category/{$i.id}/{$i.slug}/">{$i.name} <span>({$i.elements})</span></a></li>
												{/foreach}
									</ul>
		
		
								{else}
									<p>{$lang.nothing}</p>
								{/if}
		
							{/if}
						</div>
					</div>
				</div>
			</div>
		{/if}
	</div>
</div>

