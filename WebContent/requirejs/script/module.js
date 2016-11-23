(function(window) {
	function Module() {
		this.type = "not module";
		this.name = "script";
		this.method = function() {
		};
	}
	Module.prototype.introduceSelf = function() {
		console.log(JSON.stringify(this));
	}
	window.Module = Module;
})(window);
