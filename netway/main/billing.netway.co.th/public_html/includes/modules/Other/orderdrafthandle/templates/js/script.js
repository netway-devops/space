$( document ).ready( function () {
    let url     = window.location.search;
    let urlParams = new URLSearchParams(url);
    let cmd     = urlParams.get('cmd');
    let action  = urlParams.get('action');
    let id      = urlParams.get('id');

    let oOrderDraftHandle   = new OrderDraftHandle();
    oOrderDraftHandle.orderDraftId  = id;

    if (cmd == 'orders' && action == 'createdraft') {
        setTimeout( function () {
            oOrderDraftHandle.addDealForm();
        }, 1500);
    }
});

class OrderDraftHandle {
    
    constructor ()
    {
        this.orderDraftId   = 0;
    }

    addDealForm ()
    {
        let scriptUrl   = $('script[src^="/includes/modules/Other/orderdrafthandle/templates/js/script.js"]').attr('src');
        let urlParams   = new URLSearchParams(scriptUrl);
        let extendInputName     = urlParams.get('EXTEND_INPUT_NAME');
        extendInputName = extendInputName ? extendInputName : 'affiliate_id';
        $('select[name="'+ extendInputName +'"]').closest('tbody').prepend('<tr><td>Deal ID (Clickup)</td><td><div id="dealForm"></div></td><td></td><td></td></tr>');
        ajax_update('?cmd=orderdrafthandle&action=addDealForm&orderDraftId='+ this.orderDraftId, false, '#dealForm');
        
    }

}