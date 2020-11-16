// Copyright (c) CSE, IIT Ropar.
// Licensed under the IIT Ropar license.

namespace QSATURNIN.InPlace // Implementing InPlace Saturnin round functions : SubCells, Nibble permutation, MixColumns 
{
    open Microsoft.Quantum.Intrinsic; 
    open QUtilities; 
    open Microsoft.Quantum.Math; 
    open Microsoft.Quantum.Convert; 
     
    operation SaturninSboxZero(a: Qubit[], costing: Bool): Unit
    { 
        body(...) 
        { 
            using(b = Qubit())
            {
                REWIRE(a[0], a[3], costing);
                REWIRE(a[1], a[2], costing);
                X(a[0]);
                ccnot(a[1], a[2], a[3], costing);
                X(a[3]);
                ccnot(a[0], a[3], b, costing);
                X(b);
                CNOT(b, a[2]);
                X(b);
                ccnot(a[0], a[3], b, costing);
                X(a[0]);
                X(a[1]);
                X(a[2]);
                X(a[3]);
                ccnot(a[1], a[2], b, costing);
                X(b);
                CNOT(b, a[0]);
                X(b);
                ccnot(a[1], a[2], b, costing);
                X(a[1]);
                X(a[2]);
                ccnot(a[0], a[2], a[1], costing);
                X(a[1]);
                X(a[3]);
                ccnot(a[1], a[3], b, costing);
                X(b);
                CNOT(b, a[2]);
                X(b);
                ccnot(a[1], a[3], b, costing);
                X(a[0]);
                X(a[1]);
                X(a[2]);
                X(a[3]);
                ccnot(a[0], a[2], b, costing);
                X(b);
                CNOT(b, a[3]);
                X(b);
                ccnot(a[0], a[2], b, costing);
                X(a[0]);
                X(a[2]);
                REWIRE(a[2], a[3], costing);
                REWIRE(a[1], a[2], costing);
                REWIRE(a[0], a[1], costing);
                REWIRE(a[0], a[3], costing);
                REWIRE(a[1], a[2], costing);
            }         
        }
        adjoint auto;
    }

    operation SaturninSboxOne(a: Qubit[], costing: Bool): Unit 
    { 
        body(...) 
        { 
            using(b = Qubit())
            {
                REWIRE(a[0], a[3], costing);
                REWIRE(a[1], a[2], costing);
                X(a[0]);
                ccnot(a[1], a[2], a[3], costing);
                X(a[3]);
                ccnot(a[0], a[3], b, costing);
                X(b);
                CNOT(b, a[2]);
                X(b);
                ccnot(a[0], a[3], b, costing);
                X(a[0]);
                X(a[1]);
                X(a[2]);
                X(a[3]);
                ccnot(a[1], a[2], b, costing);
                X(b);
                CNOT(b, a[0]);
                X(b);
                ccnot(a[1], a[2], b, costing);
                X(a[1]);
                X(a[2]);
                ccnot(a[0], a[2], a[1], costing);
                X(a[1]);
                X(a[3]);
                ccnot(a[1], a[3], b, costing);
                X(b);
                CNOT(b, a[2]);
                X(b);
                ccnot(a[1], a[3], b, costing);
                X(a[0]);
                X(a[1]);
                X(a[2]);
                X(a[3]);
                ccnot(a[0], a[2], b, costing);
                X(b);
                CNOT(b, a[3]);
                X(b);
                ccnot(a[0], a[2], b, costing);
                X(a[0]);
                X(a[2]);
                REWIRE(a[0], a[3], costing);
                REWIRE(a[0], a[1], costing);
                REWIRE(a[0], a[3], costing);
                REWIRE(a[1], a[2], costing);
            } 
        }
        adjoint auto;
    }

