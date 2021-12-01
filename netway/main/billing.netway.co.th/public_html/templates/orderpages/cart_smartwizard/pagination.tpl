{if $step}<a href="{$ca_url}cart{if $step > 1}&step={$prevstep}{/if}" >
<div class="pagination-left-button left">
    <span class="pag-arrow"></span>
    <span class="openSansBold">{$lang.back}</span>
</div>
</a>{/if}
<div class="pagination-page-box left {if !$step}more{/if}">
    <ul>
        <li class="pagination-page{if $step==0} pagination-active-page{/if}"></li>
        <li class="pagination-page{if $step==1} pagination-active-page{/if}"></li>
        <li class="pagination-page{if $step==2} pagination-active-page{/if}"></li>
        <li class="pagination-page{if $step==3} pagination-active-page{/if}"></li>
        <li class="pagination-page{if $step==4} pagination-active-page{/if}"></li>
        <li class="pagination-page{if $step==5} pagination-active-page{/if}"></li>
    </ul>
</div>