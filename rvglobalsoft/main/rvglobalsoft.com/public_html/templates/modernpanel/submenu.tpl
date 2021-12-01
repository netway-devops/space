<aside id="submenu" >
    {if $cmd == 'downloads' ||  $cmd == 'knowledgebase' || $cmd == 'tickets' || $cmd == 'support'}
        {include file='submenu/support.submenu.tpl'}
    {/if}
    {if $cmd == 'affiliates' && $affiliate && $logged=='1'}
        {include file='submenu/affiliates.submenu.tpl'}
    {/if}
    {if $cmd == 'clientarea' &&  $action == 'default' && $logged=='1'}
        {include file='submenu/dashboard.submenu.tpl'}
    {elseif $cmd == 'clientarea' && (($action == 'services' && !$service) || ($action == 'domains' && !$edit)) && $logged=='1' && !$custom_template}
        {include file='submenu/services.submenu.tpl'}
    {elseif $cmd == 'clientarea' && $action == 'invoices' && $logged=='1'}
        {include file='submenu/invoices.submenu.tpl'}
    {/if}
    {if $cmd=='cart'}{include file="../orderpages/cart.sidemenu.tpl"}{/if}
</aside>
<script type="text/javascript">$('#submenu').children().length ? $('#submenu').parent().addClass('fullside') : $('#submenu').hide().parent().addClass('emptyside')</script>