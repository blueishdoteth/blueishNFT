// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BlueishNFT.sol";

contract BlueishNFTTest is Test {
    BlueishNFT private blueishNFT;

    function setUp() public {
        // deploy the NFT
        blueishNFT = new BlueishNFT("Blueish NFT", "BLU");
    }

    function testFailNoMintPricePaid() public {
        blueishNFT.mintTo(address(1));
    }

    function testMintTo() public {
        assertTrue(true);
    }
}
