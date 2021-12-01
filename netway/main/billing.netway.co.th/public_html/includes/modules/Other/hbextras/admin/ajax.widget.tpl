<div id="hb_extras_content"></div>
{literal}
<script>
    function bindHBExtras(){
        ajax_update("?cmd=module&module=hbextras&do=getrss",{},"#hb_extras_content");
    }
    appendLoader("bindHBExtras");
</script>

{/literal}