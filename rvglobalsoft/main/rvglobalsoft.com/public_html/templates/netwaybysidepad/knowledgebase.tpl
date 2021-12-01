{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'knowledgebase.tpl.php');
{/php}

{literal}
<style type="text/css">
.sub{ 
	display:none; 
	position:absolute; 
	background-color:#a8a8a8; 
	padding:10px; 
	color:#fff; 
	width:950px; 
	margin-left:0px; 
	z-index:1000; 
}
</style>
{/literal}

<!-- Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <h3 id="myModalLabel">Already Customer</h3>
  </div>
  <div class="modal-body">
    <form id="ajaxFormLogin" action="{$system_url}knowledgebase/article/{$article.id}/" method="post">
        {assign var="onlycustomer" value="1"}
        {include file="ajax.login.tpl"}
    </form>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>

<script language="JavaScript">
{literal}
$(document).ready( function () {

    var loginDialogTitle    = $('#myModalLabel').text();
    $('#ajaxFormLogin').submit( function () {
        $('#myModalLabel').html(''+ loginDialogTitle +'<small> logging in ... ');
        $.post('{/literal}{$ca_url}{literal}clientarea/', $(this).serialize(), function (data) {
            parse_response(data);
            if (data.indexOf("<!-- {") == 0) {
                var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                if (codes.ERROR.length == 0) {
                    window.location.reload(false);
                } else {
                    $('#myModalLabel').html(''+ loginDialogTitle +'<small><br />'+ codes.ERROR +'</small>');
                }
            }
        });
        
        return false;
    });
    
});
{/literal}
</script>
        
<div class="container">
    
    <!--- ทำขึ้นมาเอง --->
    
    {include file="knowledgebase_custom.tpl"}
    
    <!--- ไม่ใช้ของ Hostbill --->
    
    {if $action=='noactionjustwanttoskipthisblock'}
    <div class="col-md-12">
		
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
				    {if $isGDocNotPublish}
				    <p align="center">This document is not complete yet at the moment, but in a few days later. Sorry for the inconvenience.</p>
				    {else}
					<p>{$article.body}</p>
					{/if}
				</div>
				
                {if $logged =='1' || $adminlogged}
                <div class="pt15">
                    <div>
                        <p class="well well-small">If you do not understand or want to give us more updates, please comment</p>
                    </div>
                    <div id="disqus_thread"></div>
                    <script type="text/javascript">
                        {literal}
                        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
                        var disqus_shortname = 'rvglobalsoftcom'; // required: replace example with your forum shortname
                        
                        /* * * DON'T EDIT BELOW THIS LINE * * */
                        (function() {
                            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                        })();
                        {/literal}
                    </script>
                    <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
                    <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
                    <script type="text/javascript">
                        {literal}
                        
                        var disqus_config = function() {
                            this.page.remote_auth_s3 = "{/literal}{$disqusMessage}{literal} {/literal}{$disqusHmac}{literal} {/literal}{$disqusTimestamp}{literal}";
                            this.page.api_key = "{/literal}{$nwDisqusPublicKey}{literal}";
                        }
                        
                        {/literal}
                    </script>
                </div>
                {else}
                <div class="row-fluid well well-small"> 
                    <span class="span9">
                        If you do not understand or want to give us more updates, please comment
                        by  <strong>login</strong> then leave a suggestion.
                    </span>
                    <span class="span2">
                        <a href="javascript:return false;" class="btn btn-success pull-right" data-toggle="modal" data-target="#loginModal">Login</a>
                    </span>
                </div>
                {/if}
				
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
    {/if}
    
    </div>