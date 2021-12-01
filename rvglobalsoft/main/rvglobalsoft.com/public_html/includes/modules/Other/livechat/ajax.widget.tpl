
            <table border="0" cellspacing="0" width="100%" class="table">
                <tr>
                    <th width="33%">Visitors online:</th>
                    <th width="33%">Staff online:</th>
                    <th width="33%" style="border-right:none;">Active chats:</th>
                </tr>
                <tr>
                    <td><h2 style="margin:0px">{$visitors}</h2></td>
                    <td><h2 style="margin:0px">{$operators_cnt}</h2></td>
                    <td><h2 style="margin:0px">{$active}</h2></td>
                </tr>
                <tr>
                    <td colspan="3"  align="center">
                        <button class="btn btn-success" onclick="return open_chat_console();">
                            <i class="fa fa-comments-o"></i> <strong>Open chat console</strong>
                        </button>

                    </td>
                </tr>
            </table>

{literal}
<script type="text/javascript">
    var chat_window;
    function open_chat_console() {
        if ( typeof( chat_window ) == "undefined" )
            chat_window = window.open( 'index.php?cmd=hbchat&action=popup', '{/literal}{$security_token}{literal}' , "scrollbars=yes,menubar=no,resizable=1,location=no,location=0,width=986,height=493,status=0" ) ;
        else if ( chat_window.closed )
            chat_window = window.open( 'index.php?cmd=hbchat&action=popup',  '{/literal}{$security_token}{literal}' , "scrollbars=yes,menubar=no,resizable=1,location=no,location=0,width=986,height=493,status=0" ) ;

        if ( chat_window )
            chat_window.focus() ;
        return false;
    }

</script>
{/literal}