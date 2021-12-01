</div>
<div class="clear"></div>
</section>

<!--<footer>
    <span class="left">&copy; 2012 {$business_name}</span>
    <span class="right">
        <a href="{$ca_url}">{$lang.homepage}</a> -
        <a href="{$ca_url}cart/">{$lang.order}</a> -
		<a href="confirm-payment.php">{$lang.confirmPayment}</a> -
        <a href="https://support.siaminterhost.com" target="external-support" title="{$ca_url}{if $enableFeatures.kb!='off'}knowledgebase/{else}tickets/new/{/if}">{$lang.support}</a> -
        <a href="{$ca_url}clientarea/">{$lang.clientarea}</a>
        {if $enableFeatures.affiliates!='off'}
        - <a href="{$ca_url}affiliates/">{$lang.affiliates}</a>
        {/if}
    </span>
    <div class="clear"></div>

</footer>-->
</div>
</div>
<div class="container"><div style="text-align:right;"><a href="#"><img src="{$template_dir}share/images/icon_livechat.gif" alt="" width="199" height="38" /></a></div></div>
			
<!-- *************** Start Footer-Corporate *******************-->
{include file='content/footer-corporate.tpl'}
<!-- *************** End  Footer-Corporate  *******************-->
			
			
{if $enableFeatures.chat!='off'}<!--HostBill Chat Code, (c) Quality Software --><div id="hbinvitationcontainer_f87dea01855e3766"></div><div id="hbtagcontainer_f87dea01855e3766"></div><script type="text/javascript">var hb_script_tag_f87dea01855e3766=document.createElement("script");hb_script_tag_f87dea01855e3766.type="text/javascript";setTimeout('hb_script_tag_f87dea01855e3766.src="{$system_url}index.php?cmd=hbchat&action=embed&v=cmFuZGlkPWY4N2RlYTAxODU1ZTM3NjYmaW52aXRlX2lkPTMmdGFnPXNpZGViYXImc3RhdHVzX2lkPTI=";document.getElementById("hbtagcontainer_f87dea01855e3766").appendChild(hb_script_tag_f87dea01855e3766);',5);</script><!--END OF: HostBill Chat Code, (c) Quality Software-->{/if}
{userfooter}


</body>
</html>
