{include file="`$cdndir`header.cloud.tpl"}
<div class="header-bar">
    <h3>Your CDN Resources</h3>
<div class="clear"></div>
</div>
<div class="content-bar">

<table cellspacing="0" cellpadding="0" border="0" width="100%" class="tonapp" style="margin:10px 0px;">

    <thead>
        <tr>
            <th>{$lang.hostname}</th>
            <th>Origin sites</th>
            <th width="60"></th>
        </tr>
    </thead>
    <tbody id="updater">
        {if $myresources}
        {foreach from=$myresources item=vm name=foo}
        <tr >
             
            <td><a href="?cmd=clientarea&action=services&service={$service.id}&resourceid={$vm.id}&cdndo=cdndetails" ><b>{$vm.hostname}</b></a></td>
            <td>{$vm.origins}</td>
        
            <td class="fs11">
                <a href="?cmd=clientarea&action=services&service={$service.id}&resourceid={$vm.id}&cdndo=cdndetails"  class="ico ico_wrench" title="{$lang.edit}">{$lang.edit}</a>
                <a  href="?cmd=clientarea&action=services&service={$service.id}&cdndo=destroy&resourceid={$vm.id}&security_token={$security_token}" onclick="return  confirm('Are you sure you want to remove this resource?')" class="ico ico_cross" title="{$lang.delete}">{$lang.delete}</a>
            </td>
        </tr>
        {/foreach}
        {else}
        <tr >
            <td colspan="3" align="center">You don't have any CDN resources added yet, <a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=addresource">click here to add</a>.</td>
        </tr>

        {/if}
    </tbody>

</table>

</div>
{include file="`$cdndir`footer.cloud.tpl"}