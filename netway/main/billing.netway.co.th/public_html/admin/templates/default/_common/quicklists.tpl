{if $_placeholder}
    {if $enableFeatures.profiles=='on'}
        <!-- Contacts --> <div class="slide">Loading</div>
    {/if}
    <!-- Orders -->             <div class="slide">Loading</div>
    <!-- Contracts -->          <div class="slide">Loading</div>
    <!-- Services -->           <div class="slide">Loading</div>
    <!-- Domains -->            <div class="slide">Loading</div>
    <!-- Invoices -->           <div class="slide">Loading</div>
    <!-- Recurring Invoices --> <div class="slide">Loading</div>
    <!-- Estimates -->          <div class="slide">Loading</div>
    <!-- Transactions -->       <div class="slide">Loading</div>
    <!-- Tickets -->            <div class="slide">Loading</div>
    <!-- Logs -->               <div class="slide">Loading</div>
    {adminwidget module="any" section="quicklist" wrapper="adminwidgets/wrap_quicklist.tpl" placeholder=true}
    {foreach from=$adminquicklists item=list}
        <div class="slide">Loading</div>
    {/foreach}
{else}
    {if $_parent}{assign value=$_parent var=_client_link}
    {else}{assign value=$_client var=_client_link}
    {/if}

    <span class="left" style="padding-top:5px;padding-left:5px;">
        {$_client_link|@client:"<strong>%name%</strong> (%contactname%)"}       &nbsp;&nbsp;
    </span>
    {if $_client_link}
        <div id="clientnav-wrapper">
            {if $enableFeatures.profiles=='on'}
                {if in_array('Contacts', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left"  href="?cmd=clients&action=clientcontacts&id={$_client_link}" onclick="return false" >{$lang.Contacts}</a>{/if}
            {/if}
            {if in_array('Orders', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left"  href="?cmd=orders&action=clientorders&id={$_client_link}" onclick="return false">{$lang.Orders}</a>{/if}
            {if in_array('Contracts', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left nav_el_contracts"  href="?cmd=contracts&action=clientcontracts&id={$_client_link}" onclick="return false">{$lang.contracts}</a>{/if}
            {if in_array('Services', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left"  href="?cmd=accounts&action=clientaccounts&id={$_client_link}" onclick="return false">{$lang.Services}</a>{/if}
            {if in_array('Domains', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left" href="?cmd=domains&action=clientdomains&id={$_client_link}" onclick="return false">{$lang.Domains}</a>{/if}
            {if in_array('Invoices', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$_client_link}" onclick="return false">{$lang.Invoices}</a>{/if}
            {if in_array('Recurring Invoices', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$_client_link}&currentlist=recurring" onclick="return false">{$lang.Recurringinvoices}</a>{/if}
            {if $enableFeatures.estimates=='on'}
                {if in_array('Estimates', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left" href="?cmd=estimates&action=clientestimates&id={$_client_link}" onclick="return false">{$lang.Estimates}</a>{/if}
            {/if}
            {if in_array('Transactions', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left" href="?cmd=transactions&action=clienttransactions&id={$_client_link}" onclick="return false">{$lang.Transactions}</a>{/if}
            {if in_array('Tickets', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left" href="?cmd=tickets&action=clienttickets&id={$_client_link}" onclick="return false">{$lang.Tickets}</a>{/if}
            {if in_array('Logs', $admindata.ui_config.clienttabs_visible)}<a class="nav_el  left" href="?cmd=emails&action=clientemails&id={$_client_link}" onclick="return false">Logs / Email</a>{/if}
            {adminwidget module="any" section="quicklist" wrapper="adminwidgets/wrap_quicklist.tpl"}
            {foreach from=$adminquicklists item=list}
                <a class="nav_el  left" href="{$list.url}&client={$_client_link}" onclick="return false">{$list.name}</a>
            {/foreach}
            <a class="nav_el direct left" href="?cmd=clients&action=show&id={$_client}">{$lang.Profile}</a>
        </div>
    {/if}
{/if}