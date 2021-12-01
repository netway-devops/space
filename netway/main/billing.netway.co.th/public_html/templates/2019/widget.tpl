<div class="card">
    <div class="card-body">
        {if $cwidget.template}
            {include file=$cwidget.template}
        {elseif $cwidget.html}
            {$cwidget.html}
        {/if}
    </div>
</div>