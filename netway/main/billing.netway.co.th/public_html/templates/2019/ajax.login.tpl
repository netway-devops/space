{if $loginwidget}
    <div class="modal fade fade2" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title font-weight-bold mt-2" id="exampleModalLabel">{$lang.signin}</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <i class="material-icons">cancel</i>
                    </button>
                </div>
                <div class="modal-body form-credentials form-credentials-modal">
                    {include file="`$template_path`ajax.loginform.tpl" form_action="`$ca_url``$cmd`/`$action`"}
                </div>
            </div>
        </div>
    </div>
{else}
    <div class="d-block col-12 col-md-6 offset-md-3 form-credentials form-credentials-modal">
        {include file="`$template_path`ajax.loginform.tpl" form_action=""}
    </div>
{/if}