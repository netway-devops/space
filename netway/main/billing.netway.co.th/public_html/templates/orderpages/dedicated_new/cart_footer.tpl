
{if $opconfig.feature_list || $opconfig.feature_list_header}
<div class="cart-whitestrip" style="display:none;">
    <div>
        <div class="links">
            
            {if $opconfig.feature_list_header}<h2>{$opconfig.feature_list_header}</h2>{/if}
            <ul class="key-features clearfix">
                {$opconfig.feature_list}
            </ul>
        </div>
    </div>
</div>
{/if}
<div class="cart-footer clearfix" style="display:none;">
    <div class="left ext-links">
        {if $opconfig.footer_header_left}<h2>{$opconfig.footer_header_left}</h2>{/if}
    {if $opconfig.subfooter_first}<h4><span class="arial">&raquo;</span> {$opconfig.subfooter_first}</h4>{/if}
        {if $opconfig.subfooter_first_text}<p class="padd1em">{$opconfig.subfooter_first_text}</p>{/if}
        {if $opconfig.subfooter_last}<h4><span class="arial">&raquo;</span> {$opconfig.subfooter_last}</h4>{/if}
        {if $opconfig.subfooter_last_text}<p class="padd1em">{$opconfig.subfooter_last_text}</p>{/if}
    </div>
    <div class="left">
        {if $opconfig.footer_header_right}<h2>{$opconfig.footer_header_right}</h2>{/if}
        {if $opconfig.footer_text_right}
            <div class="step-gradient">
                <div class="ext-links">
                {$opconfig.footer_text_right}
                </div>
                <div class="clear">
                    {if $enableFeatures.chat!='off'}<a class="btn btn-success" href="#" onclick="$.getScript('?cmd=hbchat&action=embed', function(){literal}{hb_footprint.startChat()}{/literal}); return false;">{$lang.startchat}</a>{/if}
                    <a class="btn btn-success btn-purple" href="?cmd=tickets&action=new">{$lang.writemessage}</a>
                </div>
            </div>
        {/if}
    </div>
</div>
<!-- FOOT -->
</div>
<div class="clear"></div>
</section>

</div>
</div>

{literal}
<style type="text/css">
.feed{ 
	display:none;
}
</style>
{/literal}
<br />
<br />
{include file="footer-corporate.tpl" template_dir="templates/netwaybysidepad/content/"}

{if $enableFeatures.chat!='off'}<!--HostBill Chat Code, (c) Quality Software --><div id="hbinvitationcontainer_f87dea01855e3766"></div><div id="hbtagcontainer_f87dea01855e3766"></div><script type="text/javascript">var hb_script_tag_f87dea01855e3766=document.createElement("script");hb_script_tag_f87dea01855e3766.type="text/javascript";setTimeout('hb_script_tag_f87dea01855e3766.src="{$system_url}index.php?cmd=hbchat&action=embed&v=cmFuZGlkPWY4N2RlYTAxODU1ZTM3NjYmaW52aXRlX2lkPTMmdGFnPXNpZGViYXImc3RhdHVzX2lkPTI=";document.getElementById("hbtagcontainer_f87dea01855e3766").appendChild(hb_script_tag_f87dea01855e3766);',5);</script><!--END OF: HostBill Chat Code, (c) Quality Software-->{/if}
{userfooter}
</body>
</html>