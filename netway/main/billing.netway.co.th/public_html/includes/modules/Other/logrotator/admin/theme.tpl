<div class="row" >
    <div class="col-md-12">
            <div class="box-header" >
                <h3 class="box-title">Log rotation/backup utility</h3>

            </div>
            <div class="box-body">

                {if !$backups}
                    <div class="blank_state blank_kb">
                        <div class="blank_info">
                            <h1>No log rotation tables were created yet</h1>
                            Logs are rotated weekly with cron, if log tables consist too many entries it will be copied to backup table, and emptied, to increase performance.<br/>
                            Backup tables will be listed here for reference - you can keep them for audit purposes, or move to different database to decrease your backup size.
                            <div class="clear"></div>

                            <div class="clear"></div>
                        </div>
                    </div>
                {else}
                    Backup tables are listed here for reference - you can keep them for audit purposes, or move to different database to decrease your backup size.

                    <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
                        <tbody>
                        <tr>
                            <th align="left" >Log</th>
                            <th align="left" >Table name</th>
                            <th align="left" >Created at</th>
                        </tr>
                        {foreach from=$backups item=l name=b}

                            <tr class="{if $smarty.foreach.b.iteration%2==0}even{/if}">
                                <td>{$l.descr}</td>
                                <td>{$l.name}</td>
                                <td>{$l.date}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                {/if}


            </div>
    </div>
</div>