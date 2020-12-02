// Copyright (c) 2020 IIT Ropar.
// Licensed under MIT license.

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
            X(a[6]); 
            X(a[7]); 
            ccnot(a[6], a[7], a[4], costing); // t1 

            X(a[2]); 
            X(a[3]); 
            ccnot(a[2], a[3], a[0], costing);  // t3

            X(a[6]); 
            X(a[7]);
            X(a[1]); 
            ccnot(a[1], a[2], a[6], costing); // t5 

            X(a[0]);
            X(a[1]);
            X(a[2]);
            X(a[4]);
            ccnot(a[0], a[4], a[5], costing); // t7

            ccnot(a[0], a[3], a[1], costing); // t9

            X(a[0]);
            X(a[3]);
            X(a[5]);
            X(a[6]);
            ccnot(a[5], a[6], a[7], costing); // t11

            X(a[6]);
            ccnot(a[5], a[4], a[3], costing); // t13

            X(a[1]);
            X(a[4]);
            X(a[5]);
            X(a[7]);
            ccnot(a[1], a[7], a[2], costing); // t15
            X(a[7]);
            X(a[1]);

            REWIRE(a[0], a[2], costing);
            REWIRE(a[1], a[7], costing);
            REWIRE(a[2], a[6], costing);
            REWIRE(a[3], a[7], costing);
            REWIRE(a[4], a[7], costing);
            REWIRE(a[5], a[6], costing);
            REWIRE(a[6], a[7], costing);
            
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
                    SkinnySbox(state[j][(i*8)..((i+1)*8-1)], costing); 
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
                    CNOTBytes(tweakey[(8*i+j..8*i+j+7)], state[i][(8*j..8*j+7)]);
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
                    CNOTBytes(tweakey_1[8*i+j..8*i+j+7], tweakey_2[8*i+j..8*i+j+7]);
                }
            }
            for (i in 0..1) 
            {
                for (j in 0..3)
                {
                    CNOTBytes(tweakey_2[(8*i+j..8*i+j+7)], state[i][(8*j..8*j+7)]);
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
                    CNOTBytes(tweakey_1[8*i+j..8*i+j+7], tweakey_2[8*i+j..8*i+j+7]);
                }
            }
            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    CNOTBytes(tweakey_2[8*i+j..8*i+j+7], tweakey_3[8*i+j..8*i+j+7]);
                }
            }
            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    CNOTBytes(tweakey_3[(8*i+j..8*i+j+7)], state[i][(8*j..8*j+7)]);
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
            
            REWIREBytes(tweakey[0*8..1*8-1],  tweakey[9*8..10*8-1],  costing);
            REWIREBytes(tweakey[1*8..2*8-1],  tweakey[15*8..16*8-1], costing);
            REWIREBytes(tweakey[2*8..3*8-1],  tweakey[8*8..9*8-1],  costing);
            REWIREBytes(tweakey[3*8..4*8-1],  tweakey[13*8..14*8-1], costing);
            REWIREBytes(tweakey[4*8..5*8-1],  tweakey[10*8..11*8-1], costing);
            REWIREBytes(tweakey[5*8..6*8-1],  tweakey[14*8..15*8-1], costing);
            REWIREBytes(tweakey[6*8..7*8-1],  tweakey[12*8..13*8-1], costing);
            REWIREBytes(tweakey[7*8..8*8-1],  tweakey[11*8..12*8-1], costing);
            REWIREBytes(tweakey[8*8..9*8-1],  tweakey[0*8..1*8-1],  costing);
            REWIREBytes(tweakey[9*8..10*8-1],  tweakey[1*8..2*8-1],  costing);
            REWIREBytes(tweakey[10*8..11*8-1], tweakey[2*8..3*8-1],  costing);
            REWIREBytes(tweakey[11*8..12*8-1], tweakey[3*8..4*8-1],  costing);
            REWIREBytes(tweakey[12*8..13*8-1], tweakey[4*8..5*8-1],  costing);
            REWIREBytes(tweakey[13*8..14*8-1], tweakey[5*8..6*8-1],  costing);
            REWIREBytes(tweakey[14*8..15*8-1], tweakey[6*8..7*8-1],  costing);
            REWIREBytes(tweakey[15*8..16*8-1], tweakey[7*8..8*8-1],  costing);  
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
            
            REWIREBytes(tweakey[0*8..1*8-1],  tweakey[9*8..10*8-1],  costing);
            REWIREBytes(tweakey[1*8..2*8-1],  tweakey[15*8..16*8-1], costing);
            REWIREBytes(tweakey[2*8..3*8-1],  tweakey[8*8..9*8-1],  costing);
            REWIREBytes(tweakey[3*8..4*8-1],  tweakey[13*8..14*8-1], costing);
            REWIREBytes(tweakey[4*8..5*8-1],  tweakey[10*8..11*8-1], costing);
            REWIREBytes(tweakey[5*8..6*8-1],  tweakey[14*8..15*8-1], costing);
            REWIREBytes(tweakey[6*8..7*8-1],  tweakey[12*8..13*8-1], costing);
            REWIREBytes(tweakey[7*8..8*8-1],  tweakey[11*8..12*8-1], costing);
            REWIREBytes(tweakey[8*8..9*8-1],  tweakey[0*8..1*8-1],  costing);
            REWIREBytes(tweakey[9*8..10*8-1],  tweakey[1*8..2*8-1],  costing);
            REWIREBytes(tweakey[10*8..11*8-1], tweakey[2*8..3*8-1],  costing);
            REWIREBytes(tweakey[11*8..12*8-1], tweakey[3*8..4*8-1],  costing);
            REWIREBytes(tweakey[12*8..13*8-1], tweakey[4*8..5*8-1],  costing);
            REWIREBytes(tweakey[13*8..14*8-1], tweakey[5*8..6*8-1],  costing);
            REWIREBytes(tweakey[14*8..15*8-1], tweakey[6*8..7*8-1],  costing);
            REWIREBytes(tweakey[15*8..16*8-1], tweakey[7*8..8*8-1],  costing);

            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    REWIRE(tweakey[8*i+j+0],  tweakey[8*i+j+7],  costing);
                    REWIRE(tweakey[8*i+j+7],  tweakey[8*i+j+6],  costing);
                    REWIRE(tweakey[8*i+j+6],  tweakey[8*i+j+5],  costing);
                    REWIRE(tweakey[8*i+j+5],  tweakey[8*i+j+4],  costing);
                    REWIRE(tweakey[8*i+j+4],  tweakey[8*i+j+3],  costing);
                    REWIRE(tweakey[8*i+j+3],  tweakey[8*i+j+2],  costing);
                    REWIRE(tweakey[8*i+j+2],  tweakey[8*i+j+1],  costing);
                    CNOT(tweakey[8*i+j+6],  tweakey[8*i+j+0]);
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
            
            REWIREBytes(tweakey[0*8..1*8-1],  tweakey[9*8..10*8-1],  costing);
            REWIREBytes(tweakey[1*8..2*8-1],  tweakey[15*8..16*8-1], costing);
            REWIREBytes(tweakey[2*8..3*8-1],  tweakey[8*8..9*8-1],  costing);
            REWIREBytes(tweakey[3*8..4*8-1],  tweakey[13*8..14*8-1], costing);
            REWIREBytes(tweakey[4*8..5*8-1],  tweakey[10*8..11*8-1], costing);
            REWIREBytes(tweakey[5*8..6*8-1],  tweakey[14*8..15*8-1], costing);
            REWIREBytes(tweakey[6*8..7*8-1],  tweakey[12*8..13*8-1], costing);
            REWIREBytes(tweakey[7*8..8*8-1],  tweakey[11*8..12*8-1], costing);
            REWIREBytes(tweakey[8*8..9*8-1],  tweakey[0*8..1*8-1],  costing);
            REWIREBytes(tweakey[9*8..10*8-1],  tweakey[1*8..2*8-1],  costing);
            REWIREBytes(tweakey[10*8..11*8-1], tweakey[2*8..3*8-1],  costing);
            REWIREBytes(tweakey[11*8..12*8-1], tweakey[3*8..4*8-1],  costing);
            REWIREBytes(tweakey[12*8..13*8-1], tweakey[4*8..5*8-1],  costing);
            REWIREBytes(tweakey[13*8..14*8-1], tweakey[5*8..6*8-1],  costing);
            REWIREBytes(tweakey[14*8..15*8-1], tweakey[6*8..7*8-1],  costing);
            REWIREBytes(tweakey[15*8..16*8-1], tweakey[7*8..8*8-1],  costing);  
        
            for (i in 0..1)
            {
                for (j in 0..3)
                {
                    REWIRE(tweakey[8*i+j+1],  tweakey[8*i+j+0],  costing);
                    REWIRE(tweakey[8*i+j+2],  tweakey[8*i+j+1],  costing);
                    REWIRE(tweakey[8*i+j+3],  tweakey[8*i+j+2],  costing);
                    REWIRE(tweakey[8*i+j+4],  tweakey[8*i+j+3],  costing);
                    REWIRE(tweakey[8*i+j+5],  tweakey[8*i+j+4],  costing);
                    REWIRE(tweakey[8*i+j+6],  tweakey[8*i+j+5],  costing);
                    REWIRE(tweakey[8*i+j+7],  tweakey[8*i+j+6],  costing);
                    CNOT(tweakey[8*i+j+5],  tweakey[8*i+j+7]);
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
            REWIREBytes(state[0][(8*1)..(8*2-1)], state[1][(8*1)..(8*2-1)], costing);
            REWIREBytes(state[1][(8*1)..(8*2-1)], state[2][(8*1)..(8*2-1)], costing);
            REWIREBytes(state[2][(8*1)..(8*2-1)], state[3][(8*1)..(8*2-1)], costing);

            // third is rotated left by 2
            REWIREBytes(state[0][(8*2)..(8*3-1)], state[2][(8*2)..(8*3-1)], costing);
            REWIREBytes(state[1][(8*2)..(8*3-1)], state[3][(8*2)..(8*3-1)], costing);

            // fourth is rotated left by 3
            REWIREBytes(state[2][(8*3)..(8*4-1)], state[3][(8*3)..(8*4-1)], costing);
            REWIREBytes(state[1][(8*3)..(8*4-1)], state[2][(8*3)..(8*4-1)], costing);
            REWIREBytes(state[0][(8*3)..(8*4-1)], state[1][(8*3)..(8*4-1)], costing);
        }
        adjoint auto;
    }


    operation MixWord(word: Qubit[], costing: Bool) : Unit
    {
        body (...)
        {
            // Upper triangular matrix -- Skinny 
            CNOT(word[16], word[0]);
            CNOT(word[24], word[0]);
            CNOT(word[17], word[1]);
            CNOT(word[25], word[1]);
            CNOT(word[18], word[2]);
            CNOT(word[26], word[2]);
            CNOT(word[19], word[3]);
            CNOT(word[27], word[3]);
            CNOT(word[20], word[4]);
            CNOT(word[28], word[4]);
            CNOT(word[21], word[5]);
            CNOT(word[29], word[5]);
            CNOT(word[22], word[6]);
            CNOT(word[30], word[6]);
            CNOT(word[23], word[7]);
            CNOT(word[31], word[7]);
            CNOT(word[16], word[8]);
            CNOT(word[17], word[9]);
            CNOT(word[18], word[10]);
            CNOT(word[19], word[11]);
            CNOT(word[20], word[12]);
            CNOT(word[21], word[13]);
            CNOT(word[22], word[14]);
            CNOT(word[23], word[15]);
            CNOT(word[24], word[16]);
            CNOT(word[25], word[17]);
            CNOT(word[26], word[18]);
            CNOT(word[27], word[19]);
            CNOT(word[28], word[20]);
            CNOT(word[29], word[21]);
            CNOT(word[30], word[22]);
            CNOT(word[31], word[23]);

            // Lower triangular matrix -- Skinny 
            CNOT(word[7], word[31]);
            CNOT(word[6], word[30]);
            CNOT(word[5], word[29]);
            CNOT(word[4], word[28]);
            CNOT(word[3], word[27]);
            CNOT(word[2], word[26]);
            CNOT(word[1], word[25]);
            CNOT(word[0], word[24]);
            CNOT(word[7], word[23]);
            CNOT(word[6], word[22]);
            CNOT(word[5], word[21]);
            CNOT(word[4], word[20]);
            CNOT(word[3], word[19]);
            CNOT(word[2], word[18]);
            CNOT(word[1], word[17]);
            CNOT(word[0], word[16]); 

            // Permutation matrix -- Skinny 
            REWIRE(word[15], word[23], costing);
            REWIRE(word[14], word[22], costing);
            REWIRE(word[13], word[21], costing);
            REWIRE(word[12], word[20], costing);
            REWIRE(word[11], word[19], costing);
            REWIRE(word[10], word[18], costing);
            REWIRE(word[9], word[17], costing);
            REWIRE(word[8], word[16], costing); 
        }
        adjoint auto;
    }

    operation MixColumns(state: Qubit[][], costing: Bool) : Unit 
    {
        body (...)
        {
            for (j in 0..3)
            {
                MixWord(state[j], costing); 
            }
        }
        adjoint auto;
    }
}

