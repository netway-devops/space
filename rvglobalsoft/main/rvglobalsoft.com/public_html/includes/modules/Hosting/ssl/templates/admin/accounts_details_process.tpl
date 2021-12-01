<script src="{$system_url}includes/modules/Hosting/ssl/public_html/js/plugin/jquery.datePicker.js"></script>
<script src="{$system_url}includes/modules/Hosting/ssl/public_html/js/admin/accounts_details_process.js"></script>
{literal}
<style>
    .cssright{
        width:40%;
        text-align:left;
    }
    .cssleft{
        width:10%;
        text-align:left;
        font-weight: bold;
    }
    em {
        font-weight: bold;
        color: #FF0000;
    }
</style>
{/literal}
<div id="content">
    <input type="hidden" id="order_id" name="order_id" value="{$accounts.order_id}" />
    <table width="100%" border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td class="cssleft"nowrap>Package</td>
            <td class="cssright">{$accounts.product_name} ({$accounts.commonname})</td>
            <td class="cssleft" nowrap="true">Authority Order Id:</td>
            <td class="cssright">{$accounts.authority_orderid}</td>
        </tr>
        <tr>
            <td class="cssleft">Approval E-mail</td>
            <td class="cssright">{$accounts.email_approval}</td>
            <td class="cssleft">CSR</td>
            <td class="cssright"><a href="">download</a> (ยังดาวโหลดไม่ได้)</td>
        </tr>
    </table>
{if $dropprocess}
    <!-- start ข้อความบอก staff ว่า ติดปัญหา ยังทำไรต่อไม่ได้ต้องรอ reseller แก้ไขก่อน -->
    <fieldset>
        <h2>
            <font color="red">Order "{$accounts.product_name} ({$accounts.commonname})" อยู่ในระหว่างรอ Reseller ทำการแก้ไขปัญหา</font>
        </h2>
        <br /><br />
        หัวข้อปัญหา : {$aDataMsg.subject}<br />
        รายละเอียด : <br />
        {$aDataMsg.detail}<br />
        <br /><br /><br />
        รายงานเมื่อ : xxx
    </fieldset>
    <!-- end ข้อความบอก staff ว่า ติดปัญหา ยังทำไรต่อไม่ได้ต้องรอ reseller แก้ไขก่อน -->
{else}
        <!-- start order processing -->
        <label for="status_order_item_a">
            <input type="radio" name="status_order_item" id="status_order_item_a" value="A" checked="checked" onclick="clickOptProcess();" /> Order Processing<br />
        </label>
        <!-- start detail processing -->
        <fieldset  id="for_order_processing">
            <label for="status_order_ex_1">
                <input type="radio" name="status_order_ex" id="status_order_ex_1" value="1" {$sta1} /> 
                Buyer ทำการยืนยันตัวตน (Domain Ownership Validation)<br />
            </label>

            <label for="status_order_ex_2">
                <input type="radio" name="status_order_ex" id="status_order_ex_2" value="2"/> 
                {if $validateOrganization}<font color="#cccccc">{/if}
                Authority ทำการตรวจสอบองค์กรณ์ (Organization Validation)<br />
                {if $validateOrganization}</font>{/if}
            </label>
            
    {if $oSSLInfo.status_extend==2}
            <div style="margin-left:50px;">
            ขอเอกสารเพิ่มเติม<br />
  
                <input type="button" name="bu_send_doc" value="ร้องขอเอกสารที่เลือก"/>
                <input type="button" name="bu_send_mail" id="bu_send_mail" value="ส่ง E-mail แจ้งเตือนอีกครั้ง" style="{$chkDoc}" />
                <input type="button" name="bu_send_authority" id="bu_send_authority" style="{$chkDoc}" value="ส่ง เอกสารไปยัง authority"/>
            </div>
    {/if}

            <label for="status_order_ex_3">
                <input type="radio" name="status_order_ex" id="status_order_ex_3" value="3"/> 
                {if $validateCall}<font color="#cccccc">{/if}
                Authority ทำการตรวจสอบดงค์กรณ์ด้วยการโทรศัพท์ (Verify call)<br />
                {if $validateCall}</font>{/if}
            </label>
    {if $oSSLInfo.status_extend==3}
            <div id="div_req_call" style="margin-left:50px;{$msgReqReseller}">
                <input type="button" name="bu_request_call" id="bu_request_call" value="แจ้งให้ reseller นัดวันเวลา" />
            </div>
    
            <div id="div_wait_reseller_call" style="margin-left:50px;{$msgWaitReseller}">
                กำหนดโทร ครั้งที่ 1: รอ reseller นัดหมาย<br />
                กำหนดโทร ครั้งที่ 2: รอ reseller นัดหมาย<br />
                
            </div>
    
            <div id="div_wait_staff_sendcall" style="margin-left:50px;{$msgWaitStaff}">
                กำหนดโทร ครั้งที่ 1 เมื่อ <font color="green">{$phonecall1.date}&nbsp;&nbsp;{$phonecall1.time_start}.00-{$phonecall1.time_to}.00&nbsp;&nbsp;{$phonecall1.time_format}</font><br />
                กำหนดโทร ครั้งที่ 2 เมื่อ <font color="green">{$phonecall2.date}&nbsp;&nbsp;{$phonecall2.time_start}.00-{$phonecall2.time_to}.00&nbsp;&nbsp;{$phonecall2.time_format} (หากครั้งที่ 1 ติดต่อไม่ได้)</font><br />
                <input type="button" name="bu_sendtimecall" id="bu_sendtimecall" value="แจ้งวัน/เวลาไปยัง Authority" />
            </div>
    {/if}
    
    {if $oSSLInfo.status_extend !=3}
            {if $validateCall}<font color="#cccccc">{/if}
            <div style="margin-left:50px;">
                กำหนดโทร ครั้งที่ 1: ยังไม่ได้กำหนด<br />
                กำหนดโทร ครั้งที่ 2: ยังไม่ได้กำหนด<br />
            </div>
            {if $validateCall}</font>{/if}
    {/if}

            <label for="status_order_ex_4">
                <input type="radio" name="status_order_ex"  id="status_order_ex_4" value="4" /> 
                Authority approved request for a certificate.<br />
            </label>

            <label for="status_order_ex_5">
                <input type="radio" name="status_order_ex"  id="status_order_ex_5" value="5" /> 
                Report problems to reseller<br />
            </label>

            <table style="margin-left:50px;">
                <tr>
                    <td>Subject :</td>
                    <td style="text-align:left;"><input type="text" name="problem_subject" /></td>
                </tr>
                <tr>
                    <td valign="top">Message :</td>
                    <td><textarea  name="problem_detail" cols="80" rows="5"></textarea></td>
                </tr>
            </table>

            <input type="submit" name="bu_save" value="Change Processing Status"/>
            <input type="reset" name="bu_reset" value="Reset" />

        </fieldset>
        <!-- end detail processing -->
        <!-- end order processing -->

        <label for="status_order_item_c">
            <input type="radio" name="status_order_item" id="status_order_item_c" value="C" onclick="doshow('#for_order_complete');"/> Order Completed
        </label>
        <!-- start order completed -->
        <fieldset id="for_order_complete" style="display:none;">
            <em>*</em> CERTIFICATE: <br />
            <textarea  cols="100" rows="5" name="code_certificate" id ="code_certificate" ></textarea><br />
            (optional) CA: <br />
            <textarea  cols="100" rows="5" name="code_ca" id="code_ca"></textarea><br />
            <em>*</em> Expire: <input id="date_expire" name="date_expire" class="date-pick" title="กรุณาเลือก expire date" /><br />
            <input type="button" name="bt_create" value="Save" onclick="completeorder();" />&nbsp;&nbsp;&nbsp;
            <input type="button" name="bu_status_order_cancel" value="Cancel" onclick="doreset('order_completed');" />
            <div style="display:none;">
                <input type="submit" id="bt_autoclick" name="create" value="Create" />
            </div>
        </fieldset>
        <!-- end order completed --> 
<!-- end detail product -->
<!-- ติดปัญหา ต้องรอ reseller แก้ไข dropprocess-->
{/if}
    <div class="spacer"></div>
</div>

<script type="text/javascript">
{literal}
    $('.date-pick').datePicker();
{/literal}
</script>