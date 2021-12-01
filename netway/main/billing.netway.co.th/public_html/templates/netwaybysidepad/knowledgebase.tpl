{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'knowledgebase.tpl.php');
{/php}

<!--- ทำขึ้นมาเอง --->

{include file="knowledgebase_custom.tpl"}

<!--- ไม่ใช้ของ Hostbill --->

{if $action=='noactionjustwanttoskipthisblock'}

<!-- Services -->
{if $action=='article'}
    {if $article}

		<!-- Modal -->
		<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <h3 id="myModalLabel">Already Customer</h3>
		  </div>
		  <div class="modal-body">
		    <form action="{$system_url}knowledgebase/article/{$article.id}/" method="post">
		        {assign var="onlycustomer" value="1"}
		        {include file="ajax.login.tpl"}
		    </form>
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		  </div>
		</div>
	
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
            <p align="center">เอกสารนี้อยู่ระหว่างการปรับปรุงให้ดียิ่งขึ้น สามารถให้บริการได้อีกครั้งในวัน หรือสองวันนี้ ขออภัยในความไม่สดวก</p>
            {else}
            <p>{$article.body}</p>
            {/if}
        </div>
		
		{if $logged =='1' || $adminlogged}
        <div class="pt15">
            <div>
            	<p class="well well-small">ลูกค้ายังไม่เข้าใจในส่วนใด สามารถเขียน comment ทางบริษัทจะได้ดำเนินการปรับปรุงเอกสารให้ดียิ่งขึ้น</p>
            </div>
		    <div id="disqus_thread"></div>
		    <script type="text/javascript">
		    	{literal}
		        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
		        var disqus_shortname = 'netway'; // required: replace example with your forum shortname
		        
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
	            หากเห็นว่าเอกสารช่วยเหลือนี้มีส่วนที่ต้องปรับปรุงเพิ่มเติม หรือลูกค้ายังไม่เข้าใจในส่วนใด
				สามารถ <strong>login</strong> เพื่อเขียน comment ทางบริษัทจะได้ดำเนินการปรับปรุงเอกสารให้ดียิ่งขึ้น
	        </span>
	        <span class="span2">
	            <a href="javascript:return false;" class="btn btn-success pull-right" data-toggle="modal" data-target="#loginModal">Login</a>
	        </span>
	    </div>
		{/if}
		
        <div class="pt15">
            <p>&nbsp;</p>
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
                {foreach from=$category.categories item=i key=k}
                    <li><i class="icon-tiny-arrow-r"></i><a href="{$ca_url}knowledgebase/category/{$i.id}/{$aCategory.categories[$k].slug}{*$i.slug*}">{$i.name} <span>({$i.elements})</span></a></li>

                {/foreach}
            </ul>
        {/if}


        {if $category.articles}
        <div class="s-form">
                <h5>{$lang.articlesun} {$category.category.name}</h5>
                <ul class="nav nav-list downloadable-list clear clearfix">
                    {foreach from=$category.articles item=i key=k}
                        <li><i class="icon-tiny-arrow-r"></i><a href="{$ca_url}knowledgebase/article/{$i.id}/{$aCategory.articles[$k].slug}{*$i.slug*}/">{$i.title}</a></li>
                            {/foreach}
                </ul>
        </div>      
        {/if}

    </div>
</div>

{else}
    <div class="text-block clear clearfix">
        <h5>{$lang.knowledgebase|capitalize}</h5>
        <div class="clear clearfix">
            <div class="table-box">
                <div class="table-header">
                    <p class="small-txt">{$lang.kbwelcome}</p>
                </div>
                <div class="content-padding s-form">
                    <form method="post" action="{$ca_url}knowledgebase/search/">
                        <label>{$lang.search_article}</label>
                        <div class="input-bg">

                            <input type="text" name="query" value="{$query}" placeholder="{$query}" class="search-field">
                            <button type="submit" class="clearstyle"><i class="icon-search"></i></button>
                        </div>
						<div>
							<span class="info">เงือนไข</span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="term" id="term" value="OR" {if !isset($term) || $term != 'AND'} checked="checked" {/if}> มีคำใดก็ได้ 
							&nbsp;&nbsp;
							<input type="radio" name="term" id="term" value="AND" {if isset($term) && $term == 'AND'} checked="checked" {/if}> จะต้องมีทุกคำที่ระบุ 
						</div>
                        {securitytoken}</form>
                    <div class="dotted-line"></div>

                    {if $action=='search'}
                        <h5 style="float:none">{$lang.search_results}</h5>
                        {if $results}
                            {foreach from=$results item=i key=k}
                                <a href="{$ca_url}knowledgebase/article/{$i.id}/{$aResults[$k].slug}{*$i.slug*}/">{$i.title}</a>

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

{/if}

<div class="row"><p>&nbsp;</p></div>

{literal}
<script language="javascript">
$(document).ready( function () {
    {/literal}{if isset($blogUrl)}{literal}
    $('a[href="http://www.blog.netway.co.th"]').attr('href', '{/literal}{$blogUrl}{literal}');
    {/literal}{/if}{literal}
});
</script>
{/literal}

