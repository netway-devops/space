<div class="wbox">
    <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div id="cartSummary" class="wbox_content">
            <form method="post" action="">
                <input type="hidden" value="saveforms" name="make">

                {if $forms}

                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table table-striped fullscreen" >
                        {foreach from=$forms item=c key=kk}
                            <tr >
                                <td align="right" width="160"><strong>{$c.name}</strong></td>
                                <td>{include file=$c.configtemplates.clientedit}</td>
                            </tr>
                        {/foreach}
                    </table>
                {/if}

                <input type="submit" style="font-weight:bold" value="{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}" class="btn btn-info padded">

                {securitytoken}
            </form>

    </div>
</div>