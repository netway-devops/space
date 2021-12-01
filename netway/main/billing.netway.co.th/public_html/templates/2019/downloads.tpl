<section class="section-downloads">
    {if $action=='category'}
        <h1>{$category.name}</h1>
        {if $category.description!=''}
            <h5 class="my-5">{$category.description}</h5>
        {/if}

        {if !$files}
            <h4 class="my-5">{$lang.nothing}</h4>
        {/if}

        {if $files}
            <div class="card w-100 my-3">
                <ul class="list-group list-group-flush">
                    {foreach from=$files item=file}
                        <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$file.id}" target="_blank" class="list-group-item">
                            <i class="material-icons icon-info-color mr-3">insert_drive_file</i>
                            <span class="text-small">{$file.name}</span>
                            <small class="pull-right badge badge-primary">{if $file.size>0}{$file.size} KB{/if}</small>
                        </a>
                    {/foreach}
                </ul>
            </div>
            <br/>
        {/if}
    {else}
        <h1>{$lang.downloads|capitalize}</h1>
        <h5 class="mt-5 mb-3">{$lang.browsedownloads}</h5>
        <div class="row">
            {if $myfiles}
                <div class="col-lg-6 col-md-6 col-xs-12 col-12 mt-4">
                    <div class="d-flex flex-row justify-content-between align-items-center">
                        <h4>{$lang.myfiles_down}</h4>
                    </div>
                    <div class="card w-100 my-3">
                        <ul class="list-group list-group-flush">
                            {foreach from=$myfiles item=file}
                                <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$file.id}" target="_blank" class="list-group-item">
                                    <i class="material-icons icon-info-color mr-3">insert_drive_file</i>
                                    <span class="text-small">{$file.name|truncate:100:"..."}</span>
                                    <small class="pull-right badge badge-primary">{if $file.size>0}{$file.size} KB{/if}</small>
                                </a>
                            {foreachelse}
                                <span class="list-group-item">
                                    <span class="text-small text-center">{$lang.nothing}</span>
                                </span>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            {/if}
            {if $categories}
                {foreach from=$categories item=cat}
                    <div class="col-lg-6 col-md-6 col-xs-12 col-12 mt-4">
                        <div class="d-flex flex-row justify-content-between align-items-center">
                            <h4>{$cat.name}</h4>
                            <a href="{$ca_url}downloads/category/{$cat.id}/{$cat.slug}/" class="btn btn-sm btn-secondary btn-view-all">
                                {$lang.viewall}
                                <i class="material-icons ml-2 size-sm icon-btn-color">chevron_right</i>
                            </a>
                        </div>
                        <div class="card w-100 my-3">
                            <ul class="list-group list-group-flush">
                                {foreach from=$cat.files item=file}
                                    <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$file.id}" target="_blank" class="list-group-item">
                                        <i class="material-icons icon-info-color mr-3">insert_drive_file</i>
                                        <span class="text-small">{$file.name|truncate:100:"..."}</span>
                                        <small class="pull-right badge badge-primary">{if $file.size>0}{$file.size} KB{/if}</small>
                                    </a>
                                {foreachelse}
                                    <span class="list-group-item">
                                        <span class="text-small text-center">{$lang.nothing}</span>
                                    </span>
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                {/foreach}
            {else}
                {$lang.nothing}
            {/if}
        </div>
    {/if}
</section>