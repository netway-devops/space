<script type="text/javascript">

    var domain_name = "{$details.name}";
    var tld_id = "{$details.tld_id}";

{literal}   

     $(document).ready(function () {     




        // TODO เรียบเขียน VIEW
         data = {
                         cmd: 'netway_common',
                         action: 'domain',
                         subaction: 'doViewDomain',
                         
                         domain_name: domain_name
                 };

                 $.ajax({
                     type: 'POST',
                     data: data,
                     success: function(data) {
                           $('#domain-google-code').val(data.aResponse.view.googlecode);
                     },
                     error: function(xhr,error) {
                     }
                 });         
         
         

         $("#domain-google-code-save").click(function () {


                 data = {
                         cmd: 'netway_common',
                         action: 'domain',
                         subaction: 'doDomainGoogleCode',
                         
                         domain_name: domain_name,
                         tld_id: tld_id,
                         google_code: $('#domain-google-code').val()
                 };

                 $.ajax({
                     type: 'POST',
                     data: data,
                     success: function(data) {
                        parse_response(data);
                     },
                     error: function(xhr,error) {
                     }
                 });             
                 
                 

         });
         

         

        
    });
    </script>
    
{/literal}

<div class="wbox-domain">
	<div class="wbox-domain-header">ตั้งค่าเพื่อใช้งาน Google Apps for Business</div>
	<div>
		<ul>
			<li>Google Apps Code ใช้สำหรับ verify domain เพื่อใช้งาน Google Apps ฟรีโดยที่ไม่ต้องทำผ่านหน้า Control Panel ของ Google Apps โดยตรง</li>
		</ul>
	</div>
</div>
<div class="wbox">
    <div class="wbox_header">Google Apps Code</div>
    <div id="cartSummary" class="wbox_content">
        <textarea name="domain-google-code" id="domain-google-code" rows="5" style="width:100%;"></textarea>
       <input type="button" value="{$lang.savechanges}" style="font-weight:bold" class="btn btn-primary" id="domain-google-code-save"/>
        
    </div>
</div>