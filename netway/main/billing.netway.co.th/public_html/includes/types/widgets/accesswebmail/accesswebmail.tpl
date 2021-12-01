<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $loginurl}
    {$loginurl}
<a href="#" onclick="$('#bf').submit();return false"  class="btn"><i class="icon-share-alt"></i> {$lang.clickhereaccesswebmail}</a><br/><br/>
{/if}