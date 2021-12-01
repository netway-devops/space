{if $totalpages > 1}
    <div class="d-flex flex-row mt-4">
        <ul class="pagination" rel="{$totalpages}">
            <li class="page-item page-item-left"><a class="page-link" href="#"><i class="material-icons size-xs">chevron_left</i> {$lang.previous}</a></li>
            <li class="page-item page-item-right"><a class="page-link" href="#">{$lang.next} <i class="material-icons size-xs">chevron_right</i></a></li>
        </ul>
    </div>
{/if}