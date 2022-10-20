// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/utils/Base64.sol";
import "../src/BlueishRenderer.sol";
import "../src/BlueishOnChainMetadata.sol";

/// @title blueish
/// @author blueish.eth
/// @notice This contract is a basic on-chain SVG ERC721 template built using Foundry
/// @dev This contract is a beginner level, general purpose smart contract development template, as well as an introduction to the Foundry toolchain for EVM smart contract development. It covers developing and testing smart contracts,specifically using Foundry's Forge testing libraries and Cast deployment/scripting lirbaries. It also covers a basic implementation of on-chain SVG NFT art. The README,  code, and comments are the entirety of documentation for this template. Users and developers are encouraged to mint/interact with the original contract, clone the repo and build and deploy their own NFTs.

contract BlueishOnChainMetadataTest is Test {
    using stdStorage for StdStorage;

    BlueishRenderer private renderer;
    BlueishOnChainMetadata private metadata;

    function setUp() public {
        // the setUp() function will run before each test function. At a minimum we should deploy the contract  we're testing

        // renderer
        renderer = new BlueishRenderer();

        // deploy metadata
        metadata = new BlueishOnChainMetadata(address(renderer));
    }

    function testTokenURI() public {
        uint256 tokenId = 1;
        string memory mockSVG = "<svg>mock</svg>";

        //mock renderer call to return svg
        vm.mockCall(
            address(renderer),
            abi.encodeWithSelector(renderer.render.selector, tokenId),
            abi.encode(mockSVG)
        );

        //encode image URI with mocked svg
        string memory imageURI = string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(bytes(mockSVG))
            )
        );

        //encode metatadata with image URI and other
        string memory tokenURIBaseURL = "data:application/json;base64,";
        string memory tokenURIJSON = string(
            abi.encodePacked(
                '{"name": "blueishNFT", "description": "blueishNFT is a beginner level template for end to end Solidity smart contract development and on-chain art", "image":"',
                imageURI,
                '"}'
            )
        );
        string memory encodedJSON = Base64.encode(bytes(tokenURIJSON));
        string memory expectedVal = string(
            abi.encodePacked(tokenURIBaseURL, encodedJSON)
        );

        assertEq(
            abi.encode(metadata.tokenURI(tokenId)),
            abi.encode(expectedVal)
        );
    }

    function testContractURI() public {
        string memory contractURIBaseURL = "data:application/json;base64,";

        string memory contractURIJSON = string(
            abi.encodePacked(
                '{"name": "blueishNFT", "description": "blueishNFT is a beginner level template for end to end Solidity smart contract development and on-chain art", "external_link":"https://github.com/blueishdoteth/blueishNFT","image":"https://gateway.pinata.cloud/ipfs/QmYGiiTiY4aoRXem3HbQqbwQrASwkarGjeu2xsnGUvKyxr"}'
            )
        );

        string memory encodedJSON = Base64.encode(bytes(contractURIJSON));

        string memory expectedVal = string(
            abi.encodePacked(contractURIBaseURL, encodedJSON)
        );

        assertEq(
            abi.encode(metadata.contractURI()),
            abi.encode(expectedVal)
        );
    }
}
