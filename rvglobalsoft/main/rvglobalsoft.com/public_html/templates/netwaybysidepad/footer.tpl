{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'footer.tpl.php');
{/php}
</div>	
</div>

		<!-- End container -->
		<div class="clear"></div>
		<script type="text/javascript">var w = 0, a= $('.services-content, .services-box').each(function(){literal}{var x = $(this).height(); w = w > x ? w : x;}{/literal}).height(w);</script>
	</div>
	<!-- content-wrapper -->
</div>
<!-- End wrapper-outer -->
			
<!-- *************** Start footer *******************-->
<div {if $logged=='1'}class="client-none"{/if}>
{include file="content/footer-corporate.tpl"}
</div>
<!-- *************** End footer *******************-->		
			
{literal}
<!-- Start of rvglobalsoft Zendesk Widget script -->
<script>/*<![CDATA[*/window.zE||(function(e,t,s){var n=window.zE=window.zEmbed=function(){n._.push(arguments)}, a=n.s=e.createElement(t),r=e.getElementsByTagName(t)[0];n.set=function(e){ n.set._.push(e)},n._=[],n.set._=[],a.async=true,a.setAttribute("charset","utf-8"), a.src="https://static.zdassets.com/ekr/asset_composer.js?key="+s, n.t=+new Date,a.type="text/javascript",r.parentNode.insertBefore(a,r)})(document,"script","1628135a-4a6b-45ce-a84b-6ca1d2a1c1ce");/*]]>*/</script>
<!-- End of rvglobalsoft Zendesk Widget script -->
<script>
var oUserInfo    = {name: '{/literal}{if $aClient.id}{$aClient.firstname} {$aClient.lastname}{/if}{literal}', email: '{/literal}{$aClient.email}{literal}'};
</script>  
<script src="https://dev.zopim.com/web-sdk/latest/web-sdk.js"></script>
<script>

$(document).ready( function () {

});

zChat.init({
    account_key: 'rwF8IuPIsEUFSNhcsNd4OH0UBG8dRfID'
});

zChat.on('connection_update', function(status) {
    if (status === 'connected') {
        var oVisitor    = zChat.getVisitorInfo();
        var name    = (oVisitor.hasOwnProperty('display_name')) ? oVisitor.display_name : '';
        var email   = (oVisitor.hasOwnProperty('email')) ? oVisitor.email : '';
        
        if (name.search('/Visitor/') < 0) {
            if (typeof oUserInfo !== 'undefined') {
                name    = (oUserInfo.hasOwnProperty('name')) ? oUserInfo.name : name;
                email   = (oUserInfo.hasOwnProperty('email')) ? oUserInfo.email : email;
                
                var visitorInfo = {
                    display_name : name,
                    email        : email
                };
                zChat.setVisitorInfo(visitorInfo, function(err) {});
                
            }
        }

    }
});

</script>
{/literal}

{*if $enableFeatures.chat!='off'}<!--HostBill Chat Code, (c) Quality Software --><div id="hbinvitationcontainer_f87dea01855e3766"></div><div id="hbtagcontainer_f87dea01855e3766"></div><script type="text/javascript">var hb_script_tag_f87dea01855e3766=document.createElement("script");hb_script_tag_f87dea01855e3766.type="text/javascript";setTimeout('hb_script_tag_f87dea01855e3766.src="{$system_url}index.php?cmd=hbchat&action=embed&v=cmFuZGlkPWY4N2RlYTAxODU1ZTM3NjYmaW52aXRlX2lkPTMmdGFnPXNpZGViYXImc3RhdHVzX2lkPTI=";document.getElementById("hbtagcontainer_f87dea01855e3766").appendChild(hb_script_tag_f87dea01855e3766);',5);</script><!--END OF: HostBill Chat Code, (c) Quality Software-->{/if*}
{userfooter}

</div> <!-- body-client -->

</div>

<div id="back-top">
  <a href="#top"><span></span></a>
</div>

</body>
</html>
