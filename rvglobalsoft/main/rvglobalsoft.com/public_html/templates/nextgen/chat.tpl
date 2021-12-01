{literal}<script type="text/javascript">

    $(document).ready(function() {
        var popup = null;
        if (typeof(hb_footprint) != "undefined") {
            popup = hb_footprint.startChat();
            if (!popup
            || popup.closed
            || (typeof popup.closed == 'undefined')
            || popup.outerHeight == 0
            || popup.outerWidth == 0
            ) {
                $('#popUpBlocked').show();
            }
            else {
                window.location = '{/literal}{$system_url}{literal}index.php';
            }
        }else{
            window.location = '{/literal}{$system_url}{literal}index.php';
        }
    });
    </script>
{/literal}
<div id="popUpBlocked" class="alert" style="display: none;">
    <strong>{$lang.warning}!</strong> 
    <p>{$lang.popupsenable} <br> {$lang.tryenablingpopups} </p>
</div>