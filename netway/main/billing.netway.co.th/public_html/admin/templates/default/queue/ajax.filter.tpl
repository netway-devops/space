{if $action=='getadvanced'}
<a href="?cmd=queue&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filerisactive}</a>
<form class="searchform filterform" action="?cmd=queue" method="post" onsubmit="return filter(this)">
    {include file="_common/filters.tpl"}
    {securitytoken}
</form>
<script type="text/javascript">
    bindFreseter();
</script>
{/if}