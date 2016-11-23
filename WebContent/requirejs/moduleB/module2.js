define(function() {
	function Module() {
		this.type = "module";
		this.name = "moduleB2"
	}
	Module.prototype.introduceSelf = function() {
		console.log(JSON.stringify(this));
	}
	return Module;
})