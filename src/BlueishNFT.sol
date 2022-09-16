// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC721.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "openzeppelin-contracts/contracts/utils/Base64.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "./interfaces/IBlueishRenderer.sol";

error WithdrawFailed();

/// @title blueishNFT
/// @author blueish.eth
/// @notice This contract is a basic on-chain SVG ERC721 template built using Foundry
/// @dev This contract is a beginner level, general purpose smart contract development template, as well as an introduction to the Foundry toolchain for EVM smart contract development. It covers developing and testing smart contracts,specifically using Foundry's Forge testing libraries and Cast deployment/scripting lirbaries. It also covers a basic implementation of on-chain SVG NFT art. The README,  code, and comments are the entirety of documentation for this template. Users and developers are encouraged to mint/interact with the original contract, clone the repo and build and deploy their own NFTs.

contract BlueishNFT is ERC721, Ownable {
    uint256 public currentTokenId;
    IBlueishRenderer public renderer;

    constructor(string memory _name, string memory _symbol, address _renderer)
        ERC721(_name, _symbol)
    {
        renderer = IBlueishRenderer(_renderer);
    }

    function mintTo(address recipient) public payable returns (uint256) {
        uint256 newTokenId = ++currentTokenId;
        _safeMint(recipient, newTokenId);
        return newTokenId;
    }

    function contractURI() public pure returns (string memory) {
        string memory baseURL = "data:application/json;base64,";

        string memory json = string(
            abi.encodePacked(
                '{"name": "blueishNFT", "description": "blueishNFT is a beginner level template for end to end Solidity smart contract development and on-chain art", "external_link":"https://github.com/blueishdoteth/blueishNFT","image":"https://gateway.pinata.cloud/ipfs/QmYGiiTiY4aoRXem3HbQqbwQrASwkarGjeu2xsnGUvKyxr"}'
            )
        );

        string memory jsonBase64EncodedMetadata = Base64.encode(bytes(json));
        return string(abi.encodePacked(baseURL, jsonBase64EncodedMetadata));
    }

    function tokenURI(uint256 id)
        public
        view
        virtual
        override
        returns (string memory)
    {
        string memory baseURL = "data:application/json;base64,";
        string memory svg = svgForToken(id);

        string memory json = string(
            abi.encodePacked(
                '{"name": "blueishNFT", "description": "blueishNFT is a beginner level template for end to end Solidity smart contract development and on-chain art", "image":"',
                this.svgToImageURI(svg),
                '"}'
            )
        );
        string memory jsonBase64EncodedMetadata = Base64.encode(bytes(json));
        return string(abi.encodePacked(baseURL, jsonBase64EncodedMetadata));
    }

    function svgForToken(uint256 tokenId)
        public
        view
        returns (string memory svg)
    {
        svg = renderer.render(tokenId);
    }

    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory imgURI)
    {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory encodedSVG = Base64.encode(bytes(svg));
        imgURI = string(abi.encodePacked(baseURL, encodedSVG));
    }

    function withdrawFunds(address payable payee) external onlyOwner {
        uint256 balance = address(this).balance;
        (bool transferTx,) = payee.call{value: balance}("");
        if (!transferTx) revert WithdrawFailed();
    }
}