import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    zkEVM: {
    url: `https://rpc-mumbai.maticvigil.com/`,
    accounts: ['35c7a994392e58cb9481faa0a433d9852afa1deb3dc75da74211fd4c69e15dbb'],
    },
  },
  defaultNetwork: "zkEVM",
};

export default config;
