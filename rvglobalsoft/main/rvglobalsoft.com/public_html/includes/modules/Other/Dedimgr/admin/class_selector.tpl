<select name="css" class="inp" onchange="change_css(this)">
    <option  {if $item.css=='default_1u'}selected="selected"{/if}>default_1u</option>
    <option  {if $item.css=='blanking_1u'}selected="selected"{/if}>blanking_1u</option>
    <option  {if $item.css=='blanking_2u'}selected="selected"{/if}>blanking_2u</option>
    <option  {if $item.css=='storage_1u'}selected="selected"{/if}>storage_1u</option>
    <option  {if $item.css=='storage_2u'}selected="selected"{/if}>storage_2u</option>
    <option  {if $item.css=='switch_1u'}selected="selected"{/if}>switch_1u</option>
    <option  {if $item.css=='server_2u'}selected="selected"{/if}>server_2u</option>
    <option  {if $item.css=='server_2u2'}selected="selected"{/if}>server_2u2</option>
    <option  {if $item.css=='switch_2u'}selected="selected"{/if}>switch_2u</option>
    <option  {if $item.css=='pdu_1u'}selected="selected"{/if}>pdu_1u</option>
    <option  {if $item.css=='pdu_2u'}selected="selected"{/if}>pdu_2u</option>
    <option  {if $item.css=='kvm_2u'}selected="selected"{/if}>kvm_2u</option>
</select>