/*
Copyright 2012 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Author: Boris Smus (smus@chromium.org)
*/
(function(e){function r(e,t,n){this.host=e,this.port=t,this.pollInterval=n||15,this.callbacks={connect:null,disconnect:null,recvBuffer:null,recvString:null,sent:null},this.socketId=null,this.isConnected=!1,i("initialized tcp client")}function i(e){console.log(e)}function s(e){console.error(e)}var t=chrome.socket||chrome.experimental.socket,n=chrome.experimental.dns;r.prototype.connect=function(e){n.resolve(this.host,function(n){this.addr=n.address,t.create("tcp",{},this._onCreate.bind(this)),this.callbacks.connect=e}.bind(this))},r.prototype.sendBuffer=function(e,n){e.buffer&&(e=e.buffer),t.write(this.socketId,e,this._onWriteComplete.bind(this)),this.callbacks.sent=n},r.prototype.sendString=function(e,n){this._stringToArrayBuffer(e,function(e){t.write(this.socketId,e,this._onWriteComplete.bind(this))}.bind(this)),this.callbacks.sent=n},r.prototype.addResponseListener=function(e,t){typeof t=="undefined"&&(t="arraybuffer"),t==="string"?this.callbacks.recvString=e:this.callbacks.recvBuffer=e},r.prototype.addDisconnectListener=function(e){this.callbacks.disconnect=e},r.prototype.disconnect=function(){this.isConnected&&(this.isConnected=!1,t.disconnect(this.socketId),this.callbacks.disconnect&&this.callbacks.disconnect(),i("socket disconnected"))},r.prototype._onCreate=function(e){this.socketId=e.socketId,this.socketId>0?t.connect(this.socketId,this.addr,this.port,this._onConnectComplete.bind(this)):s("Unable to create socket")},r.prototype._onConnectComplete=function(e){this.isConnected=!0,setTimeout(this._periodicallyRead.bind(this),this.pollInterval),this.callbacks.connect&&(i("connect complete"),this.callbacks.connect()),i("onConnectComplete")},r.prototype._periodicallyRead=function(){var e=this;t.getInfo(this.socketId,function(n){n.connected?(setTimeout(e._periodicallyRead.bind(e),e.pollInterval),t.read(e.socketId,null,e._onDataRead.bind(e))):e.isConnected&&(i("socket disconnect detected"),e.disconnect())})},r.prototype._onDataRead=function(e){e.resultCode>0&&(i("onDataRead"),this.callbacks.recvBuffer&&this.callbacks.recvBuffer(e.data),this.callbacks.recvString&&this._arrayBufferToString(e.data,function(e){this.callbacks.recvString(e)}.bind(this)),setTimeout(this._periodicallyRead.bind(this),0))},r.prototype._onWriteComplete=function(e){i("onWriteComplete"),this.callbacks.sent&&this.callbacks.sent(e)},r.prototype._arrayBufferToString=function(e,t){var n=new Blob([new Uint8Array(e)]),r=new FileReader;r.onload=function(e){t(e.target.result)},r.readAsText(n)},r.prototype._stringToArrayBuffer=function(e,t){var n=new Blob([e]),r=new FileReader;r.onload=function(e){t(e.target.result)},r.readAsArrayBuffer(n)},e.TcpClient=r})(window);