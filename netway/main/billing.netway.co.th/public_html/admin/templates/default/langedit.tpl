<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td>
            <h3>{$lang.languages}</h3>
        </td>
        <td>

        </td>
    </tr>
    <tr>
        <td class="leftNav">

            {include file='configuration/leftmenu.tpl'}

        </td>
        <td  valign="top"  class="bordered">
			<div id="bodycont" style="">
			
			{include file='ajax.langedit.tpl'}
			
			<link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
			<script type="text/javascript" src="{$template_dir}js/gui.elements.js?v={$hb_version}"></script>
            </div>
        </td>
    </tr>
</table>