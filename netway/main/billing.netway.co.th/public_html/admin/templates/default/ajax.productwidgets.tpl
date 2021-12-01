{if ($cmd=='services' && $action=='product') }
    <script type="text/javascript" src="{$template_dir}js/hbwidget.js?v={$hb_version}"></script>
    <script type="text/javascript">
        HBWidget.product_id = "{$product_id}";
    </script>
{/if}
{if ($cmd=='services' && $action=='product') || ($cmd=='productwidgets' && $loadproduct)}
    {include file="services/productwidgets/ajax.list.tpl"}
{elseif $action=='editwidget'}
    {include file="services/productwidgets/ajax.editwidget.tpl"}
{/if}