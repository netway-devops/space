
<div id="AdmNotes" rel="{$cmd}" >
    <a id="notesurl" href="?cmd={$cmd}&action=notes{if $cmd=='clients'}&id={$client.id}{elseif $cmd=='orders' && $details}&id={$details.id}{elseif $cmd=='contracts' && $contract}&id={$contract.id}{elseif $draft.id}&id={$draft.id}&draft=1{elseif $invoice}&id={$invoice.id}{elseif $estimate}&id={$estimate.id}{elseif $cmd=='dedimgr'}&id={$item.id}{else}&id={$details.id}{/if}" style="display:none;" ></a>
    <strong>
        {if $cmd == 'accounts'}
            {$lang.accnotes}
        {elseif $cmd == 'clients'}
            {$lang.clientnotes}
        {elseif $cmd == 'orders'}
            {$lang.ordernotes}
        {elseif $cmd == 'domains'}
            {$lang.domainnotes}
        {elseif $cmd == 'invoices' || $cmd == 'estimates'}
            Admin Notes
        {elseif $cmd == 'contracts'}
            Contract Notes (admin only)
        {else}
            {$lang.notes}
        {/if}

    </strong> 
    <a href="#" class="editbtn" onclick="return AdminNotes.show();">{$lang.Add}</a>
    <div id="notesContainer">

    </div>
    <div class="admin-note-new" style="display:none;">
        <div class="admin-note-input">
            <textarea rows="4" name="note" class="form-control notes_field notes_changed"></textarea>
            <div class="admin-note-attach"></div>
        </div>
        <div id="notes_submit" class="notes_submit admin-note-submit">
            <input type="button" name="savenotes" value="{$lang.savechanges}" onclick="return AdminNotes.addNew();">
        </div>
        <a href="#" class="editbtn" onclick="return AdminNotes.addFile();">Attach file</a>
        <a href="#" class="editbtn" onclick="return AdminNotes.hide();">{$lang.Cancel}</a>
        {if $cmd == 'clients'}
            <input type="checkbox" name="flags[]" value="1" class="notes_checkbox"> <span class="notes_checkbox_text">{$lang.note_add_to_tickets}</span>
        {/if}
        {if $cmd == 'clients' || $cmd == 'accounts' || $cmd == 'domains'}
            <input type="checkbox" name="flags[]" value="2" class="notes_checkbox"> <span class="notes_checkbox_text">{$lang.note_client_viewable}</span>
        {/if}
    </div>
</div>
<script src="{$template_dir}js/fileupload/init.fileupload.js?v={$hb_version}"></script>
{literal}
    <script type="text/javascript">
        $(function() {
            {/literal}
            AdminNotes.init();
            AdminNotes.me = '{$admindata.firstname|escape:'javascript'} {$admindata.lastname|escape:'javascript'}';
            AdminNotes.dateformat = '{$date_format}';
            {literal}
        });
    </script>
{/literal}
