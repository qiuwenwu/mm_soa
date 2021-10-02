import Web3 from "web3";
// import WalletConnectProvider from "@walletconnect/web3-provider";
import BigNumber from "bignumber.js";

var pdr;

class Mm_contract {
  constructor(config) {
    this.config = Object.assign({
      chainId: 56,
      chain: "eth",
      gas: 0,
      gas_add: 100000,
      precision: Math.pow(10, 18),
      init_contract: ["pool", "token"],
      token_abi: [],
      pool_abi: [],
      rpc: {
        // 以太坊 Ethereum 主网络
        "1": "https://mainnet.infura.io/v3/dff1613e70d445b8bf5dcd060ac9a9eb",
        // Ropsten 测试网络
        "3": "https://ropsten.infura.io/v3/dff1613e70d445b8bf5dcd060ac9a9eb",
        // Kovan 测试网络
        "42": "https://kovan.infura.io/v3/dff1613e70d445b8bf5dcd060ac9a9eb",
        // BSC币安智能链
        "38": "https://bsc-dataseed.binance.org/",
        // BSC币安智能链
        "56": "https://bsc-dataseed.binance.org/",
        // Heco链
        "128": "https://http-mainnet.hecochain.com",
        // 本地测试链
        "545": "http://localhost:8545"
        // ...
      }
    }, config);

    /**
     * 代币
     */
    this.token = {
      // "lip": {
      //   address: "0x362e6468eA63D978B255AB92d4AF2ad15D99C530"
      // }
    };

    /**
     * 池子
     */
    this.pool = {
      // "mint": {
      //   address: "0xf65c48A057713d6468280944526e8CC84Ba93d81"
      // }
    };

    /**
     * 事件集合
     */
    this.list_event = [];

    /**
     * 地址
     */
    this.address = "";

    /**
     * 当前账户余额
     */
    this.balance = 0;
  }
}

/**
 * 获取metamask驱动
 */
Mm_contract.prototype.metamask = function() {
  return new Promise(function(resolve, d) {
    var waiting = 20;
    var times = 0;
    if (!window.ethereum) {
      var timer = setInterval(function() {
        if (window.ethereum) {
          clearInterval(timer);
          resolve(window.ethereum);
        } else if (window.web3) {
          clearInterval(timer);
          resolve(window.web3.currentProvider);
        } else if (times === waiting) {
          console.log('window.ethereum is undefined');
          clearInterval(timer);
          resolve(null);
        } else {
          times++
        }
      }, 100);
    } else {
      resolve(window.ethereum);
    }
  });
};

/**
 * 登录
 * @param {String} way 登录
 * @return {String} 地址
 */
Mm_contract.prototype.login = async function(way) {
  if (!pdr) {
    var provider;
    if (way === "wc") {
      provider = new WalletConnectProvider({
        rpc: this.config.rpc
      });
      var accounts = await provider.enable();
      this.address = accounts[0];
    } else {
      provider = await this.metamask();
      if (!provider) {
        provider = new WalletConnectProvider({
          rpc: this.config.rpc
        });
        var accounts = await provider.enable();
        this.address = accounts[0];
      }
    }

    this.subscribe_event(provider);
    pdr = provider;
  }

  this.web3 = new Web3(pdr);
  if (!this.web3.toBigNumber) {
    this.web3.toBigNumber = function(val) {
      return new BigNumber(val);
    }
  }
  BigNumber
  if (!this.address) {
    var accounts = await this.web3.eth.requestAccounts();
    this.address = accounts[0];
  }
  return this.address;
}

/**
 * 构建连接
 * @param {Object} 类型
 */
Mm_contract.prototype.link = async function(type) {
  var dict = this[type];
  var abi = this.config[type + "_abi"];
  for (var k in dict) {
    var o = dict[k];
    o.contract = new this.web3.eth.Contract(abi, o.address + "");
  }
};

/**
 * 初始化
 * @param {String} way 登录方式
 * @return {String} 返回地址
 */
Mm_contract.prototype.init = async function(way) {
  await this.login(way);

  // 连接token合约和池子合约
  var init_contract = this.config.init_contract;
  for (var i = 0; i < init_contract.length; i++) {
    await this.link(init_contract[i]);
  }

  var {
    chainId,
    selectedAddress,
    accounts
  } = pdr;
  if (!selectedAddress && accounts && accounts.length) {
    selectedAddress = accounts[0];
  }
  this.event('connected', [selectedAddress], typeof(chainId) === "number" ? chainId : this.toChage_10(chainId, 1));
  return this.address;
};

/**
 * 发送
 * @param {String} type 类型
 * @param {String} name 登录方式
 * @param {String} method ABI方法
 * @param {Number} value 数值
 * @param {Array} param 参数集合
 * @return {String}  返回地址
 */
