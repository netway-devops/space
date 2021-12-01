<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td  class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td  valign="top"  class="bordered" >
                <div id="bodycont">
                    <div id="blank_state" class="blank_state blank_news">
                        <div class="blank_info">
                            <h1>RV SSL Management</h1>
                            This plugin is management RV SSL Products and RV SSL for RV Reseller Platform . How it works: 
                            {if $submenuList}
                            <ol>
                            {foreach from=$submenuList item=menu}
                            <li><a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}">{$menu.name}</a>: {$menu.desc}</li>
                            {/foreach}
                            </ol>
                            {/if}
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>