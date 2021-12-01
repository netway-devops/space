<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td><h3>CSV Import</h3></td>
    </tr>
    <tr>
        <td class="leftNav">
            {foreach from=$importers item=imp}
                <a class="tstyled {if $imp.type==$importer.type}selected{/if}" href="?cmd=csv&import={$imp.type}">
                    {$imp.name}
                </a>
            {/foreach}
        </td>
        <td valign="top" class="bordered">
            {if $action=='result'}
                {include file="queue/progress.tpl" embedded=true token=$token}
            {else}
                <div id="bodycont">
                    <form method="post" action="?cmd=csv&action=import&import={$importer.type}"
                          enctype="multipart/form-data" id="csvform">
                        <div class="blank_state blank_news">
                            <div class="blank_info">
                                <h1>{$importer.name}</h1>
                                <div class="form-group">
                                    <input type="file" name="csvfile" style="margin: 4px 0;"/>

                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Import</button>
                                    <a class="btn btn-default" href="?cmd=csv&import={$importer.type}&action=sample">
                                        Download Sample CSV file
                                    </a>
                                </div>
                            </div>
                        </div>
                        {securitytoken}
                    </form>
                </div>
            {/if}
        </td>
    </tr>
</table>
