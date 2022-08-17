// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC721.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "openzeppelin-contracts/contracts/utils/Base64.sol";

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
                '{"name": "blueish", "description": "Blueish PFP", "image":"',
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
        svg = "<svg version='1.1' id='Layer_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px' viewBox='0 0 5500 5500' xml:space='preserve'><rect x='19.5' y='19.5' fill='#161EC1' width='367' height='367'/><rect x='19.5' y='752.5' fill='#161EC1' width='367' height='367'/><rect x='19.5' y='2217.5' fill='#353EF0' width='367' height='368'/><rect x='19.5' y='2585.5' fill='#000080' width='367' height='366'/><rect x='19.5' y='386.5' fill='#353EF0' width='367' height='366'/><rect x='19.5' y='1119.5' fill='#2A33E1' width='367' height='366'/><rect x='19.5' y='2951.5' fill='#071EC9' width='367' height='367'/><rect x='19.5' y='3318.5' fill='#549BEC' width='367' height='366'/><rect x='752.5' y='19.5' fill='#353EF0' width='367' height='367'/><rect x='386.5' y='752.5' fill='#262FDC' width='366' height='367'/><rect x='386.5' y='2951.5' fill='#0007C4' width='366' height='367'/><rect x='386.5' y='386.5' fill='#2A33E1' width='366' height='366'/><rect x='386.5' y='2585.5' fill='#1331F2' width='366' height='366'/><rect x='386.5' y='3318.5' fill='#04179B' width='366' height='366'/><rect x='386.5' y='19.5' fill='#262FDC' width='366' height='367'/><rect x='752.5' y='1484.5' fill='#353EF0' width='367' height='366'/><rect x='752.5' y='386.5' fill='#262FDC' width='367' height='366'/><rect x='752.5' y='1850.5' fill='#000080' width='367' height='367'/><rect x='752.5' y='3318.5' fill='#0006B1' width='367' height='366'/><rect x='1119.5' y='3318.5' fill='#0021F3' width='365' height='366'/><rect x='1119.5' y='1484.5' fill='#0006B1' width='365' height='366'/><rect x='1119.5' y='2217.5' fill='#0006B1' width='365' height='368'/><rect x='752.5' y='2951.5' fill='#000080' width='367' height='367'/><rect x='1118.5' y='1119.5' fill='#0009CA' width='366' height='365'/><rect x='1119.5' y='1850.5' fill='#0013DE' width='365' height='367'/><rect x='1119.5' y='19.5' fill='#2A33E1' width='365' height='367'/><rect x='1484.5' y='19.5' fill='#262FDC' width='366' height='367'/><rect x='1484.5' y='752.5' fill='#262FDC' width='366' height='367'/><rect x='1484.5' y='1484.5' fill='#0021F3' width='366' height='366'/><rect x='1484.5' y='2217.5' fill='#0013DE' width='366' height='368'/><rect x='1484.5' y='1119.5' fill='#000080' width='366' height='365'/><rect x='1484.5' y='1850.5' fill='#04179B' width='366' height='367'/><rect x='1484.5' y='3318.5' fill='#04179B' width='366' height='366'/><rect x='1850.5' y='19.5' fill='#2A33E1' width='367' height='367'/><rect x='1850.5' y='1484.5' fill='#0013DE' width='367' height='366'/><rect x='1850.5' y='2217.5' fill='#1331F2' width='367' height='368'/><rect x='1850.5' y='386.5' fill='#353EF0' width='367' height='366'/><rect x='1850.5' y='1119.5' fill='#0006B1' width='367' height='365'/><rect x='1850.5' y='1850.5' fill='#071EC9' width='367' height='367'/><rect x='1850.5' y='2585.5' fill='#0006B1' width='367' height='366'/><rect x='2217.5' y='19.5' fill='#353EF0' width='366' height='367'/><rect x='2217.5' y='752.5' fill='#0007C4' width='366' height='367'/><rect x='2217.5' y='1484.5' fill='#0021F3' width='366' height='366'/><rect x='2217.5' y='2217.5' fill='#0006B1' width='366' height='368'/><rect x='2217.5' y='386.5' fill='#000080' width='366' height='366'/><rect x='2217.5' y='1850.5' fill='#020079' width='366' height='367'/><rect x='2217.5' y='2585.5' fill='#03138A' width='366' height='366'/><rect x='2583.5' y='19.5' fill='#242BC5' width='368' height='367'/><rect x='2583.5' y='752.5' fill='#0013DE' width='368' height='367'/><rect x='2583.5' y='1484.5' fill='#000080' width='368' height='366'/><rect x='2583.5' y='2217.5' fill='#000080' width='368' height='368'/><rect x='2583.5' y='386.5' fill='#05058B' width='368' height='366'/><rect x='2583.5' y='1119.5' fill='#1331F2' width='368' height='365'/><rect x='2583.5' y='1850.5' fill='#04179B' width='368' height='367'/><rect x='2583.5' y='2585.5' fill='#0007C4' width='368' height='366'/><rect x='2951.5' y='19.5' fill='#2A33E1' width='367' height='367'/><rect x='2951.5' y='752.5' fill='#0021F3' width='367' height='367'/><rect x='2951.5' y='1484.5' fill='#262FDC' width='367' height='366'/><rect x='2951.5' y='2217.5' fill='#353EF0' width='367' height='368'/><rect x='2951.5' y='2951.5' fill='#0006B1' width='367' height='367'/><rect x='2951.5' y='386.5' fill='#000080' width='367' height='366'/><rect x='2951.5' y='1119.5' fill='#0006B1' width='367' height='365'/><rect x='2951.5' y='1850.5' fill='#2A33E1' width='367' height='367'/><rect x='2951.5' y='2585.5' fill='#020079' width='367' height='366'/><rect x='3318.5' y='19.5' fill='#353EF0' width='366' height='367'/><rect x='3318.5' y='752.5' fill='#0006A7' width='366' height='367'/><rect x='3318.5' y='1484.5' fill='#2832FA' width='366' height='366'/><rect x='3318.5' y='2217.5' fill='#2A33E1' width='366' height='368'/><path fill='#020079' d='M3318.5,2951.5h366v367h-366V2951.5z'/><rect x='3318.5' y='386.5' fill='#2A33E1' width='366' height='366'/><rect x='3318.5' y='1119.5' fill='#000080' width='366' height='365'/><rect x='3318.5' y='1850.5' fill='#353EF0' width='366' height='367'/><rect x='3318.5' y='2585.5' fill='#353EF0' width='366' height='366'/><rect x='3684.5' y='19.5' fill='#2A33E1' width='365' height='367'/><rect x='3684.5' y='752.5' fill='#2A33E1' width='365' height='367'/><rect x='3684.5' y='1484.5' fill='#353EF0' width='365' height='366'/><rect x='3684.5' y='2217.5' fill='#353EF0' width='365' height='368'/><rect x='3684.5' y='2951.5' fill='#242DE2' width='365' height='367'/><rect x='3684.5' y='386.5' fill='#353EF0' width='365' height='366'/><rect x='3684.5' y='1119.5' fill='#262DBE' width='365' height='365'/><rect x='3684.5' y='1850.5' fill='#2A33E1' width='365' height='367'/><rect x='3684.5' y='2585.5' fill='#3038E9' width='365' height='366'/><rect x='3684.5' y='3318.5' fill='#353EF0' width='365' height='366'/><rect x='4049.5' y='19.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='752.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='1484.5' fill='#2A33E1' width='367' height='366'/><rect x='4049.5' y='2217.5' fill='#262FDC' width='367' height='368'/><rect x='4049.5' y='2951.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='386.5' fill='#262FDC' width='367' height='366'/><rect x='4049.5' y='1119.5' fill='#242DE2' width='367' height='365'/><rect x='4049.5' y='1850.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='2585.5' fill='#2A33E1' width='367' height='366'/><rect x='4049.5' y='3318.5' fill='#2A8CEE' width='367' height='366'/><rect x='19.5' y='3684.5' fill='#2283F2' width='367' height='365'/><rect x='19.5' y='4049.5' fill='#4B9FFF' width='367' height='367'/><rect x='386.5' y='3684.5' fill='#4B9FFF' width='366' height='365'/><rect x='386.5' y='4049.5' fill='#2283F2' width='366' height='367'/><rect x='1119.5' y='3684.5' fill='#03138A' width='365' height='365'/><rect x='752.5' y='4049.5' fill='#4B9FFF' width='367' height='367'/><rect x='1119.5' y='4049.5' fill='#3F96FA' width='365' height='367'/><rect x='752.5' y='3684.5' fill='#04179B' width='367' height='365'/><rect x='1484.5' y='3684.5' fill='#4698EB' width='366' height='365'/><rect x='1484.5' y='4049.5' fill='#2283F2' width='366' height='367'/><rect x='1850.5' y='3684.5' fill='#3788E5' width='367' height='365'/><rect x='1850.5' y='4049.5' fill='#4B9FFF' width='367' height='367'/><rect x='2217.5' y='3684.5' fill='#4B9FFF' width='366' height='365'/><rect x='2217.5' y='4049.5' fill='#1F7AD5' width='366' height='367'/><rect x='2583.5' y='3684.5' fill='#1F7AD5' width='368' height='365'/><rect x='2583.5' y='4049.5' fill='#2283F2' width='368' height='367'/><rect x='2951.5' y='4049.5' fill='#1F7AD5' width='367' height='367'/><rect x='3318.5' y='4049.5' fill='#3788E5' width='366' height='367'/><rect x='3684.5' y='4049.5' fill='#2283F2' width='365' height='367'/><rect x='4049.5' y='4049.5' fill='#3788E5' width='367' height='367'/><rect x='4416.5' y='19.5' fill='#262FDC' width='366' height='367'/><rect x='4782.5' y='19.5' fill='#2A33E1' width='367' height='367'/><rect x='4416.5' y='752.5' fill='#262FDC' width='366' height='367'/><rect x='4782.5' y='752.5' fill='#2A33E1' width='367' height='367'/><rect x='4416.5' y='1484.5' fill='#353EF0' width='366' height='366'/><rect x='4782.5' y='1484.5' fill='#262FDC' width='367' height='366'/><rect x='4416.5' y='2217.5' fill='#2A33E1' width='366' height='368'/><rect x='4782.5' y='2217.5' fill='#353EF0' width='367' height='368'/><rect x='4416.5' y='2951.5' fill='#262FDC' width='366' height='367'/><rect x='4782.5' y='2951.5' fill='#353EF0' width='367' height='367'/><rect x='4416.5' y='386.5' fill='#262DBE' width='366' height='366'/><rect x='4782.5' y='386.5' fill='#353EF0' width='367' height='366'/><rect x='4416.5' y='1119.5' fill='#2A33E1' width='366' height='365'/><rect x='4782.5' y='1119.5' fill='#353EF0' width='367' height='365'/><rect x='4416.5' y='1850.5' fill='#242DE2' width='366' height='367'/><rect x='4782.5' y='1850.5' fill='#2A33E1' width='367' height='367'/><rect x='4416.5' y='2585.5' fill='#353EF0' width='366' height='366'/><rect x='4782.5' y='2585.5' fill='#262FDC' width='367' height='366'/><rect x='4416.5' y='3318.5' fill='#4B9FFF' width='366' height='366'/><rect x='4782.5' y='3318.5' fill='#2A33E1' width='367' height='366'/><rect x='19.5' y='1485.5' fill='#353EF0' width='367' height='366'/><rect x='19.5' y='1851.6' fill='#2A33E1' width='366.4' height='366.4'/><rect x='385.9' y='1485.2' fill='#262FDC' width='366.4' height='366.4'/><rect x='385.5' y='2218.5' fill='#0006B1' width='367' height='367'/><rect x='385.9' y='1118.8' fill='#353EF0' width='366.4' height='366.4'/><rect x='385.9' y='1851.6' fill='#353EF0' width='366.4' height='366.4'/><rect x='752.5' y='752.5' fill='#2A33E1' width='367' height='366'/><rect x='752.5' y='2217.5' fill='#071EC9' width='367' height='367'/><rect x='752.4' y='2584.5' fill='#0013DE' width='366.4' height='366.4'/><rect x='752.5' y='1118.5' fill='#262DBE' width='366' height='367'/><rect x='1118.5' y='2951.5' fill='#04179B' width='367' height='367'/><rect x='1119.5' y='752.5' fill='#353EF0' width='366' height='367'/><rect x='1119.5' y='385.5' fill='#262DBE' width='366' height='367'/><rect x='1118.8' y='2584.5' fill='#0021F3' width='366.4' height='366.4'/><rect x='1485.5' y='2951.5' fill='#071EC9' width='366' height='367'/><rect x='1485.5' y='385.5' fill='#2A33E1' width='366' height='367'/><rect x='1485.2' y='2584.5' fill='#020079' width='366.4' height='366.4'/><rect x='1850.5' y='752.5' fill='#000080' width='368' height='367'/><rect x='1851.6' y='2950.9' fill='#000080' width='366.4' height='366.4'/><rect x='1850.5' y='3317.5' fill='#4B9FFF' width='368' height='367'/><rect x='2218.1' y='2950.9' fill='#449BFE' width='366.4' height='366.4'/><rect x='2217.5' y='1118.5' fill='#0013DE' width='367' height='367'/><rect x='2218.1' y='3317.4' fill='#3788E5' width='366.4' height='366.4'/><rect x='2584.5' y='2950.9' fill='#3788E5' width='366.4' height='366.4'/><rect x='2584.5' y='3317.4' fill='#4B9FFF' width='366.4' height='366.4'/><rect x='2950.9' y='3317.4' fill='#2F8EED' width='366.4' height='366.4'/><rect x='3317.4' y='3317.4' fill='#0006B1' width='366.4' height='366.4'/><rect x='2950.9' y='3683.8' fill='#4B9FFF' width='366.4' height='366.4'/><rect x='3317.4' y='3683.8' fill='#4094F3' width='366.4' height='366.4'/><rect x='3683.8' y='3683.8' fill='#3788E5' width='366.4' height='366.4'/><rect x='4050.2' y='3683.8' fill='#4B9FFF' width='366.4' height='366.4'/><rect x='4416.6' y='3683.8' fill='#3788E5' width='366.4' height='366.4'/><rect x='4783.1' y='3683.8' fill='#2283F2' width='366.4' height='366.4'/><rect x='4416.5' y='4049.5' fill='#4B9FFF' width='366' height='367'/><rect x='4782.5' y='4049.5' fill='#1F7AD5' width='367' height='367'/><rect x='19.5' y='4416.5' fill='#1F7AD5' width='367' height='366'/><rect x='19.5' y='4782.5' fill='#4B9FFF' width='367' height='367'/><rect x='386.5' y='4416.5' fill='#4B9FFF' width='366' height='366'/><rect x='386.5' y='4782.5' fill='#0A72DA' width='366' height='367'/><rect x='752.5' y='4416.5' fill='#1F7AD5' width='367' height='366'/><rect x='752.5' y='4782.5' fill='#4B9FFF' width='367' height='367'/><rect x='1119.5' y='4416.5' fill='#2283F2' width='365' height='366'/><rect x='1119.5' y='4782.5' fill='#1F7AD5' width='365' height='367'/><rect x='1484.5' y='4416.5' fill='#1F7AD5' width='366' height='366'/><rect x='1484.5' y='4782.5' fill='#4B9FFF' width='366' height='367'/><rect x='1850.5' y='4416.5' fill='#3788E5' width='367' height='366'/><rect x='1850.5' y='4782.5' fill='#2584E2' width='367' height='367'/><rect x='2217.5' y='4416.5' fill='#4B9FFF' width='366' height='366'/><rect x='2217.5' y='4782.5' fill='#1F7AD5' width='366' height='367'/><rect x='2583.5' y='4416.5' fill='#3788E5' width='368' height='366'/><rect x='2583.5' y='4782.5' fill='#4B9FFF' width='368' height='367'/><rect x='2951.5' y='4416.5' fill='#4B9FFF' width='367' height='366'/><rect x='2951.5' y='4782.5' fill='#3788E5' width='367' height='367'/><rect x='3318.5' y='4416.5' fill='#2283F2' width='366' height='366'/><rect x='3318.5' y='4782.5' fill='#4B9FFF' width='366' height='367'/><rect x='3684.5' y='4416.5' fill='#4B9FFF' width='365' height='366'/><rect x='3684.5' y='4782.5' fill='#1F7AD5' width='365' height='367'/><rect x='4049.5' y='4416.5' fill='#1F7AD5' width='367' height='366'/><rect x='4049.5' y='4782.5' fill='#3788E5' width='367' height='367'/><rect x='4416.5' y='4416.5' fill='#3788E5' width='366' height='366'/><rect x='4416.5' y='4782.5' fill='#1F7AD5' width='366' height='367'/><rect x='4782.5' y='4416.5' fill='#2283F2' width='367' height='366'/><rect x='4782.5' y='4782.5' fill='#4B9FFF' width='367' height='367'/></svg>";
        // svg = "<svg width='18688' height='18688' viewBox='0 0 18688 18688' fill='none' xmlns='http://www.w3.org/2000/svg'\><rect width='18688' height='18688' fill='white'/>"
        //     "<rect x='6779' y='6779' width='367' height='367' fill='#161EC1'/>"
        //     "<rect x='6779' y='7512' width='367' height='367' fill='#161EC1'/>"
        //     "<rect x='6779' y='8977' width='367' height='368' fill='#353EF0'/>"
        //     "<rect x='6779' y='9345' width='367' height='366' fill='#000080'/>"
        //     "<rect x='6779' y='7146' width='367' height='366' fill='#353EF0'/>"
        //     "<rect x='6779' y='7879' width='367' height='366' fill='#2A33E1'/>"
        //     "<rect x='6779' y='9711' width='367' height='367' fill='#071EC9'/>"
        //     "<rect x='6779' y='10078' width='367' height='366' fill='#549BEC'/>"
        //     "<rect x='7512' y='6779' width='367' height='367' fill='#353EF0'/>"
        //     "<rect x='7146' y='7512' width='366' height='367' fill='#262FDC'/>"
        //     "<rect x='7146' y='9711' width='366' height='367' fill='#0007C4'/>"
        //     "<rect x='7146' y='7146' width='366' height='366' fill='#2A33E1'/>"
        //     "<rect x='7146' y='9345' width='366' height='366' fill='#1331F2'/>"
        //     "<rect x='7146' y='10078' width='366' height='366' fill='#04179B'/>"
        //     "<rect x='7146' y='6779' width='366' height='367' fill='#262FDC'/>"
        //     "<rect x='7512' y='8244' width='367' height='366' fill='#353EF0'/>"
        //     "<rect x='7512' y='7146' width='367' height='366' fill='#262FDC'/>"
        //     "<rect x='7512' y='8610' width='367' height='367' fill='#000080'/>"
        //     "<rect x='7512' y='10078' width='367' height='366' fill='#0006B1'/>"
        //     "<rect x='7879' y='10078' width='365' height='366' fill='#0021F3'/>"
        //     "<rect x='7879' y='8244' width='365' height='366' fill='#0006B1'/>"
        //     "<rect x='7879' y='8977' width='365' height='368' fill='#0006B1'/>"
        //     "<rect x='7512' y='9711' width='367' height='367' fill='#000080'/>"
        //     "<rect x='7878' y='7879' width='366' height='365' fill='#0009CA'/>"
        //     "<rect x='7879' y='8610' width='365' height='367' fill='#0013DE'/>"
        //     "<rect x='7879' y='6779' width='365' height='367' fill='#2A33E1'/>"
        //     "<rect x='8244' y='6779' width='366' height='367' fill='#262FDC'/>"
        //     "<rect x='8244' y='7512' width='366' height='367' fill='#262FDC'/>"
        //     "<rect x='8244' y='8244' width='366' height='366' fill='#0021F3'/>"
        //     "<rect x='8244' y='8977' width='366' height='368' fill='#0013DE'/>"
        //     "<rect x='8244' y='7879' width='366' height='365' fill='#000080'/>"
        //     "<rect x='8244' y='8610' width='366' height='367' fill='#04179B'/>"
        //     "<rect x='8244' y='10078' width='366' height='366' fill='#04179B'/" >
        //     "<rect x='8610' y='6779' width='367' height='367' fill='#2A33E1'/>"
        //     "<rect x='8610' y='8244' width='367' height='366' fill='#0013DE'/>"
        //     "<rect x='8610' y='8977' width='367' height='368' fill='#1331F2'/>"
        //     "<rect x='8610' y='7146' width='367' height='366' fill='#353EF0'/>"
        //     "<rect x='8610' y='7879' width='367' height='365' fill='#0006B1'/>"
        //     "<rect x='8610' y='8610' width='367' height='367' fill='#071EC9'/>"
        //     "<rect x='8610' y='9345' width='367' height='366' fill='#0006B1'/>"
        //     "<rect x='8977' y='6779' width='366' height='367' fill='#353EF0'/>"
        //     "<rect x='8977' y='7512' width='366' height='367' fill='#0007C4'/>"
        //     "<rect x='8977' y='8244' width='366' height='366' fill='#0021F3'/>"
        //     "<rect x='8977' y='8977' width='366' height='368' fill='#0006B1'/>"
        //     "<rect x='8977' y='7146' width='366' height='366' fill='#000080'/>"
        //     "<rect x='8977' y='8610' width='366' height='367' fill='#020079'/>"
        //     "<rect x='8977' y='9345' width='366' height='366' fill='#03138A'/>"
        //     "<rect x='9343' y='6779' width='368' height='367' fill='#242BC5'/>"
        //     "<rect x='9343' y='7512' width='368' height='367' fill='#0013DE'/>"
        //     "<rect x='9343' y='8244' width='368' height='366' fill='#000080'/>"
        //     "<rect x='9343' y='8977' width='368' height='368' fill='#000080'/>"
        //     "<rect x='9343' y='7146' width='368' height='366' fill='#05058B'/>"
        //     "<rect x='9343' y='7879' width='368' height='365' fill='#1331F2'/>"
        //     "<rect x='9343' y='8610' width='368' height='367' fill='#04179B'/>"
        //     "<rect x='9343' y='9345' width='368' height='366' fill='#0007C4'/>"
        //     "<rect x='9711' y='6779' width='367' height='367' fill='#2A33E1'/>"
        //     "<rect x='9711' y='7512' width='367' height='367' fill='#0021F3'/>"
        //     "<rect x='9711' y='8244' width='367' height='366' fill='#262FDC'/>"
        //     "<rect x='9711' y='8977' width='367' height='368' fill='#353EF0'/>"
        //     "<rect x='9711' y='9711' width='367' height='367' fill='#0006B1'/>"
        //     "<rect x='9711' y='7146' width='367' height='366' fill='#000080'/>"
        //     "<rect x='9711' y='7879' width='367' height='365' fill='#0006B1'/>"
        //     "<rect x='9711' y='8610' width='367' height='367' fill='#2A33E1'/>"
        //     "<rect x='9711' y='9345' width='367' height='366' fill='#020079'/>"
        //     "<rect x='10078' y='6779' width='366' height='367' fill='#353EF0'/>"
        //     "<rect x='10078' y='7512' width='366' height='367' fill='#0006A7'/>"
        //     "<rect x='10078' y='8244' width='366' height='366' fill='#2832FA'/>"
        //     "<rect x='10078' y='8977' width='366' height='368' fill='#2A33E1'/>"
        //     "<path d='M10078 9711H10444V10078H10078V9711Z' fill='#020079'/>"
        //     "<rect x='10078' y='7146' width='366' height='366' fill='#2A33E1'/>"
        //     "<rect x='10078' y='7879' width='366' height='365' fill='#000080'/>"
        //     "<rect x='10078' y='8610' width='366' height='367' fill='#353EF0'/>"
        //     "<rect x='10078' y='9345' width='366' height='366' fill='#353EF0'/>"
        //     "<rect x='10444' y='6779' width='365' height='367' fill='#2A33E1'/>"
        //     "<rect x='10444' y='7512' width='365' height='367' fill='#2A33E1'/>"
        //     "<rect x='10444' y='8244' width='365' height='366' fill='#353EF0'/>"
        //     "<rect x='10444' y='8977' width='365' height='368' fill='#353EF0'/>"
        //     "<rect x='10444' y='9711' width='365' height='367' fill='#242DE2'/>"
        //     "<rect x='10444' y='7146' width='365' height='366' fill='#353EF0'/>"
        //     "<rect x='10444' y='7879' width='365' height='365' fill='#262DBE'/>"
        //     "<rect x='10444' y='8610' width='365' height='367' fill='#2A33E1'/>"
        //     "<rect x='10444' y='9345' width='365' height='366' fill='#3038E9'/>"
        //     "<rect x='10444' y='10078' width='365' height='366' fill='#353EF0'/" >
        //     "<rect x='10809' y='6779' width='367' height='367' fill='#353EF0'/>"
        //     "<rect x='10809' y='7512' width='367' height='367' fill='#353EF0'/>"
        //     "<rect x='10809' y='8244' width='367' height='366' fill='#2A33E1'/>"
        //     "<rect x='10809' y='8977' width='367' height='368' fill='#262FDC'/>"
        //     "<rect x='10809' y='9711' width='367' height='367' fill='#353EF0'/>"
        //     "<rect x='10809' y='7146' width='367' height='366' fill='#262FDC'/>"
        //     "<rect x='10809' y='7879' width='367' height='365' fill='#242DE2'/>"
        //     "<rect x='10809' y='8610' width='367' height='367' fill='#353EF0'/>"
        //     "<rect x='10809' y='9345' width='367' height='366' fill='#2A33E1'/>"
        //     "<rect x='10809' y='10078' width='367' height='366' fill='#2A8CEE'/>"
        //     "<rect x='6779' y='10444' width='367' height='365' fill='#2283F2'/>"
        //     "<rect x='6779' y='10809' width='367' height='367' fill='#4B9FFF'/>"
        //     "<rect x='7146' y='10444' width='366' height='365' fill='#4B9FFF'/>"
        //     "<rect x='7146' y='10809' width='366' height='367' fill='#2283F2'/>"
        //     "<rect x='7879' y='10444' width='365' height='365' fill='#03138A'/>"
        //     "<rect x='7512' y='10809' width='367' height='367' fill='#4B9FFF'/>"
        //     "<rect x='7879' y='10809' width='365' height='367' fill='#3F96FA'/>"
        //     "<rect x='7512' y='10444' width='367' height='365' fill='#04179B'/>"
        //     "<rect x='8244' y='10444' width='366' height='365' fill='#4698EB'/>"
        //     "<rect x='8244' y='10809' width='366' height='367' fill='#2283F2'/>"
        //     "<rect x='8610' y='10444' width='367' height='365' fill='#3788E5'/>"
        //     "<rect x='8610' y='10809' width='367' height='367' fill='#4B9FFF'/>"
        //     "<rect x='8977' y='10444' width='366' height='365' fill='#4B9FFF'/>"
        //     "<rect x='8977' y='10809' width='366' height='367' fill='#1F7AD5'/>"
        //     "<rect x='9343' y='10444' width='368' height='365' fill='#1F7AD5'/>"
        //     "<rect x='9343' y='10809' width='368' height='367' fill='#2283F2'/>"
        //     "<rect x='9711' y='10809' width='367' height='367' fill='#1F7AD5'/>"
        //     "<rect x='10078' y='10809' width='366' height='367' fill='#3788E5'/>"
        //     "<rect x='10444' y='10809' width='365' height='367' fill='#2283F2'/>"
        //     "<rect x='10809' y='10809' width='367' height='367' fill='#3788E5'/>"
        //     "<rect x='11176' y='6779' width='366' height='367' fill='#262FDC'/>"
        //     "<rect x='11542' y='6779' width='367' height='367' fill='#2A33E1'/>"
        //     "<rect x='11176' y='7512' width='366' height='367' fill='#262FDC'/>"
        //     "<rect x='11542' y='7512' width='367' height='367' fill='#2A33E1'/>"
        //     "<rect x='11176' y='8244' width='366' height='366' fill='#353EF0'/>"
        //     "<rect x='11542' y='8244' width='367' height='366' fill='#262FDC'/>"
        //     "<rect x='11176' y='8977' width='366' height='368' fill='#2A33E1'/>"
        //     "<rect x='11542' y='8977' width='367' height='368' fill='#353EF0'/>"
        //     "<rect x='11176' y='9711' width='366' height='367' fill='#262FDC'/>"
        //     "<rect x='11542' y='9711' width='367' height='367' fill='#353EF0'/>"
        //     "<rect x='11176' y='7146' width='366' height='366' fill='#262DBE'/>"
        //     "<rect x='11542' y='7146' width='367' height='366' fill='#353EF0'/>"
        //     "<rect x='11176' y='7879' width='366' height='365' fill='#2A33E1'/>"
        //     "<rect x='11542' y='7879' width='367' height='365' fill='#353EF0'/>"
        //     "<rect x='11176' y='8610' width='366' height='367' fill='#242DE2'/>"
        //     "<rect x='11542' y='8610' width='367' height='367' fill='#2A33E1'/>"
        //     "<rect x='11176' y='9345' width='366' height='366' fill='#353EF0'/>"
        //     "<rect x='11542' y='9345' width='367' height='366' fill='#262FDC'/>"
        //     "<rect x='11176' y='10078' width='366' height='366' fill='#4B9FFF'/>"
        //     "<rect x='11542' y='10078' width='367' height='366' fill='#2A33E1'/>"
        //     "<rect x='6779' y='8245' width='367' height='366' fill='#353EF0'/>"
        //     "<rect x='6779' y='8611.14' width='366.429' height='366.429' fill='#2A33E1'/>"
        //     "<rect x='7145.43' y='8244.71' width='366.429' height='366.429' fill='#262FDC'/>"
        //     "<rect x='7145' y='8978' width='367' height='367' fill='#0006B1'/>"
        //     "<rect x='7145.43' y='7878.29' width='366.429' height='366.429' fill='#353EF0'/>"
        //     "<rect x='7145.43' y='8611.14' width='366.429' height='366.429' fill='#353EF0'/>"
        //     "<rect x='7512' y='7512' width='367' height='366' fill='#2A33E1'/>"
        //     "<rect x='7512' y='8977' width='367' height='367' fill='#071EC9'/>"
        //     "<rect x='7511.86' y='9344' width='366.429' height='366.429' fill='#0013DE'/>"
        //     "<rect x='7512' y='7878' width='366' height='367' fill='#262DBE'/>"
        //     "<rect x='7878' y='9711' width='367' height='367' fill='#04179B'/>"
        //     "<rect x='7879' y='7512' width='366' height='367' fill='#353EF0'/>"
        //     "<rect x='7879' y='7145' width='366' height='367' fill='#262DBE'/>"
        //     "<rect x='7878.28' y='9344' width='366.429' height='366.429' fill='#0021F3'/>"
        //     "<rect x='8245' y='9711' width='366' height='367' fill='#071EC9'/>"
        //     "<rect x='8245' y='7145' width='366' height='367' fill='#2A33E1'/>"
        //     "<rect x='8244.72' y='9344' width='366.429' height='366.429' fill='#020079'/>"
        //     "<rect x='8610' y='7512' width='368' height='367' fill='#000080'/>"
        //     "<rect x='8611.14' y='9710.43' width='366.429' height='366.429' fill='#000080'/>"
        //     "<rect x='8610' y='10077' width='368' height='367' fill='#4B9FFF'/>"
        //     "<rect x='8977.57' y='9710.43' width='366.429' height='366.429' fill='#449BFE'/>"
        //     "<rect x='8977' y='7878' width='367' height='367' fill='#0013DE'/>"
        //     "<rect x='8977.57' y='10076.9' width='366.429' height='366.429' fill='#3788E5'/>"
        //     "<rect x='9344' y='9710.43' width='366.429' height='366.429' fill='#3788E5'/>"
        //     "<rect x='9344' y='10076.9' width='366.429' height='366.429' fill='#4B9FFF'/>"
        //     "<rect x='9710.43' y='10076.9' width='366.429' height='366.429' fill='#2F8EED'/>"
        //     "<rect x='10076.9' y='10076.9' width='366.429' height='366.429' fill='#0006B1'/>"
        //     "<rect x='9710.43' y='10443.3' width='366.429' height='366.429' fill='#4B9FFF'/>"
        //     "<rect x='10076.9' y='10443.3' width='366.429' height='366.429' fill='#4094F3'/>"
        //     "<rect x='10443.3' y='10443.3' width='366.429' height='366.429' fill='#3788E5'/>"
        //     "<rect x='10809.7' y='10443.3' width='366.429' height='366.429' fill='#4B9FFF'/>"
        //     "<rect x='11176.1' y='10443.3' width='366.429' height='366.429' fill='#3788E5'/>"
        //     "<rect x='11542.6' y='10443.3' width='366.429' height='366.429' fill='#2283F2'/>"
        //     "<rect x='11176' y='10809' width='366' height='367' fill='#4B9FFF'/>"
        //     "<rect x='11542' y='10809' width='367' height='367' fill='#1F7AD5'/>"
        //     "<rect x='6779' y='11176' width='367' height='366' fill='#1F7AD5'/>"
        //     "<rect x='6779' y='11542' width='367' height='367' fill='#4B9FFF'/>"
        //     "<rect x='7146' y='11176' width='366' height='366' fill='#4B9FFF'/>"
        //     "<rect x='7146' y='11542' width='366' height='367' fill='#0A72DA'/>"
        //     "<rect x='7512' y='11176' width='367' height='366' fill='#1F7AD5'/>"
        //     "<rect x='7512' y='11542' width='367' height='367' fill='#4B9FFF'/>"
        //     "<rect x='7879' y='11176' width='365' height='366' fill='#2283F2'/>"
        //     "<rect x='7879' y='11542' width='365' height='367' fill='#1F7AD5'/>"
        //     "<rect x='8244' y='11176' width='366' height='366' fill='#1F7AD5'/>"
        //     "<rect x='8244' y='11542' width='366' height='367' fill='#4B9FFF'/>"
        //     "<rect x='8610' y='11176' width='367' height='366' fill='#3788E5'/>"
        //     "<rect x='8610' y='11542' width='367' height='367' fill='#2584E2'/>"
        //     "<rect x='8977' y='11176' width='366' height='366' fill='#4B9FFF'/>"
        //     "<rect x='8977' y='11542' width='366' height='367' fill='#1F7AD5'/>"
        //     "<rect x='9343' y='11176' width='368' height='366' fill='#3788E5'/>"
        //     "<rect x='9343' y='11542' width='368' height='367' fill='#4B9FFF'/>"
        //     "<rect x='9711' y='11176' width='367' height='366' fill='#4B9FFF'/>"
        //     "<rect x='9711' y='11542' width='367' height='367' fill='#3788E5'/>"
        //     "<rect x='10078' y='11176' width='366' height='366' fill='#2283F2'/>"
        //     "<rect x='10078' y='11542' width='366' height='367' fill='#4B9FFF'/>"
        //     "<rect x='10444' y='11176' width='365' height='366' fill='#4B9FFF'/>"
        //     "<rect x='10444' y='11542' width='365' height='367' fill='#1F7AD5'/>"
        //     "<rect x='10809' y='11176' width='367' height='366' fill='#1F7AD5'/>"
        //     "<rect x='10809' y='11542' width='367' height='367' fill='#3788E5'/>"
        //     "<rect x='11176' y='11176' width='366' height='366' fill='#3788E5'/>"
        //     "<rect x='11176' y='11542' width='366' height='367' fill='#1F7AD5'/>"
        //     "<rect x='11542' y='11176' width='367' height='366' fill='#2283F2'/>"
        //     "<rect x='11542' y='11542' width='367' height='367' fill='#4B9FFF'/>"
        //     "<rect x='6759.5' y='6759.5' width='5169' height='5169' rx='2584.5' stroke='#9747FF' stroke-dasharray='10 5'/>"
        //     "</svg>";
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
