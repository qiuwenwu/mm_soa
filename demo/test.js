require('mm_expand');
$.runPath = __dirname + '/';
const Soa = require('../index.js');

var soa = new Soa({
	sys: {
		name: "soa"
	},
	list: []
});


async function startup(test){
	await soa.init();
	// var ret = await soa.cmd('help','config.sys.func');
	// console.log(ret);
}

startup();