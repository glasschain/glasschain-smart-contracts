import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    zkEVM: {
    url: `https://rpc.public.zkevm-test.net`,
    accounts: ['18f74603ee8e33e9ba575a88bde542e395d628e83168175e64a57d62f72e04aa'],
    },
  },
  defaultNetwork: "zkEVM",
};

export default config;
