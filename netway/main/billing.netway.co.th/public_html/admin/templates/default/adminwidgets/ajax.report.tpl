<div id="report_widget_{$report.id}" >{if $cached}{include file=$cached.tpl series=$cached.series cachedon=$cached.time}{/if}</div>
{if !$cached}
<script>
    function bind_report_widget_{$report.id}(){literal} {
        ajax_update('?cmd=reports&action=loadwidget&id={/literal}{$report.id}{literal}', {}, '#report_widget_{/literal}{$report.id}{literal}', true);
    }
    {/literal}
    appendLoader('bind_report_widget_{$report.id}');
    {if $ajax}
    bind_report_widget_{$report.id}();
    {/if}
</script>{/if}