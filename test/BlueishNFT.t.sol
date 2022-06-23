// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BlueishNFT.sol";

contract BlueishNFTTest is Test {
    using stdStorage for StdStorage;

    BlueishNFT private blueishNFT;

    function setUp() public {
        // deploy the NFT
        blueishNFT = new BlueishNFT("Blueish NFT", "BLU");
    }

    // tests beginning of 'testFail' in function signature will 'pass' if reverted and 'fail' if not reverted
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
        // keccak256(abi.encodePacked(string)) is used for string comparison
        // the third param passed to Forge's std lib `assertEq` assertion is output in the case of a failng assertion
        // This output will only show when running `forge test` with verbosity level 2, `forge test -vv`
        string
            memory testSVGMarkup = "<svg width='140' height='140'><rect x='0' y='0' width='140' height='140' style='fill:#ffffff;stroke-width:3;stroke:black'/></svg>";
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
        uint256 tokenId = blueishNFT.mintTo(address(1));

        // Unfortunately the below doesn't work with internal calls yet : https://github.com/foundry-rs/foundry/issues/876
        
        // vm.expectCall(address(blueishNFT), abi.encodeCall(blueishNFT.foo, ()));
        // blueishNFT.tokenURI(tokenId);
        // string memory tokenURI = blueishNFT.tokenURI(tokenId);
    }
}
