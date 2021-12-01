<?php 
    include_once 'RVDomainAjax.php';
?>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>


<link href="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/css/domain.css?v=4.8.2" rel="stylesheet" media="all" />
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/punycode.js"></script>
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/domain.js"></script>



<script type="text/javascript">

$(document).ready(function() {

       
    $.domain.init({id : '#container-code', type : 'order'});
    // $.domain.init({id : '#container-code', type : 'order', api : 'https://netway.co.th/index.php?'}); // Onsite: Netway.co.th
    // $.domain.init({id : '#container-code', type : 'whois'});
    // $.domain.init({id : '#container-code', type : 'suggestion'});

    // $.domain.orders({id:'#container-diplays-ex', sld:'youdomain',tld:'.com'});
    // $.domain.whois({id:'#container-diplays-ex', sld:'youdomain',tld:'.com'});
    // $.domain.suggestion({id:'#container-diplays-ex', sld:'youdomain',tld:'.com'});
    
    $('div.mainTld').click(function() {
        if ($('div.dropbg').hasClass('shown'))
            $('div.dropbg').hide().removeClass('shown');
        else {
            $('div.dropbg').show().addClass('shown');
        }
        return true;
    });
       
    $('ul.tldDropDown li').click(function() {
        $('input[name=tld]').val($(this).attr('title'));
        $('div.mainTld').html($(this).attr('title'));
        $('div.dropbg').hide().removeClass('shown');
    });

        
});

</script>


<div id='container-code'></div>
<div id='container-diplays-ex'></div>