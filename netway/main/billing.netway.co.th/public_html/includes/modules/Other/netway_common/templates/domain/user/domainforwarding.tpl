
<script type="text/javascript">

var domain_name = "{$details.name}";
var tld_id = "{$details.tld_id}";
var domainId    = "{$details.id}";

{literal}   

$(document).ready(function () {

    $("#domain-forwarding-save").click(function () {

        var url_forwarding = $("#domain-forwarding-url-text").val();

        if ($.trim(url_forwarding) != "" && url_forwarding != $("#domain-forwarding-url-text").attr('title')) {

            data = {
                    //cmd: 'netway_common',
                    //action: 'domain',
                    //subaction: 'doDomainForwarding',
                    
                    domainId: domainId,
                    domain_name: domain_name,
                    tld_id: tld_id,
                    protocal: $('#domain-forwarding-protocal').val(),
                    url_forwarding: url_forwarding,
                    cloak: $('#domain-forwarding-cloack').is(':checked') ? 1 : 0
            };

        $.post('?cmd=domainhandle&action=forwarding', data, function (data) { 
            parse_response_json(data);
        });
            
            
        }

    });
        
    $('#domain-forwarding-delete').click( function () {
        if (! confirm('ยืนยันการลบ?')) {
            return false;
        }

        data = {
                domainId: domainId,
                domain_name: domain_name,
        };

        $.post('?cmd=domainhandle&action=deleteforwarding', data, function (data) { 
            parse_response_json(data);
            $('#domain-forwarding-url-text').val('');
        });

        
        return false;
    });

    
});

{/literal}
</script>

<div class="wbox-domain">
	<div class="wbox-domain-header">ตั้งค่า Forward ให้โดเมนคุณ</div>
	<div>
		<ul>
			<li>การทำ Domain Forwarding ช่วยให้คุณจัดการโดเมนเนมหลายๆ ชื่อที่เข้าถึงเว็บไซต์ของคุณ</li>
			<li>การทำ Domain Forwarding ช่วยลดค่าใช้จ่ายในการเปิดโฮสติ้งใหม่สำหรับคุณ เพราะคุณไม่ต้องซื้อเนื้อที่สำหรับแต่ละโดเมน เพียงแค่ตั้งค่าให้โดเมนนนั้นชี้ไปยังเว็บไซต์เดียวกันเท่านั้น</li>
			<li>คุณสามารถจดโดเมนหมายชื่อเพื่อใช้เรียกไปที่เว็บไซต์เดียวกันได้</li>
			<li>การทำ Domain Forwarding มีผลทางการตลาดในการนำลูกค้าเข้าสู่เว็บไซต์คุณด้วยความสะดวกในการพิมพ์และจดจำชื่อโดเมนที่คล้ายๆ กันกับธุรกิจคุณ</li>
		</ul>
	</div>
</div>
<div class="wbox-domain">
	<div class="wbox-domain-header">Domain Parking</div>
	<div>
		<p>Park โดเมนว่างของคุณ</p>
		<ul>
			<li>การทำ Domain Parking คือการจดทะเบียนโดเมนเนมไว้โดยที่ยังไม่ต้องใส่เนื้อหาลงในเว็บไซต์ </li>
			<li>การทำ Domain Parking ลดค่าใช้จ่ายในด้านการออกแบบเว็บไซต์เพื่อรอเว็บไซต์จริงขึ้นสู่ระบบ แทนการขึ้นเป็นหน้าจอว่างว่าเป็น Content Not Found</li>
		</ul>
	</div>
</div>
<div class="wbox">
    <div class="wbox_header">{$lang.DomainForwarding}</div>
    <div class="wbox_content">
        <span style="font-weight: 600;color:red;">**คำเตือน </span>
            {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
    </div>
    <div  class="wbox_content">
	&nbsp;
        <form action="" method="post">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
                <tr>
                    <td>{$lang.Destination}:</td>
                    <td>
                        <select name="domain-forwarding-protocal" id="domain-forwarding-protocal" class="span2 styled">
                            <option value="http">http://</option>
                            <option value="https" {if $aForwardDomain.urlforwarding_http == 'https'} selected="selected" {/if} >https://</option>
                        </select>
                        <input type="text" name="domain-forwarding-url-text" id="domain-forwarding-url-text" size="35" value="{$aForwardDomain.urlforwarding}"  title="eg. netway.co.th">
                   </td>
                </tr>
                <tr class="even" style="display: ;">
                    <td>{$lang.urlmasking}:</td>
                    <td>
                        <input type="checkbox" value="1" {if $aForwardDomain.cloak == '1'} checked="checked" {/if} name="domain-forwarding-cloack" id="domain-forwarding-cloack" /> ซ่อน URL ปลายทาง
                       //warning  url forwarding
                       <!--<p style="margin-top: 20px;"><span style="font-weight: 600;color:red;">**คำเตือน </span>{$lang.warn_destination_url}</p>-->
                    </td>
                </tr>
                <tr class="even">
                    <td colspan="3" align="center">
                        <input type="button" value="{$lang.savechanges}" style="font-weight:bold" class="btn btn-primary" id="domain-forwarding-save"/>
                        <input type="button" value="Delete" style="font-weight:bold" class="btn btn-danger" id="domain-forwarding-delete"/>
                    </td>
                </tr>
            </table>
         </form>
    </div>
</div>