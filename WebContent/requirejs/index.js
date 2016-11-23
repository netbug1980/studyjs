console.log('requirejs加载完成');
require.config({
	paths : {
		jquery : "../bower_components/jquery/dist/jquery"
	},
	shim : {//非AMD模块模式的兼容处理
		'script/module' : {
			exports : 'Module'
		}
	}
});
require([ 'jquery', 'moduleA/module', 'moduleB/module', 'moduleC/module',
		'script/module' ], function(jQuery, ModuleA, ModuleB, ModuleC, ModuleX) {
	console.log('jquery加载完成');
	new ModuleA().introduceSelf();
	new ModuleB().introduceSelf();
	new ModuleC().introduceSelf();
	new ModuleX().introduceSelf();
});