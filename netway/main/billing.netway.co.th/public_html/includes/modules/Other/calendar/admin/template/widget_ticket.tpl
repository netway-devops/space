<div id="calendar-event-list-wrapper">
    <script>
        if (typeof calendar_init == 'function')
            Calendar.viewlist = {$elist|@json_encode}, calendar_init();
    </script>
    <div class="ticket-calendar panel panel-default" id="calendar-event-list">
    </div>
</div>

