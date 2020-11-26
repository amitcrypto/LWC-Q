// Copyright (c) IIT Ropar.
// Licensed under the free license.

namespace QTests.SKINNY
{
    open Microsoft.Quantum.Intrinsic; 
    open Microsoft.Quantum.Canon; 
    open Microsoft.Quantum.Convert; 
    open QUtilities;  

    operation SkinnySBox(_a: Result[], costing: Bool) : Result[] 
    {
        mutable res = new Result[4];
        using (a = Qubit[4])
        {
            for (i in 1..4)
            {
                Set(_a[i-1], a[i-1]);
            }
            
            QSKINNY.InPlace.SkinnySbox(a, costing);
            
            for (i in 1..4)
            {
                set res w/= i-1 <- M(a[i-1]);
            }

            // cleanup
            for (i in 1..4)
            {
                Set(Zero, a[i-1]);
            }
        }
        return res;
    }

    operation SubCells(_input_state: Result[], costing: Bool) : Result[][] 
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16];

        using (
                (
                    input_state_1, input_state_2, input_state_3, input_state_4
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16]
                )
            )
        {
            let input_state = [input_state_1, input_state_2, input_state_3, input_state_4];
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_input_state[j * 16 + i], input_state[j][i]);
                }
            }

            QSKINNY.InPlace.SubCells(input_state, costing);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(input_state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(input_state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(input_state[2][i]);
            }

            for (i in 0..15)
            {
                set res_4 w/= i <- M(input_state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(Zero, input_state[j][i]); 
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }

    operation AddConstants(_state: Result[], round: Int, costing: Bool) : Result[][] 
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16];

        using (
                (
                    input_state_1, input_state_2, input_state_3, input_state_4
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16]
                )
            )
        {
            let input_state = [input_state_1, input_state_2, input_state_3, input_state_4];
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], input_state[j][i]);
                }
            }

            QSKINNY.InPlace.AddConstants(input_state, round, costing);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(input_state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(input_state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(input_state[2][i]);
            }

            for (i in 0..15) 
            {
                set res_4 w/= i <- M(input_state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15) 
                {
                    Set(Zero, input_state[j][i]); 
                }
            }
        }
        return [res_1, res_2, res_3, res_4];  
    } 

    
    operation AddRoundTweakey(_state: Result[], _round_key: Result[]) : Result[][] 
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16]; 

        using (
                (
                    state_1, state_2, state_3, state_4,
                    round_key
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16], 
                    Qubit[64] 
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }
            for (i in 0..63) 
            {
                Set(_round_key[i], round_key[i]);
            }

            QSKINNY.InPlace.AddRoundTweakey(state, round_key);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15) 
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15) 
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (i in 0..63) 
            {
                Set(Zero, round_key[i]);
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation AddRoundTweakey_z2(_state: Result[], _round_key: Result[]) : Result[][] 
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16];

        using (
                (
                    state_1, state_2, state_3, state_4,
                    round_key_1, round_key_2
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16], 
                    Qubit[64], Qubit[64] 
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }
            for (i in 0..63)
            {
                Set(_round_key[i], round_key_1[i]);
                Set(_round_key[64+i], round_key_2[i]);
            }

            QSKINNY.InPlace.AddRoundTweakey_z2(state, round_key_1, round_key_2);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15) 
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (i in 0..63) 
            {
                Set(Zero, round_key_1[i]);
                Set(Zero, round_key_2[i]);
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation AddRoundTweakey_z3(_state: Result[], _round_key: Result[]) : Result[][] 
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16]; 

        using (
                (
                    state_1, state_2, state_3, state_4,
                    round_key_1, round_key_2, round_key_3
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16],
                    Qubit[64], Qubit[64], Qubit[64]  
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }
            for (i in 0..63)
            {
                Set(_round_key[i], round_key_1[i]);
                Set(_round_key[64+i], round_key_2[i]);
                Set(_round_key[128+i], round_key_3[i]); 
            }

            QSKINNY.InPlace.AddRoundTweakey_z3(state, round_key_1, round_key_2, round_key_3);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15) 
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15) 
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (i in 0..63) 
            {
                Set(Zero, round_key_1[i]);
                Set(Zero, round_key_2[i]);
                Set(Zero, round_key_3[i]);
            }
        }
        return [res_1, res_2, res_3, res_4];
    } 

    operation TweakeyUpdate(_tweakey: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[64];

        using (tweakey = Qubit[64])
        {
            for (i in 0..63)
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY.InPlace.TweakeyUpdate(tweakey, round, costing); 
            for (i in 1..64)
            {
                set res w/= i-1 <- M(tweakey[i-1]);
            }
            // cleanup
            for (j in 0..63) 
            {
                Set(Zero, tweakey[j]);
            }
        }
        return res;
    }
    
    operation TweakeyUpdate_2(_tweakey: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[64];

        using (tweakey = Qubit[64])
        {
            for (i in 0..63)
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY.InPlace.TweakeyUpdate_2(tweakey, round, costing); 
            for (i in 1..64)
            {
                set res w/= i-1 <- M(tweakey[i-1]);
            }
            // cleanup
            for (j in 0..63) 
            {
                Set(Zero, tweakey[j]);
            }
        }
        return res;
    }
    
    operation TweakeyUpdate_3(_tweakey: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[64];

        using (tweakey = Qubit[64])
        {
            for (i in 0..63)
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY.InPlace.TweakeyUpdate_3(tweakey, round, costing); 
            for (i in 1..64) 
            {
                set res w/= i-1 <- M(tweakey[i-1]);
            }
            // cleanup
            for (j in 0..63) 
            {
                Set(Zero, tweakey[j]);
            }
        }
        return res;
    }

    
    operation ShiftRows(_state: Result[], costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16];

        using (
                (
                    state_1, state_2, state_3, state_4
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16] 
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }

            QSKINNY.InPlace.ShiftRows(state, costing);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15) 
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15) 
                {
                    Set(Zero, state[j][i]);
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }


    operation MixHalfWord(_state: Result[], costing: Bool): Result[]
    {
    mutable res = new Result[16];
        using (a = Qubit[16])
        {
            for (i in 1..16)
            {
                Set(_state[i-1], a[i-1]);
            }
            
            QSKINNY.InPlace.MixHalfWord(a, costing); 
            
            for (i in 1..16)
            {
                set res w/= i-1 <- M(a[i-1]);
            }

            // cleanup
            for (i in 1..16) 
            {
                Set(Zero, a[i-1]);
            }
        }
        return res;
    }


    operation MixColumns(_state: Result[], costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16];
 
        using (
                (
                    state_1, state_2, state_3, state_4
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }

            QSKINNY.InPlace.MixColumns(state, costing);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15) 
                {
                    Set(Zero, state[j][i]);
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }


    operation Round(_state: Result[], _tweakey: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16]; 
        using (
                (
                    state_1, state_2, state_3, state_4,
                    tweakey
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16], 
                    Qubit[64] 
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];

            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }
            for (i in 0..63) 
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY_64_64.Round(state, tweakey, round, costing);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15) 
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15) 
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (j in 0..63) 
            {
                Set(Zero, tweakey[j]);
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    } 

    operation Round_z2(_state: Result[], _tweakey: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16];
        using (
                (
                    state_1, state_2, state_3, state_4,
                    tweakey_1, tweakey_2
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16],
                    Qubit[64], Qubit[64] 
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];

            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }
            for (i in 0..63)
            {
                Set(_tweakey[i], tweakey_1[i]);
                Set(_tweakey[64+i], tweakey_2[i]); 
            }

            QSKINNY_64_128.Round(state, tweakey_1, tweakey_2, round, costing);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15) 
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (j in 0..63) 
            {
                Set(Zero, tweakey_1[j]);
                Set(Zero, tweakey_2[j]);
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    } 

    operation Round_z3(_state: Result[], _tweakey: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[16];
        mutable res_2 = new Result[16];
        mutable res_3 = new Result[16];
        mutable res_4 = new Result[16];
        using (
                (
                    state_1, state_2, state_3, state_4,
                    tweakey_1, tweakey_2, tweakey_3
                ) = (
                    Qubit[16], Qubit[16], Qubit[16], Qubit[16],
                    Qubit[64], Qubit[64], Qubit[64] 
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];

            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(_state[j * 16 + i], state[j][i]);
                }
            }
            for (i in 0..63) 
            {
                Set(_tweakey[i], tweakey_1[i]);
                Set(_tweakey[64+i], tweakey_2[i]);
                Set(_tweakey[128+i], tweakey_3[i]); 
            }

            QSKINNY_64_192.Round(state, tweakey_1, tweakey_2, tweakey_3, round, costing);

            for (i in 0..15)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..15)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..15)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..15)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..15)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (j in 0..63) 
            {
                Set(Zero, tweakey_1[j]);
                Set(Zero, tweakey_2[j]);
                Set(Zero, tweakey_3[j]);
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    } 


    operation Skinny_64_64(_message: Result[], _key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[64]; 

        using ((state, tweakey, ciphertext) = ( Qubit[64], Qubit[64], Qubit[64])) 
        {
            for (i in 0..63) 
            {
                Set(_message[i], state[i]); 
            }
            for (i in 0..63) 
            {
                Set(_key[i], tweakey[i]); 
            }

            QSKINNY_64_64.Skinny(tweakey, state, ciphertext, round, costing);
 
            for (i in 0..63) 
            {
                set res w/= i <- M(ciphertext[i]); 
            }

            // cleanup
            for (i in 0..63) 
            {
                Set(Zero, state[i]);
                Set(Zero, ciphertext[i]); 
            }
            for (i in 0..63)  
            {
                Set(Zero, tweakey[i]);
            }
        }
        return res; 
    } 

    operation Skinny_64_128(_message: Result[], _key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[64];  

        using ((state, tweakey_1, tweakey_2, ciphertext) = (Qubit[64], Qubit[64], Qubit[64], Qubit[64])) 
        {
            for (i in 0..63) 
            {
                Set(_message[i], state[i]); 
            }
            for (i in 0..63)
            {
                Set(_key[i], tweakey_1[i]);
                Set(_key[64+i], tweakey_2[i]); 
            }

            QSKINNY_64_128.Skinny(tweakey_1, tweakey_2, state, ciphertext, round, costing);
 
            for (i in 0..63) 
            {
                set res w/= i <- M(ciphertext[i]); 
            }

            // cleanup
            for (i in 0..63) 
            {
                Set(Zero, state[i]);
                Set(Zero, ciphertext[i]); 
            }
            for (i in 0..63)  
            {
                Set(Zero, tweakey_1[i]);
                Set(Zero, tweakey_2[i]);
            }
        }
        return res; 
    } 

    operation Skinny_64_192(_message: Result[], _key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[64];  

        using ((state, tweakey_1, tweakey_2, tweakey_3, ciphertext) = ( Qubit[64], Qubit[64], Qubit[64], Qubit[64], Qubit[64])) 
        {
            for (i in 0..63) 
            {
                Set(_message[i], state[i]); 
            }
            for (i in 0..63)
            {
                Set(_key[i], tweakey_1[i]);
                Set(_key[64+i], tweakey_2[i]);
                Set(_key[128+i], tweakey_3[i]);  
            }

            QSKINNY_64_192.Skinny(tweakey_1, tweakey_2, tweakey_3, state, ciphertext, round, costing);
 
            for (i in 0..63)
            {
                set res w/= i <- M(ciphertext[i]); 
            }

            // cleanup
            for (i in 0..63)
            {
                Set(Zero, state[i]);
                Set(Zero, ciphertext[i]); 
            }
            for (i in 0..63) 
            {
                Set(Zero, tweakey_1[i]);
                Set(Zero, tweakey_2[i]);
                Set(Zero, tweakey_3[i]);
            }
        }
        return res; 
    } 

    operation GroverOracle_64_64 (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((tweakey, success, plaintext) = (Qubit[64], Qubit(), Qubit[64*pairs]))
        {
            for (i in 0..63) 
            {
                Set(_key[i], tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..63)
                {
                    Set(_plaintexts[64*j + i], plaintext[64*j + i]);
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QSKINNY_64_64.GroverOracle(tweakey, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success);

            Set(Zero, success);
            for (i in 0..63)
            {
                Set(Zero, tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..63)
                {
                    Set(Zero, plaintext[64*j + i]); 
                }
            }
        }
        return res;
    }

    operation GroverOracle_64_128 (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((tweakey, success, plaintext) = (Qubit[128], Qubit(), Qubit[64*pairs]))
        {
            for (i in 0..127)   
            {
                Set(_key[i], tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..63)
                {
                    Set(_plaintexts[64*j + i], plaintext[64*j + i]); 
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QSKINNY_64_128.GroverOracle(tweakey, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success); 

            Set(Zero, success);
            for (i in 0..127)  
            {
                Set(Zero, tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..63) 
                {
                    Set(Zero, plaintext[64*j + i]);  
                }
            }
        }
        return res;
    }

    operation GroverOracle_64_192 (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((tweakey, success, plaintext) = (Qubit[192], Qubit(), Qubit[64*pairs]))
        {
            for (i in 0..191) 
            {
                Set(_key[i], tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..63)
                {
                    Set(_plaintexts[64*j + i], plaintext[64*j + i]);
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QSKINNY_64_192.GroverOracle(tweakey, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success);

            Set(Zero, success);
            for (i in 0..191)
            {
                Set(Zero, tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..63) 
                {
                    Set(Zero, plaintext[64*j + i]);  
                }
            }
        }
        return res;
    }
}

