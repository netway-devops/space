<div class="box box-primary {$widget.class} {if $widget.metadata.collapsed}collapsed-box{/if}" data-is-widget="true" data-widget-id="{$widget.ns}.{$widget.key}" {if $widget.metadata.autorefresh}data-widget-autorefresh="{$widget.metadata.autorefresh}"{/if}>
    <div class="box-header" >

        <h3 class="box-title">{if $lang[$widget.name]}{$lang[$widget.name]}{else}{$widget.name}{/if} {$widget.header}</h3>

        <div class="box-tools pull-right">
            <button type="button" class="btn btn-sm btn-default box-widget-autorefresh" data-widget="autorefresh"><i class="fa fa-cog"></i></button>
            <button type="button" class="btn btn-sm btn-default box-widget-refresh" data-widget="refresh"><i class="fa fa-refresh"></i></button>
            <button type="button" class="btn btn-sm btn-default box-widget-expand" data-widget="expand"><i class="fa fa-expand"></i></button>
            <button type="button" class="btn btn-sm btn-default box-widget-collapse" data-widget="collapse"><i class="fa {if $widget.metadata.collapsed}fa-plus{else}fa-minus{/if}"></i></button>
            <button type="button" class="btn btn-sm btn-default box-widget-remove" data-widget="remove"><i class="fa fa-times"></i></button>
        </div>
    </div>
    <div class="box-body">
        {if $widget.template}
            {include file=$widget.template|replace:'/':$DS}
        {elseif $widget.html}
            {$widget.html}
        {/if}
    </div>
    {if $widget.footer}
        <div class="box-footer clearfix no-border">
            {$widget.footer}
        </div>
    {/if}
</div>