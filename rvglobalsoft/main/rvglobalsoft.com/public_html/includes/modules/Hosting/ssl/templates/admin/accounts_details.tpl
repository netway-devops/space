<!--<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td width="50%" valign="top">
            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                <tbody>
                    <tr>
                        <td width="150"><b>Package</b></td>
                        <td><div>{$accounts.product_name} ({$accounts.commonname})</div></td>
                    </tr>
                    <tr>
                        <td width="150"><b>E-mail Approval</b></td>
                        <td><div>{$accounts.email_approval}</div></td>
                    </tr>
                    
                </tbody>
            </table>
       </td>
       <td width="50%" valign="top">
            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                <tbody>
                    <tr>
                        <td width="150"><b>Server</b></td>
                        <td><div  id="serversload">{$accounts.server_type}</div></td>
                    </tr>
                    <tr>
                        <td width="150"></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
       </td>
   </tr>
   <tr>
        <td colspan="2" valign="top">
            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                <tbody>
                    <tr>
                        <td width="150" valign="top"><b>CSR</b></td>
                        <td><div  id="serversload"><textarea rows="20" cols="100" readonly="true">{$accounts.csr}</textarea></div></td>
                    </tr>
                </tbody>
            </table>
        </td>
   </tr>
   
   <tr>
        <td colspan="2" valign="top">
            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                <tbody>
                    <tr>
                        <td>
                            ทำการสั่งซื้อ SSL ไปยัง Authority ให้เรียบร้อยก่อน หลังจากนั้น นำหมายเลข Authority Order ID มากรอกในช่อง Authority Order Id<br />
                            <b>Authority Order Id:</b>&nbsp;&nbsp;<input type="text" id="authority_orderid" name="authority_orderid" value="" /><input type="button" value="Submit" onclick="doupdate('authority_orderid');"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>
   </tr>
</table>
<script type="text/javascript">
{literal}
    function doupdate(action)
    { 
{/literal}
        var order_id = {$accounts.order_id};
        var url = "{$ca_url}";
{literal}
        data = {
            cmd: 'ssl',
            order_id: order_id
        };
        if (action == 'authority_orderid') {
            data.action = 'ajax_authority_orderid';
            data.auth_orderid = $('#authority_orderid').val();
            if (data.auth_orderid == undefined || data.auth_orderid == '') {
                alert('Please input Authority Order Id!!');
                return false;
            }
        }

        $.ajax({
            type: 'POST',
            data: data,
            success: function(data) {
                location.reload(true);
            },
            error: function(xhr,error) {
                respError = $.parseJSON(xhr.responseText);
                alert( "Whois API connection has error!! " + respError.message);
            }
         });
        return false;
    }
{/literal}
</script>
-->
