{include file="$tplPath/admin/header.tpl"}

<script type="text/javascript" src="{$template_dir}js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$template_dir}js/ckfinder/ckfinder.js"></script>

    <form id="globalTemplateForm" name="globalTemplateForm" method="post">
        <input type="hidden" name="cmd" value="servicecataloghandle" />
        <input type="hidden" name="action" value="updateGlobalTemplate" />
        <input type="hidden" name="id" value="{$aData.id}" />
        
        <table border="0" width="800" cellpadding="2" cellspacing="2">
        <tbody>
        <tr>
            <td width="180">Owner</td>
            <td>
                {$aData.firstname}
            </td>
        </tr>
        <tr>
            <td>หัวข้อ Email Template</td>
            <td>
                
            <div class="mmfeatured">
            <div class="mmfeatured-inner">
                
                <input type="text" name="subject" value="{$aData.subject}" size="60" style="width:100%; border: 0px; line-height: 1.2em;" />
            
            </div>
            </div>
            
            </td>
        </tr>
        <tr>
            <td>รายละเอียด</td>
            <td>
                
            <div class="mmfeatured">
            <div class="mmfeatured-inner">
                
                <textarea name="message" cols="60" rows="15" style="width: 600px; border: 0px;">{$aData.message}</textarea>
                <script type="text/javascript">
                {literal}
                CKEDITOR.replace('message', {toolbar:'Ticket', width:'100%', height:'250px'});
                CKEDITOR.add;
                $(document).ready(function () {
                    CKFinder.setupCKEditor( CKEDITOR.instances.message , '/7944web/templates/default/js/ckfinder' );
                });
                {/literal}
                </script>
            </div>
            </div>
                
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <a class="new_control greenbtn" href="#" onclick="$('#globalTemplateForm').submit();"><span>Save</span></a>
            </td>
        </tr>
        </tbody>
        </table>
    </form>


{include file="$tplPath/admin/footer.tpl"}
