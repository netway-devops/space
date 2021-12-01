<script>
    var Calendar = {if $calendar}{$calendar|@json_encode}{else}{literal}{}{/literal}{/if};
    {if $elist}Calendar.viewlist = {$elist|@json_encode};{/if}
</script>

<link href="{$moduledirurl}css/calendar.css?v={$hb_version}" rel="stylesheet" />
<script src="{$moduledirurl}js/calendar.min.js?v={$hb_version}"></script>