Mm_contract.prototype.send = async function(type, name, method, value, ...param) {
  console.log("send req", type, name, method, value, ...param);
  try {
    var res = await this[type][name].contract.methods[method](...param).send({
      from: this.address,
      gasLimit: this.config.gas,
      value: value
    });
  } catch (err) {
    console.error(method, err);
  }
  console.log("send res", name, method, res);
  return res;
};

/**
 * 查询
 * @param {String} name 登录方式
 * @param {String} method ABI方法
 * @param {Number} value 数值
 * @param {Array} param 参数集合
 * @return {String} 返回地址
 */
Mm_contract.prototype.call = async function(type, name, method, value, ...param) {
  if (!this.address) {
    await this.init();
  }
  console.log("call req", type, name, method, ...param);
  try {
    var res = await this[type][name].contract.methods[method](...param).call({
      from: this.address
    });
  } catch (err) {
    console.error(method, err)
  }
  console.log("call res", name, method, res);
  return res;
};


/**
 * 事件管理器
 * @param {String} name 事件名称
 * @param {String} accounts 账号组
 * @param {Number} chainId 区块链频道
 */
Mm_contract.prototype.event_after = function(name, accounts, chainId) {
  // console.log(name);

};

/**
 * 添加事件
 * @param {Function} func 事件方法
 */
Mm_contract.prototype.add_event = function(func) {
  return this.list_event.push(func);
};

/**
 * 事件管理器
 * @param {String} name 事件名称
 * @param {String} accounts 账号组
 * @param {Number} chainId 区块链频道
 */
Mm_contract.prototype.event = function(name, accounts, chainId) {
  // console.log(name, accounts, chainId);
  if (accounts && accounts.length) {
    this.address = accounts[0];
  }
  if (!chainId) {
    this.chainId = chainId;
  } else if (!this.chainId) {
    this.chainId = this.chainId || this.config.chainId;
  }
  switch (name) {
    case "session_update":
    case "connect":
    case "connected":
    case "accountsChanged":
      if (accounts.length && pdr.isConnected && pdr.isConnected()) {
        this.is_connected = pdr.isConnected();
      } else {
        this.is_connected = false;
      }
      break;
    case "disconnect":
      this.is_connected = false;
      this.address = "";
      this.balance = 0;
      break;
    case "chainChanged":
      if (accounts.length && pdr.isConnected && pdr.isConnected()) {
        this.is_connected = pdr.isConnected();
      } else {
        this.is_connected = false;
      }
      break;
  }

  var list = this.list_event;
  for (var i = 0; i < list.length; i++) {
    var o = list[i];
    try {
      o(name, this.address, this.chainId);
    } catch (e) {
      console.log(e);
    }
  }
  this.event_after(name, this.address, this.chainId);
};

/**
 * 执行供应器
 * @param {Object} provider
 */
Mm_contract.prototype.subscribe_event = function(provider) {
  if (!provider) {
    return;
  }
  // Subscribe to accounts change
  provider.on("accountsChanged", (accounts) => {
    this.event("accountsChanged", accounts)
  });

  // Subscribe to chainId change
  provider.on("chainChanged", (chainId) => {
    this.event("chainChanged", null, this.toChage_10(chainId, 1))
  });

  /**
   * 发起交易的时候会触发这个事件
   */
  provider.on("session_update", async (error, payload) => {
    if (error) {
      throw error;
    }
    const {
      chainId,
      accounts
    } = payload.params[0];
    this.event("session_update", accounts, this.toChage_10(chainId, 1));
  });

  /**
   * 连接时
   */
  provider.on("connect", (error, payload) => {
    if (error) {
      throw error;
    }
    const {
      chainId,
      accounts
    } = payload;

    this.event('connect', accounts, this.toChage_10(chainId, 1));
  });

  /**
   * 断开连接时
   */
  provider.on("disconnect", (error, payload) => {
    if (error) {
      throw error;
    }
    this.event('disconnect');
  });
};

/**
 * 转16进制
 * @param {String} num 数值
 * @param {Number} map 精度
 * @return {String} 转换结果
 */
Mm_contract.prototype.toChage_16 = function(num, map) {
  if (typeof(num) === "string") {
    return num;
  }
  return '0x' + (num * (map || this.config.precision)).toString(16);
};

/**
 * 转10进制
 * @param {String} num 数值
 * @param {Number} map 精度
 * @return {String} 转换结果
 */
Mm_contract.prototype.toChage_10 = function(value, map) {
  if (value) {
    return parseInt(value.replace('0x', ''), 16) / (map || this.config.precision);
  } else {
    return 0;
  }
};

/**
 * 新建合约连接器
 * @param {String} name 名称
 * @param {String} address 合约地址
 * @param {Array} abi ABI方法集合
 * @return {Object} 返回连接后的对象
 */
Mm_contract.prototype.new = function(name, abi, address) {
  if (!this[name]) {
    this[name] = new this.web3.eth.Contract(abi, address);
  }
  return this[name];
};

export default Mm_contract;
