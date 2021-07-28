require("dotenv").config();
const hre = require("hardhat");
const config = require('../config.json');

const setupContracts = async() => {

    const addr = config.addresses;

	const netinfo = await ethers.provider.getNetwork();
	var network = netinfo.name;
	if (network === "unknown")
		network = "mainnet";

    // get the contract factories
    const WrapperV3 = await ethers.getContractFactory('WrapAndUnWrapV3');
    const OwnableProxy = await ethers.getContractFactory('OwnableProxy');
    
    // get the signers
    let owner, addr1;
    [owner, addr1, ...addrs] = await ethers.getSigners();

    // then deploy the contracts and wait for them to be mined

    const wrapperV3 = await deployWithProxy(
        WrapperV3,
        OwnableProxy,
        'WrapAndUnWrapV3',
        addr.tokens.WETH[network],
        addr.swaps.uniswapNonfungiblePositionManager[network],
        addr.swaps.swapRouterV3[network],
        addr.swaps.uniswapFactoryV3[network],
        addr.swaps.uniswapQuoter[network],
        addr.tokens.DAI[network],
        addr.tokens.USDT[network],
        addr.tokens.USDC[network]
    );

    return { deployedContracts: {
        wrapperV3,
        owner,
        addr1,
        addrs } };
};

const log = (message, params) =>{
    if(process.env.CONSOLE_LOG === 'true') {
       console.log(message, params);
    }
}

const deployWithProxy = async(contractFactory, proxyFactory, factoryName, ...params) => {
    let deployedContract = await (await contractFactory.deploy()).deployed();
    const deployedProxy = await (await proxyFactory.deploy(deployedContract.address)).deployed();
    await deployedContract.setProxy(deployedProxy.address);
    deployedContract = await ethers.getContractAt(factoryName, deployedProxy.address);
    await deployedContract.initialize(...params);
    return deployedContract;
}

const mineBlocks = async (numOfBlocks) => {
    while (numOfBlocks > 0) {
        numOfBlocks--;
        await hre.network.provider.request({
          method: "evm_mine",
          params: [],
        });
    }
}

const getMinTick = (tickSpacing) => { return Math.ceil(-887272 / tickSpacing) * tickSpacing}
const getMaxTick = (tickSpacing) => { return Math.floor(887272 / tickSpacing) * tickSpacing}

module.exports = { setupContracts, log, mineBlocks, getMinTick, getMaxTick }