namespace QSKINNY_128_128 {
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
                Round([state[(0*32)..(1*32 - 1)],
                       state[(1*32)..(2*32 - 1)],
                       state[(2*32)..(3*32 - 1)],
                       state[(3*32)..(4*32 - 1)]],
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
            //CNOTnBits(state[(0)..(127)], ciphertext[0..127], 128);  
            
            CNOTnBits(state[(0*32)..(1*32 - 1)], ciphertext[0..31], 32);
            CNOTnBits(state[(1*32)..(2*32 - 1)], ciphertext[32..63], 32);
            CNOTnBits(state[(2*32)..(3*32 - 1)], ciphertext[64..95], 32);
            CNOTnBits(state[(3*32)..(4*32 - 1)], ciphertext[96..127], 32);

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
                CNOTnBits(key_superposition, other_keys[(i*128)..((i+1)*128-1)], 128); 
            }

            // compute SKINNY encryption of the i-th target message
            for (i in 0..(pairs-1))
            {
                let state = plaintext[(i*128)..((i+1)*128-1)] + (state_ancillas[(i*128*round)..((i+1)*128*round-1)]); 
                let tweakey = i == 0 ? key_superposition | other_keys[((i-1)*128)..(i*128-1)];
                ForwardSkinny(tweakey, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[128*(pairs-1)], Qubit[128*round*pairs])) 
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

