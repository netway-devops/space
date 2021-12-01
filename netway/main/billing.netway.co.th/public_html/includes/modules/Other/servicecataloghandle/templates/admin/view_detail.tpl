
<div style="display: block;">
<div style="float: left;"><h3>รายละเอียด</h3></div>
<div style="float: right;"><a href="">suggestion (0)</a></div>
<div class="mmfeatured">
<div class="mmfeatured-inner">
    <!--
    <p>
        <textarea id="detail" name="detail" rows="3" class="styled inp" style="width:99%;">{$oCatalog->detail}</textarea>
        <script language="JavaScript">
        {literal}
        CKEDITOR.replace('detail', {toolbar:'Basic', width:'100%', height:'300px'});
        {/literal}
        </script>
    </p>

    <p>&nbsp;</p>
    -->
    <h3>Business Service Catalogue (BSC)</h3>
    
    <ul id="grab-sorter" style="width:100%">
        <!--
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            Service name
            <div>
                <input type="text" id="serviceName" name="serviceName" value="{$oBusiness->service_name}" class="catalogDetail styled inp" style="width:99%;" />
            </div>
        </li>
        -->
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            1. รายละเอียดบริการ และ FAQs
            <div>
                <textarea id="serviceDetail" name="serviceDetail" rows="3" class="styled inp" style="width:99%;">{$oBusiness->service_detail}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('serviceDetail', {toolbar:'Basic', width:'100%', height:'250px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.serviceDetail.on('blur', function() {
                        $('#serviceDetail').parent().addLoader();
                        updateServiceCatalog ('serviceDetail', CKEDITOR.instances.serviceDetail.getData());
                    });
                    CKEDITOR.instances.serviceDetail.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.serviceDetail );
                });
                function updateEditorData (event)
                {
                    var data    = event.editor.getData();
                    data        = decodeURIComponent(data);
                    data        = data.replace(/\/\#\.([^\s]+)/, ' ');
                    event.editor.setData(data);
                }
                {/literal}
                </script>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none; color: red;">
            2. สิทธิในการร้องขอ (อนาคตจะทำ automation ให้ ตอนนี้ให้ list รายการมาก่อน)
            <div>
                <textarea id="requestPermission" name="requestPermission" rows="3" class="styled inp" style="width:99%;">{$oBusiness->request_permission}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('requestPermission', {toolbar:'Basic', width:'100%', height:'100px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.requestPermission.on('blur', function() {
                        $('#requestPermission').parent().addLoader();
                        updateServiceCatalog ('requestPermission', CKEDITOR.instances.requestPermission.getData());
                    });
                    CKEDITOR.instances.requestPermission.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.requestPermission );
                });
                {/literal}
                </script>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            3. ขั้นตอนการสั่งซื้อ หรือ ร้องขอ <small> (กรณีเป็นบริการที่ยกเลิก หรือให้บริการเฉพาะลูกค้าเก่า ให้ระบุให้ชัดเจน)</small>
            <div>
                <textarea id="requestOrder" name="requestOrder" rows="3" class="styled inp" style="width:99%;">{$oBusiness->request_order}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('requestOrder', {toolbar:'Basic', width:'100%', height:'250px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.requestOrder.on('blur', function() {
                        $('#requestOrder').parent().addLoader();
                        updateServiceCatalog ('requestOrder', CKEDITOR.instances.requestOrder.getData());
                    });
                    CKEDITOR.instances.requestOrder.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.requestOrder );
                });
                {/literal}
                </script>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            4. เงื่อนไขในการเริ่มดำเนินการส่งมอบ
            <!--เวลาที่สามารถซื้อได้ <small>(เช่น ตลอด 24 ชั่วโมง, ในเวลาทำการ)</small>-->
            <div>
                <textarea id="orderTimeAvailable" name="orderTimeAvailable" rows="3" class="styled inp" style="width:99%;">{$oBusiness->order_time_available}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('orderTimeAvailable', {toolbar:'Basic', width:'100%', height:'200px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.orderTimeAvailable.on('blur', function() {
                        $('#orderTimeAvailable').parent().addLoader();
                        updateServiceCatalog ('orderTimeAvailable', CKEDITOR.instances.orderTimeAvailable.getData());
                    });
                    CKEDITOR.instances.orderTimeAvailable.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.orderTimeAvailable );
                });
                {/literal}
                </script>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            5. ราคา <small> (ระบุให้ชัดเจนว่า อะไรฟรี อะไรเสียตังค์ อะไรต้องซื้อ บริการเสริม)</small>
            <div>
                <textarea id="priceRate" name="priceRate" rows="3" class="styled inp" style="width:99%;">{$oBusiness->price_rate}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('priceRate', {toolbar:'Basic', width:'100%', height:'200px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.priceRate.on('blur', function() {
                        $('#priceRate').parent().addLoader();
                        updateServiceCatalog ('priceRate', CKEDITOR.instances.priceRate.getData());
                    });
                    CKEDITOR.instances.priceRate.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.priceRate );
                });
                {/literal}
                </script>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            6. บริการอื่น ๆ ที่เกียวข้อง <small>(link ไปยัง service catalog นั้น ๆ แบบ new windows)</small>
            <div>
                <textarea id="serviceRelated" name="serviceRelated" rows="3" class="styled inp" style="width:99%;">{$oBusiness->service_related}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('serviceRelated', {toolbar:'Basic', width:'100%', height:'200px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.serviceRelated.on('blur', function() {
                        $('#serviceRelated').parent().addLoader();
                        updateServiceCatalog ('serviceRelated', CKEDITOR.instances.serviceRelated.getData());
                    });
                    CKEDITOR.instances.serviceRelated.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.serviceRelated );
                });
                {/literal}
                </script>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            7. ข้อห้ามในการใช้บริการ <small>(เช่น reserved domain, porn, game, proxy, vpn, voip)</small>
            <div>
                <textarea id="servicePolicy" name="servicePolicy" rows="3" class="styled inp" style="width:99%;">{$oBusiness->service_policy}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('servicePolicy', {toolbar:'Basic', width:'100%', height:'150px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.servicePolicy.on('blur', function() {
                        $('#servicePolicy').parent().addLoader();
                        updateServiceCatalog ('servicePolicy', CKEDITOR.instances.servicePolicy.getData());
                    });
                    CKEDITOR.instances.servicePolicy.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.servicePolicy );
                });
                {/literal}
                </script>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            8. เจ้าหน้าที่ขาย <small> (ระบุชื่อ และ pipeline)</small>
            <div>
                <input type="hidden" id="salePerson" name="salePerson" value="{$oBusiness->sale_person}" class="catalogDetail styled inp" style="width:99%;" />
                <select onchange="updateSalePerson(this.value);">
                    <option value="">--- ไม่ระบุ ---</option>
                    {foreach from=$aPipedrive item="aPipe" key="k"}
                    <optgroup label="{$aPipe.name}">
                    {foreach from=$aPipe.staff item="v2" key="k2"}
                    {assign var="x1" value=$aPipe.name}
                    {assign var="x2" value="#$k $x1 $v2($k2)"}
                    <option value="#{$k} {$aPipe.name} {$v2}({$k2})" {if $oBusiness->sale_person == $x2} selected="selected" {/if} >{$v2}</option>
                    {/foreach}
                    </optgroup>
                    {/foreach}
                </select>
            </div>
        </li>
        <li style="border:none;">&nbsp;</li>
        <li style="border:none;">
            9. การรับประกัน / คืนเงิน
            <div>
                <textarea id="warrantyRate" name="warrantyRate" rows="3" class="styled inp" style="width:99%;">{$oBusiness->warranty_rate}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('warrantyRate', {toolbar:'Basic', width:'100%', height:'150px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.warrantyRate.on('blur', function() {
                        $('#warrantyRate').parent().addLoader();
                        updateServiceCatalog ('warrantyRate', CKEDITOR.instances.warrantyRate.getData());
                    });
                    CKEDITOR.instances.warrantyRate.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.warrantyRate );
                });
                {/literal}
                </script>
            </div>
        </li>
    </ul>

</div>
</div>
</div>

