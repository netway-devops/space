<article>
    <h2>
        <i class="icon-supp"></i> 
        {if $enableFeatures.kb!='off' && $enableFeatures.downloads!='off'}
            {$lang.knowledgebase|capitalize} & {$lang.downloads|capitalize}
        {else}
            {$lang.knowledgebase|capitalize}
        {/if}
    </h2>
    <p>{$lang.kbwelcome}</p>

    <div class="invoices-box clearfix">
        <ul id="invoice-tab" class="nav nav-tabs table-nav">
            <li class="active">
                <a href="{$ca_url}knowledgebase/"><div class="tab-left"></div> {$lang.knowledgebase}<div class="tab-right"></div></a>
            </li>
            {if  $enableFeatures.downloads!='off'}
                <li>
                    <a href="{$ca_url}downloads/"><div class="tab-left"></div> {$lang.downloads}<div class="tab-right"></div></a>
                </li>
            {/if}
        </ul>
        <div class="tab-content support-tab tab-auto no-p">
            {if $category.categories}
                {assign value=$category.categories var=catlist}
            {elseif $categories.categories}
                {assign value=$categories.categories var=catlist}
            {/if}
            <!-- Tab #1 -->
            <div class="tab-pane active" id="tab1">
                {if $catlist }
                    <!-- Support Menu -->
                    <div class="support-menu">
                        <div class="tab-header">
                            <p>{$lang.categories}</p>
                        </div>
                        <ul class="nav">

                            {foreach from=$catlist item=i}
                                <li>
                                    <a href="{$ca_url}knowledgebase/category/{$i.id}/{$i.slug}/">
                                        <div class="border-bg"></div>
                                        <p>{$i.name}</p>
                                        <span>{$i.elements} {$lang.elements}</span>
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    <!-- End of Suppoty Menu -->
                {/if}
                <!-- Support Container -->
                <div class="support-container knowledgebase">
                    <!-- Services -->
                    <div class="tab-header">
                        <p>{$lang.articles}</p>
                    </div>
                    <div class="padding">
                        {if $category.category.parent_cat || $article.cat_id}
                            {foreach from=$path item=p key=key name=patloop}
                                {if $category.category.parent_cat == $p.id || $article.cat_id == $p.id}
                                    <div class="pull-right">
                                        <a href="{$ca_url}knowledgebase/category/{$p.id}/{$p.slug}/" class="btn c-white-btn"><i class="icon-back"></i>{$lang.back}</a>
                                    </div>
                                    {break}
                                {/if}
                            {/foreach}
                        {elseif $category.category || $action == 'search'}
                            <div class="pull-right">
                                <a href="{$ca_url}knowledgebase/" class="btn c-white-btn"><i class="icon-back"></i>{$lang.back}</a>
                            </div>
                        {/if}


                        {if $action=='article'}
                            {if $article}
                                <h2>{$article.title|ucfirst}</h2>
                                <div class="separator-line"></div>
                                <p>{$article.body}</p>
                            {/if}

                        {elseif $action=='category'}   
                            <h2>{$lang.articlesun} {$category.category.name}</h2>
                            <div class="separator-line"></div>

                            {if $category.articles}
                                <ul class="support-nav">
                                    {foreach from=$category.articles item=i}
                                        <li>
                                            <a href="{$ca_url}knowledgebase/article/{$i.id}/{$i.slug}/">{$i.title}</a>
                                        </li>
                                    {/foreach}
                                </ul>
                            {else}
                                <p>{$lang.nothing}</p>
                            {/if}
                        </div>
                    {elseif $action=='search'}
                        <h2>{$lang.search_results}</h2>
                        <div class="separator-line"></div>

                        {if $results}
                            <ul class="support-nav">
                                {foreach from=$results item=i}
                                    <li>
                                        <a href="{$ca_url}knowledgebase/article/{$i.id}/{$i.slug}/">{$i.title}</a>
                                        <p>{$i.body|nl2br}</p>
                                    </li>
                                {/foreach}
                            </ul>
                        {else}
                            <p>{$lang.search_nothing}</p>
                        {/if}

                    {else}
                        <h2>{$lang.welcomekb}</h2>

                        <div class="separator-line"></div>

                        <p>{$lang.kbwelcome}</p>
                        <p>{$lang.stillcantfind}</a></p>
                    {/if}
                </div>
                <!-- End of Support Container-->
            </div>
            <!-- End of Tab #1 -->
        </div>
    </div>
</article>