// Copyright (c) IIT Ropar.
// Licensed under the free license.

namespace QSKINNY.InPlace // Implementing InPlace-SKINNY round functions : SubCells, AddConstants, AddRoundTweakey, ShiftRows, MixColumns 
{
    open Microsoft.Quantum.Intrinsic; 
    open QUtilities; 
    open Microsoft.Quantum.Math; 
    open Microsoft.Quantum.Convert; 
     
    operation SkinnySbox(a: Qubit[], costing: Bool): Unit
    { 
        body(...) 
        { 
            // Just trying to comment here  
            X(a[2]); 
            X(a[3]); 
            ccnot(a[2], a[3], a[0], costing); // t1 
            X(a[3]); 

            X(a[1]); 
            //X(a[2]); 
            ccnot(a[1], a[2], a[3], costing);  // t3
            X(a[2]); 

            X(a[0]); 
            //X(a[1]); 
            ccnot(a[0], a[1], a[2], costing); // t5
            X(a[1]);  

            //X(a[0]);
            X(a[3]);
            ccnot(a[0], a[3], a[2], costing); // t7
            X(a[0]);
            X(a[3]);

            REWIRE(a[0], a[1], costing);
            REWIRE(a[1], a[2], costing);
            REWIRE(a[2], a[3], costing);
        }
        adjoint auto;
    }

    operation SubCells(state: Qubit[][], costing: Bool) : Unit
    {
        body (...)
        {
            for (i in 0..3)
            {
                for (j in 0..3)
                {   
                    SkinnySbox(state[j][(i*4)..((i+1)*4-1)], costing); 
                }
            }
        }
        adjoint auto;
    }

