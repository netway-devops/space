$(function () {
    $('.product-billing').each(function () {
        var self = $(this);

        if(self.data('productBilling')){
            return;
        }

        self.data('productBilling', true);

        var currency = new CurrencyFormat(self.data('currency')),
            tbpricing = $('#tbpricing', this),
            addpricing = $('#addpricing', this),
            cycleselect = $('#billing-cycle-select'),
            newprice = $('.new-cycle .input-price-row input', this),
            cycles;

        function dataToPrice(key) {
            var price = !this.hasOwnProperty(key) ? 0 : (
                typeof this[key] === 'number' ? this[key] : parseFloat(this[key])
            );
            return isNaN(price) ? 0 : price;
        }

        cycles = $('.cycle', this).get().reduce(function (map, elm) {
            var cycle = $(elm),
                data = cycle.data();
            if (!data.cycle)
                return map;

            data.price = dataToPrice.call(data, 'price');
            data.setup = dataToPrice.call(data, 'setup');
            data.upgrade = dataToPrice.call(data, 'upgrade');
            data.enabled = data.price + data.setup > 0;
            map[data.cycle] = cycle;
            return map;
        }, {})

        function controlfrom() {
            addpricing.removeClass('active');
            tbpricing.hide();

            $('#add-cycle-area', self).toggle($('.cycle:not(:visible)', self).length > 0)
            return false;
        }


        function setupcycles() {
            var options = [], index = 1;

            $.each(cycles, function (key, elm) {
                var cycle = elm.data();

                elm.toggleClass('enabled',cycle.enabled);
                if(cycle.enabled)
                    options.push(elm);

                elm.find('.input-price')
                    .val(currency.formatNumber(cycle.price))
                    .prop('tabindex', index++);

                elm.find('.input-price-setup')
                    .val(currency.formatNumber(cycle.setup))
                    .prop('tabindex', index++);

                elm.find('.input-price-upgrade')
                    .val(currency.formatNumber(cycle.upgrade))
                    .prop('tabindex', index++);

                elm.find('.pricer_setup').text(currency.format(cycle.setup))
                    .closest('.price-setup').toggle(cycle.setup > 0);

                elm.find('.pricer_upgrade').text(currency.format(cycle.upgrade))
                    .closest('.price-upgrade').toggle(cycle.upgrade > 0);

                elm.find('.pricer').text(currency.format(cycle.price));
            })

            if(options.length < 1){
                var cfk = cycles.hasOwnProperty('m') ? 'm' : Object.keys(cycles)[0];
                cycles[cfk].addClass('enabled');
                options.push(cycles[cfk]);
            }

            var cyopt = $('option', cycleselect),
                opcycle = options.map(function (elm) {
                    return elm.data('cycle')
                }),
                filter = function () {
                    return opcycle.indexOf(this.value) > -1
                };

            cyopt.filter(filter).prop('disabled', true).hide();
            cyopt.not(filter).prop('disabled', false).show();
        }

        self.on('blur', '.input-price-setup, .input-price', function () {
            var inp = $(this),
                ctype = inp.attr('name').split('_'),
                price = currency.unformat(inp.val());

            cycles[ctype[0]].data(ctype[1] ? 'setup' : 'price', price);
            inp.val(currency.formatNumber(price));
        })

        addpricing.on('click',function () {
            cycleselect.val('');
            if(addpricing.is('.active')){
                return controlfrom();
            }

            var zero_value = currency.formatNumber(0);
            newprice.val(zero_value);

            addpricing.addClass('active');
            tbpricing.show();
            return false;
        });

        $("#add-cycle", this).on('click', function () {
            var cycle = tbpricing.find('select').val();
            if (!cycles[cycle])
                return;

            var pricedata = {
                enabled: true,
            };

            newprice.each(function () {
                pricedata[this.dataset.type] = currency.unformat(this.value);
            });

            cycles[cycle].data(pricedata);

            setupcycles();
            controlfrom();
            return false;
        });

        $('#hidepricingadd', this).on('click', controlfrom);

        self.on('click', '.e1, .edit', function () {
            var cycle = $(this).closest('.cycle');
            cycle.find('.e1').hide();
            cycle.find('.e2').show();
            return false;
        });

        self.on('click', '.delete', function () {
            var cycle = $(this).closest('.cycle');
            cycle.data({
                enabled: false,
                price: 0,
                setup: 0
            });
            setupcycles();
            controlfrom();
            return false;
        });

        setupcycles();
    })
})