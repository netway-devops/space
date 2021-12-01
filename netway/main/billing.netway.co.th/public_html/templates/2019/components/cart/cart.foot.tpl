
    </div>

    {if $step!=5 && $step!=0 && $step!=4 && !$has_own_ajax}
        <div class="col-lg-4 col-md-5 col-12">
            {include file="`$template_path`components/cart/cart.sidemenu.tpl"}
        </div>
    {/if}
</div>
