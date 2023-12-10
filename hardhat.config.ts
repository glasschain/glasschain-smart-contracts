import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    zkEVM: {
    url: `https://rpc-mumbai.maticvigil.com/`,
    accounts: ['35c7a994392e58cb9481faa0a433d9852afa1deb3dc75da74211fd4c69e15dbb'],
    // accounts: ['8c2384d17cfa9fda40a1340de57e05df266d971728b8419a7a802813c6a792e7']
    },
  },
  defaultNetwork: "zkEVM",
};

export default config;
