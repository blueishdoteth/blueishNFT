// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC721.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol"; 
import "openzeppelin-contracts/contracts/utils/Base64.sol";

contract BlueishNFT is ERC721 {
    uint256 public currentTokenId;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function mintTo(address recipient) public payable returns (uint256) {
        uint256 newTokenId = ++currentTokenId;
       _safeMint(recipient, newTokenId);
       return newTokenId;
    }

    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        string memory baseURL = "data:application/json;base64,";
        string memory svg = this.svgForToken(id);

        string memory json = string(
            abi.encodePacked(
                '{"name": "blueish", "description": "Blueish PFP", "image":"',
                this.svgToImageURI(svg),
                '"}'
            )
        );
        string memory jsonBase64EncodedMetadata = Base64.encode(bytes(json));
        return string(abi.encodePacked(baseURL, jsonBase64EncodedMetadata));
    }

    function svgForToken(uint256 tokenId) public pure returns(string memory svg) {
       svg =  "<svg xmlns='http://www.w3.org/2000/svg' width='140' height='140'><rect x='0' y='0' width='140' height='140' style='fill:blue;stroke-width:3;stroke:blue'/></svg>";
    }

    function svgToImageURI(string memory svg) public pure returns(string memory imgURI) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory encodedSVG = Base64.encode(bytes(svg));
        imgURI = string(abi.encodePacked(baseURL, encodedSVG));
    }
}
