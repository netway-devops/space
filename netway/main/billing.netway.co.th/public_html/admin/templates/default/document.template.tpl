<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration" class="tstyled selected">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron" class="tstyled">{$lang.cronprofiles}</a>
            <a href="?cmd=security" class="tstyled">{$lang.securitysettings}</a>
            <a href="?cmd=langedit" class="tstyled">{$lang.languages}</a>
        </td>
        <td valign="top" class="bordered">
            <div id="bodycont" style="">
                {include file="configuration/nav.tpl"}
                <div class="nicerblu" id="ticketbody">
                    {include file='configuration/edit_template.tpl'}
                </div>
            </div>
        </td>
    </tr>
</table>