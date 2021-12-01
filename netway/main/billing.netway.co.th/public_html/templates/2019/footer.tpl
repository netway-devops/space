{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'footer.tpl.php');
{/php}
{if $logged!='1'}
    {include file="`$template_path`ajax.login.tpl" loginwidget=true}
{/if}

</section>

</div>
    {include file="`$template_path`footer_script.tpl"}
    
<div class="footer-content">
    <footer role="footer" class="footer">
        <div class="footer-box text-secondary">
            {if $tpl_config.footer.menu}
                {if $tpl_config.footer.show_info}
                    <small>&copy; {$smarty.now|date_format:"%Y"} {$business_name} </small>
                {/if}
                <ul class="nav">
                    {foreach from=$tpl_config.footer.menu item=item}
                        {* check login condition*}
                        {if $item.conditions.customers}
                            {assign var=cs value=$item.conditions.customers}
                            {if $cs.value === '1' && !$clientdata.id}
                                {continue}
                            {elseif $cs.value === '-1' && $clientdata.id}
                                {continue}
                            {elseif $cs.value === null && $cs.default === '1' && !$clientdata.id}
                                {continue}
                            {elseif $cs.value === null && $cs.default === '-1' && $clientdata.id}
                                {continue}
                            {/if}
                        {/if}
                        {* end check login condition*}

                        {* check enabled feature*}
                        {if $item.conditions.enabled_feature.value && $enableFeatures[$item.conditions.enabled_feature.feature] == 'off'}
                            {continue}
                        {/if}
                        {* end check enabled feature*}

                        <li class="nav-item">
                            <a {if $item.options.new_tab.value}target="_blank" {/if} class="nav-link text-secondary" href="{if $item.url_type == 'system'}{$ca_url}{$item.url}{elseif $item.url_type == 'custom'}{$item.url}{/if}">
                                <small>{$item.name|lang}</small>
                            </a>
                        </li>
                    {/foreach}
                </ul>
            {else}
                <small>&copy; {$smarty.now|date_format:"%Y"} {$business_name} </small>
                <ul class="nav">
                    <li class="nav-item"><a class="nav-link text-secondary" href="{$ca_url}"><small>{$lang.homepage}</small></a>
                    </li>
                    <li class="nav-item"><a class="nav-link text-secondary" href="{$ca_url}cart/"><small>{$lang.order}</small></a></li>
                    <li class="nav-item"><a class="nav-link text-secondary" href="{$ca_url}{if $enableFeatures.kb!='off'}knowledgebase/{else}tickets/new/{/if}"><small>{$lang.support}</small></a>
                    </li>
                    <li class="nav-item"><a class="nav-link text-secondary" href="{$ca_url}clientarea/"><small>{$lang.clientarea}</small></a></li>
                    {if $enableFeatures.affiliates!='off'}
                        <li class="nav-item"><a class="nav-link text-secondary" href="{$ca_url}affiliates/"><small>{$lang.affiliates}</small></a></li>
                    {/if}
                </ul>
            {/if}
        </div>
        {userfooter}
    </footer>
</div>
{php}
if($logoutClient == 'logout'){
    session_start();   
    $sessionLogoutClient  = '<script type="text/javascript">';
    $sessionLogoutClient .= '$crisp.push(["do", "session:reset"]);sessionStorage.removeItem("loadForm");';
    $sessionLogoutClient .=  '</script>'; 
    echo $sessionLogoutClient;
    session_unset();
    session_destroy();
}
{/php}
</body>
</html>