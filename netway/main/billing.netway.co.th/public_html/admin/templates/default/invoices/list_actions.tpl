<div class="left menubar">
    {if $type!='bottom'}
        <input type="submit" name="markcancelled" class="submiter markcancelled" style="display:none" />
    {/if}


    {if ($currentlist!='recurring' && !$forbidAccess.editInvoices) || !$forbidAccess.deleteInvoices}{$lang.withselected}
    {/if}
    {if $currentlist!='creditnote' && $currentlist!='recurring' && $currentlist != 'print' && !$forbidAccess.editInvoices}
        <a class="submiter menuitm menu-auto" name="markpaid" {if $enablequeue}queue='push'{/if}  href="#" >
            <span >{$lang.markaspaid}</span>
        </a>
        <a class="submiter menuitm menu-auto" name="markunpaid"  href="#" >
            <span >{$lang.markasunpaid}</span>
        </a>
    {/if}
    {if !$forbidAccess.deleteInvoices && $currentlist != 'print'}
        <a class="submiter menuitm confirm menu-auto " name="delete" href="#" >
            <span style="color:#FF0000">{$lang.Delete}</span>
        </a>
    {/if}

    <span class="menu-auto-reset">&nbsp;</span>

    {if $currentlist!='recurring' && $currentlist != 'print'}
        <a class="submiter menuitm menu-auto " name="send"   href="#" >
            <span style="font-weight:bold">{$lang.Send}</span>
        </a>
        <a class="submiter menuitm formsubmit menu-auto" name="downloadpdf" href="#" >
            <span >PDF</span>
        </a>
        <a class="menuitm setStatus menu-auto" id="hd1" onclick="return false;" href="#" >
            <span class="morbtn">{$lang.moreactions}</span>
        </a>
    {/if}

    {if $type!='bottom'}
        <ul id="hd1_m" class="ddmenu">
            {if $currentlist!='creditnote'}
                <li>
                    <a href="SendReminder2">{$lang.sendreminder}</a>
                </li>
                {if !$forbidAccess.editInvoices}
                    <li>
                        <a href="MarkCancelled">{$lang.markascancelled}</a>
                    </li>
                {/if}
            {/if}
            <li>
                <a href="#" onclick="return send_msg('invoices')">{$lang.SendMessage}</a>
            </li>
            <li>
                <a class="submiter" name="addprintqueue" href="#">{$lang.AddPrintQueue}</a>
            </li>
            <li>
                <a class="submiter" name="removeprintqueue" href="#">{$lang.RemovePrintQueue}</a>
            </li>
        </ul>
    {/if}

    {if $currentlist == 'print'}
        <a class="submiter menuitm formsubmit menu-auto" name="downloadpdf" href="#" >
            <span >PDF</span>
        </a>
        <a class="submiter menuitm menu-auto" name="markprinted" href="#" >
            <span >{$lang.MarkAsPrinted}</span>
        </a>
        <a class="submiter menuitm menu-auto" name="removeprintqueue" href="#" >
            <span >{$lang.RemovePrintQueue}</span>
        </a>
    {/if}
    {adminwidget module="invoices" section="invoicesactions"}
</div>
<div class="right">
    <div class="pagination"></div>
</div>
<div class="clear"></div>