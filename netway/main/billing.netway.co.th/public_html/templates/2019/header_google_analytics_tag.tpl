{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'header.tpl.php');
{/php}
{literal}
<!-- Google Tag Manager -->
<script>
    (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-K5JBBX2');
</script>
<!-- End Google Tag Manager -->
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-90664309-1"></script>
<script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
    {/literal}    
    {if isset($aClient.id) && $aClient.id != ''}
    
    {literal}gtag('set',{'user_id':'{/literal}{$aClient.email}{literal}'});{/literal}
    {/if}   
    {literal}
    
    
        gtag('config', 'UA-90664309-1', { 
            'linker': {
                'domains': ['netway.co.th', 'netway.cloud', 'netway.academy', 'netwaystore.in.th', 'siamdomain.com', 'siaminterhost.com', 'ssl.in.th', 'thaidomainnames.com', 'thaimailgroup.com', 'blog.netway.co.th', 'netway.services', 'support.netway.co.th']
            }
            ,'custom_map': {'dimension1': 'Admin'}
        });
    {/literal}

    {if isset($aAdmin.id) && $aAdmin.id != ''}
    {literal}            
        gtag('event', 'admin_dimension1', {'Admin': 1});
    {/literal} 
    {/if} 
    {literal}
</script>
{/literal}
        