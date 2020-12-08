// Copyright (c) 2020 IIT Ropar.
// Licensed under MIT license.

namespace QGIFT.InPlace // Implementing InPlace GIFT 
{
    open Microsoft.Quantum.Intrinsic; 
    open QUtilities; 
    open Microsoft.Quantum.Math; 
    open Microsoft.Quantum.Convert; 
     
    operation GiftSbox(a: Qubit[], costing: Bool): Unit{ 
        body(...) 
        { 
            // Just trying to comment here  
            ccnot(a[0], a[2], a[1], costing); 
            ccnot(a[3], a[1], a[0], costing); 
            X(a[0]); 
            X(a[1]); 
            ccnot(a[0], a[1], a[2], costing); 
            X(a[2]); 
            X(a[0]); 
            X(a[1]); 
            CNOT(a[2], a[3]); 
            CNOT(a[3], a[1]); 
            X(a[3]); 
            ccnot(a[0], a[1], a[2], costing); 
            REWIRE(a[0], a[3], costing); 
        }
        adjoint auto;
    }
    
    operation SubCells(input_state : Qubit[], costing: Bool) : Unit
    {
        body(...)
        {
            for (i in 0..31) 
            {
                GiftSbox(input_state[((i*4)..(i+1)*4-1)], costing);  
            }
        }
        adjoint auto; 
    }

    // Bit Permutation :: /* Block size = 128 */
    //  0, 33, 66, 99, 96,  1, 34, 67, 64, 97,  2, 35, 32, 65, 98,  3,
    //  4, 37, 70,103,100,  5, 38, 71, 68,101,  6, 39, 36, 69,102,  7,
    //  8, 41, 74,107,104,  9, 42, 75, 72,105, 10, 43, 40, 73,106, 11,
    // 12, 45, 78,111,108, 13, 46, 79, 76,109, 14, 47, 44, 77,110, 15,
    // 16, 49, 82,115,112, 17, 50, 83, 80,113, 18, 51, 48, 81,114, 19,
    // 20, 53, 86,119,116, 21, 54, 87, 84,117, 22, 55, 52, 85,118, 23,
    // 24, 57, 90,123,120, 25, 58, 91, 88,121, 26, 59, 56, 89,122, 27,
    // 28, 61, 94,127,124, 29, 62, 95, 92,125, 30, 63, 60, 93,126, 31 . 

    
    operation PermBits(state: Qubit[], costing: Bool) : Unit{
        body(...){
            for (i in 0..127)
            {
                mutable p = 4*Floor(IntAsDouble(i/16)) + 32*ModulusI((3*(Floor(IntAsDouble(ModulusI(i, 16)/4)))+ ModulusI(i, 4)),4) + ModulusI(i, 4);
                REWIRE(state[i], state[p], costing);
            }
        }
        adjoint auto; 
    } 

    
    operation AddRoundKey(state: Qubit[], round_key: Qubit[]) : Unit
    {
        body (...)
        {   
            // Round key RK = U||V = (k5||k4)||(k1||k0) = (u_{s - 1} ... u_0)||(v_{s - 1} ... v_0) 
            for (i in 0..31)
            {
                CNOT(round_key[i], state[4*i + 2]);         // b_{4i + 1} <--- b_{4i + 1} XOR v_i  
                CNOT(round_key[i + 32], state[4*i + 1]);    // b_{4i + 2} <--- b_{4i + 2} XOR u_i   
            } 
        }
        adjoint auto; 
    }


    operation KeySchedule(key: Qubit[], kexp_round: Int, costing: Bool) : Unit
    {
        body (...)
        {   
            // Key updation : 76543210 --> 10765432

            // 01 --> 23
            // 23 --> 45
            // 45 --> 67
            // 0123456 --> 2103456 -->2301456 --> 2341056 --> 2345016 --> 2345610 --> 2345601
            
            // 76543210 --> 76543012 --> 76541032 ... --> 10765432
            
            
            for (i in 0..95)
            {
                REWIRE(key[i], key[i+32], costing);
            }
            
            // k0: 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0  --> 11 10 9 8 7 6 5 4 3 2 1 0 15 14 13 12 
            for (i in 96..107)
            {
                REWIRE(key[i], key[i+4], costing); 
            }
            for (i in 108..111)
            {
                REWIRE(key[i], key[i-12], costing); 
            }
            
            // k1: 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0  --> 1 0 15 14 13 12 11 10 9 8 7 6 5 4 3 2
            for (i in 112..125)
            {
                REWIRE(key[i], key[i+2], costing);
            }
            for (i in 126..127)
            {
                REWIRE(key[i-2], key[i], costing);
            }
        }
        adjoint auto; 
    }


