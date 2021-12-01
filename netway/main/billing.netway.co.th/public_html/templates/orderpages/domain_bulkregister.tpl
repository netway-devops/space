{*
@@author:: HostBill team
@@name:: Bulk domain registration
@@description:: Use this template with TLDs you wish to offer registration for. You can also assign this orderpage to product you wish to offer domain with.
@@thumb:: images/bulk_domain_thumb.png
@@img:: images/bulk_domain_preview.png
*}

<link href="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/css/domain.css?v={$hb_version}" rel="stylesheet" media="all" />

<script src="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/reserveword.js"></script>
<script src="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/punycode.js"></script>
<script src="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/domain.js"></script>

{include file='/domains/domainstyles.css'}

<script type="text/javascript">
    {literal}
        function check_domain2_(form, updater) {
            // clear errors
            $(updater).addLoader();
            $.post('index.php?cmd=checkdomain&' + $(form).serialize(), {layer: 'ajax', justparse: '1', bulk: true, action: 'checkdomain'}, function (data) {
                $(updater).html('');
                var resp = parse_response(data);
                if (resp) {
                    $(updater).html(resp);
                    if (typeof ($().slideToElement) == 'function') {
                        $('body').slideToElement('searchresults');
                    }
                }
            });
            return false;
        }
        function runBulkSearch_() {
            var domaincat = 0;
            if ($("#domain_cat").length)
                domaincat = $('#domain_cat').val();
            if ($('.status-row').length < 1)
                return;
            $('.status-row').each(function (n) {
                var tld = $(this).find('input[name=tlx]').val();
                var sld = $(this).find('input[name=slx]').val();
                ajax_update('index.php?cmd=checkdomain', {layer: 'ajax', 'singlecheck': true, action: 'checkdomain', domain_cat: domaincat, tld: tld, sld: sld}, '.status-row:eq(' + n + ')');

                {/literal}{if 'config:EnableDomainSuggestions:on'|checkcondition}{literal}
                if(n==0) {
                    ajax_update('?cmd=checkdomain&action=suggest', {
                        sld:sld,tld:tld,domain_cat:domaincat
                    }, '#suggestions');
                }
                {/literal}{/if}{literal}

            });

        }
    {/literal}
</script>

{literal}
<style>
 #cont{
     background: #ffffff !important;
     
 }
   .head-table td{
        font-size: 18px;
        color: #ffffff;
        font-weight: 300;
        background: #0052Cd;
        height: 40px;
    }

    .row-table{
       font-size: 16px;
       height: 40px;
       font-weight: 300;
       border-bottom: 1px solid #ccc; 
       background-color: #ffffff;
       color:#5B5858;
    }
    .row-table:hover{
       font-size: 16px;
       height: 40px;
       font-weight: 300;
       background-color:#EEF2F5;
       color:#000000
    }
    .row-table-white:hover{
      background-color:#EEF2F5;
      color :#000000
    }

    .row-table-white td{
       background-color: unset !important;  
    }
</style>
{/literal}
<script type="text/javascript">
	{literal}

	$(document).ready(function() {
         
		//$.domain.init({id : '#container-code', type : 'order', api : 'https://netway.co.th/index.php?'});
		//$.domain.init({id : '#container-code', type : 'order'});

		$('.regprices').show();
	       
	});
	{/literal}
</script>

<div class="container">
    <center>
    <div class="row">
        <div class="dynamic-content">
         
                <h3 class="h3-title-content g-txt32 re-topic" style="margin-top: 50px;">Domain Pricing</h3>
                <span class="nw-2018-content-line" ></span>
        </div> 

        <div style="margin-top:60px;" >
               
               
               <form class="pure-form" method="get" action="/domain-order"  style="margin-bottom: 0px;">
                    <span style="font-size:20px;" >ค้นหาโดเมนว่าง</span>&nbsp;&nbsp;<input type="search"  class="txt-SearchDomain" id=""  name="domain" required=""  placeholder="พิมพ์ชื่อโดเมนที่คุณต้องการที่นี่" style="width:500px">
                    <button type="submit" class="btn-search-domain"><i class="fa fa-search" aria-hidden="true"></i> </button>
                </form> 
       </div> 



    </div>
    </center>
<div id='container-code'></div>
<br><br>
<div class="dropbg-copy" style="display: none;">
<!-- START TLD COPY -->
    <ul class="tldDropDown">
        {foreach from=$tld item=tldname}
            <li title="{$tldname}" onclick="{literal}$.domain.tld{/literal}('{$tldname}');{literal}$.domain.tldDropDown{/literal}();">{$tldname}</li>
        {/foreach}
    </ul>
<!-- END TLD COPY -->    
</div>

<!-- START PRICING COPY ....-->
{include file="domainpricing.tpl"}
<!-- END PRICING COPY -->
</div>
