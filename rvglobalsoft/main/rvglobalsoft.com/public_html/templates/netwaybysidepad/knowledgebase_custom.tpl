<style>

{literal}

.clear-mp{
    padding:0;
    margin:0;
}
</style>

{/literal}

<div class="kb-support">
    
    <!-- RVG Support -->
   
    <h1><img src="{$template_dir}images/icon_support.gif" alt="support" width="40" height="40" align="absmiddle" />&nbsp;<span>SUPPORT</span></h1>
   
    
    <!-- Link Support --> 
	<div class="row-fluid"><div class="col-md-12 clear-mp kb-topline"></div></div>
    <div class="row-fluid kb-support-menu" style="background:#09447e;">
        <div class="span2 clear-mp">
            <div class="dropdown">
            <a href="#" class="btn btn-block btn-danger dropdown-toggle" data-toggle="dropdown">
                <span class="icon-ticket icon-white"></span> Submit ticket
                <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <!-- dropdown menu links -->
                <li class="disabled"><a tabindex="-1" href="#">Ask for help about ?</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="{$ca_url}tickets/new&deptId=5">RVsitebuilder</a></li>
                <li class="dropdown-submenu">
                    <a tabindex="-1" href="{$ca_url}tickets/new&amp;deptId=6">RVskin</a>
                    <ul class="dropdown-menu" style="top: -20px;">
                        <li><a tabindex="-1" href="{$ca_url}tickets/new&amp;deptId=6">RVadmintools</a></li>
                        <li><a tabindex="-1" href="{$ca_url}tickets/new&amp;deptId=6">RVlogin</a></li>
                        <li><a tabindex="-1" href="{$ca_url}tickets/new&amp;deptId=6">RVsubversion</a></li>
                    </ul>
                </li>
                <li><a tabindex="-1" href="{$ca_url}tickets/new&deptId=2">Billing &amp; license</a></li>
            </ul>
            </div>
        </div>
        <div class="span2 clear-mp"  style="padding:0; margin:0;">
            <a href="{$ca_url}verifyrvlicense" class="btn btn-block" style="white-space:nowrap;"><span class="icon-verify"></span> Verify license</a>
        </div>
        <div class="span2 clear-mp"  style="padding:0; margin:0;">
            <a href="{if isset($forumUrl)}{$forumUrl}{else}http://forum.rvglobalsoft.com/?rvglobalsoft.com=1{/if}&hbsid={$hbsid}" target="_blank" class="btn btn-block"><span class="icon-forums"></span> Forums</a>
        </div>
        <div class="span2 clear-mp"  style="padding:0; margin:0;">
            <a href="{if isset($blogUrl)}{$blogUrl}{else}http://blog.rvglobalsoft.com/{/if}" target="_blank" class="btn btn-block"><span class="icon-blog"></span> Blog</a>
        </div>
        <div class="span2 clear-mp" style="padding:0; margin:0;">
            <a href="{if isset($yoursayUrl)}{$yoursayUrl}{else}http://forums.rvskin.com/index.php?showforum=13{/if}" target="_blank"  class="btn btn-block" style="white-space:nowrap;"><span class="icon-feature"></span> Feature Request</a>
        </div>
        <div class="span2 clear-mp" style="padding:0; margin:0;">
            <a href="{if isset($vdotutorials)}{$vdotutorials}{else}https://goo.gl/J3vY8q{/if}" target="_blank"  class="btn btn-block" style="white-space:nowrap;"><span class="icon-video"></span> Video Tutorials</a>
        </div>
        
    </div>
    
    <!-- 
	<div class="rv_inpage_support">
        <h1><img src="{$template_dir}images/icon_support.gif" alt="support" width="40" height="40" align="absmiddle" />&nbsp;<span>Knowledgebase</span></h1>
        <div class="bgline"></div>
    </div>
	-->
	<br />


    <!-- Search and jump -->
    <div class="row-fluid">
        <div class="span6">
            <div class="btn-group">
                <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#">
                    Jump to category
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                    {foreach from=$listCategories item=aCat}
                    {$aCat.content}
                    {/foreach}
                </ul>
            </div>
            
        </div>
        <div class="span6 clear-mp" style="margin-top:15px; padding-right: 67px;">
            <div class="pull-right">
                <form method="post" action="{$ca_url}knowledgebase/search/" class="form-search">
                    <div class="input-append">
                        <input type="text" name="query" value="{$query}" class="span12 search-query" placeholder="search keyword">
                        <button type="submit" class="btn"><i class="icon-search"></i> Search</button>
                    </div>
                </form>
                
            </div>
        </div>
    </div>
    
    {if $action != 'article' && $action != 'search'}
    <div><p>&nbsp;</p></div>
    
    <div class="brcrm clear clearfix">
        <ul class="breadcrumb left">
            <li><a href="{$ca_url}knowledgebase/">{$lang.knowledgebase|capitalize}</a> <span class="divider">&rsaquo;&rsaquo;</span></li>
            {foreach from=$path item=p}
                <li><a href="{$ca_url}knowledgebase/category/{$p.id}/{$p.slug}/">{$p.name}</a> <span class="divider">&rsaquo;&rsaquo;</span></li>
            {/foreach}
        </ul>
        <div class="clear"></div>
    </div>

    
    <!-- List category tree -->
    {if $listSubCategories|@count}
    <div><p>&nbsp;</p></div>
    <div class="row">
        
        {foreach from=$listSubCategories key=catId item=aCat}
        <div class="span4">
            <h4><a href="{$ca_url}knowledgebase/category/{$aCat.id}/{$aCat.slug}/">{$aCat.name}</a></h4>
            {if $aCat.items|@count}
            <ul class="kb-sub-category">
                {foreach from=$aCat.items key=subId item=aSub}
                <li><a href="{$ca_url}knowledgebase/category/{$aSub.id}/{$aSub.slug}/">{$aSub.name}</a></li>
                {/foreach}
            </ul>
            {/if}
        </div>
        {/foreach}
        
    </div>
    {/if}
    
    <!-- List article under category -->
    {if $listArticles|@count}
    <div><p>&nbsp;</p></div>
	<h2>{$p.name} : </h2>
    <ul class="unstyled">
        {foreach from=$listArticles item=aArticle}
        <li>
            <a href="{$ca_url}knowledgebase/article/{$aArticle.id}/{$aArticle.slug}/">{$aArticle.title}</a>
            {if $aArticle.description}
            <blockquote>
                {$aArticle.description}
                <small class="pull-right">Tags: <cite title="Tags">{$aArticle.tags}</cite></small>
            </blockquote>
            {/if}
        </li>
        {/foreach}
    </ul>
    {/if}
    
    {/if}
    
