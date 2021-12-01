{if !$do}
    <table class="data-table backups-list"  width="100%" cellspacing=0>
        <thead>
            <tr>
                <td>{$lang.size}</td>
                <td>{$lang.label}</td>
                <td>{$lang.type}</td>
                <td>{$lang.status}</td>
                <td width="220"></td>
            </tr>
        </thead>
        {foreach item=disk from=$disks}
            <tr>
                <td align="right">{$disk.dsize}</td>
                <td>
                    {$disk.name}
                </td>
                <td>
                    {$disk.type}
                </td>
                <td>
                    {assign value=$disk.state|lower var=diskstatelower}
                    {if $lang[$disk.state]}{$lang[$disk.state]|capitalize}
                    {elseif $lang[$diskstatelower]}{$lang[$diskstatelower]|capitalize}
                    {else}{$disk.state}
                    {/if}
                </td>
                <td>
                    {if $provisioning_type!='single' && $disk.type == 'DATADISK'}
                        <a title="{$lang.edit}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&do=editor&diskid={$disk.id}&vpsid={$vpsid}" class="small_control small_pencil fs11" >
                            {$lang.edit}
                        </a> &nbsp;&nbsp;
                        <a title="Detach" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&do=detach&diskid={$disk.id}&vpsid={$vpsid}&security_token={$security_token}" 
                        {if $vm.state != 'Stopped'}onclick="alert('{$lang.youhavestopthisvm}'); return false;"{/if} class="small_control small_delete fs11" >
                            {$lang.detach}
                        </a> </br>

                    {/if}
                    <a title="Create Snapshot" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&do=create&diskid={$disk.id}&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.suretocreatesnapshot}{if $meteredsnap} {$lang.additionalmayaddedyourbill}{/if}');" class="small_control small_backup fs11" >
                        {$lang.createsnapshot}
                    </a>
                    <br/>
                    <a title="{$lang.backupschedule}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backupschedule&diskid={$disk.id}&vpsid={$vpsid}" class="small_control small_backup_schedule fs11" >
                        {$lang.snapshotschedule}
                    </a>
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="5">{$lang.nothing}</td>
            </tr>
        {/foreach}
    </table>
    {if $availabledisks}
        <div style="padding:10px 0px;text-align:right" class="right">
            <form action="{$ca_url}?cmd=clientarea&action=services&service={$service.id}&vpsdo=detachedhvolumes&vpsid={$vpsid}" method="GET">
                <input type="hidden" name="cmd" value="clientarea" /><input type="hidden" name="action" value="services" />
                <input type="hidden" name="service" value="{$service.id}" /><input type="hidden" name="vpsdo" value="detachedhvolumes" />
                <input type="hidden" name="vpsid" value="{$vpsid}" />
                <input type="submit" class="blue" value="Attach volume" />
            </form>
        </div>
        <div class="clear"></div>
    {/if}
{elseif $do=='editdisk'}
    <form method="post" action="">
        <input type="hidden" value="editdisk" name="make" />

        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">

            <tr>
                <td colspan="2">
                    <div class='input-with-slider'>
                        <span class="slabel">{$lang.diskspace}</span>
                        <input type="text" size="4" required="required" name="disk_size" class="styled" value="{$editdisk.current}" id="disk_size"/>
                        GB
                        <div class='slider' max='{$editdisk.max}' min='{$editdisk.min}' step='1' target='#disk_size'></div>
                    </div>

                </td>

            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" class="padded" style="font-weight: bold;" value="{$lang.savechanges}" onclick="return confirm('{$lang.diskconfirm1}')"/>
                    <input type="button" class="padded" value="{$lang.cancel}"  style="font-weight:normal" onclick="window.location = '?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}'"/>
                </td></tr>
        </table>{securitytoken}
    </form><script type="text/javascript">
        {literal}
            $(document).ready(function() {
                init_sliders();
            });
        {/literal}
    </script>
{/if}