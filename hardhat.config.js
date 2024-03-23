require("@nomicfoundation/hardhat-toolbox");
require("@typechain/hardhat");
require("@typechain/hardhat");
require("@nomiclabs/hardhat-ethers");
require("hardhat-deploy");
// require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();
// require("hardhat-contract-sizer");
// require("hardhat-coverage");

module.exports = {
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },

  networks: {
    localhost: {
      url: "//http://localhost:8545",
      // accounts:
      //   process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      allowUnlimitedContractSize: true,
    },
    sepolia: {
      url: process.env.URL,
      accounts: [process.env.PRIVATE_KEY],
      chainId: 11155111,
      saveDeployments: true,
    },
    polygonMumbai: {
      url: process.env.MUMBAI_URL,
      accounts: [process.env.PRIVATE_KEY],
      chainId: 80001,
      saveDeployments: true,
    },
  },
  solidity: {
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
      // viaIR: true,
    },

    compilers: [
      {
        version: "0.8.20",
      },
      {
        version: "0.8.9",
      },
    ],
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_VERIFY_KEY,
      polygonMumbai: process.env.POLYGONSCAN_VERIFY_KEY,
    },
  },
};