</div>


{if $action=='search'}
<div><p>&nbsp;</p></div>
<div class="col-md-12 kb-support clear-mp">
    <h2><b>{$lang.search_results}</b></h2>
    <div class="kb-line"></div>
    {if $results}
    <ul class="unstyled">
        {foreach from=$results item=i}
        <li>
            <a href="{$ca_url}knowledgebase/article/{$i.id}/{$i.slug}/">{$i.title}</a>
            {if $i.description}
            <blockquote>
                {$i.description}
                <small class="pull-right">Tags: <cite title="Tags">{$i.tags}</cite></small>
            </blockquote>
            <p>&nbsp;</p>
            {/if}
        </li>
        {/foreach}
    </ul>
    {else}
        <p class="kb-bg-found">{$lang.search_nothing}</p>
    {/if}
</div>
{/if}



{if $action == 'article' && $article}

{literal}
<script language="JavaScript">
var iframeIsLoaded      = false;
$(document).ready( function () {
    $('iframe').load(function() {
        if (iframeIsLoaded) {
            return false;
        }
        setTimeout(iResize, 1000);
        // Safari and Opera need a kick-start.
        var iSource = document.getElementById('gDocs').src;
        document.getElementById('gDocs').src = '';
        document.getElementById('gDocs').src = iSource;
    });
});

function iResize() {
    document.getElementById('gDocs').style.height = 
    document.getElementById('gDocs').contentWindow.document.body.offsetHeight + 'px';
    if (! $('#gDocs').hasScrollBar()) {
        iframeIsLoaded  = true;
    }
}

(function($) {
    $.fn.hasScrollBar = function() {
        return this.get(0).scrollHeight > this.height();
    }
})(jQuery);
</script>
{/literal}

<div><p>&nbsp;</p></div>
<div class="col-md-12 kb-support clear-mp">
    <div class="text-block clear clearfix">
        <h5>{$article.title|ucfirst}</h5>
        <div class="brcrm clear clearfix">
            <ul class="breadcrumb left">
                <li><a href="{$ca_url}knowledgebase/">{$lang.knowledgebase|capitalize}</a> <span class="divider">/</span></li>
                {foreach from=$path item=p}
                <li><a href="{$ca_url}knowledgebase/category/{$p.id}/{$p.slug}/">{$p.name}</a> <span class="divider">/</span></li>
                {/foreach}
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
        <div class="row-fluid kb-support"> 
			<div class="well"> 
				<div class="span2"></div>
				<div class="span6">
					<div class="well-small">
						<span class="kb-icon-key"></span>
						<div class="middle-screen1">If you do not understand or want to give us more updates, please comment
					by  <strong>login</strong> then leave a suggestion.</div>
					</div>
				</div>
				<div class="span2 aleft">
					<div class="middle-screen2"><a href="javascript:return false;" class="btn btn-success pull-left" data-toggle="modal" data-target="#loginModal">Login</a></div>
				</div>
				<div class="span2"></div>
				<div class="clearit"></div>
			</div>
        </div>
        {/if}
        
    </div>
</div>
{/if}

<script language="JavaScript">
{literal}
$(document).ready( function () {
    $('.search-tags').each( function () {
        $(this).click( function () {
            $('input[name="query"]').val('tag:'+$(this).text()+'');
            $('.form-search').submit();
            return false;
        });
    });
    
    $('.dropdown-submenu a').each( function () {
        $(this).hover( function () {
            var oOffset             = $(this).offset();
            $(this).next().offset({ top: oOffset.top});
        });
    });
});
{/literal}
</script>