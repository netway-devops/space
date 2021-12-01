<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $loginurl}
    {if $loginurl|filter_var:273}
        <a href="{$loginurl}" target="_blank" class="btn"><i class="icon-share-alt"></i> {$lang.clickhereaccesscontrolpanel}</a><br/><br/>
    {else}
        {$loginurl}
        <a href="#" onclick="$('#bf').submit();return false" class="btn"><i class="icon-share-alt"></i> {$lang.clickhereaccesscontrolpanel}</a><br/><br/>
    {/if}
{/if}