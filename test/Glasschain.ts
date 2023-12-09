import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox-viem/network-helpers";
import { expect } from "chai";
import hre from "hardhat";
import { getAddress } from "viem";
import { utils } from "ethers";

describe("GlassChain", function () {
  async function deployGlasschain() {
    const [owner, otherAccount] = await hre.viem.getWalletClients();
    const glasschain  = await hre.viem.deployContract("Glasschain", [], {});

    const publicClient = await hre.viem.getPublicClient();
    return {
      glasschain,
      owner,
      otherAccount,
      publicClient,
    };
  }

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      const { glasschain, owner } = await loadFixture(deployGlasschain);

      expect(await glasschain.read.owner()).to.equal(getAddress(owner.account.address));
    });
  });

  describe("Register company", function() {
    it("Should register a company", async function () {
      const { glasschain, owner } = await loadFixture(deployGlasschain);
      const companyName = "glasschain";
      const companyDoamin = "glasschain.eth";

      const ipfsHash = utils.formatBytes32String("0x0");

      await expect(glasschain.write.registerCompany([companyName, ipfsHash, companyDoamin])).to.be.fulfilled;
    })
  })
})
