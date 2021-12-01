<div id="service_label_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title font-weight-bold mt-2">{$lang.editlabel}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <i class="material-icons">cancel</i>
                </button>
            </div>
            <div class="modal-body">
                <label for="servicelabel">{$lang.label}</label>
                <input type="text" id="servicelabel" name="servicelabel" class="form-control" autofocus>
                <div class="w-100 mt-4">
                    <input type="hidden" name="id" value="">
                    <button type="submit" class="btn btn-primary btn-lg w-100 service_label_success">{$lang.savechanges}</button>
                </div>
            </div>
        </div>
    </div>
</div>