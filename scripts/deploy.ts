import { formatEther, parseEther } from "viem";
import hre from "hardhat";
import { utils } from "ethers";

async function main() {
  const [owner, otherAccount] = await hre.viem.getWalletClients();
    const glasschain  = await hre.viem.deployContract("Glasschain", [], {
      
    });
    console.log("Glasschain deployed to:", glasschain.address);

    // const companyName = "glasschain";
    // const companyDoamin = "glasschain.eth";
    // const ipfsHash = utils.formatBytes32String("0x0");

    // const resp = await glasschain.write.registerCompany([companyName, ipfsHash, companyDoamin]);
    // console.log("resp", resp);

    // const publicClient = await hre.viem.getPublicClient();
    // // wait for tx to be mined
    // await publicClient.waitForTransactionReceipt({ hash: resp });

    // const allComp = await glasschain.read.fetchAllCompanies();
    // console.log("allComp", allComp);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
