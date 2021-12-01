<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td ><h3>Direct Debit Log</h3></td>
        <td> </td>
    </tr>
    <tr>
        <td class="leftNav">

            <a href="?cmd=direct_debit"  class="tstyled selected"><strong>Direct Debit</strong></a>

        </td>
        <td  valign="top"  class="bordered"><div id="bodycont">

                <form action="" method="post" id="testform" >
                    <div class="blu">

                        <div class="right">
                        </div>
                        <div class="clear"></div>
                    </div>

                    <a href="?cmd=logs&action=clientactivity" id="currentlist" style="display:none" updater="#updater"></a>
                    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                        <tbody>
                            <tr>
                                <th width="150">{$lang.Client}</th>
                                <th width="150">{$lang.Invoice}</th>
                                <th width="150">Invoice status</th>
                                <th >Bank account</th>
                                <th >Bank name</th>
                                <th >{$bic_label}</th>



                            </tr>
                        </tbody>
                        <tbody id="updater">


                            {foreach from=$details item=d}
                            <tr>

                                <td><a href="?cmd=clients&action=show&id={$d.client_id}">{$d.firstname} {$d.lastname}</a></td>
                                <td>#<a href="?cmd=invoices#{$d.invoice_id}">{$d.invoice_id}</a></td>
                                <td><span class="{$d.status}">{$d.status}</span></td>
                                <td>{$d.iban}</td>
                                <td>{$d.bank_name}</td>
                                <td>{$d.bic}</td>
                            </tr>
                            {/foreach}

                        </tbody>
                       

                    </table>
                    <div class="blu">

                        <div class="right">
                            
                        </div>
                        <div class="clear"></div>
                    </div>

                    {securitytoken}</form>




            </div></td>
    </tr>
</table>