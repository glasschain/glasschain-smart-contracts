import { formatEther, parseEther } from "viem";
import hre from "hardhat";

async function main() {
  const [owner, otherAccount] = await hre.viem.getWalletClients();
    const glasschain  = await hre.viem.deployContract("Glasschain", [], {});
    console.log("Glasschain deployed to:", glasschain.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
