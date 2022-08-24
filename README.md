# blueishNFT
A basic on-chain svg ERC721 template built using [Foundry](https://github.com/foundry-rs/foundry)

![blueish-nft-small-version](https://user-images.githubusercontent.com/1835823/186516507-25eca348-5fea-4cb6-b430-bf01971a3ce3.png) ![blueish-nft-small-version](https://user-images.githubusercontent.com/1835823/186516507-25eca348-5fea-4cb6-b430-bf01971a3ce3.png) ![blueish-nft-small-version](https://user-images.githubusercontent.com/1835823/186516507-25eca348-5fea-4cb6-b430-bf01971a3ce3.png)

## Why
blueishNFT is a beginner level template for end to end Solidity smart contract development. Write tests, build your contract, deploy to testnet/mainnet, mint and view your on-chain art NFT, all without needing to touch any dApp code or Javascript. 

Deliberately lightweight and basic, this template sits somewhere between [CryptoZombies](https://cryptozombies.io/) and Austin Griffith's amazing [scaffold-eth](https://github.com/scaffold-eth/scaffold-eth) tutorials as a resource for those endeavoring to learn web3 development.

This README, the code, and comments are the entirety of documentation for this template, minimizing googling/context switching and maximizing time spent in the code, learning Solidity, Foundry, and smart contract development.

## What
This template covers the following topics:
 - **Tests** - Unit tests utilize Foundry's [Forge](https://book.getfoundry.sh/forge/) std testing library. They are heavily commented and cover topics ranging from failure/success assertions to mock function calls and event assertions.
 - **Deployment** - Smart contracts can be deployed using the `forge` CLI. This project utilizes [Solidity scripting](https://book.getfoundry.sh/tutorials/solidity-scripting) for declaritive deployment, which will be familiar to web2 engineers as well as smart contract developers handy with tools like Hardhat, etc. 
 - **On-Chain art** - While non-dynamic, this template illustrates an example of on-chain art which has and is being explored by many other robust and sophisticated projects/artists. 


## How

- Install Foundry ([instructions here](https://github.com/foundry-rs/foundry))
- clone this repo
- run tests using the `forge test -vv` command (`-vv` will output custom failure messages and logging to terminal)
- update the contract and tests. Want to make an ERC1155 instead? Have an idea for making the on-chain art dynamic? Have at it!
- when ready to deploy to testnet or mainnet:
  - update the deployment contract in the `script` directory
  - use the `forge script` command to deploy (further instructions can be found in the comments in `script/BlueishNFT.s.sol`)
- use your block explorer of choice (ex. [Etherscan](https://etherscan.io/), [Polygonscan](https://polygonscan.com/)) to interact with your contract and mint NFTs.

## Original Contract
You can find and mint nfts from the original blueish project [here](#) and [here](#). Use them as your pfp to show some 💙
