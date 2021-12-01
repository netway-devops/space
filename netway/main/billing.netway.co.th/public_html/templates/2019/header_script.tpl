 {include file="`$template_path`header_google_analytics_tag.tpl"}
{literal}
 <script type="text/javascript">
$(document).ready(function() {
    var	fullUrl = window.location.href;
    var url     = new URL(fullUrl);
    var domainUrl = location.pathname;
    var getDomain   = url.searchParams.get("domain");
    
    if(domainUrl == '/checkdomain/domain-names'){
        var thaiDomain  = getDomain.match(/[ก-ฮ]/i);
        if(thaiDomain  != null){                  //search international-domain page
           window.location = '{/literal}{$system_url}{literal}checkdomain/--internationalized-domain-names?domain='+getDomain;
        } 
    }
    if((domainUrl == '/checkdomain/domain-names' || domainUrl == '/checkdomain/--internationalized-domain-names') && getDomain != null ) {          //check if foo parameter 
            $('.domain-input textarea.domain-textarea').val(getDomain) ;
            $('.domain-search-btn').trigger('click');
        }
   
}); 
</script>
{/literal}
