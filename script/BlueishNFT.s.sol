// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/BlueishNFT.sol";

contract BlueishNFTScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();

        BlueishNFT nft = new BlueishNFT("Blueish NFT", "BLU", address(1));

        vm.stopBroadcast();
    }
}

//see the tutorial here: https://book.getfoundry.sh/tutorials/solidity-scripting
// for my purposes, I used the --mnemonic-paths arg rather than --private-key. Though it's not covered in the docs, 
// if you use this option, you'll also need to pass the address (pub key) associated with that mnemonic as the --sender arg
// otherwise you'll get an error indicating 'You seem to be using Foundry's default sender...' Note: when using 
// --private-key, you do not need to explicitly pass the --sender address
// The forge script command with args I used to deploy using this script is below:
//
//forge script script/BlueishNFT.s.sol:BlueishNFTScript --rpc-url $RPC_URL --sender {sender address} --mnemonic-paths {path-to-file-with-mnemonic} --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
//
// as the output of this command will indicate, you'll be able to view the details of your deploy transaction at
// broadcast/{script-file-name}/number-of-deploys/run-latest.json. This file will have the deployed contract address, the deployer address,
// and some other pertinent information.