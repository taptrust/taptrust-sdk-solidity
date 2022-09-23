import { expect } from "chai"
import { Contract, Wallet } from "ethers"
import { ethers } from "hardhat"

describe("ERC20RequireCredential", function () {
  // create a wallet to generate a private key for signing verification results
  const mnemonic =
    "announce room limb pattern dry unit scale effort smooth jazz weasel alcohol"
  const signer: Wallet = ethers.Wallet.fromMnemonic(mnemonic)

  // get a random subject address that will be used for verified subject tests
  let registeredAddress: string
  let notRegisteredAddress: string;
  it("Should find a random address to use as a subject to verifiy", async function () {
    const addresses = await ethers.getSigners()
    registeredAddress = await addresses[addresses.length - 1].getAddress()
    notRegisteredAddress = await addresses[addresses.length - 2].getAddress()
  })
  
  let mockRegistryContract: Contract
  it("Should deploy mock credential registry", async function () {
    const deployer = await ethers.getContractFactory("MockCredentialRegistry")
    mockRegistryContract = await deployer.deploy(registeredAddress)
    await mockRegistryContract.deployed()
  })

  // deploy the contract, which makes this test provider the contract's owner
  let erc20RequireCredentialContract: Contract
  let contractOwnerAddress: string
  it("Should deploy example ERC-20 contract", async function () {
    const deployer = await ethers.getContractFactory("ERC20RequireCredential")
    erc20RequireCredentialContract = await deployer.deploy(1000000)
    await erc20RequireCredentialContract.deployed()
    contractOwnerAddress = erc20RequireCredentialContract.deployTransaction.from
    expect(await erc20RequireCredentialContract.balanceOf(contractOwnerAddress)).to.equal(1000000);
  })

  it("Should set TapTrust address", async function () {
    const setTapTrustAddressTx = await erc20RequireCredentialContract.setTapTrustAddress(mockRegistryContract.address); 
    await setTapTrustAddressTx.wait();
  })

  it("Should transfer tokens", async function () {
    const transferTx = await erc20RequireCredentialContract.transfer(registeredAddress, 1000);
    await transferTx.wait();
  })

  it("Should fail at transferring tokens to unregistered address", async function () {
    const transferTx = erc20RequireCredentialContract.transfer(notRegisteredAddress, 1000);
    await expect(transferTx).to.throw;
  })


})
