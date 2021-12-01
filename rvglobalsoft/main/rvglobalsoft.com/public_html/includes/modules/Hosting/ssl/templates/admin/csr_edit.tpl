<!--<ul class="accor">
	<li>
		<a href="#">SSL - CSR</a>
			
		<div  class="sor">

<table border="0" cellpadding="3" cellspacing="0" width="100%" class="glike" id="AddAddonT">
<tr>
<th align="left">
	<input type="hidden" value="{$accounts.csr}" name="csr_old" id="csr_old">
	ลิงค์ตรวจสอบ CSR ที่ถูกต้อง <a href="https://ssl-tools.verisign.com/checker/" target="_blank">https://ssl-tools.verisign.com/checker/</a><br />
	<textarea rows="20" cols="100" name="csr_new" id="csr_new">{$accounts.csr}</textarea><br />
<input type="button" value="บันทึก CSR ใหม่" onclick="updatecsr('authority_orderid');"/>
</th>
</tr>
</table>


</div>
</li></ul>
<script type="text/javascript">
{literal}
    function updatecsr(action)
    { 
{/literal}
        if(confirm("ต้องการเปลี่ยน CSR ใช่ไหม?") == false) return false;
        var order_id = {$accounts.order_id};
        var url = "{$ca_url}";
{literal}
        data = {
            cmd: 'ssl',
            order_id: order_id
        };

            data.action = 'ajax_updatecsr';
            data.auth_orderid = $('#authority_orderid').val();
            data.csr_old = $('#csr_old').val();
            data.csr_new = $('#csr_new').val();
            if (data.csr_new == undefined || data.csr_new == '') {
                alert('Please input CSR!!');
                //return false;
            }
      

        $.ajax({
            type: 'POST',
            data: data,
            success: function(data) {
                location.reload(true);
            },
            error: function(xhr,error) {
                respError = $.parseJSON(xhr.responseText);
                alert( "Update has error!! " + respError.message);
            }
         });
        return false;
    }
{/literal}
</script>
-->
