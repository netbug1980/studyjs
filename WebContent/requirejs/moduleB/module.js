//CommonJS的写法
define(function(require, exports, module) {
	var Module2 = require('moduleB/module2');
	var Module3 = require('moduleB/module3');
	function Module() {
		this.type = "module";
		this.name = "moduleB";
		this.codeStyle = "CommonJS";
	}
	Module.prototype.introduceSelf = function() {
		new Module2().introduceSelf();
		new Module3().introduceSelf();
		console.log(JSON.stringify(this));
	}
	return Module;
})