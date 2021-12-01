<script type="text/javascript">
    var domain_name = "{$details.name}";
{literal}   

     $(document).ready(function () {
         
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

        	              var msgCloak = "";
        	              if (data.aResponse.view.cloak == 1 || data.aResponse.view.cloak == "1") {
        	            	  msgCloak = "ซ่อน URL ปลายทาง (cloak)";
        	              } else if (data.aResponse.view.cloak == "") {
        	            	  msgCloak = "";
        	              } else if (data.aResponse.view.cloak == 0 || data.aResponse.view.cloak == "0") {
        	            	  msgCloak = "ไม่ได้ซ่อน URL ปลายทาง (un-cloak)";
        	              }
        	              
                          $('#details-domain-forwarding-cloak').html(msgCloak);
                          $('#details-domain-forwarding-url-forwarding').html(data.aResponse.view.urlforwarding);
                          $('#details-domain-forwarding-google-code').html(data.aResponse.view.googlecode);
                          
                     },
                     error: function(xhr,error) {
                     }
           });
    });
     
    </script>
{/literal}

<b>Domain Forwarding Details (ให้ทำการ update ที่ฝั่ง client)</b>
<br>
<table id="tb-details-domain-forwarding" width="100%">
    <tr>
        <td>
            URL masking:
        </td>
        <td>
            <div id="details-domain-forwarding-cloak" name="details-domain-forwarding-cloak"></div>
        </td>
    </tr>
    <tr>
        <td>
            Destination:
        </td>
        <td>
            <div id="details-domain-forwarding-url-forwarding" name="details-domain-forwarding-url-forwarding"></div>
        </td>
    </tr>
    <tr>
        <td>
            Google Apps Codes:
        </td>
        <td>
            <div id="details-domain-forwarding-google-code" id="details-domain-forwarding-google-code"></div>
        </td>
    </tr>
</table>