{if $action=='article'}
{if $article}
<center>
    <h3>{$article.title}</h3>
    {$lang.tags}: {$article.tags}<br>

    {$lang.body}:{$article.body}<br>

    {if !$wasvoted}
    <form method="post" action="">
        <input type="hidden" name="make" value="wasuseful" />       
        {$lang.wasthisarticleusefulyou} <input type="submit" value="yes"/>
        {securitytoken}</form>
    {/if}

    {$lang.articleviewed}: {$article.viewed} {$lang.times}, {$article.useful}% {$lang.wasuseful}.
</center>

{/if}

{elseif $action=='category'}

{if $category}

{$lang.category}:{$category.name}<br>
{$lang.Description}{$category.description}<br>
<hr>
{/if}

{if $articles}
{$lang.articles}:<br>
{foreach from=$articles item=i}
<a href="{$ca_url}knowledgebase/article/{$i.id}/">{$i.title}</a><br><br>
{/foreach}
{/if}

{else}
{if $categories}
{$lang.currentcats}<br>
{foreach from=$categories item=i}
<a href="{$ca_url}knowledgebase/category/{$i.id}/">{$i.name}</a> - {$i.description}<br><br>
{/foreach}

{else}
{$lang.nothing}
{/if}
{/if}