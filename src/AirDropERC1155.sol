// SPDX-License-Identifier: UNLICENSED
// The compiler version being used is above or equal to Solidity version 0.8.20.
pragma solidity >=0.8.20;

// Imports the ERC721 library from OpenZeppelin which is a standard for
// non-fungible tokens (NFTs).
import {ERC1155} from "lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";

// Imports the BitMaps library from OpenZeppelin that provides a structure
// for storing boolean flags in a compact and efficient manner.
import {BitMaps} from "lib/openzeppelin-contracts/contracts/utils/structs/BitMaps.sol";

// Imports the MerkleProof library from OpenZeppelin which provides
// functions to verify the inclusion of elements in Merkle trees.
import {MerkleProof} from "lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol";



// Define new contract AirDropERC1155 that extends ERC1155
contract AirDropERC1155 is ERC1155 {
    // Immutable variable storing the root of the Merkle Tree.
    bytes32 public immutable merkleRoot;

    // Bitmap structure that keeps track of claimed NFTs based on their index.
    // This prevents the same NFT from being claimed multiple times.
    BitMaps.BitMap private _claimedMap;


    // Constructor which sets the Merkle root and URI for the token upon contract deployment.
    constructor(bytes32 _merkleRoot) ERC1155("https://myapi.com/{id}.json") {
        merkleRoot = _merkleRoot;
    }

    // claimERC1155 function can be called by a claimant to receive an NFT.
    // The Merkle proof, index, and amount are passed as an argument.
    function claimERC1155(bytes32[] calldata proof, uint256 index, uint256 amount, uint256 tokenId) external {
        // If the NFT at the specific index has already been claimed, revert the call.
        require(!BitMaps.get(_claimedMap, index), "Already claimed");

        // Verifies the proof, if it fails to verify, reverts the call.
        _verifyProof(proof, index, amount, msg.sender, tokenId);

        // Marks the NFT at the specific index as claimed.
        BitMaps.setTo(_claimedMap, index, true);

        // Mints the new NFT and assigns it to the claimant.
        _mintERC1155(msg.sender, tokenId, amount);
    }

    // Internal helper function to mint the new NFTs.
    function _mintERC1155(address to, uint256 tokenId, uint256 amount) private {
        _mint(to, tokenId, amount, "");
    }

    // Internal helper function that verifies the proof.
    // Verifies that the hashed (claimant's address + index) matches a leaf of the Merkle tree.
    function _verifyProof(bytes32[] memory proof, uint256 index, uint256 amount, address addr, uint256 tokenID) private view {
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(addr, index, amount, tokenID))));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof");
    }
}