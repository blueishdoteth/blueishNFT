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
            memory testSVGMarkup = "<svg version='1.1' id='Layer_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px' viewBox='0 0 336 336' enable-background='new 0 0 336 336' xml:space='preserve'><rect x='0' y='0' fill='#161EC1' width='24' height='24'/><rect x='0' y='48' fill='#161EC1' width='24' height='24'/><rect x='0' y='144' fill='#353EF0' width='24' height='24.1'/><rect x='0' y='168.1' fill='#000080' width='24' height='24'/><rect x='0' y='24' fill='#353EF0' width='24' height='24'/><rect x='0' y='72' fill='#2A33E1' width='24' height='24'/><rect x='0' y='192' fill='#071EC9' width='24' height='24'/><rect x='0' y='216.1' fill='#549BEC' width='24' height='24'/><rect x='48' y='0' fill='#353EF0' width='24' height='24'/><rect x='24' y='48' fill='#262FDC' width='24' height='24'/><rect x='24' y='192' fill='#0007C4' width='24' height='24'/><rect x='24' y='24' fill='#2A33E1' width='24' height='24'/><rect x='24' y='168.1' fill='#1331F2' width='24' height='24'/><rect x='24' y='216.1' fill='#04179B' width='24' height='24'/><rect x='24' y='0' fill='#262FDC' width='24' height='24'/><rect x='48' y='95.9' fill='#353EF0' width='24' height='24'/><rect x='48' y='24' fill='#262FDC' width='24' height='24'/><rect x='48' y='119.9' fill='#000080' width='24' height='24'/><rect x='48' y='216.1' fill='#0006B1' width='24' height='24'/><rect x='72' y='216.1' fill='#0021F3' width='23.9' height='24'/><rect x='72' y='95.9' fill='#0006B1' width='23.9' height='24'/><rect x='72' y='144' fill='#0006B1' width='23.9' height='24.1'/><rect x='48' y='192' fill='#000080' width='24' height='24'/><rect x='72' y='72' fill='#0009CA' width='24' height='23.9'/><rect x='72' y='119.9' fill='#0013DE' width='23.9' height='24'/><rect x='72' y='0' fill='#2A33E1' width='23.9' height='24'/><rect x='95.9' y='0' fill='#262FDC' width='24' height='24'/><rect x='95.9' y='48' fill='#262FDC' width='24' height='24'/><rect x='95.9' y='95.9' fill='#0021F3' width='24' height='24'/><rect x='95.9' y='144' fill='#0013DE' width='24' height='24.1'/><rect x='95.9' y='72' fill='#000080' width='24' height='23.9'/><rect x='95.9' y='119.9' fill='#04179B' width='24' height='24'/><rect x='95.9' y='216.1' fill='#04179B' width='24' height='24'/><rect x='119.9' y='0' fill='#2A33E1' width='24' height='24'/><rect x='119.9' y='95.9' fill='#0013DE' width='24' height='24'/><rect x='119.9' y='144' fill='#1331F2' width='24' height='24.1'/><rect x='119.9' y='24' fill='#353EF0' width='24' height='24'/><rect x='119.9' y='72' fill='#0006B1' width='24' height='23.9'/><rect x='119.9' y='119.9' fill='#071EC9' width='24' height='24'/><rect x='119.9' y='168.1' fill='#0006B1' width='24' height='24'/><rect x='144' y='0' fill='#353EF0' width='24' height='24'/><rect x='144' y='48' fill='#0007C4' width='24' height='24'/><rect x='144' y='95.9' fill='#0021F3' width='24' height='24'/><rect x='144' y='144' fill='#0006B1' width='24' height='24.1'/><rect x='144' y='24' fill='#000080' width='24' height='24'/><rect x='144' y='119.9' fill='#020079' width='24' height='24'/><rect x='144' y='168.1' fill='#03138A' width='24' height='24'/><rect x='167.9' y='0' fill='#242BC5' width='24.1' height='24'/><rect x='167.9' y='48' fill='#0013DE' width='24.1' height='24'/><rect x='167.9' y='95.9' fill='#000080' width='24.1' height='24'/><rect x='167.9' y='144' fill='#000080' width='24.1' height='24.1'/><rect x='167.9' y='24' fill='#05058B' width='24.1' height='24'/><rect x='167.9' y='72' fill='#1331F2' width='24.1' height='23.9'/><rect x='167.9' y='119.9' fill='#04179B' width='24.1' height='24'/><rect x='167.9' y='168.1' fill='#0007C4' width='24.1' height='24'/><rect x='192' y='0' fill='#2A33E1' width='24' height='24'/><rect x='192' y='48' fill='#0021F3' width='24' height='24'/><rect x='192' y='95.9' fill='#262FDC' width='24' height='24'/><rect x='192' y='144' fill='#353EF0' width='24' height='24.1'/><rect x='192' y='192' fill='#0006B1' width='24' height='24'/><rect x='192' y='24' fill='#000080' width='24' height='24'/><rect x='192' y='72' fill='#0006B1' width='24' height='23.9'/><rect x='192' y='119.9' fill='#2A33E1' width='24' height='24'/><rect x='192' y='168.1' fill='#020079' width='24' height='24'/><rect x='216.1' y='0' fill='#353EF0' width='24' height='24'/><rect x='216.1' y='48' fill='#0006A7' width='24' height='24'/><rect x='216.1' y='95.9' fill='#2832FA' width='24' height='24'/><rect x='216.1' y='144' fill='#2A33E1' width='24' height='24.1'/><path fill='#020079' d='M216.1,192h24v24h-24V192z'/><rect x='216.1' y='24' fill='#2A33E1' width='24' height='24'/><rect x='216.1' y='72' fill='#000080' width='24' height='23.9'/><rect x='216.1' y='119.9' fill='#353EF0' width='24' height='24'/><rect x='216.1' y='168.1' fill='#353EF0' width='24' height='24'/><rect x='240.1' y='0' fill='#2A33E1' width='23.9' height='24'/><rect x='240.1' y='48' fill='#2A33E1' width='23.9' height='24'/><rect x='240.1' y='95.9' fill='#353EF0' width='23.9' height='24'/><rect x='240.1' y='144' fill='#353EF0' width='23.9' height='24.1'/><rect x='240.1' y='192' fill='#242DE2' width='23.9' height='24'/><rect x='240.1' y='24' fill='#353EF0' width='23.9' height='24'/><rect x='240.1' y='72' fill='#262DBE' width='23.9' height='23.9'/><rect x='240.1' y='119.9' fill='#2A33E1' width='23.9' height='24'/><rect x='240.1' y='168.1' fill='#3038E9' width='23.9' height='24'/><rect x='240.1' y='216.1' fill='#353EF0' width='23.9' height='24'/><rect x='264' y='0' fill='#353EF0' width='24' height='24'/><rect x='264' y='48' fill='#353EF0' width='24' height='24'/><rect x='264' y='95.9' fill='#2A33E1' width='24' height='24'/><rect x='264' y='144' fill='#262FDC' width='24' height='24.1'/><rect x='264' y='192' fill='#353EF0' width='24' height='24'/><rect x='264' y='24' fill='#262FDC' width='24' height='24'/><rect x='264' y='72' fill='#242DE2' width='24' height='23.9'/><rect x='264' y='119.9' fill='#353EF0' width='24' height='24'/><rect x='264' y='168.1' fill='#2A33E1' width='24' height='24'/><rect x='264' y='216.1' fill='#2A8CEE' width='24' height='24'/><rect x='0' y='240.1' fill='#2283F2' width='24' height='23.9'/><rect x='0' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='24' y='240.1' fill='#4B9FFF' width='24' height='23.9'/><rect x='24' y='264' fill='#2283F2' width='24' height='24'/><rect x='72' y='240.1' fill='#03138A' width='23.9' height='23.9'/><rect x='48' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='72' y='264' fill='#3F96FA' width='23.9' height='24'/><rect x='48' y='240.1' fill='#04179B' width='24' height='23.9'/><rect x='95.9' y='240.1' fill='#4698EB' width='24' height='23.9'/><rect x='95.9' y='264' fill='#2283F2' width='24' height='24'/><rect x='119.9' y='240.1' fill='#3788E5' width='24' height='23.9'/><rect x='119.9' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='144' y='240.1' fill='#4B9FFF' width='24' height='23.9'/><rect x='144' y='264' fill='#1F7AD5' width='24' height='24'/><rect x='167.9' y='240.1' fill='#1F7AD5' width='24.1' height='23.9'/><rect x='167.9' y='264' fill='#2283F2' width='24.1' height='24'/><rect x='192' y='264' fill='#1F7AD5' width='24' height='24'/><rect x='216.1' y='264' fill='#3788E5' width='24' height='24'/><rect x='240.1' y='264' fill='#2283F2' width='23.9' height='24'/><rect x='264' y='264' fill='#3788E5' width='24' height='24'/><rect x='288' y='0' fill='#262FDC' width='24' height='24'/><rect x='312' y='0' fill='#2A33E1' width='24' height='24'/><rect x='288' y='48' fill='#262FDC' width='24' height='24'/><rect x='312' y='48' fill='#2A33E1' width='24' height='24'/><rect x='288' y='95.9' fill='#353EF0' width='24' height='24'/><rect x='312' y='95.9' fill='#262FDC' width='24' height='24'/><rect x='288' y='144' fill='#2A33E1' width='24' height='24.1'/><rect x='312' y='144' fill='#353EF0' width='24' height='24.1'/><rect x='288' y='192' fill='#262FDC' width='24' height='24'/><rect x='312' y='192' fill='#353EF0' width='24' height='24'/><rect x='288' y='24' fill='#262DBE' width='24' height='24'/><rect x='312' y='24' fill='#353EF0' width='24' height='24'/><rect x='288' y='72' fill='#2A33E1' width='24' height='23.9'/><rect x='312' y='72' fill='#353EF0' width='24' height='23.9'/><rect x='288' y='119.9' fill='#242DE2' width='24' height='24'/><rect x='312' y='119.9' fill='#2A33E1' width='24' height='24'/><rect x='288' y='168.1' fill='#353EF0' width='24' height='24'/><rect x='312' y='168.1' fill='#262FDC' width='24' height='24'/><rect x='288' y='216.1' fill='#4B9FFF' width='24' height='24'/><rect x='312' y='216.1' fill='#2A33E1' width='24' height='24'/><rect x='0' y='96' fill='#353EF0' width='24' height='24'/><rect x='0' y='120' fill='#2A33E1' width='24' height='24'/><rect x='24' y='96' fill='#262FDC' width='24' height='24'/><rect x='23.9' y='144' fill='#0006B1' width='24' height='24'/><rect x='24' y='72' fill='#353EF0' width='24' height='24'/><rect x='24' y='120' fill='#353EF0' width='24' height='24'/><rect x='48' y='48' fill='#2A33E1' width='24' height='24'/><rect x='48' y='144' fill='#071EC9' width='24' height='24'/><rect x='48' y='168' fill='#0013DE' width='24' height='24'/><rect x='48' y='72' fill='#262DBE' width='24' height='24'/><rect x='72' y='192' fill='#04179B' width='24' height='24'/><rect x='72' y='48' fill='#353EF0' width='24' height='24'/><rect x='72' y='23.9' fill='#262DBE' width='24' height='24'/><rect x='72' y='168' fill='#0021F3' width='24' height='24'/><rect x='96' y='192' fill='#071EC9' width='24' height='24'/><rect x='96' y='23.9' fill='#2A33E1' width='24' height='24'/><rect x='96' y='168' fill='#020079' width='24' height='24'/><rect x='119.9' y='48' fill='#000080' width='24.1' height='24'/><rect x='120' y='192' fill='#000080' width='24' height='24'/><rect x='119.9' y='216' fill='#4B9FFF' width='24.1' height='24'/><rect x='144' y='192' fill='#449BFE' width='24' height='24'/><rect x='144' y='72' fill='#0013DE' width='24' height='24'/><rect x='144' y='216' fill='#3788E5' width='24' height='24'/><rect x='168' y='192' fill='#3788E5' width='24' height='24'/><rect x='168' y='216' fill='#4B9FFF' width='24' height='24'/><rect x='192' y='216' fill='#2F8EED' width='24' height='24'/><rect x='216' y='216' fill='#0006B1' width='24' height='24'/><rect x='192' y='240' fill='#4B9FFF' width='24' height='24'/><rect x='216' y='240' fill='#4094F3' width='24' height='24'/><rect x='240' y='240' fill='#3788E5' width='24' height='24'/><rect x='264' y='240' fill='#4B9FFF' width='24' height='24'/><rect x='288' y='240' fill='#3788E5' width='24' height='24'/><rect x='312' y='240' fill='#2283F2' width='24' height='24'/><rect x='288' y='264' fill='#4B9FFF' width='24' height='24'/><rect x='312' y='264' fill='#1F7AD5' width='24' height='24'/><rect x='0' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='0' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='24' y='288' fill='#4B9FFF' width='24' height='24'/><rect x='24' y='312' fill='#0A72DA' width='24' height='24'/><rect x='48' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='48' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='72' y='288' fill='#2283F2' width='23.9' height='24'/><rect x='72' y='312' fill='#1F7AD5' width='23.9' height='24'/><rect x='95.9' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='95.9' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='119.9' y='288' fill='#3788E5' width='24' height='24'/><rect x='119.9' y='312' fill='#2584E2' width='24' height='24'/><rect x='144' y='288' fill='#4B9FFF' width='24' height='24'/><rect x='144' y='312' fill='#1F7AD5' width='24' height='24'/><rect x='167.9' y='288' fill='#3788E5' width='24.1' height='24'/><rect x='167.9' y='312' fill='#4B9FFF' width='24.1' height='24'/><rect x='192' y='288' fill='#4B9FFF' width='24' height='24'/><rect x='192' y='312' fill='#3788E5' width='24' height='24'/><rect x='216.1' y='288' fill='#2283F2' width='24' height='24'/><rect x='216.1' y='312' fill='#4B9FFF' width='24' height='24'/><rect x='240.1' y='288' fill='#4B9FFF' width='23.9' height='24'/><rect x='240.1' y='312' fill='#1F7AD5' width='23.9' height='24'/><rect x='264' y='288' fill='#1F7AD5' width='24' height='24'/><rect x='264' y='312' fill='#3788E5' width='24' height='24'/><rect x='288' y='288' fill='#3788E5' width='24' height='24'/><rect x='288' y='312' fill='#1F7AD5' width='24' height='24'/><rect x='312' y='288' fill='#2283F2' width='24' height='24'/><rect x='312' y='312' fill='#4B9FFF' width='24' height='24'/></svg>";

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
        
        // below console statement is helpful for outputing encoded SVG data uri and testing in browser
        // console2.log("Image URI", base64encodedSVGURI);

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
                '{"name": "blueishNFT", "description": "blueishNFT is a beginner level template for end to end Solidity smart contract development and on-chain art", "image":"',
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
                '{"name": "blueishNFT", "description": "blueishNFT is a beginner level template for end to end Solidity smart contract development and on-chain art", "external_link":"https://github.com/blueishdoteth/blueishNFT","image":"https://gateway.pinata.cloud/ipfs/QmYGiiTiY4aoRXem3HbQqbwQrASwkarGjeu2xsnGUvKyxr"}'
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
