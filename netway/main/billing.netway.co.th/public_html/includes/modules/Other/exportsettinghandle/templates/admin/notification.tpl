{if $aNotification.type != ''}
    <div class="{if $aNotification.type == 'success'} gbox1 {else} imp_msg {/if}">
        <p>{$aNotification.message}</p>
    </div>
{/if}