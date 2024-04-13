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
//   '0xf83ca0388f551737cb62b255877d87f4c642318039bf8917c0fd1ec43b322098',
//   '0xb2564203a6ff557aa735f670b5ff4552226b146a1479186854a740306ee818f0',
//   '0xdf866059a2d2c4ba80efb172da60b697a053746d6c753df4ac9d5d3291c48db6',
//   '0x46e0c701b50fc9b79a424abb36b8cceab827dd7dcee9856cf02f9f6eab325f48',
//   '0x36e1c173eba43ea05cee224d4b7ec38ddc8c6813f89f0f0aa3343ae423a04a66',
//   '0xe11ffc8b642c08ec93584dfe6f8e233b3eae0550815e4031729994f27a425bf0',
//   '0x31a7281732821380454fab8cda954a519ba159771a11124c9623a0b2d94d1229',
//   '0x0cbe44d13c051fe963d5f611cdf3bf17c877eef6b60baa3034a1732d06fcb3c8',
//   '0xcb9d24b8a3ce770085b4a36280abd799a4198a6a661ec645b53b90c02c96e525'
// ]

