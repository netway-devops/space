{if $result.return}
    <label style="margin: 0;"><button class="yes btn btn-success btn-sm" style="width: 35px; " onclick="validate(this,'{$result.id}')">{$lang.yes}</button><span style="margin-left: 40px;">{$result.info}</span></label>
{else}
    <label style="margin: 0;"><button class="no btn btn-danger btn-sm" style="width: 35px;" onclick="validate(this,'{$result.id}')">{$lang.no}</button><span style="margin-left: 40px;">{$result.info}</span></label>
{/if}