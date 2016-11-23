define(function(){
	function Module(){
		this.type="module";
		this.name="moduleC"
	}
	Module.prototype.introduceSelf = function(){
		console.log(JSON.stringify(this));
	}
	return Module;
})