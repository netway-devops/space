var socket      = io('https://server2.rvglobalsoft.com:3004');
var oRv         = new RvAdmin;

// Initialise the Zendesk JavaScript API client
// https://developer.zendesk.com/apps/docs/apps-v2
var client = ZAFClient.init();


function debug (data)
{
    //$('#consoleBox pre').text( JSON.stringify(data, null, 2) );
}