import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    zkEVM: {
    url: `https://rpc.public.zkevm-test.net`,
    accounts: ['8c2384d17cfa9fda40a1340de57e05df266d971728b8419a7a802813c6a792e7'],
    },
  },
  defaultNetwork: "zkEVM",
};

export default config;