    operation SubCells(state: Qubit[][][][], costing: Bool) : Unit
    {
        body (...)
        {
            for (k in 0..3)
            {
                for (j in 0..3)
                {   
                    for (i in 0..3)
                    {
                        if ((i+j+k) %2 == 0)
                        {
                            SaturninSboxZero(state[i][j][k], costing);
                        }
                        else
                        {
                            SaturninSboxOne(state[i][j][k], costing);
                        }
                    } 
                }
            }
        }
        adjoint auto;
    }

    operation ShiftRow_1(state: Qubit[][][], costing: Bool) : Unit
    {
        body(...)
        {            
            REWIRENibbles(state[0][0][0..3], state[0][3][0..3], costing);
            REWIRENibbles(state[0][1][0..3], state[0][0][0..3], costing);
            REWIRENibbles(state[0][2][0..3], state[0][1][0..3], costing);
            
            REWIRENibbles(state[1][0][0..3], state[1][2][0..3], costing);
            REWIRENibbles(state[1][1][0..3], state[1][3][0..3], costing);

            REWIRENibbles(state[2][0][0..3], state[2][3][0..3], costing);
            REWIRENibbles(state[2][1][0..3], state[2][3][0..3], costing);
            REWIRENibbles(state[2][2][0..3], state[2][3][0..3], costing);    
        }
        adjoint auto;
    }

    operation ShiftRow_2(state: Qubit[][][], costing: Bool) : Unit
    {
        body(...)
        {
            //first is kept as it is i.e. no rotation in first
            //second is rotated left by 1
            REWIRENibbles(state[0][0][(4*1)..(4*2-1)], state[0][1][(4*1)..(4*2-1)], costing);
            REWIRENibbles(state[0][1][(4*1)..(4*2-1)], state[0][2][(4*1)..(4*2-1)], costing);
            REWIRENibbles(state[0][2][(4*1)..(4*2-1)], state[0][3][(4*1)..(4*2-1)], costing);

            // third is rotated left by 2
            REWIRENibbles(state[0][0][(4*2)..(4*3-1)], state[0][2][(4*2)..(4*3-1)], costing);
            REWIRENibbles(state[0][1][(4*2)..(4*3-1)], state[0][3][(4*2)..(4*3-1)], costing);

            // fourth is rotated left by 3
            REWIRENibbles(state[0][2][(4*3)..(4*4-1)], state[0][3][(4*3)..(4*4-1)], costing);
            REWIRENibbles(state[0][1][(4*3)..(4*4-1)], state[0][2][(4*3)..(4*4-1)], costing);
            REWIRENibbles(state[0][0][(4*3)..(4*4-1)], state[0][1][(4*3)..(4*4-1)], costing);   
        }
        adjoint auto;
    }

    operation NibblePermutation(state: Qubit[][][][], round: Int, costing: Bool) : Unit
    {
        body(...)
        {    
            if (round % 4 == 1)
            {
                for (k in 0..3)
                {
                    ShiftRow_1(state[0..3][0..3][k][0..3], costing); 
                }
            }
            if (round % 4 == 3)
            {
                for (i in 0..3)
                {
                    ShiftRow_1(state[i][0..3][0..3][0..3], costing);
                }
            }
        }        
        adjoint auto; 
    }

    operation Alpha(a: Qubit[], costing: Bool): Unit
    {
        body(...)
        {
            CNOT(a[1], a[0]);
            REWIRE(a[1],a[0], costing);
            REWIRE(a[1],a[2], costing);
            REWIRE(a[2],a[3], costing);
        }     
        adjoint auto; 
    }

    operation AlphaSquare(a: Qubit[], costing: Bool): Unit
    {
        body(...)
        {
            CNOT(a[1], a[0]);
            CNOT(a[2], a[1]);
            REWIRE(a[0],a[2], costing);
            REWIRE(a[3],a[1], costing);
        }     
        adjoint auto; 
    }