                mutable ciphertext = state_ancillas[(128*round-128)..(128*round-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*128*round-128)..((i+1)*128*round-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }
}

namespace QSKINNY_128_256 {
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
                Round([state[(0*32)..(1*32 - 1)],
                       state[(1*32)..(2*32 - 1)],
                       state[(2*32)..(3*32 - 1)],
                       state[(3*32)..(4*32 - 1)]],
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
            //CNOTnBits(state[(0)..(127)], ciphertext[0..127], 128);  
            
            CNOTnBits(state[(0*32)..(1*32 - 1)], ciphertext[0..31], 32);
            CNOTnBits(state[(1*32)..(2*32 - 1)], ciphertext[32..63], 32);
            CNOTnBits(state[(2*32)..(3*32 - 1)], ciphertext[64..95], 32);
            CNOTnBits(state[(3*32)..(4*32 - 1)], ciphertext[96..127], 32);

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
                CNOTnBits(key_superposition, other_keys[(i*256)..((i+1)*256-1)], 256); 
            }

            // compute SKINNY encryption of the i-th target message
            for (i in 0..(pairs-1))
            {
                let state = plaintext[(i*128)..((i+1)*128-1)] + (state_ancillas[(i*128*round)..((i+1)*128*round-1)]); 
                let tweakey = i == 0 ? key_superposition | other_keys[((i-1)*256)..(i*256-1)];
                let tweakey_1 = tweakey[0..127];
                let tweakey_2 = tweakey[128..255];
                ForwardSkinny(tweakey_1, tweakey_2, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[256*(pairs-1)], Qubit[128*round*pairs])) 
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

