{include file="$tplPath/admin/header.tpl"}

<div class="box-body">
{if $step == 'sync'}
<p align="center"><a href="?cmd=module&module=dbcproducthandle">Done</a></p>
{/if}
{if ! $step}
<p align="center"><a href="?cmd=module&module=dbcproducthandle&action=sync&step=sync">Continue</a></p>
{/if}


</div>

{include file="$tplPath/admin/footer.tpl"}

