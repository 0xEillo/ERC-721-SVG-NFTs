require("@nomiclabs/hardhat-waffle");
require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");

const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL;
const mneumonic = process.env.mneumonic;
const etherscan_api_key = process.env.etherscan_api_key;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetworks: "hardhat",
  networks: {
    hardhat: {},
    rinkeby: {
      url: RINKEBY_RPC_URL,
      accounts: [`${mneumonic}`],
      saveDeployements: true,
    },
  },
  etherscan: {
    apiKey: {
      rinkeby: etherscan_api_key,
    },
  },
  solidity: "0.8.1",
};
