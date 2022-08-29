// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/BlueishNFT.sol";

/// @title blueishNFT
/// @author blueish.eth
/// @notice This contract is a basic on-chain SVG ERC721 template built using Foundry
/// @dev This contract is a beginner level, general purpose smart contract development template, as well as an introduction to the Foundry toolchain for EVM smart contract development. It covers developing and testing smart contracts,specifically using Foundry's Forge testing libraries and Cast deployment/scripting lirbaries. It also covers a basic implementation of on-chain SVG NFT art. The README,  code, and comments are the entirety of documentation for this template. Users and developers are encouraged to mint/interact with the original contract, clone the repo and build and deploy their own NFTs.

contract BlueishNFTTest is Test {
    using stdStorage for StdStorage;
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed id
    );

    BlueishNFT private blueishNFT;

    function setUp() public {
        // the setUp() function will run before each test function. At a minimum we should deploy the contract  we're testing

        // deploy the NFT
        blueishNFT = new BlueishNFT("Blueish NFT", "BLU");
    }

    // tests beginning with 'testFail' in function signature will 'pass' if reverted and 'fail' if not reverted
    // this is testing for vm/contract to revert. This is NOT the same as a failing test assertion and if you try to
    // use testFail with failing assertions, and not reverts, you will get unexpected behavior, i.e. 'passing' tests when you are
    // expecting them to fail
    function testFailMintToZeroAddress() public {
        blueishNFT.mintTo(address(0));
    }

    // tests beginning with 'test' in function signature are run as tests cases
    function testBalanceOfIncremented() public {
        blueishNFT.mintTo(address(1));

        //stdstore gives us access to contract state/storage. You can append the following query functions to stdstore
        //
        //Query functions (configure the state query - this will return a storage slot):
        // .target - address of contract whose storage you want to access (required)
        // .sig - function signature that access storage (required) - format is contract.<functionName>.selector
        // .with_key - if storage is mapping, set the mapping key
        // .depth - index of struct member, if state var w e are accessing is type Struct
        // Terminator functions (actions):
        // .checked_write - set data to be written to storage slot
        // .find() - return the slot numnber
        // .read() - access value at the targeted storage slot
        // .find() is helpful if you want to retain a pointer to a specific storage slot that can be accessed multiple times
        // in a test (for instance to check for changing state)
        // vs. read(), which is helpful if the value being accessed is going to used or asserted.
        // This:
        // uint256 slot = foo.find()
        //uint256 value = uint256(vm.load(address(contract), bytes32(slot)))
        // Is Equal to this:
        // uint256 value = foo.read_int()

        uint256 storageSlotForBalanceOf = stdstore
            .target(address(blueishNFT))
            .sig(blueishNFT.balanceOf.selector)
            .with_key(1)
            .find();

        uint256 origBalance = uint256(
            vm.load(address(blueishNFT), bytes32(storageSlotForBalanceOf))
        );

        assertEq(origBalance, 1);
        blueishNFT.mintTo(address(1));

        uint256 newBalance = uint256(
            vm.load(address(blueishNFT), bytes32(storageSlotForBalanceOf))
        );

        assertEq(newBalance, 2);
    }

    function testGenerateSVG() public {
        uint256 tokenId = blueishNFT.mintTo(address(1));
        string memory svg = blueishNFT.svgForToken(tokenId);
        string
            memory testSVGMarkup = "<svg version='1.1' id='Layer_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px' viewBox='0 0 5500 5500' xml:space='preserve'><rect x='19.5' y='19.5' fill='#161EC1' width='367' height='367'/><rect x='19.5' y='752.5' fill='#161EC1' width='367' height='367'/><rect x='19.5' y='2217.5' fill='#353EF0' width='367' height='368'/><rect x='19.5' y='2585.5' fill='#000080' width='367' height='366'/><rect x='19.5' y='386.5' fill='#353EF0' width='367' height='366'/><rect x='19.5' y='1119.5' fill='#2A33E1' width='367' height='366'/><rect x='19.5' y='2951.5' fill='#071EC9' width='367' height='367'/><rect x='19.5' y='3318.5' fill='#549BEC' width='367' height='366'/><rect x='752.5' y='19.5' fill='#353EF0' width='367' height='367'/><rect x='386.5' y='752.5' fill='#262FDC' width='366' height='367'/><rect x='386.5' y='2951.5' fill='#0007C4' width='366' height='367'/><rect x='386.5' y='386.5' fill='#2A33E1' width='366' height='366'/><rect x='386.5' y='2585.5' fill='#1331F2' width='366' height='366'/><rect x='386.5' y='3318.5' fill='#04179B' width='366' height='366'/><rect x='386.5' y='19.5' fill='#262FDC' width='366' height='367'/><rect x='752.5' y='1484.5' fill='#353EF0' width='367' height='366'/><rect x='752.5' y='386.5' fill='#262FDC' width='367' height='366'/><rect x='752.5' y='1850.5' fill='#000080' width='367' height='367'/><rect x='752.5' y='3318.5' fill='#0006B1' width='367' height='366'/><rect x='1119.5' y='3318.5' fill='#0021F3' width='365' height='366'/><rect x='1119.5' y='1484.5' fill='#0006B1' width='365' height='366'/><rect x='1119.5' y='2217.5' fill='#0006B1' width='365' height='368'/><rect x='752.5' y='2951.5' fill='#000080' width='367' height='367'/><rect x='1118.5' y='1119.5' fill='#0009CA' width='366' height='365'/><rect x='1119.5' y='1850.5' fill='#0013DE' width='365' height='367'/><rect x='1119.5' y='19.5' fill='#2A33E1' width='365' height='367'/><rect x='1484.5' y='19.5' fill='#262FDC' width='366' height='367'/><rect x='1484.5' y='752.5' fill='#262FDC' width='366' height='367'/><rect x='1484.5' y='1484.5' fill='#0021F3' width='366' height='366'/><rect x='1484.5' y='2217.5' fill='#0013DE' width='366' height='368'/><rect x='1484.5' y='1119.5' fill='#000080' width='366' height='365'/><rect x='1484.5' y='1850.5' fill='#04179B' width='366' height='367'/><rect x='1484.5' y='3318.5' fill='#04179B' width='366' height='366'/><rect x='1850.5' y='19.5' fill='#2A33E1' width='367' height='367'/><rect x='1850.5' y='1484.5' fill='#0013DE' width='367' height='366'/><rect x='1850.5' y='2217.5' fill='#1331F2' width='367' height='368'/><rect x='1850.5' y='386.5' fill='#353EF0' width='367' height='366'/><rect x='1850.5' y='1119.5' fill='#0006B1' width='367' height='365'/><rect x='1850.5' y='1850.5' fill='#071EC9' width='367' height='367'/><rect x='1850.5' y='2585.5' fill='#0006B1' width='367' height='366'/><rect x='2217.5' y='19.5' fill='#353EF0' width='366' height='367'/><rect x='2217.5' y='752.5' fill='#0007C4' width='366' height='367'/><rect x='2217.5' y='1484.5' fill='#0021F3' width='366' height='366'/><rect x='2217.5' y='2217.5' fill='#0006B1' width='366' height='368'/><rect x='2217.5' y='386.5' fill='#000080' width='366' height='366'/><rect x='2217.5' y='1850.5' fill='#020079' width='366' height='367'/><rect x='2217.5' y='2585.5' fill='#03138A' width='366' height='366'/><rect x='2583.5' y='19.5' fill='#242BC5' width='368' height='367'/><rect x='2583.5' y='752.5' fill='#0013DE' width='368' height='367'/><rect x='2583.5' y='1484.5' fill='#000080' width='368' height='366'/><rect x='2583.5' y='2217.5' fill='#000080' width='368' height='368'/><rect x='2583.5' y='386.5' fill='#05058B' width='368' height='366'/><rect x='2583.5' y='1119.5' fill='#1331F2' width='368' height='365'/><rect x='2583.5' y='1850.5' fill='#04179B' width='368' height='367'/><rect x='2583.5' y='2585.5' fill='#0007C4' width='368' height='366'/><rect x='2951.5' y='19.5' fill='#2A33E1' width='367' height='367'/><rect x='2951.5' y='752.5' fill='#0021F3' width='367' height='367'/><rect x='2951.5' y='1484.5' fill='#262FDC' width='367' height='366'/><rect x='2951.5' y='2217.5' fill='#353EF0' width='367' height='368'/><rect x='2951.5' y='2951.5' fill='#0006B1' width='367' height='367'/><rect x='2951.5' y='386.5' fill='#000080' width='367' height='366'/><rect x='2951.5' y='1119.5' fill='#0006B1' width='367' height='365'/><rect x='2951.5' y='1850.5' fill='#2A33E1' width='367' height='367'/><rect x='2951.5' y='2585.5' fill='#020079' width='367' height='366'/><rect x='3318.5' y='19.5' fill='#353EF0' width='366' height='367'/><rect x='3318.5' y='752.5' fill='#0006A7' width='366' height='367'/><rect x='3318.5' y='1484.5' fill='#2832FA' width='366' height='366'/><rect x='3318.5' y='2217.5' fill='#2A33E1' width='366' height='368'/><path fill='#020079' d='M3318.5,2951.5h366v367h-366V2951.5z'/><rect x='3318.5' y='386.5' fill='#2A33E1' width='366' height='366'/><rect x='3318.5' y='1119.5' fill='#000080' width='366' height='365'/><rect x='3318.5' y='1850.5' fill='#353EF0' width='366' height='367'/><rect x='3318.5' y='2585.5' fill='#353EF0' width='366' height='366'/><rect x='3684.5' y='19.5' fill='#2A33E1' width='365' height='367'/><rect x='3684.5' y='752.5' fill='#2A33E1' width='365' height='367'/><rect x='3684.5' y='1484.5' fill='#353EF0' width='365' height='366'/><rect x='3684.5' y='2217.5' fill='#353EF0' width='365' height='368'/><rect x='3684.5' y='2951.5' fill='#242DE2' width='365' height='367'/><rect x='3684.5' y='386.5' fill='#353EF0' width='365' height='366'/><rect x='3684.5' y='1119.5' fill='#262DBE' width='365' height='365'/><rect x='3684.5' y='1850.5' fill='#2A33E1' width='365' height='367'/><rect x='3684.5' y='2585.5' fill='#3038E9' width='365' height='366'/><rect x='3684.5' y='3318.5' fill='#353EF0' width='365' height='366'/><rect x='4049.5' y='19.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='752.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='1484.5' fill='#2A33E1' width='367' height='366'/><rect x='4049.5' y='2217.5' fill='#262FDC' width='367' height='368'/><rect x='4049.5' y='2951.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='386.5' fill='#262FDC' width='367' height='366'/><rect x='4049.5' y='1119.5' fill='#242DE2' width='367' height='365'/><rect x='4049.5' y='1850.5' fill='#353EF0' width='367' height='367'/><rect x='4049.5' y='2585.5' fill='#2A33E1' width='367' height='366'/><rect x='4049.5' y='3318.5' fill='#2A8CEE' width='367' height='366'/><rect x='19.5' y='3684.5' fill='#2283F2' width='367' height='365'/><rect x='19.5' y='4049.5' fill='#4B9FFF' width='367' height='367'/><rect x='386.5' y='3684.5' fill='#4B9FFF' width='366' height='365'/><rect x='386.5' y='4049.5' fill='#2283F2' width='366' height='367'/><rect x='1119.5' y='3684.5' fill='#03138A' width='365' height='365'/><rect x='752.5' y='4049.5' fill='#4B9FFF' width='367' height='367'/><rect x='1119.5' y='4049.5' fill='#3F96FA' width='365' height='367'/><rect x='752.5' y='3684.5' fill='#04179B' width='367' height='365'/><rect x='1484.5' y='3684.5' fill='#4698EB' width='366' height='365'/><rect x='1484.5' y='4049.5' fill='#2283F2' width='366' height='367'/><rect x='1850.5' y='3684.5' fill='#3788E5' width='367' height='365'/><rect x='1850.5' y='4049.5' fill='#4B9FFF' width='367' height='367'/><rect x='2217.5' y='3684.5' fill='#4B9FFF' width='366' height='365'/><rect x='2217.5' y='4049.5' fill='#1F7AD5' width='366' height='367'/><rect x='2583.5' y='3684.5' fill='#1F7AD5' width='368' height='365'/><rect x='2583.5' y='4049.5' fill='#2283F2' width='368' height='367'/><rect x='2951.5' y='4049.5' fill='#1F7AD5' width='367' height='367'/><rect x='3318.5' y='4049.5' fill='#3788E5' width='366' height='367'/><rect x='3684.5' y='4049.5' fill='#2283F2' width='365' height='367'/><rect x='4049.5' y='4049.5' fill='#3788E5' width='367' height='367'/><rect x='4416.5' y='19.5' fill='#262FDC' width='366' height='367'/><rect x='4782.5' y='19.5' fill='#2A33E1' width='367' height='367'/><rect x='4416.5' y='752.5' fill='#262FDC' width='366' height='367'/><rect x='4782.5' y='752.5' fill='#2A33E1' width='367' height='367'/><rect x='4416.5' y='1484.5' fill='#353EF0' width='366' height='366'/><rect x='4782.5' y='1484.5' fill='#262FDC' width='367' height='366'/><rect x='4416.5' y='2217.5' fill='#2A33E1' width='366' height='368'/><rect x='4782.5' y='2217.5' fill='#353EF0' width='367' height='368'/><rect x='4416.5' y='2951.5' fill='#262FDC' width='366' height='367'/><rect x='4782.5' y='2951.5' fill='#353EF0' width='367' height='367'/><rect x='4416.5' y='386.5' fill='#262DBE' width='366' height='366'/><rect x='4782.5' y='386.5' fill='#353EF0' width='367' height='366'/><rect x='4416.5' y='1119.5' fill='#2A33E1' width='366' height='365'/><rect x='4782.5' y='1119.5' fill='#353EF0' width='367' height='365'/><rect x='4416.5' y='1850.5' fill='#242DE2' width='366' height='367'/><rect x='4782.5' y='1850.5' fill='#2A33E1' width='367' height='367'/><rect x='4416.5' y='2585.5' fill='#353EF0' width='366' height='366'/><rect x='4782.5' y='2585.5' fill='#262FDC' width='367' height='366'/><rect x='4416.5' y='3318.5' fill='#4B9FFF' width='366' height='366'/><rect x='4782.5' y='3318.5' fill='#2A33E1' width='367' height='366'/><rect x='19.5' y='1485.5' fill='#353EF0' width='367' height='366'/><rect x='19.5' y='1851.6' fill='#2A33E1' width='366.4' height='366.4'/><rect x='385.9' y='1485.2' fill='#262FDC' width='366.4' height='366.4'/><rect x='385.5' y='2218.5' fill='#0006B1' width='367' height='367'/><rect x='385.9' y='1118.8' fill='#353EF0' width='366.4' height='366.4'/><rect x='385.9' y='1851.6' fill='#353EF0' width='366.4' height='366.4'/><rect x='752.5' y='752.5' fill='#2A33E1' width='367' height='366'/><rect x='752.5' y='2217.5' fill='#071EC9' width='367' height='367'/><rect x='752.4' y='2584.5' fill='#0013DE' width='366.4' height='366.4'/><rect x='752.5' y='1118.5' fill='#262DBE' width='366' height='367'/><rect x='1118.5' y='2951.5' fill='#04179B' width='367' height='367'/><rect x='1119.5' y='752.5' fill='#353EF0' width='366' height='367'/><rect x='1119.5' y='385.5' fill='#262DBE' width='366' height='367'/><rect x='1118.8' y='2584.5' fill='#0021F3' width='366.4' height='366.4'/><rect x='1485.5' y='2951.5' fill='#071EC9' width='366' height='367'/><rect x='1485.5' y='385.5' fill='#2A33E1' width='366' height='367'/><rect x='1485.2' y='2584.5' fill='#020079' width='366.4' height='366.4'/><rect x='1850.5' y='752.5' fill='#000080' width='368' height='367'/><rect x='1851.6' y='2950.9' fill='#000080' width='366.4' height='366.4'/><rect x='1850.5' y='3317.5' fill='#4B9FFF' width='368' height='367'/><rect x='2218.1' y='2950.9' fill='#449BFE' width='366.4' height='366.4'/><rect x='2217.5' y='1118.5' fill='#0013DE' width='367' height='367'/><rect x='2218.1' y='3317.4' fill='#3788E5' width='366.4' height='366.4'/><rect x='2584.5' y='2950.9' fill='#3788E5' width='366.4' height='366.4'/><rect x='2584.5' y='3317.4' fill='#4B9FFF' width='366.4' height='366.4'/><rect x='2950.9' y='3317.4' fill='#2F8EED' width='366.4' height='366.4'/><rect x='3317.4' y='3317.4' fill='#0006B1' width='366.4' height='366.4'/><rect x='2950.9' y='3683.8' fill='#4B9FFF' width='366.4' height='366.4'/><rect x='3317.4' y='3683.8' fill='#4094F3' width='366.4' height='366.4'/><rect x='3683.8' y='3683.8' fill='#3788E5' width='366.4' height='366.4'/><rect x='4050.2' y='3683.8' fill='#4B9FFF' width='366.4' height='366.4'/><rect x='4416.6' y='3683.8' fill='#3788E5' width='366.4' height='366.4'/><rect x='4783.1' y='3683.8' fill='#2283F2' width='366.4' height='366.4'/><rect x='4416.5' y='4049.5' fill='#4B9FFF' width='366' height='367'/><rect x='4782.5' y='4049.5' fill='#1F7AD5' width='367' height='367'/><rect x='19.5' y='4416.5' fill='#1F7AD5' width='367' height='366'/><rect x='19.5' y='4782.5' fill='#4B9FFF' width='367' height='367'/><rect x='386.5' y='4416.5' fill='#4B9FFF' width='366' height='366'/><rect x='386.5' y='4782.5' fill='#0A72DA' width='366' height='367'/><rect x='752.5' y='4416.5' fill='#1F7AD5' width='367' height='366'/><rect x='752.5' y='4782.5' fill='#4B9FFF' width='367' height='367'/><rect x='1119.5' y='4416.5' fill='#2283F2' width='365' height='366'/><rect x='1119.5' y='4782.5' fill='#1F7AD5' width='365' height='367'/><rect x='1484.5' y='4416.5' fill='#1F7AD5' width='366' height='366'/><rect x='1484.5' y='4782.5' fill='#4B9FFF' width='366' height='367'/><rect x='1850.5' y='4416.5' fill='#3788E5' width='367' height='366'/><rect x='1850.5' y='4782.5' fill='#2584E2' width='367' height='367'/><rect x='2217.5' y='4416.5' fill='#4B9FFF' width='366' height='366'/><rect x='2217.5' y='4782.5' fill='#1F7AD5' width='366' height='367'/><rect x='2583.5' y='4416.5' fill='#3788E5' width='368' height='366'/><rect x='2583.5' y='4782.5' fill='#4B9FFF' width='368' height='367'/><rect x='2951.5' y='4416.5' fill='#4B9FFF' width='367' height='366'/><rect x='2951.5' y='4782.5' fill='#3788E5' width='367' height='367'/><rect x='3318.5' y='4416.5' fill='#2283F2' width='366' height='366'/><rect x='3318.5' y='4782.5' fill='#4B9FFF' width='366' height='367'/><rect x='3684.5' y='4416.5' fill='#4B9FFF' width='365' height='366'/><rect x='3684.5' y='4782.5' fill='#1F7AD5' width='365' height='367'/><rect x='4049.5' y='4416.5' fill='#1F7AD5' width='367' height='366'/><rect x='4049.5' y='4782.5' fill='#3788E5' width='367' height='367'/><rect x='4416.5' y='4416.5' fill='#3788E5' width='366' height='366'/><rect x='4416.5' y='4782.5' fill='#1F7AD5' width='366' height='367'/><rect x='4782.5' y='4416.5' fill='#2283F2' width='367' height='366'/><rect x='4782.5' y='4782.5' fill='#4B9FFF' width='367' height='367'/></svg>";

        // keccak256(abi.encodePacked(string)) is used for string comparison
        // the third param passed to Forge's std lib `assertEq` assertion is output in the case of a failng assertion
        // This output will only show when running `forge test` with verbosity level 2, `forge test -vv`

        assertEq(
            keccak256(abi.encodePacked(testSVGMarkup)),
            keccak256(abi.encodePacked(svg)),
            "SVG output does not equal expected"
        );
    }

    function testGenerateSVGForImageURI() public {
        uint256 tokenId = blueishNFT.mintTo(address(1));

        // set up expected value for base64 encoded SVG image URI
        string memory svg = blueishNFT.svgForToken(tokenId);
        string memory encodedSVG = Base64.encode(bytes(svg));
        string memory svgDataURIbaseURL = "data:image/svg+xml;base64,";
        string memory expectedImageURI = string(
            abi.encodePacked(svgDataURIbaseURL, encodedSVG)
        );

        string memory base64encodedSVGURI = blueishNFT.svgToImageURI(svg);

        assertEq(
            keccak256(abi.encodePacked(expectedImageURI)),
            keccak256(abi.encodePacked(base64encodedSVGURI)),
            "Image URI output does not equal expected"
        );
    }

    function testTokenURI() public {
        //the below test illustrates mocking function to test fuction logic in isolation. 

        uint256 tokenId = blueishNFT.mintTo(address(1));

        // set up mocks
        string memory mockSVGForTokenReturn = "svg";
        string memory mockSVGToImageURIReturn = "svgURI";

        vm.mockCall(
            address(blueishNFT),
            abi.encodeWithSelector(blueishNFT.svgForToken.selector, tokenId),
            abi.encode(mockSVGForTokenReturn)
        );
        vm.mockCall(
            address(blueishNFT),
            abi.encodeWithSelector(
                blueishNFT.svgToImageURI.selector,
                mockSVGForTokenReturn
            ),
            abi.encode(mockSVGToImageURIReturn)
        );

        // set up expected return value
        string memory tokenURIBaseURL = "data:application/json;base64,";
        string memory tokenURIJSON = string(
            abi.encodePacked(
                '{"name": "blueish", "description": "Blueish PFP", "image":"',
                mockSVGToImageURIReturn,
                '"}'
            )
        );
        string memory encodedJSON = Base64.encode(bytes(tokenURIJSON));
        string memory expectedVal = string(
            abi.encodePacked(tokenURIBaseURL, encodedJSON)
        );

        assertEq(
            abi.encode(blueishNFT.tokenURI(tokenId)),
            abi.encode(expectedVal)
        );

        // Unfortunately the below doesn't work with internal calls yet : https://github.com/foundry-rs/foundry/issues/876

        // vm.expectCall(address(blueishNFT), abi.encodeCall(blueishNFT.foo, ()));
        // blueishNFT.tokenURI(tokenId);
    }

    function testMintedEvent() public {
        //the below test illustrates Forge's event emission assertion.
        // we first set up our test assertion. The boolean parameters to this call //are indicating which topics from the event to include in our assertion/////matcher. The fifth (optional) parameter indicates which contract address //we expect to emit the event.
        vm.expectEmit(true, true, true, false, address(blueishNFT));

        // the Forge documentation is lacking here, but we must then emit the expected event, with expected topic values, directly after setting up our expectation/assertion
        emit Transfer(address(0), address(1), 1);

        //submit tx that will trigger the expected event with expected values
        blueishNFT.mintTo(address(1));
    }

    function testContractMetadata() public {

        string memory contractURIBaseURL = "data:application/json;base64,";

        string memory contractURIJSON = string(
            abi.encodePacked(
                '{"name": "blueishNFT", "description": "blueishNFT is a beginner level template for end to end Solidity smart contract development and on-chain art", "external_link":"https://github.com/blueishdoteth/blueishNFT","image":"https://gateway.pinata.cloud/ipfs/Qmbm92KCi1ocsS4L2oDohvxTVBdqQqhRp29iUxXt5ATBPx"}'
            )
        );

        string memory encodedJSON = Base64.encode(bytes(contractURIJSON));

         string memory expectedVal = string(
            abi.encodePacked(contractURIBaseURL, encodedJSON)
        );

        assertEq(
            abi.encode(blueishNFT.contractURI()),
            abi.encode(expectedVal)
        );
    }
}
