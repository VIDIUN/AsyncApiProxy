require('./lib/utils/VidiunLogger');
const AsyncProxyManager = require('./lib/AsyncProxyManager');
const continuationLocalStorage = require('continuation-local-storage');
const VidiunAsyncProxyServerValidator = require('./lib/utils/VidiunAsyncProxyServerValidator');

function VidiunMainProcess(){
	this.start();
};

VidiunMainProcess.prototype.start = function () {

	this.namespace = continuationLocalStorage.createNamespace('async-proxy-server');//Here just to make sure we create it only once
	var server = new AsyncProxyManager();

};

module.exports.VidiunMainProcess = VidiunMainProcess;

var VidiunProcess = new VidiunMainProcess();
