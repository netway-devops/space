<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {include file='configuration/leftmenu.tpl'}
        </td>
        <td valign="top" class="bordered">
            <div id="bodycont" style="">
                {include file="configuration/nav.tpl" picked_tab='3'}
                <div class="nicerblu" id="ticketbody">
                    {include file='ajax.invoice.template.tpl' }
                </div>
            </div>
        </td>
    </tr>
</table>