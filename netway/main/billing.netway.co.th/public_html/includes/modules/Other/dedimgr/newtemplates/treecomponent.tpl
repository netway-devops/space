<link rel="stylesheet" href="{$template_dir}js/tree/jqtree.css?v={$hb_version}">
<script type="text/javascript" src="{$template_dir}js/tree/tree.jquery.js?v={$hb_version}"></script>
<input type="text" id="jqitems_ddmgr-search" class="input-sm jqitems-search" placeholder="Filter tree..." >
<div class="jqitems-tree"></div>
{literal}
<script>
    //retrieve data
    function retrieveData() {
        $.ajaxSetup({async:false});
        var returnData = null;
        $.post('?cmd=dedimgr&action=get_tree',{},function (d) {returnData = d;});
        $.ajaxSetup({async:true});
        return $.parseJSON(returnData);
    }

    var tree = $('.jqitems-tree'),
        _vfilter = $('#jqitems_ddmgr-search'),
        state = null,
        _filtering = false,
        data = retrieveData();

    tree.tree({
        data: data,
        dragAndDrop: false,
        saveState: true,
        useContextMenu: false,
        onCreateLi: function(node, $li) {
            var search = _vfilter.val().toLowerCase();
            var icon = '';
            if (search !== '') {
                var value = node.name.toLowerCase();
                var parent = node.parent;
                if (value.indexOf(search) > -1) {
                    $li.show();
                    $li.find('.jqtree-title').addClass('jqtree-title-active');
                    while (typeof (parent.element) !== 'undefined') {
                        tree.tree('openNode', parent);
                        $(parent.element).show().addClass('jqtree-filtered');
                        parent = parent.parent;
                    }
                } else {
                    if (!$(parent.element).is(":visible")) {
                        $li.hide();
                    }
                }
                if (!_filtering) {
                    _filtering = true;
                }
                if (!tree.hasClass('jqtree-filtering')) {
                    tree.addClass('jqtree-filtering');
                }
            } else {
                if (_filtering) {
                    _filtering = false;
                }
                if (tree.hasClass('jqtree-filtering')) {
                    tree.removeClass('jqtree-filtering');
                }
            }
            icon = '<a class="jqtree-togicon" role="presentation" aria-hidden="true">';
            if (node.type == 'colocation') {
                icon += '<i class="fa fa-building"></i></a>';
            } else if (node.type == 'floor') {
                icon += '<i class="fa fa-indent"></i>';
            } else if (node.type == 'rack') {
                icon += '<i class="fa fa-server"></i>';
            } else if (node.type == 'item') {
                icon += '<i class="fa fa-file"></i>';
            }
            icon += '</a>';
            $li.find('.jqtree-element').prepend(icon);
            if (node.url) {
                var a = $li.find('span')[0];
                a.outerHTML = '<a href="' + node.url + '">' + a.outerHTML + '</a>';
            }
        }
    }).on(
        'tree.click',
        function(event) {
            console.log(event.node.type);
            if (event.node.type == 'rack' && !event.node.also_loaded) {
                $.ajaxSetup({async:false});
                var data = null;
                $.post('?cmd=dedimgr&action=get_tree_rack',{rack_id:event.node.rack_id},function (d) {data = d;});
                $.ajaxSetup({async:true});
                tree.tree('updateNode', event.node, $.parseJSON(data));
                tree.tree('openNode', event.node);
            } else {
                tree.tree('toggle', event.node);
            }
        }
    ).on(
        'tree.open',
        function(e) {
            if (_vfilter.val().toLowerCase() == '') {
                state = tree.tree('getState');
            }
        }
    ).on(
        'tree.close',
        function(e) {
            if (_vfilter.val().toLowerCase() == '') {
                state = tree.tree('getState');
            }
        }
    );
    _vfilter.keyup(function() {
        tree.tree('loadData', data);
        if (_vfilter.val().toLowerCase() == '') {
            tree.tree('setState', state);
        }
    });
</script>
{/literal}