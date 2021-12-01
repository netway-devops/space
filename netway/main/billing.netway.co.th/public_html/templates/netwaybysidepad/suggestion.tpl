<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/domainstyles.css" />
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/reserveword.js"></script>
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/punycode.js"></script>
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/domain.js"></script>

{literal}
<style type="text/css">
#container-diplays strong{ margin:10px 10px;}
#container-diplays div{padding-bottom:10px;}
#container-diplays input{margin-top:15px;margin-bottom:20px;}
#container-diplays div.button06 input{margin-top:0px;margin-bottom:0px;}
	h1.title06, .kol-1, .kol-2, .linia1{ 
		display:none;
	}
	.domain-in-02{ 
		margin-bottom:0px;
	}
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
	div.domain-in-03{ 
		margin-bottom:5px;
	}
	.container-step1 .domain-in{
		width:100%;
		margin:0 0 0 5px;
		clear:both;
	}
}
@media (max-width: 360px){
	ul.tldDropDown {
		margin-left:-7px;
	}
	div.domain-in-03{ 
		margin-bottom:5px;
	}
	.container-step1 .domain-in{
		width:100%;
		margin:0 0 0 5px;
		clear:both;
	}
	.container-step1 .button01{
		width:100%;
	}
}
</style>
{/literal}

<script type="text/javascript">

{literal}
$(document).ready(function() {
	$.domain.init({id : '#container-code', type : 'suggestion'});
});
{/literal}

</script>

<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
<div class="in-page" style="padding-bottom:0; margin-bottom:0;">
	<div class="bgtitle" style="padding-bottom:0; margin-bottom:0;">
		<h1 style="padding-bottom:0; margin-bottom:0;">บริการแนะนำโดเมน</h1>
	</div>	
</div>
<div class="in-page clearbot">
	<div class="row clearmar">
		<div class="row-fluid" style="margin-top:-33px;">	
			<div class="span12"><img src="{$template_dir}images/banner-suggestion.png" width="970" height="275" alt="" /></div>
		</div>
		<div class="row-fluid domain-bgback"  style="padding:15px 0 0 0; margin-bottom:8px;">
					<div class="span2" style="margin-top:5px;"><span class="sd-font">ค้นหาโดเมนว่าง</span></div>
				<!-- start search domain -->
					<div id='container-code'></div>
				<!-- end search domain -->
			</div>				
		</div>
		
		<div class="row-fluid suggestion">	
			<div class="span12">
				<div class="bgtab-t">
				<h2>การใช้บริการ Domain Suggestions</h2>
				<div class="bgtab">
					<div class="span2 acenter"><img src="{$template_dir}images/icon-suggestion.png" width="98" height="87" alt="" /></div>
					<div class="span10">
						<div>บริการแนะนำโดเมนหรือ Domain Suggestion เป็นบริการที่เหมาะสำหรับผู้ใช้งานเริ่มต้นที่ยังลังเลในการมองหาโดเมนเพื่อทำเว็บไซต์หรือกิจกรรมออนไลน์ต่างๆ โดยระบบจะเลือกรายชื่อโดเมนที่พร้อมใช้งาน และพร้อมราคาให้คุณเลือกตัดสินใจได้ตามความต้องการ ช่วยให้เกิดความสะดวกและคล่องตัวในการเลือกโดเมนและการจัดการต่างๆ เช่น SEO และการสร้างแคมเปญทางการตลาดเกี่ยวกับเว็บไซต์ของคุณ คุณสามารถใช้บริการนี้ได้ง่ายๆ โดยเพียงแค่ใส่ชื่อ Domain ที่คุณต้องการลงในช่องด้านบน และ<span class="star" style="font-style:italic;"> <b>กด GO!</b></span></div>
					</div>
					
					<div class="clearit"></div>
				</div>
			</div>
			</div>
		</div>
		</div>
		
	</div>
</div>


{include file='notificationinfo.tpl'}
