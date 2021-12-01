This form element allows your customer to pick cloud during signup. Cloud is separate  App in HostBill->Settings->Apps.<br/><br/>



<h1 style="color:red;margin:10px 0px;">To preconfigure this field - <a href="#" onclick="premadeCloudList();return false">click here</a></h1>
<h1 style="margin:10px 0px;">To update this field - <a href="#" onclick="updateCloudList();return false">click here</a></h1>
<script type="text/javascript">
{literal}
    function premadeCloudList() {

        $('input[name=make]','#facebox').val("includes/libs/configoptions/onappcloudselect/premade.yml").attr('name','premadeurl').after('<input name="premade" value="1" type="hidden" />');
            $('input[name=action]').val('getaddform','#facebox');
             $('#facebox').ajaxStop(function() {
                updateCloudList();
            });
       saveChangesField();
      
    }
    function updateCloudList() {
        $('#facebox').unbind('ajaxStop');
        if($('#field_category_id').val()=='new')
            return;
        $('#onapp-preloader1').show();
        $.post('?cmd=services&action=product',{id:$('#product_id').val(),field_id:$('#field_category_id').val(),make:'updatemapping'},function(data){
            var r= parse_response(data);
             saveChangesField();
        });
    }
{/literal}
</script>

<div style="display: none;" id="onapp-preloader1" class="onapp-preloader" ><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...<br>
    (this may take longer, if many apps are added)...</div>
<br />
<h3>How it works</h3>
<ul>
    <li>In order for this to work your zone names (HV/NETWORK/STORAGE/OS Groups) should match accross your OnApp installations! (if you're not using auto-assign options).</li>
    <li>Example: If product config: HV Zone is set to "Hypervisors A" - the same zone should exist across all your onapps you wish to allow choosing from.</li>
    <li>When preconfiguring field, HostBill will create internal map of your OnApp zones and install-specific values.</li>
    <li>Once client during order picks cloud other than configured under "Connect with App" his account will be automatically prepared to be created on this cloud</li>
    <li>When account will be provisioned HostBill will try to use matched zones ids to create resources/vps properly</li>
     <li>Any time your installations will be changed, added new zones, new onapp installations - use button above to update!</li>
</ul>

