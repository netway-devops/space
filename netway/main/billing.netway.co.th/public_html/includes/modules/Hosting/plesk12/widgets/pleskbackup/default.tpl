
<div >
    {foreach from=$widgets item=wig}
        {if $widget.name == $wig.name}
            {assign value=$wig.location var=widgeturl}
        {/if}
    {/foreach}
    <div id="billing_info" class="wbox">
        <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
        <div class="wbox_content">
            <form autocomplete="off" action="{$widget_url}&act={$act}" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {counter start=1 skip=1 assign=even}
                    <thead>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                            <td align="left">{$lang.Available}:</td>
                        </tr>
                    </thead>
                    <tbody id="updater">
                        {if $listentrys}
                            {foreach from=$listentrys item=entry key=index} 
                                <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                    <td align="center">
                                        <img src="{$widgeturl}{if $entry.status == 'complete'}ico_info.gif"{else}ajax-loading2.gif"{/if} alt="{$entry.status|capitalize}" title="{$entry.status|capitalize}">
                                             <strong>{$entry.file}</strong>
                                        ( {$entry.created} )
                                    </td>
                                </tr>
                            {/foreach}
                        {else}
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="center">
                                    <strong>{$lang.nobackups}</strong>
                                </td>
                            </tr>
                        {/if}
                    </tbody>
                    <tfoot>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">{$lang.yourbackapslocatedin} <strong>{if $ftp_homedir}{$ftp_homedir}{else}home/yourusername{/if}</strong> {$lang.directory}</td></tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td style="border:none" colspan="4"><input class="btn btn-success" type="submit" name="save" value="{$lang.plesk_create_backup}"></td></tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>
<link rel="stylesheet" type="text/css" href="{$widgetdir_url}../widget.css"  media="all">