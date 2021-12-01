<div id="ssl_nothing" align="center"></div>
<script type="text/javascript">
    {literal}
    $('#ssl_nothing').css('height', $('.nav-list').css('height'));
    var url = '{/literal}{$system_url}{$ca_url}{literal}clientarea/cancel&id={/literal}{$id}{literal}';
    window.location.replace(url);
    showText();
    
    function showText(){
        $('#ssl_nothing').text('Redirect to Revoke Page');
        setTimeout(genText, 500, 0);
    }

    function genText(i){
        i++;
        if(i == 4){
            i = 1;
        }
        var dot = '.'.repeat(i);
        $('#ssl_nothing').text('Redirect to Revoke Page' + dot);
        setTimeout(genText, 500, i);
    }
    
    String.prototype.repeat = function( num )
    {
        return new Array( num + 1 ).join( this );
    }
    {/literal}
</script>