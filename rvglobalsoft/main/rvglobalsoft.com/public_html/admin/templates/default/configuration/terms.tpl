<div id="terms-conf" data-conf="{$terms|@json_encode|escape}"></div>
{literal}
    <script type="text/x-handlebars-template" id="terms-template-edit">
        <li class="list-group-item">
            <div class="row">
                {{#if edit}}
                <div class="col-md-3">

                    <input type="text" name="ServiceTerms[{{id}}][lang]" class="inp" value="{{lang}}"
                           id="{{id}}" style="width: 100%"
                           placeholder="Terms description eg. Terms of Service"/>
                    <div class="l_editor" id="l_editor_{{id}}">
                        <span class="translations">
                            <span class="taag" style="display:none">Tags: </span>
                        </span>
                        <a class="fs11 editbtn l_adder" href="#"
                           onclick="return HBInputTranslate.addTranslation('{{id}}');">Add translation</a>
                        <div class="clear"></div>
                    </div>

                </div>
                <div class="col-md-8">
                    <div class="form-group">
                        <input type="text" name="ServiceTerms[{{id}}][url]" class="inp" value="{{url}}"
                               style="width: 100%"
                               placeholder="Enter the URL to your terms"/>
                    </div>
                </div>
                <div class="col-md-1 text-right">
                    <a class="btn btn-default btn-xs rem-term">
                        <i class="fa fa-trash"></i>
                    </a>
                </div>
                {{else}}
                <div class="col-md-2 text-right pull-right">
                    <a class="btn btn-success btn-xs edit-term">
                        <i class="fa fa-pencil"></i>
                    </a>
                    <a class="btn btn-default btn-xs rem-term">
                        <i class="fa fa-trash"></i>
                    </a>
                </div>
                <input type="hidden" name="ServiceTerms[{{@index}}][lang]" value="{{lang}}"/>
                <input type="hidden" name="ServiceTerms[{{@index}}][url]" value="{{url}}"/>
                <div class="col-md-3">
                    <strong>{{name}}</strong>
                </div>
                <div class="col-md-7" >
                    <code>{{url}}</code>
                </div>

                {{/if}}
            </div>
        </li>
    </script>
    <script type="text/x-handlebars-template" id="terms-template">
        <ul class="list-group" style="margin-bottom: 10px;">
            {{#if items}}
            {{#each items}}
            {{> termEntry }}
            {{/each}}
            {{else}}
            <li class="list-group-item empty-term">
                <em>No terms added yet</em>
                <span class="btn btn-primary btn-xs pull-right add-term">
                    <i class="fa fa-plus"></i> Add new term
                </span>
            </li>
            {{/if}}
        </ul>
        {{#if items}}
        <span class="btn btn-primary btn-xs add-term">
            <i class="fa fa-plus"></i> Add new term
        </span>
        {{/if}}
    </script>
    <script>
        $(function () {
            var hb = Handlebars.create(),
                tpl = hb.compile(document.getElementById("terms-template").innerHTML),
                termEntry = hb.compile(document.getElementById("terms-template-edit").innerHTML);

            var terms = $('#terms-conf'),
                termData = terms.data('conf') || [],
                refresh = function (){
                    terms.html(tpl({
                        items: termData
                    }))
                }

            hb.registerPartial('termEntry', termEntry);

            terms.on('click', '.edit-term', function () {
                var self = $(this).closest('li'),
                    index = self.index();

                if (termData[index]) {
                    termData[index].id = 'term' + index;
                    termData[index].edit = true;
                    self.replaceWith(termEntry(termData[index]))
                }
                return false;
            })

            terms.on('click', '.add-term', function () {
                var data = {
                    id: 'term' + termData.length,
                    edit: 1
                };

                termData.push(data)
                terms.find('ul').append(termEntry(data))

                if(termData.length === 1)
                    refresh();

                return false;
            })

            terms.on('click', '.rem-term', function () {
                var self = $(this).closest('li'),
                    index = self.index();

                if (termData[index]) {
                    termData.splice(index, 1);
                    self.remove()
                }

                console.log(termData)
                if (!termData.length)
                    refresh();

                return false;
            })

            refresh();
        })
    </script>
{/literal}