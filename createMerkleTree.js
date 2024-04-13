import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";

// (1)
// Load data from database.json
let jsonData = fs.readFileSync('database.json');

// If the JSON file is not a flat array, adjust the below line accordingly
let values = JSON.parse(jsonData);

// (2)
const tree = StandardMerkleTree.of(values, ["address", "uint256", "uint256", "uint256"]);

// (3)
console.log("Merkle Root:", tree.root);

// (4)
fs.writeFileSync("tree.json", JSON.stringify(tree.dump()));


// Merkle Root:
// 0x29d90e4671714fd1b0956f79d43601bfad699ad2be7739bdf909526db43e789b