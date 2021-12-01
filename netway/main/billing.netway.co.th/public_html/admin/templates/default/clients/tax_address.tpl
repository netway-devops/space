<fieldset>
    ค้นหาข้อมูลที่อยู่จากกรมสรรพากร <!-- http://www.rd.go.th/publish/42535.0.html -->
    <input type="text" id="taxId" />
    <input type="button" value="ค้นหา" onclick="getAddressByTaxId();" /> *** ถ้าไม่มีข้อมูลให้ลองอีก 2-3 ครั้ง
    <div id="taxAddress"></div>
</fieldset>

<br />


<script type="text/javascript">
    lang['deleteprofileheading'] = "{$lang.deleteprofileheading}";
    lang['convertclientheading'] = "{$lang.convertclientheading}";

    {literal}
    function getAddressByTaxId ()
    {
        $('#taxAddress').html('');
        var taxId   = $('#taxId').val();
        $.getJSON('../index.php?cmd=vatservicehandle&action=getByTaxId&taxId='+ taxId, function (data) {
            var oData   = $.parseJSON(data.data);
            $.each(oData, function (k, v) {
                $('#taxAddress').append('<span style="display:block;width:250px;float:left;text-align:right;"> '+ k +' <input type="text" value="'+ v +'" disabled="disabled" /></span>');
            });

            if (oData.hasOwnProperty('vNID')) {
                $('input[name="organizationName"]').val(oData.vName);
                $('input[name="address1"]').val(oData.vHouseNumber
                    +' '+ oData.vBuildingName
                    +' '+ oData.vFloorNumber
                    +' '+ oData.vRoomNumber
                    +' '+ oData.vVillageName
                    +' '+ oData.vSoiName
                    +' '+ oData.vMooNumber
                    );
                $('input[name="address2"]').val(oData.vStreetName
                    +' '+ oData.vThambol
                    );
                $('input[name="city"]').val(oData.vAmphur);
                $('input[name="state"]').val(oData.vProvince);
                $('input[name="postcode"]').val(oData.vPostCode);
            } else {
                getAddressByTaxId();
            }

        });
    }
    {/literal}

</script>