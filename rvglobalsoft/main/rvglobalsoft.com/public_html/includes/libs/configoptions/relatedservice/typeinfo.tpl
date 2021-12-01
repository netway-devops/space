This form element allows your customer to pick service related to order he is making. Service selected here will be added into "Related services" section in account management.

<script type="text/javascript">
{literal}

    $(function() {
        if($('#field_category_id','#facebox').val()!='new' && $('input[name=variable]','#facebox').val()=='server_selector_id') {
        } else {

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
    <li>You do not need to setup "values" for this field, HostBill will populate them automatically with logged-in customer services during order</li>
    <li>If customer is not logged in during order, this field will not block order, no value would be passed as "Related Service" </li>
</ul>