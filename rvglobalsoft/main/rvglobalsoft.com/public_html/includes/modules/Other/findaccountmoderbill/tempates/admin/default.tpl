<div align="center" style="padding-top:20px;">
 <!--  -----------------------------------------------------------------------------------------View search------------------------------------------------------------------------- -->
    <form method="post">
        <br>
        <table border="0" cellpadding="0" cellspacing="0" align="center">
        
            <tbody>
                <tr>
                    <td align="left" valign="middle" class="padd">
                    <h3>Search : &nbsp;</h3><input name="ivc" type="text" size="20" class="bdrbox" value="{$ip}">
                    <input type="submit"  class="btn-order-big">
                    </td>
                </tr>
                  
            </tbody>
        </table>
                   
    </form>   
</div>

{if $data}
    <div align="center" style="padding-top:20px;font-size: 18px;">
        <table width="70%">
            <tr bgcolor="#BDBDBD">
                <th>
                    Email
                </th>
                <th>
                    Account ID
                </th>
                <th>
                    Invoice ID
                </th>
            </tr>
            {foreach from=$data key=k item=p}
                {if $k%2 == 0}
                    <tr  class="rowdata" href="?cmd=clients&action=show&id={$p.cid}">
                        <td>
                            {$p.mail_hostbill}
                        </td>
                        <td>
                            {$p.account_id}
                        </td>
                        <td>
                            {$p.invoice_id}
                        </td>
                    </tr>
                {else}
                    <tr bgcolor="#F2F2F2" class="rowdata" href="?cmd=clients&action=show&id={$p.cid}">
                        <td>
                            {$p.mail_hostbill}
                        </td>
                        <td>
                            {$p.account_id}
                        </td>
                        <td>
                            {$p.invoice_id}
                        </td>
                    </tr>
                {/if}
            {/foreach}
        </table>
    </div>
{/if}

 <script type="text/javascript">
    {literal}
        $(document).ready(function(){
            $('.rowdata').click(function(){
                window.open($(this).attr('href'), "_blank");
            });
            
            $(".rowdata").hover(function() {
                $(this).css('cursor','pointer');
            }, function() {
                $(this).css('cursor','auto');
            });
        });
    {/literal}
</script>
