{*

    This is empty wrapper template, its job is just to render/show widget

*}{if $cwidget.template}
    {include file=$cwidget.template}
{elseif $cwidget.html}
    {$cwidget.html}
{/if}