    operation AddConstants(state: Qubit[], round: Int, costing: Bool): Unit
    {
        body(...)
        {
            
            // 1 - 16  : 01,03,07,0F,1F,3E,3D,3B,37,2F,1E,3C,39,33,27,0E  
            // 17 - 32 : 1D,3A,35,2B,16,2C,18,30,21,02,05,0B,17,2E,1C,38   
            // 33 - 48 : 31,23,06,0D,1B,36,2D,1A,34,29,12,24,08,11,22,04  
            
            if (round == 1) 
            {
                // >>> bin(0x01) = '000001' 
                X(state[3]);
                //X(state[7]);
                //X(state[11]);
                //X(state[15]);
                //X(state[19]);
                //X(state[23]); 
            }
            elif (round == 2)
            {
                // >>> bin(0x03) == '000011'
                X(state[3]);
                X(state[7]);
                //X(state[11]);
                //X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 3)
            {
                // >>> bin(0x07) == '000111'
                X(state[3]);
                X(state[7]);
                X(state[11]);
                //X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 4)
            {
                // >>> bin(0x0F) == '001111'
                X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 5)
            {
                // >>> bin(0x1F) == '011111'
                X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                X(state[19]); 
                //X(state[23]);
            }
            elif (round == 6)
            {
                // >>> bin(0x3E) == '111110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                X(state[19]);
                X(state[23]); 
            }
            elif (round == 7)
            {
                // >>> bin(0x3D) == '111101'
                X(state[3]);
                //X(state[7]);
                X(state[11]);
                X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 8)
            {
                // >>> bin(0x3B) == '111011'
                X(state[3]);
                X(state[7]);
                //X(state[11]);
                X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 9)
            {
                // >>> bin(0x37) == '110111'
                X(state[3]);
                X(state[7]);
                X(state[11]);
                //X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 10)
            {
                // >>> bin(0x2F) == '101111'
                X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 11)
            {
                // >>> bin(0x1E) == '011110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                X(state[19]);
                //X(state[23]);
            }
            elif (round == 12)
            {
                // >>> bin(0x3C) == '111100'
                //X(state[3]);
                //X(state[7]);
                X(state[11]);
                X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 13)
            {
                // >>> bin(0x39) == '111001'
                X(state[3]);
                //X(state[7]);
                //X(state[11]);
                X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 14)
            {
                // >>> bin(0x33) == '110011'
                X(state[3]);
                X(state[7]);
                //X(state[11]);
                //X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 15)
            {
                // >>> bin(0x27) == '100111'
                X(state[3]);
                X(state[7]);
                X(state[11]);
                //X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 16)
            {
                // >>> bin(0x0E) == '001110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 17)
            {
                // >>> bin(0x1D) == '011101'
                X(state[3]);
                //X(state[7]);
                X(state[11]);
                X(state[15]);
                X(state[19]);
                //X(state[23]);
            }
            elif (round == 18)
            {
                // >>> bin(0x3A) == '111010'
                //X(state[3]);
                X(state[7]);
                //X(state[11]);
                X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 19)
            {
                // >>> bin(0x35) == '110110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                //X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 20)
            {
                // >>> bin(0x2B) == '101011'
                X(state[3]);
                X(state[7]);
                //X(state[11]);
                X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 21)
            {
                // >>> bin(0x16) == '010110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                //X(state[15]);
                X(state[19]);
                //X(state[23]);
            }
            elif (round == 22)
            {
                // >>> bin(0x2C) == '101100'
                //X(state[3]);
                //X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 23)
            {
                // >>> bin(0x18) == '011000'
                //X(state[3]);
                //X(state[7]);
                //X(state[11]);
                X(state[15]);
                X(state[19]);
                //X(state[23]);
            }
            elif (round == 24)
            {
                // >>> bin(0x30) == '110000'
                //X(state[3]);
                //X(state[7]);
                //X(state[11]);
                //X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 25)
            {
                // >>> bin(0x21) == '100001'
                X(state[3]);
                //X(state[7]);
                //X(state[11]);
                //X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 26)
            {
                // >>> bin(0x02) == '000010'
                //X(state[3]);
                X(state[7]);
                //X(state[11]);
                //X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 27)
            {
                // >>> bin(0x05) == '000101'
                X(state[3]);
                //X(state[7]);
                X(state[11]);
                //X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 28)
            {
                // >>> bin(0x0B) == '001011'
                X(state[3]);
                X(state[7]);
                //X(state[11]);
                X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 29)
            {
                // >>> bin(0x17) == '010111'
                X(state[3]);
                X(state[7]);
                X(state[11]);
                //X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 30)
            {
                // >>> bin(0x2E) == '101110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 31)
            {
                // >>> bin(0x1C) == '011100'
                //X(state[3]);
                //X(state[7]);
                X(state[11]);
                X(state[15]);
                X(state[19]);
                //X(state[23]);
            }
            elif (round == 32)
            {
                // >>> bin(0x38) == '111000'
                //X(state[3]);
                //X(state[7]);
                //X(state[11]);
                X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 33)
            {
                // >>> bin(0x31) == '110001'
                X(state[3]);
                //X(state[7]);
                //X(state[11]);
                //X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 34)
            {
                // >>> bin(0x23) == '100011'
                X(state[3]);
                X(state[7]);
                //X(state[11]);
                //X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 35)
            {
                // >>> bin(0x06) == '000110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 36)
            {
                // >>> bin(0x0D) == '001101'
                X(state[3]);
                //X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                //X(state[23]);
            }
            elif (round == 37)
            {
                // >>> bin(0x1B) == '011011'
                X(state[3]);
                X(state[7]);
                //X(state[11]);
                X(state[15]);
                X(state[19]);
                //X(state[23]);
            }
            elif (round == 38)
            {
                // >>> bin(0x36) == '110110'
                //X(state[3]);
                X(state[7]);
                X(state[11]);
                //X(state[15]);
                X(state[19]);
                X(state[23]);
            }
            elif (round == 39)
            {
                // >>> bin(0x2D) == '101101'
                X(state[3]);
                //X(state[7]);
                X(state[11]);
                X(state[15]);
                //X(state[19]);
                X(state[23]);
            }
            elif (round == 40)
            {
                // >>> bin(0x1A) == '011010'
                //X(state[3]);
                X(state[7]);
                //X(state[11]);
                X(state[15]);
                X(state[19]);
                //X(state[23]);
            } 
            
            X(state[127]); 
        }
        adjoint auto;
    }
}


namespace QGIFT
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open QUtilities;

    // round values start from 1 to 40 
    operation Round(state: Qubit[], key: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            QGIFT.InPlace.SubCells(state, costing);  
            QGIFT.InPlace.PermBits(state, costing);  
            QGIFT.InPlace.KeySchedule(key, round, costing);  
            QGIFT.InPlace.AddRoundKey(state, key);   
            QGIFT.InPlace.AddConstants(state, round, costing);   
        }
        adjoint auto; 
    }

    operation ForwardGift(key: Qubit[], state: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            // "round 0"
            QGIFT.InPlace.AddRoundKey(state, key); 

            for (i in 1..round)
            {
                // round i \in [1..40]
                Round(state, key, i, costing);  
            } 
        }
        adjoint auto;
    } 

    operation Gift(key: Qubit[], state: Qubit[], ciphertext: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            ForwardGift(key, state, round, costing); 

            // copy resulting ciphertext out
            CNOTnBits(state[(0)..(127)], ciphertext[0..127], 128);  

            (Adjoint ForwardGift)(key, state, round, costing); 
        }
        adjoint auto;
    }

    operation ForwardGroverOracle(other_keys: Qubit[], state_ancillas: Qubit[], key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            // copy loaded key
            for (i in 0..(pairs-2))
            {
                CNOTnBits(key_superposition, other_keys[(i*128)..((i+1)*128-1)], 128); 
            }

            // compute AES encryption of the i-th target message
            for (i in 0..(pairs-1))
            {
                let state = plaintext[(i*128)..((i+1)*128-1)] + (state_ancillas[(i*128*40)..((i+1)*128*40-1)]); 
                let key = i == 0 ? key_superposition | other_keys[((i-1)*128)..(i*128-1)];
                ForwardGift(key, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[128*(pairs-1)], Qubit[128*40*pairs])) 
            {
                ForwardGroverOracle(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing);

                // debug output
                // for (i in 0..(Length(target_ciphertext)-1))
                // {
                //     if (i == Length(target_ciphertext)/pairs)
                //     {
                //         Message("----");
                //     }
                //     Message($"{M(ciphertext[i])} = {target_ciphertext[i]}"); 
                // }

                mutable ciphertext = state_ancillas[(128*40-128)..(128*40-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*128*40-128)..((i+1)*128*40-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }
}



