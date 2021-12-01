<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>{$lang.cpanel_name}</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <h3>{$lang.cpanel_access_filemanager}</h3>
    <br />
    <a href="{$panelurl}" class="btn btn-primary btn-flat-primary" target="_blank">{$lang.cpanel_open_filemanager}</a>
{/if}