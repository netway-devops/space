<div class="form_submit_document" style="display: none;">
    <div class="container">
    	<div class="row">
    		<div class="col-md-8 table-header">
		        <p><b>SSL Certificate Documentation</b></p>
		    </div>
    		<div class="col-md-8" style="margin-top: 30px;">
    			<p>You have to submit documents to SSL authority to validate your organization. Just provide required documents to show that the company you are registering is lawfully formed and legal.</p>
    			<br />
    			<!--
    			<p>These are the example templates of Professional Opinion Letter for each SSL Authority:</p>
    			<ul>
    				<li><a href="/templates/netwaybysidepad/doc/ThawteProfessionalOpinionLetter.pdf" target="_blank">Thawte</a></li>
    				<li><a href="/templates/netwaybysidepad/doc/GeoTrustProfessionalOpinionLetter.pdf" target="_blank">GeoTrust</a></li>
    				<li><a href="/templates/netwaybysidepad/doc/SymantecProfessionalOpinionLetter.pdf" target="_blank">Symantec</a></li>
    			</ul>
    			<br />
    			-->
    			<p>Click 'Choose File' to upload any required documents for validation.</p>
    			<br />
    			<form method="post" action="?cmd=module&module=ssl&action=upload_documents" name="frmsubmitdocument" id="frmsubmitdocument" enctype="multipart/form-data" onsubmit="return false;">
		            <b>Verify organization documents, Certificate of Incorporation or Business License</b>
		            <br><input type="file" name="organization" id="organization"/><br><br>
		            <b>Verify documents of Acknowledgement of Agreement</b>
		            <br><input type="file" name="acknowledgement" id="acknowledgement"/><br><br>
		            <!--
		            <b>Professional Opinion Letter</b>
		            <br><input type="file" name="opinion_letter" id="opinion_letter"/><br><br>
		            -->
		            <b>Copy of Lawyer License</b>
		            <br><input type="file" name=" lawyer_license" id=" lawyer_license"/><br><br>
		            <b>Copy of Attorney Identification Card</b>
		            <br><input type="file" name=" attorney_identification_card" id=" attorney_identification_card"/><br><br>
		            <div  style="margin-left: 150px;"><br>
			            <input name="order_id" value="{$service.order_id}"  type="hidden"/>
			            <input id="validate_button" class="back" type="button" value="Back">
			            &nbsp; <input type="submit" value="Submit" id="validate_button"  class="" >
			            &nbsp <input id="validate_button" class="" type="reset" value="Reset" >
		            </div>
		        </form>
    		</div>
    	</div>
    </div>
</div>