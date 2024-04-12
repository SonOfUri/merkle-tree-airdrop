// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20; // This specifies the version (0.8.20) of Solidity to be used to compile the contract.

// Importing necessary modules. 'Test.sol' is a helper contract from forge-std and provides testing utilities/tooling.
// 'AirDropERC1155.sol' is the contract to be tested.
import "forge-std/Test.sol";
import "../src/AirDropERC1155.sol";

// Define the test contract which extends the Test contract, therefore inheriting its helper functionalities.
contract AirDropERC1155Test is Test {
    // The AirDropERC1155 contract that we are going to test.
    AirDropERC1155 public airdropERC1155;
    // This is an address variable named 'alice', initialized with a hard-coded address 0x1.
    address public alice = address(0x1);

    // A publicly accessible mapping that maps address to a boolean value.
    mapping(address => bool) public bitmap;

    // The 'setUp' function will be called before each test.
    function setUp() public {
        // merkleRoot is a hard-coded value assumed to be correct for the airdrop.
        bytes32 merkleRoot = 0x9ca89f8f1f7d75f3b599dc3e003ec893bb01635c911cbe33a417aa709f302fc5;
        // The function 'vm.prank' sets the sender of the next transaction.
        vm.prank(address(0x99));
        // Initializes the contract to be tested with the specific merkleRoot.
        airdropERC1155 = new AirDropERC1155(merkleRoot);
    }

    // This is the test function.
    function testClaimAirDrop() public {
        // Initializes an array with fixed size of 3 to store the Merkle proof.
        bytes32[] memory proof = new bytes32[](3);
        // These are precalculated leaf hashes for the Merkle proof.
        proof[0] = 0xefd4bd68076cdbd8491cef3a4a34fc4a7670133156ebe35f2a5f171094a23808;
        proof[1] = 0xd498feb50eed00b4b08e5619cd7533ac1a13d7dafda640d2288d94ce70319477;
        proof[2] = 0xf3652c14710490596ee869e8ee031019be0050852ab683ed322685897140166d;

        // These are predefined values for the test. Index of leaf node, amount of tokens to claim and the id of token to be claimed.
        uint256 index = 0;
        uint256 amount = 1;
        uint256 tokenId = 1;

        // This line checks that before the airdrop claim, Alice has no tokens of 'tokenId'.
        assertEq(airdropERC1155.balanceOf(alice, tokenId), 0, "Initial balance for the token isn't 0");

        // Pranks Alice to be the sender for the next transaction again. It's specific to your testing environment.
        vm.prank(alice);
        // Call the function under test - the claimERC1155 function of the airdropERC1155 contract.
        airdropERC1155.claimERC1155(proof, index, amount, tokenId);

        // Now checks if Alice's balance matches the amount claimed.
        assertEq(airdropERC1155.balanceOf(alice, tokenId), amount, "Final balance of the token is incorrect");
//        console.log(airdropERC1155.balanceOf(alice, tokenId));
    }
}