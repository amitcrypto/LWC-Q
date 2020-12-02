# LWC-Q

The code is for our paper "Quantum Search for Lightweight Block Ciphers: GIFT, SKINNY and SATURNIN".
Preprint available at https://eprint.iacr.org/2020/1485.

## Grover's algorithm for lightweight block cipher key search

The grover-blocks project contains implementations of Grover oracles for exhaustive key search on lightweight block ciphers via Grover's quantum search algorithm. Version 1.0 provides oracles for GIFT, SKINNY and SATURNIN in the quantum-focused programming language Q# and depends on the Microsoft Quantum Development Kit. The code can be used to obtain quantum resource estimates for exhaustive key search to inform the post-quantum security assessment of GIFT, SKINNY and SATURNIN.

### Installation instructions
- [GIFT](https://github.com/amitcrypto/LWC-Q/blob/main/install.md) 
- [SKINNY](https://github.com/amitcrypto/LWC-Q/blob/main/install.md) 
- [SATURNIN](https://github.com/amitcrypto/LWC-Q/blob/main/install.md)

## Contributors 
- Amit Kumar Chauhan 
- Subodh Bijwe

## References 
[1] Samuel Jaques, Michael Naehrig, Martin Roetteler, and Fernando Virdia, "Implementing Grover oracles for quantum key search on AES and LowMC". Preprint available at https://eprint.iacr.org/2019/1146.

## Acknowledgement 

We would like to thank to Microsoft team for using the Q# code of AES. 