    operation MixHalfWord(state: Qubit[][], costing: Bool): Unit
    {   
        body(...)
        {
            CNOTNibbles(state[1][0..3], state[0][0..3]);
            Alpha(state[1][0..3], costing);
            CNOTNibbles(state[3][0..3], state[2][0..3]);
            Alpha(state[3][0..3], costing);
            CNOTNibbles(state[2][0..3], state[1][0..3]);
            CNOTNibbles(state[0][0..3], state[3][0..3]);
            AlphaSquare(state[0][0..3], costing);
            AlphaSquare(state[2][0..3], costing);
            CNOTNibbles(state[1][0..3], state[0][0..3]);
            CNOTNibbles(state[3][0..3], state[2][0..3]);
            CNOTNibbles(state[2][0..3], state[1][0..3]);
            CNOTNibbles(state[0][0..3], state[3][0..3]);

            //CNOTNibbles(state[4..7], state[0..3]);
            //Alpha(state[4..7], costing);
            //CNOTNibbles(state[12..15], state[8..11]);
            //Alpha(state[12..15], costing);
            //CNOTNibbles(state[8..11], state[4..7]);
            //CNOTNibbles(state[0..3], state[12..15]);
            //AlphaSquare(state[0..3], costing);
            //AlphaSquare(state[8..11], costing);
            //CNOTNibbles(state[4..7], state[0..3]);
            //CNOTNibbles(state[12..15], state[8..11]);
            //CNOTNibbles(state[8..11], state[4..7]);
            //CNOTNibbles(state[0..3], state[12..15]);         
        }     
        adjoint auto; 
    }

