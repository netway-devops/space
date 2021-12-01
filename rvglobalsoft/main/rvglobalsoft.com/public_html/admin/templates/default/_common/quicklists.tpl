<script type="text/javascript" src="{$template_dir}js/jquery.timeago.js"></script>
<script type="text/javascript">
{literal}
$(document).ready( function () {
    setTimeout('howLongAgo()', 1000);
});
function howLongAgo ()
{
    $('td.lastreply_longago').each(function (i) {
        $(this).attr('title', $(this).text());
        $(this).timeago();
    });
    setTimeout('howLongAgo()', 5000);
}
{/literal}
</script>

{if $_placeholder}
    {if $enableFeatures.profiles=='on'}
        <div class="slide">Loading</div>
    {/if}
    <div class="slide">Loading</div> <div class="slide">Loading</div>
    <div class="slide">Loading</div> <div class="slide">Loading</div>
    <div class="slide">Loading</div> <div class="slide">Loading</div>  
    <div class="slide">Loading</div> <div class="slide">Loading</div>
    <div class="slide">Loading</div> <div class="slide">Loading</div>
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
                <a class="nav_el  left"  href="?cmd=clients&action=clientcontacts&id={$_client_link}" onclick="return false" >{$lang.Contacts}</a>
            {/if}
            <a class="nav_el  left"  href="?cmd=orders&action=clientorders&id={$_client_link}" onclick="return false">{$lang.newCmdOrders}</a>
            <a class="nav_el  left"  href="?cmd=accounts&action=clientaccounts&id={$_client_link}" onclick="return false">{$lang.Services}</a>
            <a class="nav_el  left" href="?cmd=domains&action=clientdomains&id={$_client_link}" onclick="return false">{$lang.Domains}</a>
            <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$_client_link}" onclick="return false">{$lang.Invoices}</a>
            <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$_client_link}&currentlist=recurring" onclick="return false">{$lang.Recurringinvoices}</a>
            {if $enableFeatures.estimates=='on'}
                <a class="nav_el  left" href="?cmd=estimates&action=clientestimates&id={$_client_link}" onclick="return false">{$lang.Estimates}</a>
            {/if}
            <a class="nav_el  left" href="?cmd=transactions&action=clienttransactions&id={$_client_link}" onclick="return false">{$lang.Transactions}</a>
        	<a class="nav_el direct left" href="?cmd=redirecthandle&action=zendeskUser&clientId={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" target="_blank">{$lang.Tickets}</a>
            <a class="nav_el  left" href="?cmd=emails&action=clientemails&id={$_client_link}" onclick="return false">Logs</a>
            {if $enableFeatures.chat=='on'}
                <a class="nav_el  left" href="?cmd=hbchat&action=clienthistory&id={$_client}" onclick="return false">Chat History</a>
            {/if}
            {adminwidget module="any" section="quicklist" wrapper="adminwidgets/wrap_quicklist.tpl"}
            {foreach from=$adminquicklists item=list}
                <a class="nav_el  left" href="{$list.url}&client={$_client_link}" onclick="return false">{$list.name}</a>
            {/foreach}
            <a class="nav_el direct left" href="?cmd=clients&action=show&id={$_client}" target="_blank">{$lang.Profile} <img src="images/icon_new_window.gif" border="0" width="10" /> </a>
        </div>
    {/if}
{/if}