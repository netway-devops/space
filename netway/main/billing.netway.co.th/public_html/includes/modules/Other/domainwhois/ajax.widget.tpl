
 Domain: <input id="whoischeck"/> <input type="button" style="font-weight:bold" value="WHOIS" onclick="return openwhois()"/>

 {literal}
 <script type="text/javascript">
     function openwhois(){
         var uurr=$("#whoischeck").val();
         window.open("{/literal}{$system_url}{literal}?cmd=checkdomain&security_token={/literal}{$security_token}{literal}&action=whois&domain="+uurr,"WHOIS","width=500, height=500, scrollbars=1"); return false;
     }
 </script>

 {/literal}