// Import `StandardMerkleTree` class from @openzeppelin/merkle-tree JavaScript package.
// This class is used to interact with a Merkle tree, a cryptographic data structure
// that allows for efficient and secure verification of large data structures.
import { StandardMerkleTree } from "@openzeppelin/merkle-tree";

// Import the `fs` (File System) module from Node.js.
// This module is used for interacting with the file system in a way modeled on standard POSIX functions.
import fs from "fs";

// (1) Load a Merkle tree from a JSON file.
// `fs.readFileSync("tree.json")` reads the file `tree.json` from the local file system
// and returns its content. `JSON.parse()` is used to parse this content to a JavaScript object.
// `StandardMerkleTree.load()` takes this object and returns an instance of `StandardMerkleTree`.
const tree = StandardMerkleTree.load(JSON.parse(fs.readFileSync("tree.json")));

// (2) Iterate over the elements (entries) of the Merkle tree.
for (const [i, v] of tree.entries()) {

  // Check if the first element of the entry (v[0]) is "0x0000000000000000000000000000000000000001".
  if (v[0] === "0x0000000000000000000000000000000000000001") {
    // (3) If the condition is met, it generates a proof for the current entry (i).
    // The proof is an array of hashes representing the minimal number of nodes required to compute the Merkle root for the tree.
    const proof = tree.getProof(i);

    // Print the value and the proof to the console.
    console.log("Value:", v);
    console.log("Proof:", proof);
  }
}


// Merkle Proof:
// Value: [ '0x0000000000000000000000000000000000000001', '0', '1', '1' ]
// Proof: [
//   '0xefd4bd68076cdbd8491cef3a4a34fc4a7670133156ebe35f2a5f171094a23808',
//   '0xd498feb50eed00b4b08e5619cd7533ac1a13d7dafda640d2288d94ce70319477',
//   '0xf3652c14710490596ee869e8ee031019be0050852ab683ed322685897140166d'
// ]
