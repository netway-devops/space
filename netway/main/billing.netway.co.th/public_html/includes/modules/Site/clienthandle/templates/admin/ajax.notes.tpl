
<div id="notescontainer">
{literal}
<style type="text/css">
.boxNotes {
    display: block;
}
.boxNotes h3{
    display: block;
    padding: 3px;
    background-color: #464646;
    color:#FFFEFD;
    margin:0px;
}
.boxNotes ul{
    background-color: #FFFEFD;
    color:#464646;
    margin:0px;
}
.boxNotes ul li{
    border-bottom: 1px dotted #4C3B48;
    list-style: none;
    line-height: 1.4em;
}
</style>
{/literal}
    <div class="boxNotes">
        <h3>Client Note:</h3>
        <ul>
            {if $aClientNotes|count}
                {foreach from=$aClientNotes item=aNote}
                <li>{$aNote.note}</li>
                {/foreach}
            {else}
                <li>--- ไม่มีข้อมูล ---</li>
            {/if}
        </ul>
    </div>
    {if $noteType}
    <div class="boxNotes">
        <h3>Domain Note:</h3>
        <ul>
            {if $aNotesDomain|count}
                {foreach from=$aNotesDomain item=aNote}
                <li><a href="?cmd=domains&action=edit&id={$aNote.rel_id}">#{$aNote.rel_id}</a>: {$aNote.name} {$aNote.note}</li>
                {/foreach}
            {else}
                <li>--- ไม่มีข้อมูล ---</li>
            {/if}
        </ul>
    </div>
    <div class="boxNotes">
        <h3>Account Note:</h3>
        <ul>
            {if $aNotesAccount|count}
                {foreach from=$aNotesAccount item=aNote}
                <li><a href="?cmd=accounts&action=edit&id={$aNote.rel_id}">#{$aNote.rel_id}</a>: {$aNote.name} {$aNote.note}</li>
                {/foreach}
            {else}
                <li>--- ไม่มีข้อมูล ---</li>
            {/if}
        </ul>
    </div>
    {/if}

{literal}
<script type="text/javascript">
    $(document).ready(function(){
        //$('#slidepanel').hide();
    });
</script>
{/literal}

</div>