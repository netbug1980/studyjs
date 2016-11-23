/**
 * 模块编程演化过程
 */

/**
 * 惯用写法一，在全局对象window中增加了一个变量，两个方法,可以任意被改写
 */
var count = 0;
function method1() {
	count++;
}
function method2() {
	count--;
}

/**
 * 惯用写法二，适当封装，仅仅暴露了一个obj对象，外部方法很容易修改计数器的值
 */
var obj = {
	count : 0,
	method1 : function() {
		this.count++;
	},
	method2 : function() {
		this.count--;
	}
};

/**
 * 模块写法一，匿名函数，加立即执行
 */
var module = (function() {
	var count = 0;
	function method1() {
		count++;
	}
	function method2() {
		count--;
	}
	function getCount() {
		return count;
	}
	return {
		method1 : method1,
		method2 : method2,
		getCount : getCount
	}
})();

/**
 * 模块写法二，放大模式,当模块很大时，为模块扩展方法
 */
var module = (function(module) {
	module.getCount2 = function() {
		return module.getCount();
	}
	return module;
})(module);
/**
 * 模块写法二，宽放大模式,模块异步加载时，避免空对象的产生
 */
var module = (function(module) {
	module.getCount2 = function() {
		return module.getCount();
	}
	return module;
})(module || {});
/**
 * 模块写法之依赖显示注入，保持模块独立性，尽量不与程序的其他模块交互，参考jQuery源码
 */
var module = (function($,module) {
	module.getCount2 = function() {
		return module.getCount();
	}
	return module;
})(jQuery,module || {});