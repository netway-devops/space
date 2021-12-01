{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '_common/ajax.noteseditor.tpl.php');
{/php}
{foreach from=$notes item=note}
    <div class="admin-note" rel="{$note.id}">
    {if $editable == 'true'}
        <a class="editbtn right" href="#" onclick=" if (confirm('Are you sure you want to delete this note?'))
                    AdminNotes.del({$note.id});
                return false;"><small>[{$lang.Delete}]</small></a>
	{/if}
	
        <div class="left">
            {$note.date|date_format:'%d %b %Y'}{if $note.firstname || $note.lastname} by {$note.firstname} {$note.lastname}{/if}
            {if $editable == 'true'}
            <a href="#" class="editbtn" onclick=" AdminNotes.hide();
                $(this).parent().next().hide().next().show().next().hide();
                return false;">{$lang.Edit}</a>
            {/if}
        </div>

        <pre class="admin-note-body">{$note.note|escape:'html':'UTF-8'}</pre>
        <div class="admin-note-edit clear" style="display:none">
            <textarea rows="4" name="notes" class="notes_field notes_changed form-control admin-note-input">{$note.note|escape:'html':'UTF-8'}</textarea>
            <div id="notes_submit" class="notes_submit admin-note-submit">
                <input type="button" name="savenotes" value="{$lang.savechanges}" onclick="AdminNotes.edit({$note.id});">
            </div>
            <a href="#" class="editbtn" onclick="$(this).parent().hide().prev().show().next().next().show(); return false;">{$lang.Cancel}</a>
            {if $cmd == 'clients'}
                <input type="checkbox" name="flags[{$note.id}][]" value="1" class="notes_checkbox" {if $note.flags & 1}checked{/if}> <span class="notes_checkbox_text">{$lang.note_add_to_tickets}</span>
            {/if}
        </div>
        {if $cmd == 'clients' && $note.flags & 1}<span class="notes_checkbox_text" style="color: #ec9eff; margin-left:3px;"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> {$lang.note_add_to_tickets}</span>{/if}
        {if $note.attachments}
            <div class="admin-note-attach">
            {foreach from=$note.attachments item=attachment}
                <div class="attachment"><a href="?cmd=root&action=download&type=downloads&id={$attachment.id}">{$attachment.name}</a></div>
            {/foreach}
            </div>
        {/if}
    </div>
{/foreach}
