// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC721.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "openzeppelin-contracts/contracts/utils/Base64.sol";

/// @title blueishNFT
/// @author blueish.eth
/// @notice This contract is a basic on-chain SVG ERC721 template built using Foundry
/// @dev This contract is a beginner level, general purpose smart contract development template, as well as an introduction to the Foundry toolchain for EVM smart contract development. It covers developing and testing smart contracts,specifically using Foundry's Forge testing libraries and Cast deployment/scripting lirbaries. It also covers a basic implementation of on-chain SVG NFT art. The README,  code, and comments are the entirety of documentation for this template. Users and developers are encouraged to mint/interact with the original contract, clone the repo and build and deploy their own NFTs.

contract BlueishNFT is ERC721 {
    uint256 public currentTokenId;

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    function mintTo(address recipient) public payable returns (uint256) {
        uint256 newTokenId = ++currentTokenId;
        _safeMint(recipient, newTokenId);
        return newTokenId;
    }

    function contractURI() public view returns (string memory) {
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
        string memory svg = this.svgForToken(id);

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
        pure
        returns (string memory svg)
    {
        svg = "<svg version='1.1' id='blueish' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' height='336' width='336' viewBox='0 0 336 336'><rect x='0' y='0' fill='#161EC1' width='24' height='24'/><rect x='0' y='48' fill='#161EC1' width='24' height='24'/><rect x='0' y='144' fill='#353EF0' width='24' height='24'/><rect x='0' y='168' fill='#000080' width='24' height='24'/><rect x='0' y='24' fill='#353EF0' width='24' height='24'/><rect x='0' y='72' fill='#2A33E1' width='24' height='24'/><rect x='0' y='192' fill='#071EC9' width='24' height='24'/><rect x='0' y='216' fill='#549BEC' width='24' height='24'/><rect x='48' y='0' fill='#353EF0' width='24' height='24'/><rect x='24' y='48' fill='#262FDC' width='24' height='24'/><rect x='24' y='192' fill='#0007C4' width='24' height='24'/><rect x='24' y='24' fill='#2A33E1' width='24' height='24'/><rect x='24' y='168' fill='#1331F2' width='24' height='24'/><rect x='24' y='216' fill='#04179B' width='24' height='24'/><rect x='24' y='0' fill='#262FDC' width='24' height='24'/><rect x='48' y='96' fill='#353EF0' width='24' height='24'/><rect x='48' y='24' fill='#262FDC' width='24' height='24'/><rect x='48' y='120' fill='#000080' width='24' height='24'/><rect x='48' y='216' fill='#0006B1' width='24' height='24'/><rect x='72' y='216' fill='#0021F3' width='24' height='24'/><rect x='72' y='96' fill='#0006B1' width='24' height='24'/><rect x='72' y='144' fill='#0006B1' width='24' height='24'/><rect x='48' y='192' fill='#000080' width='24' height='24'/><rect x='72' y='72' fill='#0009CA' width='24' height='24'/><rect x='72' y='120' fill='#0013DE' width='24' height='24'/><rect x='72' y='0' fill='#2A33E1' width='24' height='24'/><rect x='96' y='0' fill='#262FDC' width='24' height='24'/><rect x='96' y='48' fill='#262FDC' width='24' height='24'/><rect x='96' y='96' fill='#0021F3' width='24' height='24'/><rect x='96' y='144' fill='#0013DE' width='24' height='24'/><rect x='96' y='72' fill='#000080' width='24' height='24'/><rect x='96' y='120' fill='#04179B' width='24' height='24'/><rect x='96' y='216' fill='#04179B' width='24' height='24'/><rect x='120' y='0' fill='#2A33E1' width='24' height='24'/><rect x='120' y='96' fill='#0013DE' width='24' height='24'/><rect x='120' y='144' fill='#1331F2' width='24' height='24'/><rect x='120' y='24' fill='#353EF0' width='24' height='24'/><rect x='120' y='72' fill='#0006B1' width='24' height='24'/><rect x='120' y='120' fill='#071EC9' width='24' height='24'/><rect x='120' y='168' fill='#0006B1' width='24' height='24'/><rect x='144' y='0' fill='#353EF0' width='24' height='24'/><rect x='144' y='48' fill='#0007C4' width='24' height='24'/><rect x='144' y='96' fill='#0021F3' width='24' height='24'/><rect x='144' y='144' fill='#0006B1' width='24' height='24'/><rect x='144' y='24' fill='#000080' width='24' height='24'/><rect x='144' y='120' fill='#020079' width='24' height='24'/><rect x='144' y='168' fill='#03138A' width='24' height='24'/><rect x='168' y='0' fill='#242BC5' width='24' height='24'/><rect x='168' y='48' fill='#0013DE' width='24' height='24'/><rect x='168' y='96' fill='#000080' width='24' height='24'/><rect x='168' y='144' fill='#000080' width='24' height='24'/><rect x='168' y='24' fill='#05058B' width='24' height='24'/><rect x='168' y='72' fill='#1331F2' width='24' height='24'/><rect x='168' y='120' fill='#04179B' width='24' height='24'/><rect x='168' y='168' fill='#0007C4' width='24' height='24'/><rect x='192' y='0' fill='#2A33E1' width='24' height='24'/><rect x='192' y='48' fill='#0021F3' width='24' height='24'/><rect x='192' y='96' fill='#262FDC' width='24' height='24'/><rect x='192' y='144' fill='#353EF0' width='24' height='24'/><rect x='192' y='192' fill='#0006B1' width='24' height='24'/><rect x='192' y='24' fill='#000080' width='24' height='24'/><rect x='192' y='72' fill='#0006B1' width='24' height='24'/><rect x='192' y='120' fill='#2A33E1' width='24' height='24'/><rect x='192' y='168' fill='#020079' width='24' height='24'/><rect x='216' y='0' fill='#353EF0' width='24' height='24'/><rect x='216' y='48' fill='#0006A7' width='24' height='24'/><rect x='216' y='96' fill='#2832FA' width='24' height='24'/><rect x='216' y='144' fill='#2A33E1' width='24' height='24'/><rect x='216' y='192' fill='#020079' width='24' height='24'/><rect x='216' y='24' fill='#2A33E1' width='24' height='24'/><rect x='216' y='72' fill='#000080' width='24' height='24'/><rect x='216' y='120' fill='#353EF0' width='24' height='24'/><rect x='216' y='168' fill='#353EF0' width='24' height='24'/><rect x='240' y='0' fill='#2A33E1' width='24' height='24'/><rect x='240' y='48' fill='#2A33E1' width='24' height='24'/><rect x='240' y='96' fill='#353EF0' width='24' height='24'/><rect x='240' y='144' fill='#353EF0' width='24' height='24'/><rect x='240' y='192' fill='#242DE2' width='24' height='24'/><rect x='240' y='24' fill='#353EF0' width='24' height='24'/><rect x='240' y='72' fill='#262DBE' width='24' height='24'/><rect x='240' y='120' fill='#2A33E1' width='24' height='24'/><rect x='240' y='168' fill='#3038E9' width='24' height='24'/><rect x='240' y='216' fill='#353EF0' width='24' height='24'/><rect x='264' y='0' fill='#353EF0' width='24' height='24'/><rect x='264' y='48' fill='#353EF0' width='24' height='24'/><rect x='264' y='96' fill='#2A33E1' width='24' height='24'/><rect x='264' y='144' fill='#262FDC' width='24' height='24'/><rect x='264' y='192' fill='#353EF0' width='24' height='24'/><rect x='264' y='24' fill='#262FDC' width='24' height='24'/><rect x='264' y='72' fill='#242DE2' width='24' height='24'/><rect x='264' y='120' fill='#353EF0' width='24' height='24'/><rect x='264' y='168' fill='#2A33E1' width='24' height='24'/><rect x='264' y='216' fill='#2A8CEE' width='24' height='24'/><rect x='0' y='240' fill='#2283F2' width='24' height='24'/><rect x='0' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='24' y='240' fill='#4B9FFF' width='24' height='24'/><rect x='24' y='264' fill='#2283F2' width='24' height='24'/><rect x='72' y='240' fill='#03138A' width='24' height='24'/><rect x='48' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='72' y='264' fill='#3F96FA' width='24' height='24'/><rect x='48' y='240' fill='#04179B' width='24' height='24'/><rect x='96' y='240' fill='#4698EB' width='24' height='24'/><rect x='96' y='264' fill='#2283F2' width='24' height='24'/><rect x='120' y='240' fill='#3788E5' width='24' height='24'/><rect x='120' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='144' y='240' fill='#4B9FFF' width='24' height='24'/><rect x='144' y='264' fill='#1F7AD5' width='24' height='24'/><rect x='168' y='240' fill='#1F7AD5' width='24' height='24'/><rect x='168' y='264' fill='#2283F2' width='24' height='24'/><rect x='192' y='264' fill='#1F7AD5' width='24' height='24'/><rect x='216' y='264' fill='#3788E5' width='24' height='24'/><rect x='240' y='264' fill='#2283F2' width='24' height='24'/><rect x='264' y='264' fill='#3788E5' width='24' height='24'/><rect x='288' y='0' fill='#262FDC' width='24' height='24'/><rect x='312' y='0' fill='#2A33E1' width='24' height='24'/><rect x='288' y='48' fill='#262FDC' width='24' height='24'/><rect x='312' y='48' fill='#2A33E1' width='24' height='24'/><rect x='288' y='96' fill='#353EF0' width='24' height='24'/><rect x='312' y='96' fill='#262FDC' width='24' height='24'/><rect x='288' y='144' fill='#2A33E1' width='24' height='24'/><rect x='312' y='144' fill='#353EF0' width='24' height='24'/><rect x='288' y='192' fill='#262FDC' width='24' height='24'/><rect x='312' y='192' fill='#353EF0' width='24' height='24'/><rect x='288' y='24' fill='#262DBE' width='24' height='24'/><rect x='312' y='24' fill='#353EF0' width='24' height='24'/><rect x='288' y='72' fill='#2A33E1' width='24' height='24'/><rect x='312' y='72' fill='#353EF0' width='24' height='24'/><rect x='288' y='120' fill='#242DE2' width='24' height='24'/><rect x='312' y='120' fill='#2A33E1' width='24' height='24'/><rect x='288' y='168' fill='#353EF0' width='24' height='24'/><rect x='312' y='168' fill='#262FDC' width='24' height='24'/><rect x='288' y='216' fill='#4B9FFF' width='24' height='24'/><rect x='312' y='216' fill='#2A33E1' width='24' height='24'/><rect x='0' y='96' fill='#353EF0' width='24' height='24'/><rect x='0' y='120' fill='#2A33E1' width='24' height='24'/><rect x='24' y='96' fill='#262FDC' width='24' height='24'/><rect x='24' y='144' fill='#0006B1' width='24' height='24'/><rect x='24' y='72' fill='#353EF0' width='24' height='24'/><rect x='24' y='120' fill='#353EF0' width='24' height='24'/><rect x='48' y='48' fill='#2A33E1' width='24' height='24'/><rect x='48' y='144' fill='#071EC9' width='24' height='24'/><rect x='48' y='168' fill='#0013DE' width='24' height='24'/><rect x='48' y='72' fill='#262DBE' width='24' height='24'/><rect x='72' y='192' fill='#04179B' width='24' height='24'/><rect x='72' y='48' fill='#353EF0' width='24' height='24'/><rect x='72' y='24' fill='#262DBE' width='24' height='24'/><rect x='72' y='168' fill='#0021F3' width='24' height='24'/><rect x='96' y='192' fill='#071EC9' width='24' height='24'/><rect x='96' y='24' fill='#2A33E1' width='24' height='24'/><rect x='96' y='168' fill='#020079' width='24' height='24'/><rect x='120' y='48' fill='#000080' width='24' height='24'/><rect x='120' y='192' fill='#000080' width='24' height='24'/><rect x='120' y='216' fill='#4B9FFF' width='24' height='24'/><rect x='144' y='192' fill='#449BFE' width='24' height='24'/><rect x='144' y='72' fill='#0013DE' width='24' height='24'/><rect x='144' y='216' fill='#3788E5' width='24' height='24'/><rect x='168' y='192' fill='#3788E5' width='24' height='24'/><rect x='168' y='216' fill='#4B9FFF' width='24' height='24'/><rect x='192' y='216' fill='#2F8EED' width='24' height='24'/><rect x='216' y='216' fill='#0006B1' width='24' height='24'/><rect x='192' y='240' fill='#4B9FFF' width='24' height='24'/><rect x='216' y='240' fill='#4094F3' width='24' height='24'/><rect x='240' y='240' fill='#3788E5' width='24' height='24'/><rect x='264' y='240' fill='#4B9FFF' width='24' height='24'/><rect x='288' y='240' fill='#3788E5' width='24' height='24'/><rect x='312' y='240' fill='#2283F2' width='24' height='24'/><rect x='288' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='312' y='264' fill='#1F7AD5' width='24' height='24'/><rect x='0' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='0' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='24' y='288' fill='#4B9FFF' width='24' height='24'/><rect x='24' y='312' fill='#0A72DA' width='24' height='24'/><rect x='48' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='48' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='72' y='288' fill='#2283F2' width='24' height='24'/><rect x='72' y='312' fill='#1F7AD5' width='24' height='24'/><rect x='96' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='96' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='120' y='288' fill='#3788E5' width='24' height='24'/><rect x='120' y='312' fill='#2584E2' width='24' height='24'/><rect x='144' y='288' fill='#4B9FFF' width='24' height='24'/><rect x='144' y='312' fill='#1F7AD5' width='24' height='24'/><rect x='168' y='288' fill='#3788E5' width='24' height='24'/><rect x='168' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='192' y='288' fill='#4B9FFF' width='24' height='24'/><rect x='192' y='312' fill='#3788E5' width='24' height='24'/><rect x='216' y='288' fill='#2283F2' width='24' height='24'/><rect x='216' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='240' y='288' fill='#4B9FFF' width='24' height='24'/><rect x='240' y='312' fill='#1F7AD5' width='24' height='24'/><rect x='264' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='264' y='312' fill='#3788E5' width='24' height='24'/><rect x='288' y='288' fill='#3788E5' width='24' height='24'/><rect x='288' y='312' fill='#1F7AD5' width='24' height='24'/><rect x='312' y='288' fill='#2283F2' width='24' height='24'/><rect x='312' y='312' fill='#4B9FFF' width='24' height='24'/></svg>";
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
}
