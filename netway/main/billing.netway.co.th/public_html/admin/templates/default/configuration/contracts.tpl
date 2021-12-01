<div id="contracts-conf" data-conf="{$contracts|@json_encode|escape}" data-templates="{$templates|@json_encode|escape}" data-downloads="{$downloads|@json_encode|escape}"></div>
{literal}
    <script type="text/x-handlebars-template" id="contracts-template-edit">
        <li class="list-group-item">
            <div class="row">
                {{#if edit}}
                    <div class="col-md-3">
                        <input type="text" name="contracts[{{id}}][name]" class="inp" value="{{name}}" id="{{id}}" style="width: 100%" placeholder="Contract name"/>
                        <div class="l_editor" id="l_editor_{{id}}">
                        <span class="translations">
                            <span class="taag" style="display:none">Tags: </span>
                        </span>
                            <a class="fs11 editbtn l_adder" href="#"
                               onclick="return HBInputTranslate.addTranslation('{{id}}');">Add translation</a>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <textarea style="width: 100%" name="contracts[{{id}}][description]" placeholder="Enter contract description here (admin only)">{{description}}</textarea>
                        </div>
                    </div>
                    <div class="col-md-2" style="text-align: center">
                        {{#if new}}
                            <a class="btn btn-default btn-sm" disabled="disabled" href="#">Edit template</a> <br>
                            <small><code>Save changes first!</code></small>
                        {{else}}
                            <a class="btn btn-default btn-sm" target="_blank" href="?cmd=configuration&action=contract_template&id={{template_id}}">Edit template</a>
                        {{/if}}
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <select style="width: 100%" multiple="multiple" class="chosenselect" name="contracts[{{id}}][attachments][]">
                                {{#each all_downloads}}
                                    <option value="{{this.id}}">{{this.name}} ({{this.size}} kb)</option>
                                {{/each}}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-1 text-right">
                        <a class="btn btn-default btn-xs rem-contract">
                            <i class="fa fa-trash"></i>
                        </a>
                    </div>
                {{else}}
                    <div class="col-md-1 text-right pull-right">
                        <a class="btn btn-success btn-xs edit-contract">
                            <i class="fa fa-pencil"></i>
                        </a>
                        <a class="btn btn-default btn-xs rem-contract">
                            <i class="fa fa-trash"></i>
                        </a>
                    </div>
                    <input type="hidden" name="contracts[old_{{id}}][name]" value="{{name}}"/>
                    <input type="hidden" name="contracts[old_{{id}}][description]" value="{{description}}"/>
                    <input type="hidden" name="contracts[old_{{id}}][attachments]" value="{{attachments}}"/>
                    <div class="col-md-3">
                        <strong>{{name}}</strong>
                    </div>
                    <div class="col-md-3">
                        <strong>{{description}}</strong>
                    </div>
                    <div class="col-md-2" style="text-align: center">
                        <strong>{{template_parsed}}</strong>
                    </div>
                    <div class="col-md-2">
                        {{#if attachments_parsed}}
                            <code>{{attachments_parsed}}</code>
                        {{else}}
                            <span>-</span>
                        {{/if}}
                    </div>
                {{/if}}
            </div>
        </li>
    </script>
    <script type="text/x-handlebars-template" id="contracts-template">
        <div class="row">
            <div class="col-md-3">Name</div>
            <div class="col-md-3">Description<a title="Admin only" class="vtip_description"></a> </div>
            <div class="col-md-2" style="text-align: center;">Template</div>
            <div class="col-md-4">Attachments <a title="Attachmets are loaded from available, general-purpose files added in Extras->Downloads" class="vtip_description"></a></div>
        </div>
        <ul class="list-group" style="margin-bottom: 10px;">
            {{#if items}}
                {{#each items}}
                    {{> contractEntry }}
                {{/each}}
            {{else}}
                <li class="list-group-item empty-contract">
                    <em>No contract templates added yet</em>
                    <span class="btn btn-primary btn-xs pull-right add-contract">
                    <i class="fa fa-plus"></i> Add new contract template
                </span>
                </li>
            {{/if}}
        </ul>
        {{#if items}}
            <span class="btn btn-primary btn-xs add-contract">
            <i class="fa fa-plus"></i> Add new contract template
        </span>
        {{/if}}
    </script>
    <script>
        $(function () {
            var hb = Handlebars.create(),
                    tpl = hb.compile(document.getElementById("contracts-template").innerHTML),
                    contractEntry = hb.compile(document.getElementById("contracts-template-edit").innerHTML);
            var contracts = $('#contracts-conf'),
                    contractData = contracts.data('conf') || [],
                    downloads_data = contracts.data('downloads') || [],
                    templates_data = contracts.data('templates') || [],
                    refresh = function () {
                        contracts.html(tpl({
                            items: contractData,
                            downloads: downloads_data,
                            templates: templates_data
                        }));
                    },
                    hideDefaultContract = function () {
                        $('.def_contract_save_first').show().css('display', 'flex');
                    };

            hb.registerPartial('contractEntry', contractEntry);
            contracts.on('click', '.edit-contract', function () {
                var self = $(this).closest('li'),
                        index = self.index();
                if (contractData[index]) {
                    contractData[index].id = 'old_' + contractData[index].id;
                    contractData[index].edit = true;
                    contractData[index].all_downloads = downloads_data;
                    contractData[index].all_templates = templates_data;
                    self.replaceWith(contractEntry(contractData[index]))
                }
                contracts.find('select.chosenselect').chosenedge({width: '100%'});
                return false;
            });
            contracts.on('click', '.add-contract', function () {
                var data = {
                    id: 'new_' + contractData.length,
                    edit: true,
                    new: true,
                    all_downloads: downloads_data,
                    all_templates: templates_data,
                };
                contractData.push(data);
                contracts.find('ul.list-group').append(contractEntry(data));
                contracts.find('select.chosenselect').chosenedge({width: '100%'});
                hideDefaultContract();
                return false;
            });
            contracts.on('click', '.rem-contract', function () {
                var self = $(this).closest('li'),
                        index = self.index();
                if (contractData[index]) {
                    contractData.splice(index, 1);
                    self.remove()
                }
                contracts.find('select.chosenselect').chosenedge({width: '100%'});
                hideDefaultContract();
                return false;
            });
            refresh();
        })
    </script>
{/literal}