//AMD的写法
define([ 'moduleA/module2', 'moduleA/module3' ], function(Module2, Module3) {
	function Module() {
		this.type = "module";
		this.name = "moduleA";
		this.codeStyle = "AMD";
	}
	Module.prototype.introduceSelf = function() {
		new Module2().introduceSelf();
		new Module3().introduceSelf();
		console.log(JSON.stringify(this));
	}
	return Module;
})