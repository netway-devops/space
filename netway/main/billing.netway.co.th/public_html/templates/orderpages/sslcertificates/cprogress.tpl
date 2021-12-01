<script type="text/javascript" src="{$orderpage_dir}sslcertificates/js/script.js"></script>
<div id="progress-indicator" class="clearfix">
    {if $progress>1}<a href="{$ca_url}cart&do=1">{/if}
    <div class="step {if $progress>1}progress-done{else}progress-active{/if}">
        
        <div class="line right"></div>
        <div class="progress-icon step-1"></div>
        <div><span class="circle">1</span><span class="header">{$lang.en_certtype}</span></div>
        
    </div>
    {if $progress>1}</a>{/if}
    {if $progress>2}<a href="{$ca_url}cart&do=2">{/if}
    <div class="step {if $progress>2}progress-done{elseif $progress == 2}progress-active{/if}">
        <div class="line left"></div><div class="line right"></div>
        <div class="progress-icon step-2"></div>
        <div><span class="circle">2</span><span class="header">{$lang.en_csr}</span></div>
    </div>
    {if $progress>2}</a>{/if}
    {if $progress>3}<a href="{$ca_url}cart&do=3">{/if}
    <div class="step {if $progress>3}progress-done{elseif $progress == 3}progress-active{/if}">
        <div class="line left"></div><div class="line right"></div>
        <div class="progress-icon step-3"></div>
        <div><span class="circle">3</span><span class="header">{$lang.en_contacts}</span></div>
    </div>
    {if $progress>3}</a>{/if}
    {if $progress>4}<a href="{$ca_url}cart&do=4">{/if}
    <div class="step {if $progress>4}progress-done{elseif $progress == 4}progress-active{/if}">
        <div class="line left"></div><div class="line right"></div>
        <div class="progress-icon step-4"></div>
        <div><span class="circle">4</span><span class="header">{$lang.config_options}</span></div>
    </div>
    {if $progress>4}</a>{/if}
    <div class="step {if $progress>5}progress-done{elseif $progress == 5}progress-active{/if}">
        <div class="line left"></div>
        <div class="progress-icon step-5"></div>
        <div><span class="circle">5</span><span class="header">{$lang.en_payment}</span></div>
    </div>
</div>

<script type="text/javascript">
shortenSeparators();
</script>

