
<div style="display: block;">
<div style="float: left;"><h3>รายละเอียด</h3></div>
<div style="float: right;"><a href="">suggestion (0)</a></div>
<div class="mmfeatured">
<div class="mmfeatured-inner">
    
    <h3>วิธีแก้ปัญหา Level 1</h3>
    
    <ul id="grab-sorter" style="width:100%">
        <li style="border:none;">
            <div>
                <textarea id="detailHelpdesk" name="detailHelpdesk" rows="3" class="styled inp" style="width:99%;">{$oKB->detail_helpdesk}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('detailHelpdesk', {toolbar:'Basic', width:'100%', height:'200px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.detailHelpdesk.on('blur', function() {
                        $('#detailHelpdesk').parent().addLoader();
                        updateIncidentKB ('detailHelpdesk', CKEDITOR.instances.detailHelpdesk.getData());
                    });
                    CKEDITOR.instances.detailHelpdesk.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.detailHelpdesk , '/7944web/templates/default/js/ckfinder');
                });
                {/literal}
                </script>
            </div>
        </li>
    </ul>
    
    <p>&nbsp;</p>
    
    <h3>วิธีแก้ปัญหา Level 2</h3>
    
    <ul id="grab-sorter" style="width:100%">
        <li style="border:none;">
            <div>
                <textarea id="detailSupport" name="detailSupport" rows="3" class="styled inp" style="width:99%;">{$oKB->detail_support}</textarea>
                <script language="JavaScript">
                {literal}
                CKEDITOR.replace('detailSupport', {toolbar:'Basic', width:'100%', height:'200px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKEDITOR.instances.detailSupport.on('blur', function() {
                        $('#detailSupport').parent().addLoader();
                        updateIncidentKB ('detailSupport', CKEDITOR.instances.detailSupport.getData());
                    });
                    CKEDITOR.instances.detailSupport.on('afterPaste', function(event) {
                        updateEditorData(event);
                    });
                    CKFinder.setupCKEditor( CKEDITOR.instances.detailSupport , '/7944web/templates/default/js/ckfinder');
                });
                {/literal}
                </script>
            </div>
        </li>
    </ul>
    
    <p>&nbsp;</p>
    
</div>
</div>
</div>

