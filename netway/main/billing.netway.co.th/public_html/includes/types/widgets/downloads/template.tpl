<div class="wbox">
    <div class="wbox_header">
        {$lang.downloads|capitalize}
    </div>
    <div class="wbox_content">
        {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
    </div>
    <div class="wbox_content">
        {if $files}
            <ul class="nav list-group list-group-flush">
                {foreach from=$files item=file}
                    <li>
                        <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$file.id}" target="_blank" style="display: flex; flex-direction: row; justify-content: space-between; align-items: start;padding: 8px;" class="list-group-item d-flex flex-row justify-content-between align-items-start border-bottom">
                            <span class="d-flex flex-row" style="display: flex; flex-direction: row">
                                <div class="">
                                    <div class="text-small">{$file.name|truncate:100:"..."}</div>
                                    {if $file.description}
                                        <div class="text-muted muted small mt-2 d-block">{$file.description}</div>
                                    {/if}
                                </div>
                            </span>
                            <span class="pull-right">
                                <small class=" badge badge-primary">{if $file.size>0}{$file.size} KB{/if}</small>
                            </span>
                        </a>
                    </li>
                    {foreachelse}
                    <span class="list-group-item">
                        <span class="text-small text-center">{$lang.nothing}</span>
                    </span>
                {/foreach}
            </ul>
        {else}
            <section class="py-4 text-center text-muted">
                {$lang.nothing}
            </section>
        {/if}
    </div>
</div>