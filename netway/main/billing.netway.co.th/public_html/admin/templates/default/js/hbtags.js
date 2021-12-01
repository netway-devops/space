var HBTags = {
    bindFilter: function(item, container,reset){
        $(container).html('');
        $('.inlineTags',$(item)).off("click","span").on("click","span",function(){
            var tag = $(this).text();
            $(item).hide();
            $(reset).show();
            $(container).html("Showing products with tag: <span class='label label-success'>"+tag+"</span>");
            $(item +"[data-tags*='"+tag+"']").show();
            return false;
        });
        $(reset).on("click",function(){
            $(container).html('');
            $(reset).hide();
            $(item).show();
            return false;
        });
    },
    showMatchingTags: function (list, str, max) {
        $(list).html('').hide();
        if (max == undefined)
            max = 10;
        var i = 0, r = 0;
        var rbox = $(list);
        var spans = $('#tagsBox span.tag');
        spans.each(function () {
            var tag = this.innerHTML;
            if ((str == undefined || str.length < 1 || tag.match(new RegExp('^' + str + '.*$'))) && $('span a:first-child', rbox.parent().parent()).filter(function () {
                    return tag == $(this).text()
                }).length == 0 && (max == 0 || r < max)) {
                rbox.append('<li>' + this.innerHTML + '</li>');
                r++;
            }
        });


        if ($('li', $(list)).length)
            $(list).show();
        $('body').bind('mouseout mousein', function (e) {
            if ($(e.target).parents('label').filter($(list).parents('label')).length == 0 && $(e.target).attr('id') != 'tagsCont') {
                if (HBTags.hideTagsTimeout == null)
                    HBTags.hideTagsTimeout = setTimeout(function () {
                        $(list).hide();
                        $('body').unbind('mouseout mousein');
                    }, 400);
            } else {
                clearTimeout(HBTags.hideTagsTimeout);
                HBTags.hideTagsTimeout = null;
            }
        });
    },
    hideTagsTimeout: null,
    insertTags: function (to, tags, special, preserve, wraperclass) {
        if (wraperclass === undefined)
            wraperclass = 'tag';
        var cls = '.' + wraperclass;
        var old = {};
        if (typeof preserve == 'undefined') {
            $('span' + cls + ':not(:has(a:first-child[class]))', to).remove();
            $('span' + cls, to).each(function () {
                old[$(this).find('a:first-child').text()] = $(this).detach()
            });
        }
        $.each(tags, function (i) {
            if (typeof old[tags[i]] == 'object') {
                if ($('span' + cls + ' a:first-child[class]', to).length)
                    $('span' + cls + ':has(a:first-child[class]):last', to).after(old[tags[i]]);
                else
                    $(to).prepend(old[tags[i]]);
                return;
            }
            var clas = '';
            if (typeof special != 'undefined' && typeof special[tags[i]] != 'undefined') {
                clas = 'class="' + special[tags[i]] + '"'
            }
            $('label', to).before('<span class="' + wraperclass + '"><a ' + clas + '>' + tags[i] + '</a> |<a class="cls">x</a></span>');
        });
    },
    bindTagsActions: function (root, tip, oninsert, onremove) {

        $(root + ' input').bind('focus click', function () {
            $(this).css({
                filter: 'alpha(opacity=100)',
                opacity: '1'
            });
            setTimeout('HBTags.showMatchingTags("' + root + ' ul","' + this.value + '",' + tip + ')', 100);
        }).blur(function () {
            if (this.value.length == 0)
                $(this).css({
                    filter: 'alpha(opacity=80)',
                    opacity: '0.8'
                });
        });

        $(root).undelegate('input', 'keydown').delegate('input', 'keydown', function (event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                return false;
            }
        }).undelegate('input', 'keyup').delegate('input', 'keyup', function (e) {
            HBTags.showMatchingTags(root + ' ul', this.value, tip);
            if (this.value.length == 0)
                return;
            if (e.which == 13) {
                e.preventDefault();
                var tag = $.trim(this.value).replace(/[#$%^&*(){}~`\[\]:;"'?|+\/><,]/g, '');
                if (tag.length == 0)
                    return;
                if ($(root + ' span a:first-child').filter(function () {
                        return this.innerHTML == tag
                    }).length > 0)
                    return;
                tag = $('<i/>').text(tag).html();
                HBTags.insertTags(root, [tag], [], true);
                if (typeof oninsert == 'function')
                    oninsert(tag);
                this.value = '';
                HBTags.showMatchingTags(root + ' label ul', '', tip);
            }
            return false;
        });
        $(root + ' ul').undelegate('li', 'click').delegate('li', 'click', function () {
            var ev = jQuery.Event("keyup");
            ev.which = 13;
            $(root + ' input').val(this.innerHTML).trigger(ev);

        });
        $(root).undelegate('span a:last-child', 'click').delegate('span a:last-child', 'click', function () {
            if ($(this).prev('a').hasClass('shared')) {
                if (!confirm(lang.unshare_confirm)) {
                    return false;
                }
            }
            $(this).parent().remove();
            if (typeof onremove == 'function')
                onremove($(this).siblings().text());
        });
        $(document).undelegate(root, 'click').delegate(root, 'click', function (e) {
            if ($(e.target).is(root))
                $('label input', this).focus();
        });
    }

};