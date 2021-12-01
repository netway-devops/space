{*

    This is empty wrapper template, its job is just to render/show widget

*}{if $widget.template}
    {include file=$widget.template}
{elseif $widget.html}
    {$widget.html}
{/if}