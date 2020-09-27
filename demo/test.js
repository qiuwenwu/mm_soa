const Soa = require('../index.js');

var soa = new Soa({
	sys: {
		name: "soa",
		func: function(t1){
			return 'tt' + t1
		}
	},
	list: []
});


async function startup(test){
	await soa.init();
	// var ret = await soa.cmd('help','config.sys.func');
	// console.log(ret);
}

startup();