
{literal}
<style type="text/css">
h1.title06, .kol-1, .kol-2, .linia1{ 
	display:none;
}
.domain-in-02 {border:1px solid #cccccc;border-right:0;}
.domain-in-03 {border:1px solid #cccccc;border-left:0;}
.domain-in-02, .domain-in-03{ margin-bottom:20px;}
@media (min-width: 481px){
	ul.tldDropDown {
		margin-left:23px;
		margin-top:5px;
	}
}
@media (max-width: 480px){
	ul.tldDropDown {
		margin-left:-7px;
	}
}
</style>

{/literal}
<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
<div class="in-page clearbot">
	<div class="row clearmar">
		<div class="bgtitle">
			<h1>ตรวจสอบโดเมนกับ Whois</h1>
		</div>
		<div>
			<h1 class="aleft"><span>ระบุโดเมนที่ต้องการตรวจสอบ </span> www.</h1>
			<div style="padding:10px 0 0 0;">
				<div class="acenter" style="margin:0 auto;">
				
				
				<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/reserveword.js"></script>
				<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/punycode.js"></script>
				<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/domain.js"></script>
				<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/domainstyles.css" />
				<script type="text/javascript">
				{literal}
				$(document).ready(function() {
					
					// $.domain.init({id : '#container-code-whois', type : 'whois', api : 'https://netway.co.th/RVDomainAjax.php?'});
					$.domain.init({id : '#container-code-whois', type : 'whois'});
					
				});
				{/literal}
				</script>
				
					<div class="aleft">
						<div id='container-code-whois'></div>
					</div>
				</div>
			</div>
			
  		</div>
	</div>		
</div>

	

	