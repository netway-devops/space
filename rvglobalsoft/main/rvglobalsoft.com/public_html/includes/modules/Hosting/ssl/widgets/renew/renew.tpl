<div id="ssl_nothing" align="center"></div>
<script type="text/javascript">
    {literal}
    $('#ssl_nothing').css('height', $('.nav-list').css('height'));
    var url = '{/literal}{$system_url}{$ca_url}{literal}clientarea/services/ssl/{/literal}{$id}{literal}&action=renew';
    window.location.replace(url);
    showText();
    
    function showText(){
        $('#ssl_nothing').text('Redirect to Renew Page');
        setTimeout(genText, 500, 0);
    }

    function genText(i){
        i++;
        if(i == 4){
            i = 1;
        }
        var dot = '.'.repeat(i);
        $('#ssl_nothing').text('Redirect to Renew Page' + dot);
        setTimeout(genText, 500, i);
    }
    
    String.prototype.repeat = function( num )
    {
        return new Array( num + 1 ).join( this );
    }
    {/literal}
</script>