{if $action=='add' || $action=='edit'}
    {include file='support_dept/add_edit.tpl'}
{else}
    {include file='support_dept/list.tpl'}
{/if}