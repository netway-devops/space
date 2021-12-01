<!-- Menu -->
<div class="wrapper-menu">
    <div class="menu-bg">
        <nav class="center-area">
            <ul class="nav nav-pills">
                {if $logged=='1'}
                    {include file='menus/menu.main.logged.tpl'}
                {else}
                    {include file='menus/menu.main.notlogged.tpl'}
                {/if}
            </ul>
        </nav>
    </div>
    <script type="text/javascript">nav_resize()</script>
</div>
<!-- End of Menu -->