                mutable ciphertext = state_ancillas[(128*round-128)..(128*round-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*128*round-128)..((i+1)*128*round-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }

}

namespace QSKINNY_128_384 {
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
                Round([state[(0*32)..(1*32 - 1)],
                       state[(1*32)..(2*32 - 1)],
                       state[(2*32)..(3*32 - 1)],
                       state[(3*32)..(4*32 - 1)]],
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
            //CNOTnBits(state[(0)..(127)], ciphertext[0..127], 128);  
            
            CNOTnBits(state[(0*32)..(1*32 - 1)], ciphertext[0..31], 32);
            CNOTnBits(state[(1*32)..(2*32 - 1)], ciphertext[32..63], 32);
            CNOTnBits(state[(2*32)..(3*32 - 1)], ciphertext[64..95], 32);
            CNOTnBits(state[(3*32)..(4*32 - 1)], ciphertext[96..127], 32);

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
                CNOTnBits(key_superposition, other_keys[(i*384)..((i+1)*384-1)], 384); 
            }

            // compute SKINNY encryption of the i-th target message
            for (i in 0..(pairs-1))
            {
                let state = plaintext[(i*128)..((i+1)*128-1)] + (state_ancillas[(i*128*round)..((i+1)*128*round-1)]); 
                let tweakey = i == 0 ? key_superposition | other_keys[((i-1)*384)..(i*384-1)];
                let tweakey_1 = tweakey[0..127];
                let tweakey_2 = tweakey[128..255];
                let tweakey_3 = tweakey[256..383];
                ForwardSkinny(tweakey_1, tweakey_2, tweakey_3, state, round, costing); 
            }
        }
        adjoint auto;
    }

    operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    {
        body (...)
        {
            using ((other_keys, state_ancillas) = (Qubit[384*(pairs-1)], Qubit[128*round*pairs])) 
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

                mutable ciphertext = state_ancillas[(128*round-128)..(128*round-1)];
                for (i in 1..(pairs-1))
                {
                    set ciphertext = ciphertext + (state_ancillas[((i+1)*128*round-128)..((i+1)*128*round-1)]); 
                }

                CompareQubitstring(success, ciphertext, target_ciphertext, costing);

                (Adjoint ForwardGroverOracle)(other_keys, state_ancillas, key_superposition, success, plaintext, target_ciphertext, pairs, round, costing); 
            }
        }
    }

}