    operation MixColumns(state : Qubit[][][][], costing: Bool) : Unit
    {
        body(...)
        {
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    MixHalfWord(state[0..3][j][k][0..3], costing); 
                }
            }
        }     
        adjoint auto; 
    }
    
    operation InverseShiftRow_1(state: Qubit[][][], costing: Bool) : Unit
    {
        body(...)
        {
            REWIRENibbles(state[0][0][0..3], state[0][1][0..3], costing);
            REWIRENibbles(state[0][1][0..3], state[0][3][0..3], costing);
            REWIRENibbles(state[0][2][0..3], state[0][3][0..3], costing);
            
            REWIRENibbles(state[1][0][0..3], state[1][2][0..3], costing);
            REWIRENibbles(state[1][1][0..3], state[1][3][0..3], costing);

            REWIRENibbles(state[2][0][0..3], state[2][3][0..3], costing);
            REWIRENibbles(state[2][0][0..3], state[2][1][0..3], costing);
            REWIRENibbles(state[2][1][0..3], state[2][2][0..3], costing);   
        }     
        adjoint auto;
    }

    operation InverseShiftRow_2(state: Qubit[][][], costing: Bool) : Unit
    {
        body(...)
        {
            //first is kept as it is i.e. no rotation in first
            //second is rotated right by 1
            REWIRENibbles(state[0][0][(4*3)..(4*4-1)], state[0][1][(4*3)..(4*4-1)], costing);
            REWIRENibbles(state[0][1][(4*3)..(4*4-1)], state[0][2][(4*3)..(4*4-1)], costing);
            REWIRENibbles(state[0][2][(4*3)..(4*4-1)], state[0][3][(4*3)..(4*4-1)], costing);

            // third is rotated right by 2
            REWIRENibbles(state[0][0][(4*2)..(4*3-1)], state[0][2][(4*2)..(4*3-1)], costing);
            REWIRENibbles(state[0][1][(4*2)..(4*3-1)], state[0][3][(4*2)..(4*3-1)], costing);

            // fourth is rotated right by 3
            REWIRENibbles(state[0][2][(4*1)..(4*2-1)], state[0][3][(4*1)..(4*2-1)], costing);
            REWIRENibbles(state[0][1][(4*1)..(4*2-1)], state[0][2][(4*1)..(4*2-1)], costing);
            REWIRENibbles(state[0][0][(4*1)..(4*2-1)], state[0][1][(4*1)..(4*2-1)], costing);   
        }     
        adjoint auto;
    }

    operation InverseNibblePermutation(state: Qubit[][][][], round: Int, costing: Bool) : Unit
    {
        body(...)
        {
            if (round % 4 == 1)
            {
                for (k in 0..3)
                {
                    InverseShiftRow_1(state[0..3][0..3][k][0..3], costing);   
                }
            }
            if (round % 4 == 3)
            {
                for (k in 0..3)
                {
                    InverseShiftRow_1(state[k][0..3][0..3][0..3], costing);
                }
            }     
        }
        adjoint auto; 
    }

    // Updating the key-states with round constants 
    operation AddRoundConstants(key: Qubit[][][][], costing: Bool) : Unit 
    {
        body(...)
        {
            // RC0 bit i will be added to bit 0 to the nibble with index 4i  
            // RC1 bit i will be addded to bit 0 to the nibble with index (4i + 2) 
 
            // Round 1: RC0 [15, 14, 13, 10, 8, 7, 6, 5, 1] 
            //X(key[0][0][0][0]);
            X(key[0][1][0][0]);
            //X(key[0][2][0][0]);
            //X(key[0][3][0][0]); 

            //X(key[0][0][1][0]);
            X(key[0][1][1][0]);
            X(key[0][2][1][0]);
            X(key[0][3][1][0]); 

            X(key[0][0][2][0]);
            //X(key[0][1][2][0]);
            X(key[0][2][2][0]);
            //X(key[0][3][2][0]); 

            //X(key[0][0][3][0]);
            X(key[0][1][3][0]);
            X(key[0][2][3][0]);
            X(key[0][3][3][0]); 

            // Round 1: RC1 [15, 12, 10, 8, 7, 5, 4, 1, 0] 
            X(key[2][0][0][0]); 
            X(key[2][1][0][0]);
            //X(key[2][2][0][0]); 
            //X(key[2][3][0][0]); 

            //X(key[2][0][1][0]); 
            X(key[2][1][1][0]);
            //X(key[2][2][1][0]); 
            X(key[2][3][1][0]);  

            X(key[2][0][2][0]); 
            //X(key[2][1][2][0]);  
            X(key[2][2][2][0]); 
            //X(key[2][3][2][0]);  

            X(key[2][0][3][0]);  
            //X(key[2][1][3][0]); 
            //X(key[2][2][3][0]); 
            //X(key[2][3][3][0]);  
        }  
        adjoint auto;
    }

    // How to rotate the key : i --> (i + 20) mod 64 for i in [0, 63]  
    operation RotateKey(key: Qubit[][][][], costing: Bool): Unit
    {
        body(...)
        {
            for (i in 0..1)
            {
                REWIRENibbles(key[i][0][0][0..3], key[i][1][1][0..3], costing);
                REWIRENibbles(key[i][1][0][0..3], key[i][2][1][0..3], costing);
                REWIRENibbles(key[i][2][0][0..3], key[i][3][1][0..3], costing);
                REWIRENibbles(key[i][3][0][0..3], key[i][0][2][0..3], costing);    

                REWIRENibbles(key[i][0][1][0..3], key[i][1][2][0..3], costing);
                REWIRENibbles(key[i][1][1][0..3], key[i][2][2][0..3], costing);
                REWIRENibbles(key[i][2][1][0..3], key[i][3][2][0..3], costing);
                REWIRENibbles(key[i][3][1][0..3], key[i][0][3][0..3], costing); 
            }

            REWIRENibbles(key[0][0][2][0..3], key[0][1][3][0..3], costing);
            REWIRENibbles(key[0][1][2][0..3], key[0][2][3][0..3], costing);
            REWIRENibbles(key[0][2][2][0..3], key[0][3][3][0..3], costing);
            //REWIRENibbles(key[0][3][2][0..3], key[0][0][0][0..3], costing);

            REWIRENibbles(key[1][0][2][0..3], key[0][1][3][0..3], costing);
            REWIRENibbles(key[1][1][2][0..3], key[0][2][3][0..3], costing);
            REWIRENibbles(key[1][2][2][0..3], key[0][3][3][0..3], costing);
            //REWIRENibbles(key[1][3][2][0..3], key[0][0][0][0..3], costing);

            REWIRENibbles(key[2][0][2][0..3], key[0][1][3][0..3], costing);
            REWIRENibbles(key[2][1][2][0..3], key[0][2][3][0..3], costing);
            REWIRENibbles(key[2][2][2][0..3], key[0][3][3][0..3], costing);
            //REWIRENibbles(key[2][3][2][0..3], key[0][0][0][0..3], costing); 

            //REWIRENibbles(key[i][0][3][0..3], key[i][1][0][0..3], costing);
            //REWIRENibbles(key[i][1][3][0..3], key[i][2][0][0..3], costing);
            //REWIRENibbles(key[i][2][3][0..3], key[i][3][0][0..3], costing);
            //REWIRENibbles(key[i][3][3][0..3], key[i][0][1][0..3], costing);

            REWIRENibbles(key[0][3][2][0..3], key[0][3][3][0..3], costing);
            REWIRENibbles(key[1][3][2][0..3], key[1][3][3][0..3], costing);
            REWIRENibbles(key[2][3][2][0..3], key[2][3][3][0..3], costing);
            REWIRENibbles(key[3][3][2][0..3], key[3][3][3][0..3], costing);

            REWIRENibbles(key[0][0][3][0..3], key[0][3][3][0..3], costing);
            REWIRENibbles(key[1][0][3][0..3], key[1][3][3][0..3], costing);
            REWIRENibbles(key[2][0][3][0..3], key[2][3][3][0..3], costing);
            REWIRENibbles(key[3][0][3][0..3], key[3][3][3][0..3], costing);

            REWIRENibbles(key[0][1][3][0..3], key[0][3][3][0..3], costing);
            REWIRENibbles(key[1][1][3][0..3], key[1][3][3][0..3], costing);
            REWIRENibbles(key[2][1][3][0..3], key[2][3][3][0..3], costing);
            REWIRENibbles(key[3][1][3][0..3], key[3][3][3][0..3], costing);

            REWIRENibbles(key[0][2][3][0..3], key[0][3][3][0..3], costing);
            REWIRENibbles(key[1][2][3][0..3], key[1][3][3][0..3], costing);
            REWIRENibbles(key[2][2][3][0..3], key[2][3][3][0..3], costing);
            REWIRENibbles(key[3][2][3][0..3], key[3][3][3][0..3], costing);           
        }
        adjoint auto;
    }  

    operation SubKeyGeneration(key: Qubit[][][][], round: Int, costing: Bool) : Unit
    {
        body(...)
        {
            if(round % 2 == 1) 
            {
                if (round % 4 == 3)  // Upadting keys with round constants  
                {
                    AddRoundConstants(key, costing);   
                }
                elif (round % 4 == 1)    // Upadting keys (with rotation) with round constants    
                {
                    // Rotating the master key 
                    RotateKey(key, costing);
                    AddRoundConstants(key, costing);
                }
            }
        }  
        adjoint auto;
    }

    operation AddRoundKey(state : Qubit[][][][], key: Qubit[][][][]) : Unit
    {
        body(...)
        {
            // Xoring round key to the internal state 
            for (i in 0..3)
            {
                for (j in 0..3)
                {
                    for (k in 0..3) 
                    {
                        CNOTNibbles(state[i][j][k][0..3], key[i][j][k][0..3]); 
                    }
                }
            }
        }
        adjoint auto; 
    }
}

