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
//        bytes32 merkleRoot = 0x9ca89f8f1f7d75f3b599dc3e003ec893bb01635c911cbe33a417aa709f302fc5;
        bytes32 merkleRoot = 0x29d90e4671714fd1b0956f79d43601bfad699ad2be7739bdf909526db43e789b;

        // The function 'vm.prank' sets the sender of the next transaction.
        vm.prank(address(0x99));
        // Initializes the contract to be tested with the specific merkleRoot.
        airdropERC1155 = new AirDropERC1155(merkleRoot);
    }


    function testClaimAirDropAlpha() public {
        // Initializes an array with fixed size of 3 to store the Merkle proof.
        bytes32[] memory proof = new bytes32[](9);
        // These are precalculated leaf hashes for the Merkle proof.
        proof[0] =  0xf83ca0388f551737cb62b255877d87f4c642318039bf8917c0fd1ec43b322098;
        proof[1] =  0xb2564203a6ff557aa735f670b5ff4552226b146a1479186854a740306ee818f0;
        proof[2] =  0xdf866059a2d2c4ba80efb172da60b697a053746d6c753df4ac9d5d3291c48db6;
        proof[3] =  0x46e0c701b50fc9b79a424abb36b8cceab827dd7dcee9856cf02f9f6eab325f48;
        proof[4] =  0x36e1c173eba43ea05cee224d4b7ec38ddc8c6813f89f0f0aa3343ae423a04a66;
        proof[5] =  0xe11ffc8b642c08ec93584dfe6f8e233b3eae0550815e4031729994f27a425bf0;
        proof[6] =  0x31a7281732821380454fab8cda954a519ba159771a11124c9623a0b2d94d1229;
        proof[7] =  0x0cbe44d13c051fe963d5f611cdf3bf17c877eef6b60baa3034a1732d06fcb3c8;
        proof[8] =  0xcb9d24b8a3ce770085b4a36280abd799a4198a6a661ec645b53b90c02c96e525;


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
    }


    // This is the test function.
    function testClaimAirDropOmega() public {
        // Initializes an array with fixed size of 3 to store the Merkle proof.
        bytes32[] memory proof = new bytes32[](9);
        // These are precalculated leaf hashes for the Merkle proof.
          proof[0] =  0x13429043fd056af88080125e976ded203cc4a18916b7f2c004b299760d3e7d0d;
          proof[1] =  0x8cbfb67c37482c06f0fbb3bf0200454d044c09f68d76e5e0bad33732b17d2c31;
          proof[2] =  0xe3249a990c9153b4f498a3d30dfcb86eda945a450b20c4c05467d7d966286d30;
          proof[3] =  0x2080b74cfe5547862e5d5590a810aeb1ebf51d708b2488788c2f8b171b847749;
          proof[4] =  0x2c31e724955b50b7a455d596c4a1481aa1df2e8abb6799a43eb1fbf902a84b5f;
          proof[5] =  0x7ef5b2666e3dfe14a9f6eae86dd4be2fc0ee207c4117eb5f809100bb5e83ec37;
          proof[6] =  0x7afbc172a5984a31c098186a5e0a083d049439f3b0bee3c5f7c2afcbfa6c4974;
          proof[7] =  0xa47dd65f1957a2ec97725761554ab38b09853ed7a435c3d1d530012e87b5f080;
          proof[8] =  0x98ad149f414a2873d35317d15045d3ad49c9e32225745ecf6cd7f7949fa17ef8;


        // These are predefined values for the test. Index of leaf node, amount of tokens to claim and the id of token to be claimed.
        uint256 index = 499;
        uint256 amount = 1;
        uint256 tokenId = 500;

        address zarah = 0x00000000000000000000000000000000000001F4;

        // This line checks that before the airdrop claim, Zarah has no tokens of 'tokenId'.
        assertEq(airdropERC1155.balanceOf(alice, tokenId), 0, "Initial balance for the token isn't 0");

        // Pranks Zarah to be the sender for the next transaction again. It's specific to your testing environment.
        vm.prank(zarah);
        // Call the function under test - the claimERC1155 function of the airdropERC1155 contract.
        airdropERC1155.claimERC1155(proof, index, amount, tokenId);

        // Now checks if Zarah's balance matches the amount claimed.
        assertEq(airdropERC1155.balanceOf(zarah, tokenId), amount, "Final balance of the token is incorrect");
    }

}