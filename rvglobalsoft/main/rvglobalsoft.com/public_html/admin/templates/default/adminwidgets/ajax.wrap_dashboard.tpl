
        {if $widget.template}
            {include file=$widget.template}
        {elseif $widget.html}
            {$widget.html}
        {/if}
