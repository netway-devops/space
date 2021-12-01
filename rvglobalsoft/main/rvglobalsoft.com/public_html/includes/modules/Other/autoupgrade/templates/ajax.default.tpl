<iframe src="https://hostbillapp.com/latest/" frameborder="0" border="0" style="width:650px;height:400px" />
<script type="text/javascript">
    {literal}

    $('#facebox .footer').append(
            '<div class="left" style="padding: 3px 15px;"><input type="checkbox" id="dontshowmeagain" name="dontshowmeagain"> <label for="dontshowmeagain">Dont show this message again</label></div>'
    );
    $('#facebox .close').addClass('btn').addClass('btn-primary').addClass('btn-sm').text('Close');

    $(document).bind('close.facebox',function(){
        if ($("#dontshowmeagain").is(":checked")) {
            ajax_update('?cmd=autoupgrade&action=dismiss');
        }
    });
    {/literal}
</script>