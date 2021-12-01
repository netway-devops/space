<div class="wbox">
    <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div  class="wbox_content">
        {$lang.autorenewhowto}
        {if $details && $details.next_invoice && $details.next_invoice!='0000-00-00'}
           <b>{$lang.autorenewinvoice} {$details.next_invoice|dateformat:$date_format}, {$lang.adding} {$details.period} {$lang.years} @  {$details.recurring_amount|price:$currency}</b>
            <br/> <br />
        {/if}
        
         <center>
             <table  cellspacing="0" cellpadding="0" class="checker table table-striped" width="100%">
         <tr class="even">
             <td align="right" width="50%" style="border:none"><b>{$lang.autorenew}</b></td>
            <td style="border:none">
                <form action="" method="post" onsubmit="return confirm_renew_form(this)">
                    <input type="hidden" name="make" value="setrenew" />
                    <select  name="renew" class="inp styled span2" id="renewconfirm">
                        <option value="">-</option>
                    <option value="0" {if $details && $details.autorenew==0}selected="selected"{/if}>{$lang.Off}</option>
                    <option value="1" {if $details && $details.autorenew==1}selected="selected"{/if}>{$lang.On}</option>

                </select> <input type="submit" value="{$lang.savechanges}" class="padded btn btn-primary" style="font-weight:bold" />
                {securitytoken}    </form>

                </td>
        </tr>
        </table>
        </center>
        
    </div>
</div>
<script type="text/javascript" >
    {literal}
        function confirm_renew_form(el) {
            if($('#renewconfirm').val()==="0")
                return confirm('{/literal}{$lang.autorenewoff}{literal}');
            if($('#renewconfirm').val()==="")
                return false;
                    
                return true;
        }
        {/literal}
</script>

