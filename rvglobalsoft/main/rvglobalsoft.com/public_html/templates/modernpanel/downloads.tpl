<article>
    <h2>
        <i class="icon-supp"></i> 
        {if $enableFeatures.kb!='off' && $enableFeatures.downloads!='off'}
            {$lang.knowledgebase|capitalize} & {$lang.downloads|capitalize}
        {else}
            {$lang.downloads|capitalize}
        {/if}
    </h2>
    <p>{$lang.browsedownloads}</p>

    <div class="invoices-box clearfix">
        <ul id="invoice-tab" class="nav nav-tabs table-nav">
            {if $enableFeatures.kb!='off'}
                <li >
                    <a href="{$ca_url}knowledgebase/" ><div class="tab-left"></div> {$lang.knowledgebase}<div class="tab-right"></div></a>
                </li>
            {/if}
            <li class="active">
                <a href="{$ca_url}downloads/" ><div class="tab-left"></div> {$lang.downloads}<div class="tab-right"></div></a>
            </li>

        </ul>
        <div class="tab-content support-tab tab-auto no-p">

            <!-- Tab #1 -->
            <div class="tab-pane active" id="tab1">
                {if $categories }
                    <!-- Support Menu -->
                    <div class="support-menu">
                        <div class="tab-header">
                            <p>{$lang.categories}</p>
                        </div>
                        <ul class="nav">

                            {foreach from=$categories item=i}
                                <li>
                                    <a href="{$ca_url}downloads/category/{$i.id}/{$i.slug}/">
                                        <div class="border-bg"></div>
                                        <p>{$i.name}</p>
                                        <span>{$i.files} {$lang.files}</span>
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
                        <p>{$lang.files}</p>
                    </div>
                    <div class="padding">
                        {if $category}
                            <div class="pull-right">
                                <a  href="{$ca_url}downloads/" class="btn c-white-btn"><i class="icon-back"></i>{$lang.back}</a>
                            </div>
                        {/if}
                        {if $action=='default'}
                            {if $myfiles}
                                <h2>{$lang.myfiles_down}</h2>
                                <div class="separator-line"></div>
                                {foreach from=$myfiles item=i name=loop}
                                    <div class="download-box">
                                        <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="link">{$i.name}</a>
                                        <p>{$i.description}</p>
                                        <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="btn c-white-btn">
                                            <i class="icon-close-issue"></i> 
                                            {$lang.download} {if $i.size>0}({$i.size} KB)
                                            {/if}
                                        </a>
                                    </div>
                                    {if !$smarty.foreach.loop.last}
                                        <div class="separator-line"></div>
                                    {/if}
                                {/foreach}
                            {/if}

                            {if $popular}
                                <h2>{$lang.popular_down}</h2>
                                <div class="separator-line"></div>

                                {foreach from=$popular item=i name=loop}
                                    <div class="download-box">
                                        <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="link">{$i.name}</a>
                                        <p>{$i.description}</p>
                                        <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="btn c-white-btn">
                                            <i class="icon-close-issue"></i> 
                                            {$lang.download} {if $i.size>0}({$i.size} KB)
                                            {/if}
                                        </a>
                                    </div>
                                    {if !$smarty.foreach.loop.last}
                                        <div class="separator-line"></div>
                                    {/if}
                                {/foreach}
                            {/if}

                        {elseif $action=='category'}
                            <h2>{$lang.filesunder} {$category.name}</h2>
                            <div class="separator-line"></div>

                            {if $category.description!=''}
                                <p>{$category.description}</p>
                            {/if}

                            {foreach from=$files item=i name=loop}
                                <div class="download-box">
                                    <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="link">{$i.name}</a>
                                    <p>{$i.description}</p>
                                    <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$i.id}" class="btn c-white-btn">
                                        <i class="icon-close-issue"></i> 
                                        {$lang.download} {if $i.size>0}({$i.size} KB)
                                        {/if}
                                    </a>
                                </div>
                                {if !$smarty.foreach.loop.last}
                                    <div class="separator-line"></div>
                                {/if}
                            {/foreach}
                        {/if}
                    </div>
                </div>
            </div>
            <!-- End of Support Container-->
        </div>
        <!-- End of Tab #1 -->
    </div>
</article>