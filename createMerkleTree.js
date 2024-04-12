import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";

// (1)
const values = [
  ["0x0000000000000000000000000000000000000001", "0", "1", "1"],
  ["0x0000000000000000000000000000000000000002", "1", "1", "2"],
  ["0x0000000000000000000000000000000000000003", "2", "1", "3"],
  ["0x0000000000000000000000000000000000000004", "3", "1", "4"],
  ["0x0000000000000000000000000000000000000005", "4", "1", "5"],
  ["0x0000000000000000000000000000000000000006", "5", "1", "6"],
  ["0x0000000000000000000000000000000000000007", "6", "1", "7"],
  ["0x0000000000000000000000000000000000000008", "7", "1", "8"],
];

// (2)
const tree = StandardMerkleTree.of(values, ["address", "uint256", "uint256", "uint256"]);

// (3)
console.log("Merkle Root:", tree.root);

// (4)
fs.writeFileSync("tree.json", JSON.stringify(tree.dump()));


// Merkle Root:
// 0x9ca89f8f1f7d75f3b599dc3e003ec893bb01635c911cbe33a417aa709f302fc5