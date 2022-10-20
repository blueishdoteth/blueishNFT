// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/BlueishNFT.sol";
import "../src/BlueishRenderer.sol";
import "../src/BlueishOnChainMetadata.sol";

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
    BlueishRenderer private renderer;
    BlueishOnChainMetadata private metadata;

    function setUp() public {
        // the setUp() function will run before each test function. At a minimum we should deploy the contract  we're testing

        // renderer
        renderer = new BlueishRenderer();
        metadata = new BlueishOnChainMetadata(address(renderer));

        // deploy the NFT
        blueishNFT = new BlueishNFT("Blueish NFT", "BLU", address(metadata));
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

    function testTokenURI() public {
        uint256 tokenId = blueishNFT.mintTo(address(1));
        // set up mocks
        string memory mockTokenURI = "mockedTokenURI";

        vm.mockCall(
            address(metadata),
            abi.encodeWithSelector(metadata.tokenURI.selector, tokenId),
            abi.encode(mockTokenURI)
        );

        assertEq(
            abi.encode(blueishNFT.tokenURI(tokenId)),
            abi.encode(mockTokenURI)
        );
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
        // set up mocks
        string memory mockContractURI = "mockedContractURI";

        vm.mockCall(
            address(metadata),
            abi.encodeWithSelector(metadata.contractURI.selector),
            abi.encode(mockContractURI)
        );

        assertEq(abi.encode(blueishNFT.contractURI()), abi.encode(mockContractURI));
    }

    function testIsOwnable() public {
        //Tests are deployed to 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84. If you deploy a contract within your test, then 0xb4c...7e84 will be its deployer. If the contract deployed within a test gives special permissions to its deployer, such as Ownable.sol's onlyOwner modifier, then the test contract 0xb4c...7e84 will have those permissions.
        assertEq(
            blueishNFT.owner(),
            address(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84)
        );
    }

    function testWithdrawFunds() public {
        address payer = vm.addr(1);
        address payable withdrawer = payable(vm.addr(2));

        blueishNFT.mintTo{value: 1}(payer);

        assertEq(address(blueishNFT).balance, 1);

        uint256 initialBalance = withdrawer.balance;

        //try to call withDrawFunds with non owner address as msg.sender
        vm.expectRevert("Ownable: caller is not the owner");
        vm.startPrank(payer);
        blueishNFT.withdrawFunds(withdrawer);
        //test balance unchanged, meaning withdrawal did not happen
        assertEq(withdrawer.balance, initialBalance);
        vm.stopPrank();

        //call withdrawFunds as contract owner
        blueishNFT.withdrawFunds(withdrawer);
        // balance changed, meaning withdrawal was successful
        assertEq(withdrawer.balance, initialBalance + 1);
    }
}
