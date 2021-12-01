This form element allows your customer to pick server/app during signup. "Server" is separate entry HostBill->Settings->Apps that is related to this product.<br/><br/>

<a href="#" class="btn btn-primary btn-sm" onclick="premadeCloudList();return false" id="preconfigure-btn">Preconfigure field</a>
<a href="#" class="btn btn-info btn-sm" onclick="updateCloudList();return false" id="update-btn">Update field values</a>
<script type="text/javascript">
{literal}
    function premadeCloudList() {

        $('input[name=make]','#facebox').val("includes/libs/configoptions/serverselector/premade.yml").attr('name','premadeurl').after('<input name="premade" value="1" type="hidden" />');
            $('input[name=action]').val('getaddform','#facebox');

       saveChangesField();
      
    }
    function updateCloudList() {
        $('#facebox').unbind('ajaxStop');
        if($('#field_category_id').val()=='new')
            return;

        $.post('?cmd=configfields&action=field',{
            id: $('#field_category_id').val(),
            product_id: $('#product_id').val(),
            update_server_values: 1
        },function(data){
            //refresh
            editCustomFieldForm($('#field_category_id').val(),$('#product_id').val());
        });

    }
    $(function() {
        if($('#field_category_id','#facebox').val()!='new' && $('input[name=variable]','#facebox').val()=='server_selector_id') {
            $('#preconfigure-btn','#facebox').hide();
        } else {

            $('#update-btn','#facebox').hide();
            window.setTimeout(function(){
                $('.tchoice:eq(3)','#facebox').click();
            },500);
        }
    });
{/literal}
</script>

<br /><br />
<h3>How to use this field</h3>
<ul>
    <li>Make sure to save product changes before configuring this field</li>
    <li>For newly added field use "Preconfigure field" button above, this option will set required variable name + load servers you've have available in Connect with App for this product</li>
    <li>You can update server names in Values tab</li>
    <li>If you've added new server, use "Update field values" button that will appear above.</li>
    <li>When account is inserted to database, this field will change default server for account to server that customer selected</li>
</ul>


<h3><span style="color:red">Important:</span> Field limitations</h3>
<ul>
<li>This field will work correctly with "simple" provisioning apps, like cPanel, DirectAdmin etc. </li>
<li>Do not use it for more advanced apps, because:<ul>
        <li>HostBill often  fetch resource IDs from certain server configured in this product for provisioning. </li>
        <li>If customer would choose different server those IDs would not be valid, resulting in provisioning errors.</li>
        <li>"Advanced" app is any app that under "Connect with app" present options that loads IDs rather than names/simple options</li>
    </ul>
</li>

<li>Make sure to monitor servers usage that are available in this field.
    <ul>
        <li>By default (when this field is not available), HostBill attempts to best-fit new accounts on configured servers.</li>
        <li> When this field is enabled your customers can quickly overload single servers with new accounts.</li>
        <li>When certain server is getting full, make sure to remove it from "Values" tab in this field.</li>
    </ul>
    </li>
</ul>