    operation AddConstants(state: Qubit[][], round: Int, costing: Bool): Unit
    {
        body(...)
        {
            
            // 1 - 16  : 01,03,07,0F,1F,3E,3D,3B,37,2F,1E,3C,39,33,27,0E  
            // 17 - 32 : 1D,3A,35,2B,16,2C,18,30,21,02,05,0B,17,2E,1C,38   
            // 33 - 48 : 31,23,06,0D,1B,36,2D,1A,34,29,12,24,08,11,22,04  
            // 49 - 62 : 09,13,26,0C,19,32,25,0A,15,2A,14,28,10,20
            if (round == 1) 
            {
                // >>> bin(0x01) = '000001' 
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);

                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 2)
            {
                // >>> bin(0x03) == '000011'
                X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 3)
            {
                // >>> bin(0x07) == '000111'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 4)
            {
                // >>> bin(0x0F) == '001111'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 5)
            {
                // >>> bin(0x1F) == '011111'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 6)
            {
                // >>> bin(0x3E) == '111110'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 7)
            {
                // >>> bin(0x3D) == '111101'
                X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 8)
            {
                // >>> bin(0x3B) == '111011'
                X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]); 
                X(state[1][1]); 
            }
            elif (round == 9)
            {
                // >>> bin(0x37) == '110111'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 10)
            {
                // >>> bin(0x2F) == '101111'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 11)
            {
                // >>> bin(0x1E) == '011110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 12)
            {
                // >>> bin(0x3C) == '111100'
                //X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 13)
            {
                // >>> bin(0x39) == '111001'
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 14)
            {
                // >>> bin(0x33) == '110011'
                X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                //(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 15)
            {
                // >>> bin(0x27) == '100111'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 16)
            {
                // >>> bin(0x0E) == '001110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 17)
            {
                // >>> bin(0x1D) == '011101'
                X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]);
            }
            elif (round == 18)
            {
                // >>> bin(0x3A) == '111010'
                //X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 19)
            {
                // >>> bin(0x35) == '110110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 20)
            {
                // >>> bin(0x2B) == '101011'
                X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 21)
            {
                // >>> bin(0x16) == '010110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 22)
            {
                // >>> bin(0x2C) == '101100'
                //X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 23)
            {
                // >>> bin(0x18) == '011000'
                //X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]);
            }
            elif (round == 24)
            {
                // >>> bin(0x30) == '110000'
                //X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]);  
            }
            elif (round == 25)
            {
                // >>> bin(0x21) == '100001'
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 26)
            {
                // >>> bin(0x02) == '000010'
                //X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 27)
            {
                // >>> bin(0x05) == '000101'
                X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 28)
            {
                // >>> bin(0x0B) == '001011'
                X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 29)
            {
                // >>> bin(0x17) == '010111'
                X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 30)
            {
                // >>> bin(0x2E) == '101110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 31)
            {
                // >>> bin(0x1C) == '011100'
                //X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]);
            }
            elif (round == 32)
            {
                // >>> bin(0x38) == '111000'
                //X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]);  
            }
            elif (round == 33)
            {
                // >>> bin(0x31) == '110001'
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 34)
            {
                // >>> bin(0x23) == '100011'
                X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 35)
            {
                // >>> bin(0x06) == '000110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 36)
            {
                // >>> bin(0x0D) == '001101'
                X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 37)
            {
                // >>> bin(0x1B) == '011011'
                X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 38)
            {
                // >>> bin(0x36) == '110110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 39)
            {
                // >>> bin(0x2D) == '101101'
                X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 40)
            {
                // >>> bin(0x1A) == '011010'
                //X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 41)
            {
                // >>> bin(0x34) == '110100'
                //X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]);  
            }
            elif (round == 42)
            {
                // >>> bin(0x29) == '101001'
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 43)
            {
                // >>> bin(0x12) == '010010'
                //X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 44)
            {
                // >>> bin(0x24) == '100100'
                //X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 45)
            {
                // >>> bin(0x08) == '001000'
                //X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 46)
            {
                // >>> bin(0x11) == '010001'
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 47)
            {
                // >>> bin(0x22) == '100010'
                //X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 48)
            {
                // >>> bin(0x04) == '000100'
                //X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 49)
            {
                // >>> bin(0x09) == '001001'
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 50)
            {
                // >>> bin(0x13) == '011101'
                X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 51)
            {
                // >>> bin(0x26) == '100110'
                //X(state[0][0]);
                X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 52)
            {
                // >>> bin(0x0C) == '001100'
                //X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }
            elif (round == 53)
            {
                // >>> bin(0x19) == '011001'
                X(state[0][0]);
                //X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                X(state[1][0]);
                //X(state[1][1]);
            }
            elif (round == 54)
            {
                // >>> bin(0x32) == '110010'
                //X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                //X(state[0][3]);
                
                X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 55)
            {
                // >>> bin(0x25) == '100101'
                X(state[0][0]);
                //X(state[0][1]);
                X(state[0][2]);
                //X(state[0][3]);
                
                //X(state[1][0]);
                X(state[1][1]); 
            }
            elif (round == 56)
            {
                // >>> bin(0x0A) == '001010'
                //X(state[0][0]);
                X(state[0][1]);
                //X(state[0][2]);
                X(state[0][3]);
                
                //X(state[1][0]);
                //X(state[1][1]); 
            }  
            X(state[2][1]);
        }
        adjoint auto;
    }

    operation AddRoundTweakey(state: Qubit[][], tweakey: Qubit[]) : Unit 
    {
        body (...)
        {
            // (tweakey size) z = t/n   
            // t = n, 2n, 3n thus z = 1,2,3 
            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    CNOTNibbles(tweakey[(4*i+j..4*i+j+3)], state[i][(4*j..4*j+3)]); 
                }
            }
        }
        adjoint auto; 
    }

    operation AddRoundTweakey_z2(state: Qubit[][], tweakey_1: Qubit[], tweakey_2: Qubit[]) : Unit 
    {
        body (...)
        {
            // (tweakey size) z = t/n   
            // t = n, 2n, 3n thus z = 1,2,3 

            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    CNOTNibbles(tweakey_1[4*i+j..4*i+j+3], tweakey_2[4*i+j..4*i+j+3]);
                }
            }
            for (i in 0..1) 
            {
                for (j in 0..3)
                {
                    CNOTNibbles(tweakey_2[(4*i+j..4*i+j+3)], state[i][(4*j..4*j+3)]); 
                }
            }

        }
        adjoint auto; 
    }

    operation AddRoundTweakey_z3(state: Qubit[][], tweakey_1: Qubit[], tweakey_2: Qubit[], tweakey_3: Qubit[]) : Unit 
    {
        body (...)
        {
            // (tweakey size) z = t/n   
            // t = n, 2n, 3n thus z = 1,2,3 

            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    CNOTNibbles(tweakey_1[4*i+j..4*i+j+3], tweakey_2[4*i+j..4*i+j+3]);
                }
            }
            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    CNOTNibbles(tweakey_2[4*i+j..4*i+j+3], tweakey_3[4*i+j..4*i+j+3]);
                }
            }
            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    CNOTNibbles(tweakey_3[(4*i+j..4*i+j+3)], state[i][(4*j..4*j+3)]);
                }
            }
        }
        adjoint auto; 
    }

    operation TweakeyUpdate(tweakey: Qubit[], round: Int, costing: Bool) : Unit
    {
        body(...)
        {
            //we have s = 8 for the 128-bit block SKINNY versions
            // mutable PT = [9, 15, 8, 13, 10, 14, 12, 11, 0, 1, 2, 3, 4, 5, 6, 7];
            
            //|0 4 8  12|  = |9  10 0 4|
            //|1 5 9  13|  = |15 14 1 5|
            //|2 6 10 14|  = |8  12 0 6|
            //|3 7 11 15|  = |13 11 3 7|

            //|0  1  2  3 |  = |9  15 8  13|
            //|4  5  6  7 |  = |10 14 12 11|
            //|8  9  10 11|  = |0  1  2  3 |
            //|12 13 14 15|  = |4  5  6  7 |
            
            REWIREBytes(tweakey[0*4..1*4-1],  tweakey[9*4..10*4-1],  costing);
            REWIREBytes(tweakey[1*4..2*4-1],  tweakey[15*4..16*4-1], costing);
            REWIREBytes(tweakey[2*4..3*4-1],  tweakey[8*4..9*4-1],  costing);
            REWIREBytes(tweakey[3*4..4*4-1],  tweakey[13*4..14*4-1], costing);
            REWIREBytes(tweakey[4*4..5*4-1],  tweakey[10*4..11*4-1], costing);
            REWIREBytes(tweakey[5*4..6*4-1],  tweakey[14*4..15*4-1], costing);
            REWIREBytes(tweakey[6*4..7*4-1],  tweakey[12*4..13*4-1], costing);
            REWIREBytes(tweakey[7*4..8*4-1],  tweakey[11*4..12*4-1], costing);
            REWIREBytes(tweakey[8*4..9*4-1],  tweakey[0*4..1*4-1],  costing);
            REWIREBytes(tweakey[9*4..10*4-1],  tweakey[1*4..2*4-1],  costing);
            REWIREBytes(tweakey[10*4..11*4-1], tweakey[2*4..3*4-1],  costing);
            REWIREBytes(tweakey[11*4..12*4-1], tweakey[3*4..4*4-1],  costing);
            REWIREBytes(tweakey[12*4..13*4-1], tweakey[4*4..5*4-1],  costing);
            REWIREBytes(tweakey[13*4..14*4-1], tweakey[5*4..6*4-1],  costing);
            REWIREBytes(tweakey[14*4..15*4-1], tweakey[6*4..7*4-1],  costing);
            REWIREBytes(tweakey[15*4..16*4-1], tweakey[7*4..8*4-1],  costing);  
        }
        adjoint auto;   
    }

    operation TweakeyUpdate_2(tweakey: Qubit[], round: Int, costing: Bool) : Unit
    {
        body(...)
        {
            //we have s = 8 for the 128-bit block SKINNY versions
            // mutable PT = [9, 15, 8, 13, 10, 14, 12, 11, 0, 1, 2, 3, 4, 5, 6, 7];
            
            //|0 4 8  12|  = |9  10 0 4|
            //|1 5 9  13|  = |15 14 1 5|
            //|2 6 10 14|  = |8  12 0 6|
            //|3 7 11 15|  = |13 11 3 7|

            //|0  1  2  3 |  = |9  15 8  13|
            //|4  5  6  7 |  = |10 14 12 11|
            //|8  9  10 11|  = |0  1  2  3 |
            //|12 13 14 15|  = |4  5  6  7 |
            
            REWIREBytes(tweakey[0*4..1*4-1],  tweakey[9*4..10*4-1],  costing);
            REWIREBytes(tweakey[1*4..2*4-1],  tweakey[15*4..16*4-1], costing);
            REWIREBytes(tweakey[2*4..3*4-1],  tweakey[8*4..9*4-1],  costing);
            REWIREBytes(tweakey[3*4..4*4-1],  tweakey[13*4..14*4-1], costing);
            REWIREBytes(tweakey[4*4..5*4-1],  tweakey[10*4..11*4-1], costing);
            REWIREBytes(tweakey[5*4..6*4-1],  tweakey[14*4..15*4-1], costing);
            REWIREBytes(tweakey[6*4..7*4-1],  tweakey[12*4..13*4-1], costing);
            REWIREBytes(tweakey[7*4..8*4-1],  tweakey[11*4..12*4-1], costing);
            REWIREBytes(tweakey[8*4..9*4-1],  tweakey[0*4..1*4-1],  costing);
            REWIREBytes(tweakey[9*4..10*4-1],  tweakey[1*4..2*4-1],  costing);
            REWIREBytes(tweakey[10*4..11*4-1], tweakey[2*4..3*4-1],  costing);
            REWIREBytes(tweakey[11*4..12*4-1], tweakey[3*4..4*4-1],  costing);
            REWIREBytes(tweakey[12*4..13*4-1], tweakey[4*4..5*4-1],  costing);
            REWIREBytes(tweakey[13*4..14*4-1], tweakey[5*4..6*4-1],  costing);
            REWIREBytes(tweakey[14*4..15*4-1], tweakey[6*4..7*4-1],  costing);
            REWIREBytes(tweakey[15*4..16*4-1], tweakey[7*4..8*4-1],  costing);  

            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    REWIRE(tweakey[4*i+j+0],  tweakey[4*i+j+3],  costing);
                    REWIRE(tweakey[4*i+j+3],  tweakey[4*i+j+2],  costing);
                    REWIRE(tweakey[4*i+j+2],  tweakey[4*i+j+1],  costing);
                    CNOT(tweakey[4*i+j+3],  tweakey[4*i+j+0]);
                }
            }  
        }
        adjoint auto;   
    }

    operation TweakeyUpdate_3(tweakey: Qubit[], round: Int, costing: Bool) : Unit
    {
        body(...)
        {
            //we have s = 8 for the 128-bit block SKINNY versions
            // mutable PT = [9, 15, 8, 13, 10, 14, 12, 11, 0, 1, 2, 3, 4, 5, 6, 7];
            
            //|0 4 8  12|  = |9  10 0 4|
            //|1 5 9  13|  = |15 14 1 5|
            //|2 6 10 14|  = |8  12 0 6|
            //|3 7 11 15|  = |13 11 3 7|

            //|0  1  2  3 |  = |9  15 8  13|
            //|4  5  6  7 |  = |10 14 12 11|
            //|8  9  10 11|  = |0  1  2  3 |
            //|12 13 14 15|  = |4  5  6  7 |
            
            REWIREBytes(tweakey[0*4..1*4-1],  tweakey[9*4..10*4-1],  costing);
            REWIREBytes(tweakey[1*4..2*4-1],  tweakey[15*4..16*4-1], costing);
            REWIREBytes(tweakey[2*4..3*4-1],  tweakey[8*4..9*4-1],  costing);
            REWIREBytes(tweakey[3*4..4*4-1],  tweakey[13*4..14*4-1], costing);
            REWIREBytes(tweakey[4*4..5*4-1],  tweakey[10*4..11*4-1], costing);
            REWIREBytes(tweakey[5*4..6*4-1],  tweakey[14*4..15*4-1], costing);
            REWIREBytes(tweakey[6*4..7*4-1],  tweakey[12*4..13*4-1], costing);
            REWIREBytes(tweakey[7*4..8*4-1],  tweakey[11*4..12*4-1], costing);
            REWIREBytes(tweakey[8*4..9*4-1],  tweakey[0*4..1*4-1],  costing);
            REWIREBytes(tweakey[9*4..10*4-1],  tweakey[1*4..2*4-1],  costing);
            REWIREBytes(tweakey[10*4..11*4-1], tweakey[2*4..3*4-1],  costing);
            REWIREBytes(tweakey[11*4..12*4-1], tweakey[3*4..4*4-1],  costing);
            REWIREBytes(tweakey[12*4..13*4-1], tweakey[4*4..5*4-1],  costing);
            REWIREBytes(tweakey[13*4..14*4-1], tweakey[5*4..6*4-1],  costing);
            REWIREBytes(tweakey[14*4..15*4-1], tweakey[6*4..7*4-1],  costing);
            REWIREBytes(tweakey[15*4..16*4-1], tweakey[7*4..8*4-1],  costing);   
        
            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    REWIRE(tweakey[4*i+j+1],  tweakey[4*i+j+0],  costing);
                    REWIRE(tweakey[4*i+j+2],  tweakey[4*i+j+1],  costing);
                    REWIRE(tweakey[4*i+j+3],  tweakey[4*i+j+2],  costing);
                    CNOT(tweakey[4*i+j+2],  tweakey[4*i+j+3]); 
                }
            }
        }
        adjoint auto;   
    }

    // P = [0, 1, 2, 3, 7, 4, 5, 6, 10, 11, 8, 9, 13, 14, 15, 12]
    operation ShiftRows(state: Qubit[][], costing: Bool) : Unit
    {
        body (...)
        {
            // state is an array of four columns wide one qbit
            // and long 32 qbits. each stretch of 8 qubits makes 
            // one of the four qubytes of the word

            // first row stays where it is

            // second is rotated left by 1
            REWIREBytes(state[0][(4*1)..(4*2-1)], state[1][(4*1)..(4*2-1)], costing);
            REWIREBytes(state[1][(4*1)..(4*2-1)], state[2][(4*1)..(4*2-1)], costing);
            REWIREBytes(state[2][(4*1)..(4*2-1)], state[3][(4*1)..(4*2-1)], costing);

            // third is rotated left by 2
            REWIREBytes(state[0][(4*2)..(4*3-1)], state[2][(4*2)..(4*3-1)], costing);
            REWIREBytes(state[1][(4*2)..(4*3-1)], state[3][(4*2)..(4*3-1)], costing);

            // fourth is rotated left by 3
            REWIREBytes(state[2][(4*3)..(4*4-1)], state[3][(4*3)..(4*4-1)], costing);
            REWIREBytes(state[1][(4*3)..(4*4-1)], state[2][(4*3)..(4*4-1)], costing);
            REWIREBytes(state[0][(4*3)..(4*4-1)], state[1][(4*3)..(4*4-1)], costing);
        }
        adjoint auto;
    }


    operation MixHalfWord(state: Qubit[], costing: Bool) : Unit
    {
        body (...)
        {
            // Upper triangular matrix -- Skinny-64  
            CNOT(state[8], state[0]);
            CNOT(state[12], state[0]);
            CNOT(state[9], state[1]);
            CNOT(state[13], state[1]);
            CNOT(state[10], state[2]);
            CNOT(state[14], state[2]);
            CNOT(state[11], state[3]);
            CNOT(state[15], state[3]);
            CNOT(state[8], state[4]);
            CNOT(state[9], state[5]);
            CNOT(state[10], state[6]);
            CNOT(state[11], state[7]);
            CNOT(state[12], state[8]);
            CNOT(state[13], state[9]);
            CNOT(state[14], state[10]);
            CNOT(state[15], state[11]); 

            // Lower triangular matrix -- Skinny-64  
            CNOT(state[3], state[15]);
            CNOT(state[2], state[14]);
            CNOT(state[1], state[13]);
            CNOT(state[0], state[12]); 
            CNOT(state[3], state[11]); 
            CNOT(state[2], state[10]);
            CNOT(state[1], state[9]);
            CNOT(state[0], state[8]); 

            // Permutation matrix -- Skinny-64  
            REWIRE(state[4], state[8], costing);
            REWIRE(state[5], state[9], costing);
            REWIRE(state[6], state[10], costing);
            REWIRE(state[7], state[11], costing);  
        }
        adjoint auto;
    }

    operation MixColumns(state: Qubit[][], costing: Bool) : Unit 
    {
        body (...)
        {
            for (j in 0..3)
            {
                MixHalfWord(state[j], costing); 
            }
        }
        adjoint auto;
    }
}

namespace QSKINNY_64_64 { 
    open Microsoft.Quantum.Intrinsic;  
    open Microsoft.Quantum.Canon;  
    open QUtilities; 

    
    operation Round(state: Qubit[][], tweakey: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            QSKINNY.InPlace.SubCells(state, costing);  
            QSKINNY.InPlace.AddConstants(state, round, costing); 
            QSKINNY.InPlace.AddRoundTweakey(state, tweakey);    
            QSKINNY.InPlace.TweakeyUpdate(tweakey, round, costing);        
            QSKINNY.InPlace.ShiftRows(state, costing);        
            QSKINNY.InPlace.MixColumns(state, costing);  
        }
        adjoint auto; 
    }

    operation ForwardSkinny(tweakey: Qubit[], state: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            for (i in 1..round)
            {
                Round([state[(0*16)..(1*16 - 1)],
                       state[(1*16)..(2*16 - 1)],
                       state[(2*16)..(3*16 - 1)],
                       state[(3*16)..(4*16 - 1)]],
                       tweakey, i, costing); 
            } 
        }
        adjoint auto;
    } 

    operation Skinny(tweakey: Qubit[], state: Qubit[], ciphertext: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            ForwardSkinny(tweakey, state, round, costing); 

            // copy resulting ciphertext out
            //CNOTnBits(state[(0)..(64)], ciphertext[0..64], 64);  
            
            CNOTnBits(state[(0*16)..(1*16 - 1)], ciphertext[0..15], 16);
            CNOTnBits(state[(1*16)..(2*16 - 1)], ciphertext[16..31], 16);
            CNOTnBits(state[(2*16)..(3*16 - 1)], ciphertext[32..47], 16);
            CNOTnBits(state[(3*16)..(4*16 - 1)], ciphertext[48..63], 16); 

            (Adjoint ForwardSkinny)(tweakey, state, round, costing); 
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
                CNOTnBits(key_superposition, other_keys[(i*64)..((i+1)*64-1)], 64); 
            } 

            // compute SKINNY encryption of the i-th target message
            for (i in 0..(pairs-1))
            {
                let state = plaintext[(i*64)..((i+1)*64-1)] + (state_ancillas[(i*64*round)..((i+1)*64*round-1)]); 
                let tweakey = i == 0 ? key_superposition | other_keys[((i-1)*64)..(i*64-1)];
                ForwardSkinny(tweakey, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[64*(pairs-1)], Qubit[64*round*pairs])) 
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

                mutable ciphertext = state_ancillas[(64*round-64)..(64*round-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*64*round-64)..((i+1)*64*round-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }
}

namespace QSKINNY_64_128 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open QUtilities;

    
    operation Round(state: Qubit[][], tweakey_1: Qubit[], tweakey_2: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            QSKINNY.InPlace.SubCells(state, costing);  
            QSKINNY.InPlace.AddConstants(state, round, costing); 
            //QSKINNY.InPlace.AddRoundTweakey(state, tweakey_1);   
            QSKINNY.InPlace.AddRoundTweakey_z2(state, tweakey_1, tweakey_2);   
            QSKINNY.InPlace.TweakeyUpdate(tweakey_1, round, costing); 
            QSKINNY.InPlace.TweakeyUpdate_2(tweakey_2, round, costing); 
            QSKINNY.InPlace.ShiftRows(state, costing);        
            QSKINNY.InPlace.MixColumns(state, costing);  
        }
        adjoint auto; 
    }

    operation ForwardSkinny(tweakey_1: Qubit[], tweakey_2: Qubit[], state: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            for (i in 1..round)
            {
                Round([state[(0*16)..(1*16 - 1)],
                       state[(1*16)..(2*16 - 1)],
                       state[(2*16)..(3*16 - 1)],
                       state[(3*16)..(4*16 - 1)]],
                       tweakey_1, tweakey_2, i, costing); 
            } 
        }
        adjoint auto;
    } 

    operation Skinny(tweakey_1: Qubit[], tweakey_2: Qubit[], state: Qubit[], ciphertext: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            ForwardSkinny(tweakey_1, tweakey_2, state, round, costing); 

            // copy resulting ciphertext out
            //CNOTnBits(state[(0)..(64)], ciphertext[0..64], 64);  
            
            CNOTnBits(state[(0*16)..(1*16 - 1)], ciphertext[0..15], 16);
            CNOTnBits(state[(1*16)..(2*16 - 1)], ciphertext[16..31], 16);
            CNOTnBits(state[(2*16)..(3*16 - 1)], ciphertext[32..47], 16);
            CNOTnBits(state[(3*16)..(4*16 - 1)], ciphertext[48..63], 16);

            (Adjoint ForwardSkinny)(tweakey_1, tweakey_2, state, round, costing); 
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
                let state = plaintext[(i*64)..((i+1)*64-1)] + (state_ancillas[(i*64*round)..((i+1)*64*round-1)]); 
                let tweakey = i == 0 ? key_superposition | other_keys[((i-1)*128)..(i*128-1)];
                let tweakey_1 = tweakey[0..63];
                let tweakey_2 = tweakey[64..127];
                ForwardSkinny(tweakey_1, tweakey_2, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[128*(pairs-1)], Qubit[64*round*pairs])) 
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

                mutable ciphertext = state_ancillas[(64*round-64)..(64*round-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*64*round-64)..((i+1)*64*round-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }

}

namespace QSKINNY_64_192 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open QUtilities;

    
    operation Round(state: Qubit[][], tweakey_1: Qubit[], tweakey_2: Qubit[], tweakey_3: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            QSKINNY.InPlace.SubCells(state, costing);  
            QSKINNY.InPlace.AddConstants(state, round, costing); 
            //QSKINNY.InPlace.AddRoundTweakey(state, tweakey);   
            //QSKINNY.InPlace.AddRoundTweakey_z2(state, tweakey_1);   
            QSKINNY.InPlace.AddRoundTweakey_z3(state, tweakey_1, tweakey_2, tweakey_3);    
            QSKINNY.InPlace.TweakeyUpdate(tweakey_1, round, costing); 
            QSKINNY.InPlace.TweakeyUpdate_2(tweakey_2, round, costing); 
            QSKINNY.InPlace.TweakeyUpdate_3(tweakey_3, round, costing);        
            QSKINNY.InPlace.ShiftRows(state, costing);        
            QSKINNY.InPlace.MixColumns(state, costing);  
        }
        adjoint auto; 
    }

    operation ForwardSkinny(tweakey_1: Qubit[], tweakey_2: Qubit[], tweakey_3: Qubit[], state: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            for (i in 1..round)
            {
                Round([state[(0*16)..(1*16 - 1)],
                       state[(1*16)..(2*16 - 1)],
                       state[(2*16)..(3*16 - 1)],
                       state[(3*16)..(4*16 - 1)]],
                       tweakey_1, tweakey_2, tweakey_3, i, costing); 
            } 
        }
        adjoint auto;
    } 

    operation Skinny(tweakey_1: Qubit[], tweakey_2: Qubit[], tweakey_3: Qubit[], state: Qubit[], ciphertext: Qubit[], round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            ForwardSkinny(tweakey_1, tweakey_2, tweakey_3, state, round, costing); 

            // copy resulting ciphertext out
            //CNOTnBits(state[(0)..(64)], ciphertext[0..64], 64);  
            
            CNOTnBits(state[(0*16)..(1*16 - 1)], ciphertext[0..15], 16);
            CNOTnBits(state[(1*16)..(2*16 - 1)], ciphertext[16..31], 16);
            CNOTnBits(state[(2*16)..(3*16 - 1)], ciphertext[32..47], 16);
            CNOTnBits(state[(3*16)..(4*16 - 1)], ciphertext[48..63], 16);

            (Adjoint ForwardSkinny)(tweakey_1, tweakey_2, tweakey_3, state, round, costing); 
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
                CNOTnBits(key_superposition, other_keys[(i*192)..((i+1)*192-1)], 192); 
            }

            // compute SKINNY encryption of the i-th target message
            for (i in 0..(pairs-1))
            {
                let state = plaintext[(i*64)..((i+1)*64-1)] + (state_ancillas[(i*64*round)..((i+1)*64*round-1)]); 
                let tweakey = i == 0 ? key_superposition | other_keys[((i-1)*192)..(i*192-1)];
                let tweakey_1 = tweakey[0..63];
                let tweakey_2 = tweakey[64..127];
                let tweakey_3 = tweakey[128..191];
                ForwardSkinny(tweakey_1, tweakey_2, tweakey_3, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[192*(pairs-1)], Qubit[64*round*pairs])) 
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

                mutable ciphertext = state_ancillas[(64*round-64)..(64*round-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*64*round-64)..((i+1)*64*round-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }

}
