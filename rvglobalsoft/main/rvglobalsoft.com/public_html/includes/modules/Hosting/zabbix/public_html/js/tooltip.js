(function(jQuery) {
	
	 $.tooltip = {};
	 
	 $.tooltip.init = function() {
		 $.tooltip.makeUi();
		 $.tooltip.makeEvent();
	 };
	 
	 $.tooltip.makeUi = function() {
	 };
	 
	 $.tooltip.makeEvent = function() {
		 $.tooltip.makeEventTooltipNetworkTrafficEmail();
		 $.tooltip.makeEventTooltipDiscoveryEmail();
	 };
	 
	 $.tooltip.makeEventTooltipNetworkTrafficEmail = function() {
		 
		 $('#tooltip-network-traffic-email').cluetip({
				local: true,
	            cluetipClass: 'jtip',
	            arrows: true,
	            dropShadow: false,
	            sticky: true,
	            mouseOutClose: true,
	            closePosition: 'title',
	            closeText: '<img src="' + system_url + 'includes/modules/Hosting/zabbix/public_html/images/close.png" alt="close" />'
	 	});
		 
		 
	 };
	 
	 
	 $.tooltip.makeEventTooltipDiscoveryEmail = function() {
		 
		 $('#tooltip-discovery-email').cluetip({
				local: true,
	            cluetipClass: 'jtip',
	            arrows: true,
	            dropShadow: false,
	            sticky: true,
	            mouseOutClose: true,
	            closePosition: 'title',
	            closeText: '<img src="' + system_url + 'includes/modules/Hosting/zabbix/public_html/images/close.png" alt="close" />'
	 	});
		 
	 };
	 
	 
})(jQuery);