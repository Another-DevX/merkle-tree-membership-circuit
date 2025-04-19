use binary_merkle_root::binary_merkle_root;
use std::hash::poseidon::bn254::hash_2 as poseidon2;
// Maximum depth of the Merkle Tree.
pub global MAX_DEPTH: u32 = 10;

fn main(
    entry: Field,
    merkle_proof_length: pub u32,
    merkle_proof_indices: [u1; MAX_DEPTH],
    merkle_proof_siblings: [Field; MAX_DEPTH],
    expected_merkle_root: pub Field,
) -> pub (Field, Field) {
    let merkle_root = binary_merkle_root(
        poseidon2,
        entry,
        merkle_proof_length,
        merkle_proof_indices,
        merkle_proof_siblings,
    );


    assert(merkle_root == expected_merkle_root);

    (entry, merkle_root)
}

#[test]
fn address_membership() {
    let addr = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e;
    let proof_len = 10;
    let proof_indices = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; 
    let proof_siblings = [
        0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199,
        0x159a0fb15e0498ecdcab51111aa7a8bcc342dc9a75ee428427ead7694fc31fd8,
        0x1069673dcdb12263df301a6ff584a7ec261a44cb9dc68df067a4774460b1f1e1,
        0x18f43331537ee2af2e3d758d50f72106467c6eea50371dd528d57eb2b856d238,
        0x7f9d837cb17b0d36320ffe93ba52345f1b728571a568265caac97559dbc952a,
        0x2b94cf5e8746b3f5c9631f4c5df32907a699c58c94b2ad4d7b5cec1639183f55,
        0x2dee93c5a666459646ea7d22cca9e1bcfed71e6951b953611d11dda32ea09d78,
        0x78295e5a22b84e982cf601eb639597b8b0515a88cb5ac7fa8a4aabe3c87349d,
        0x2fa5e5f18f6027a6501bec864564472a616b2e274a41211a444cbe3a99f3cc61,
        0xe884376d0d8fd21ecb780389e941f66e45e7acce3e228ab3e2156a614fcd747,
    ];

    let expected_merkle_root = 0x2615cf131db524329173504474a6b17ae18856c4d8e4e33e31f5961c1f843be;

    let (entry, merkle_root) = main(
        addr,
        proof_len,
        proof_indices,
        proof_siblings,
        expected_merkle_root,
    );

    println("\nEntry:");
    println(entry);
    println("\nProof Length:"); 
    println(proof_len);
    println("\nProof Indices:");
    println(proof_indices);
    println("\nProof Siblings:");
    println(proof_siblings);
    println("\nMerkle Root:");
    println(merkle_root);
    println("\nExpected Merkle Root:");
    println(expected_merkle_root);

}

