/*
 * pm2 stop node_zendesk_hostbill
 * pm2 start node_zendesk_hostbill --watch
 * pm2 restart node_zendesk_hostbill
 * pm2 monit
 */

var fs          = require('fs');
var options     = {
    key: fs.readFileSync('/home/rvglobal/app/ssl/server1-server.key'),
    cert: fs.readFileSync('/home/rvglobal/app/ssl/server1-server.crt')
};

var os          = require('os');
var app         = require('express')();
var https       = require('https').Server(options, app);
var io          = require('socket.io')(https);
var request     = require('request');

app.get('/', function(req, res){
    res.send('RVGlobalsoft Co,Ltd.');
});

var API_URL     = 'https://api2.rvglobalsoft.com';


io.on('connection', function(socket){
    
    socket.on('getClient', function(oData){
        //debug(oData);
        request.get(API_URL +'/client/search/keyword/'+ encodeURIComponent(oData.keyword)
            +'?apiid='+ oData.apiid +'&apikey='+ oData.apikey, function (error, response, data) {
            //debug(data);
            if (error || response.statusCode !== 200) { 
                return console.log('Error:', error);
            }
            socket.emit('getClient', data);
        });
    });
    
    socket.on('getClientDetail', function(oData){
        request.get(API_URL +'/client/view/id/'+ encodeURIComponent(oData.clientId)
            +'?apiid='+ oData.apiid +'&apikey='+ oData.apikey, function (error, response, data) {
            if (error || response.statusCode !== 200) {
                return console.log('Error:', error);
            }
            socket.emit('getClientDetail', data);
        });
        
    });
    
    socket.on('getClientService', function(oData){
        request.get(API_URL +'/client/service/clientid/'+ encodeURIComponent(oData.clientId)
            +'?apiid='+ oData.apiid +'&apikey='+ oData.apikey, function (error, response, data) {
            if (error || response.statusCode !== 200) {
                return console.log('Error:', error);
            }
            socket.emit('getClientService', data);
        });
        
    });
    
    socket.on('getClientOrders', function(oData){
        request.get(API_URL +'/client/orders/clientid/'+ encodeURIComponent(oData.clientId)
            +'?apiid='+ oData.apiid +'&apikey='+ oData.apikey, function (error, response, data) {
            if (error || response.statusCode !== 200) {
                return console.log('Error:', error);
            }
            socket.emit('getClientOrders', data);
        });
        
    });
    
    socket.on('getClientInvoice', function(oData){
        request.get(API_URL +'/client/invoice/clientid/'+ encodeURIComponent(oData.clientId)
            +'?apiid='+ oData.apiid +'&apikey='+ oData.apikey, function (error, response, data) {
            if (error || response.statusCode !== 200) {
                return console.log('Error:', error);
            }
            socket.emit('getClientInvoice', data);
        });    
    });
    
   
    socket.on('addTagToTicket', function(oData){
        request.post(API_URL +'/ticket/add/tag', {form:oData}, function (error, response, data) {
            if (error || response.statusCode !== 200) {
                return console.log('Error:', error);
            }
            socket.emit('addTagToTicket', data);
        });
        
    });
    
    socket.on('getTicket', function(oData){
        request.get(API_URL +'/ticket/view/id/'+ oData.ticketId
            +'?apiid='+ oData.apiid +'&apikey='+ oData.apikey, function (error, response, data) {
            if (error || response.s3004tatusCode !== 200) {
                return console.log('Error:', error);
            }
            socket.emit('getTicket', data);
        });
        
    });
    
    
    
});



https.listen(3004, function(){
    var d = new Date();
    var n = d.toString();
    console.log(n + ' listening on *:3004');
});

function debug (data) {
    console.log(data);
}