namespace QSATURNIN {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open QUtilities;

    operation Round(state: Qubit[][][][], key: Qubit[][][][], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            if (round == 0)
            {
                QSATURNIN.InPlace.AddRoundKey(state, key);
            }
            else
            {
                QSATURNIN.InPlace.SubCells(state, costing);  
                QSATURNIN.InPlace.NibblePermutation(state[0..3][0..3][0..3][0..3], round, costing);     
                QSATURNIN.InPlace.MixColumns(state, costing);  
                QSATURNIN.InPlace.InverseNibblePermutation(state, round, costing);      
                QSATURNIN.InPlace.SubKeyGeneration(key, round, costing);    
                QSATURNIN.InPlace.AddRoundKey(state, key);   
            }
        }
        adjoint auto; 
    }

    operation ForwardSATURNIN(key: Qubit[], state: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            for (i in 0..round)
            {
                Round([ 
                        [[state[0..3], state[16..19], state[32..35], state[48..51]],   
                        [state[4..7], state[20..23], state[36..39], state[52..55]],   
                        [state[8..11], state[24..27], state[40..43], state[56..59]],   
                        [state[12..15], state[28..31], state[44..47], state[60..63]]],  

                        [[state[64..67], state[80..83], state[96..99] , state[112..115]],   
                        [state[68..71], state[84..87], state[100..103] , state[116..119]],    
                        [state[72..75], state[88..91], state[104..107], state[120..123]],    
                        [state[76..79], state[92..95], state[108..111], state[124..127]]],  
 
                        [[state[128..131], state[144..147], state[160..163], state[176..179]],   
                        [state[132..135], state[148..151], state[164..167], state[180..183]],    
                        [state[136..139], state[152..155], state[168..171], state[184..187]],    
                        [state[140..143], state[156..159], state[172..175], state[188..191]]],  

                        [[state[192..195], state[208..211], state[224..227], state[240..243]],   
                        [state[196..199], state[212..215], state[228..231], state[244..247]],    
                        [state[200..203], state[216..219], state[232..235], state[248..251]],    
                        [state[204..207], state[220..223], state[236..239], state[252..255]]] 
                     ], 
                     [
                        [[key[0..3],key[16..19], key[32..35], key[48..51] ], 
                        [key[4..7], key[20..23], key[36..39], key[52..55]],  
                        [key[8..11], key[24..27], key[40..43], key[56..59]],  
                        [key[12..15], key[28..31], key[44..47], key[60..63]]],

                        [[key[64..67],key[80..83] ,key[96..99] , key[112..115]], 
                        [key[68..71], key[84..87],key[100..103] , key[116..119]],  
                        [key[72..75], key[88..91], key[104..107], key[120..123]],  
                        [key[76..79], key[92..95], key[108..111], key[124..127]]],

                        [[key[128..131],key[144..147], key[160..163], key[176..179]], 
                        [key[132..135], key[148..151], key[164..167], key[180..183]],  
                        [key[136..139], key[152..155], key[168..171], key[184..187]],  
                        [key[140..143], key[156..159], key[172..175], key[188..191]]],

                        [[key[192..195], key[208..211], key[224..227], key[240..243]], 
                        [key[196..199], key[212..215], key[228..231], key[244..247]],  
                        [key[200..203], key[216..219], key[232..235], key[248..251]],  
                        [key[204..207], key[220..223], key[236..239], key[252..255]]]

                     ], i, costing); 
            } 
        }
        adjoint auto;
    } 

    operation SATURNIN(key: Qubit[], state: Qubit[], ciphertext: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            ForwardSATURNIN(key, state, round, costing); 

            // copy resulting ciphertext out

            for (i in 0..63)
            {
                CNOTNibbles(state[(4*i)..4*(i+1)-1], ciphertext[(4*i)..4*(i+1)-1]); 
            }

            (Adjoint ForwardSATURNIN)(key, state, round, costing); 
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

            // compute SKINNY encryption of the i-th target message
            for (i in 0..(pairs-1))
            {
                let state = plaintext[(i*256)..((i+1)*256-1)]; //+ (state_ancillas[(i*256*round)..((i+1)*256*round-1)]); 
                let key = i == 0 ? key_superposition | other_keys[((i-1)*256)..(i*256-1)];
                ForwardSATURNIN(key, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[256*(pairs-1)], Qubit[256*round*pairs])) 
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

                mutable ciphertext = state_ancillas[(256*round-256)..(256*round-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*256*round-256)..((i+1)*256*round-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }

}
