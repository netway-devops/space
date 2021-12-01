<a class="tstyled {if $action == '' || $action == 'default'}selected{/if}" href="?cmd=module&module={$moduleid}">Home</a>
{foreach from=$aLeftMenus item="aData" key="k"}
    <a class="tstyled {if $action == $aData.id }selected{/if}" href="?cmd=module&module={$moduleid}&action={$aData.id}">{$aData.name}</a>
{/foreach}

