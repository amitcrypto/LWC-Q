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
        mutable res = new Result[8];
        using (a = Qubit[8])
        {
            for (i in 1..8)
            {
                Set(_a[i-1], a[i-1]);
            }
            
            QSKINNY.InPlace.SkinnySbox(a, costing);
            
            for (i in 1..8)
            {
                set res w/= i-1 <- M(a[i-1]);
            }

            // cleanup
            for (i in 1..8)
            {
                Set(Zero, a[i-1]);
            }
        }
        return res;
    }

    operation SubCells(_input_state: Result[], costing: Bool) : Result[][] 
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];

        using (
                (
                    input_state_1, input_state_2, input_state_3, input_state_4
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32]
                )
            )
        {
            let input_state = [input_state_1, input_state_2, input_state_3, input_state_4];
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_input_state[j * 32 + i], input_state[j][i]);
                }
            }

            QSKINNY.InPlace.SubCells(input_state, costing);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(input_state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(input_state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(input_state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(input_state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, input_state[j][i]); 
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }

    operation AddConstants(_state: Result[], round: Int, costing: Bool) : Result[][] 
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];

        using (
                (
                    input_state_1, input_state_2, input_state_3, input_state_4
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32]
                )
            )
        {
            let input_state = [input_state_1, input_state_2, input_state_3, input_state_4];
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], input_state[j][i]);
                }
            }

            QSKINNY.InPlace.AddConstants(input_state, round, costing);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(input_state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(input_state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(input_state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(input_state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, input_state[j][i]); 
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    } 

    
    operation AddRoundTweakey(_state: Result[], _round_key: Result[]) : Result[][] 
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];

        using (
                (
                    state_1, state_2, state_3, state_4,
                    round_key
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32],
                    Qubit[128]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(_round_key[i], round_key[i]);
            }

            QSKINNY.InPlace.AddRoundTweakey(state, round_key);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(Zero, round_key[i]);
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation AddRoundTweakey_z2(_state: Result[], _round_key: Result[]) : Result[][] 
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];

        using (
                (
                    state_1, state_2, state_3, state_4,
                    round_key_1, round_key_2
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32],
                    Qubit[128], Qubit[128]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(_round_key[i], round_key_1[i]);
                Set(_round_key[128+i], round_key_2[i]);
            }

            QSKINNY.InPlace.AddRoundTweakey_z2(state, round_key_1, round_key_2);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(Zero, round_key_1[i]);
                Set(Zero, round_key_2[i]);
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation AddRoundTweakey_z3(_state: Result[], _round_key: Result[]) : Result[][] 
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];

        using (
                (
                    state_1, state_2, state_3, state_4,
                    round_key_1, round_key_2, round_key_3
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32],
                    Qubit[128], Qubit[128], Qubit[128]  
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(_round_key[i], round_key_1[i]);
                Set(_round_key[128+i], round_key_2[i]);
                Set(_round_key[256+i], round_key_3[i]);
            }

            QSKINNY.InPlace.AddRoundTweakey_z3(state, round_key_1, round_key_2, round_key_3);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (i in 0..127)
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
        mutable res = new Result[128];

        using (tweakey = Qubit[128])
        {
            for (i in 0..127)
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY.InPlace.TweakeyUpdate(tweakey, round, costing); 
            for (i in 1..128)
            {
                set res w/= i-1 <- M(tweakey[i-1]);
            }
            // cleanup
            for (j in 0..127)
            {
                Set(Zero, tweakey[j]);
            }
        }
        return res;
    }
    
    operation TweakeyUpdate_2(_tweakey: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[128];

        using (tweakey = Qubit[128])
        {
            for (i in 0..127)
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY.InPlace.TweakeyUpdate_2(tweakey, round, costing); 
            for (i in 1..128)
            {
                set res w/= i-1 <- M(tweakey[i-1]);
            }
            // cleanup
            for (j in 0..127)
            {
                Set(Zero, tweakey[j]);
            }
        }
        return res;
    }
    
    operation TweakeyUpdate_3(_tweakey: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[128];

        using (tweakey = Qubit[128])
        {
            for (i in 0..127)
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY.InPlace.TweakeyUpdate_3(tweakey, round, costing); 
            for (i in 1..128)
            {
                set res w/= i-1 <- M(tweakey[i-1]);
            }
            // cleanup
            for (j in 0..127)
            {
                Set(Zero, tweakey[j]);
            }
        }
        return res;
    }
    
    operation MixWord(_state: Result[], costing: Bool): Result[]
    {
    mutable res = new Result[32];
        using (a = Qubit[32])
        {
            for (i in 1..32)
            {
                Set(_state[i-1], a[i-1]);
            }
            
            QSKINNY.InPlace.MixWord(a, costing);
            
            for (i in 1..32)
            {
                set res w/= i-1 <- M(a[i-1]);
            }

            // cleanup
            for (i in 1..32)
            {
                Set(Zero, a[i-1]);
            }
        }
        return res;
    }

    operation ShiftRows(_state: Result[], costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];

        using (
                (
                    state_1, state_2, state_3, state_4
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }

            QSKINNY.InPlace.ShiftRows(state, costing);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }

    operation MixColumns(_state: Result[], costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];

        using (
                (
                    state_1, state_2, state_3, state_4
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }

            QSKINNY.InPlace.MixColumns(state, costing);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }


    operation Round(_state: Result[], _tweakey: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];
        using (
                (
                    state_1, state_2, state_3, state_4,
                    tweakey
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32],
                    Qubit[128]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];

            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(_tweakey[i], tweakey[i]);
            }

            QSKINNY_128_128.Round(state, tweakey, round, costing);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (j in 0..127)
            {
                Set(Zero, tweakey[j]);
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    } 

    operation Round_z2(_state: Result[], _tweakey: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];
        using (
                (
                    state_1, state_2, state_3, state_4,
                    tweakey_1, tweakey_2
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32],
                    Qubit[128], Qubit[128]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];

            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(_tweakey[i], tweakey_1[i]);
                Set(_tweakey[128+i], tweakey_2[i]);
            }

            QSKINNY_128_256.Round(state, tweakey_1, tweakey_2, round, costing);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (j in 0..127)
            {
                Set(Zero, tweakey_1[j]);
                Set(Zero, tweakey_2[j]);
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    } 

    operation Round_z3(_state: Result[], _tweakey: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[32];
        mutable res_2 = new Result[32];
        mutable res_3 = new Result[32];
        mutable res_4 = new Result[32];
        using (
                (
                    state_1, state_2, state_3, state_4,
                    tweakey_1, tweakey_2, tweakey_3
                ) = (
                    Qubit[32], Qubit[32], Qubit[32], Qubit[32],
                    Qubit[128], Qubit[128], Qubit[128]
                )
            )
        {
            let state = [state_1, state_2, state_3, state_4];

            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(_state[j * 32 + i], state[j][i]);
                }
            }
            for (i in 0..127)
            {
                Set(_tweakey[i], tweakey_1[i]);
                Set(_tweakey[128+i], tweakey_2[i]);
                Set(_tweakey[256+i], tweakey_3[i]);
            }

            QSKINNY_128_384.Round(state, tweakey_1, tweakey_2, tweakey_3, round, costing);

            for (i in 0..31)
            {
                set res_1 w/= i <- M(state[0][i]);
            }

            for (i in 0..31)
            {
                set res_2 w/= i <- M(state[1][i]);
            }

            for (i in 0..31)
            {
                set res_3 w/= i <- M(state[2][i]);
            }

            for (i in 0..31)
            {
                set res_4 w/= i <- M(state[3][i]);
            }

            // cleanup
            for (j in 0..3)
            {
                for (i in 0..31)
                {
                    Set(Zero, state[j][i]);
                }
            }
            for (j in 0..127)
            {
                Set(Zero, tweakey_1[j]);
                Set(Zero, tweakey_2[j]);
                Set(Zero, tweakey_3[j]);
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    } 


    operation Skinny_128_128(_message: Result[], _key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[128]; 

        using ((state, tweakey, ciphertext) = ( Qubit[128], Qubit[128], Qubit[128])) 
        {
            for (i in 0..127) 
            {
                Set(_message[i], state[i]); 
            }
            for (i in 0..127)
            {
                Set(_key[i], tweakey[i]); 
            }

            QSKINNY_128_128.Skinny(tweakey, state, ciphertext, round, costing);
 
            for (i in 0..127)
            {
                set res w/= i <- M(ciphertext[i]); 
            }

            // cleanup
            for (i in 0..127)
            {
                Set(Zero, state[i]);
                Set(Zero, ciphertext[i]); 
            }
            for (i in 0..127) 
            {
                Set(Zero, tweakey[i]);
            }
        }
        return res; 
    } 

    operation Skinny_128_256(_message: Result[], _key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[128]; 

        using ((state, tweakey_1, tweakey_2, ciphertext) = (Qubit[128], Qubit[128], Qubit[128], Qubit[128])) 
        {
            for (i in 0..127) 
            {
                Set(_message[i], state[i]); 
            }
            for (i in 0..127)
            {
                Set(_key[i], tweakey_1[i]);
                Set(_key[128+i], tweakey_2[i]); 
            }

            QSKINNY_128_256.Skinny(tweakey_1, tweakey_2, state, ciphertext, round, costing);
 
            for (i in 0..127)
            {
                set res w/= i <- M(ciphertext[i]); 
            }

            // cleanup
            for (i in 0..127)
            {
                Set(Zero, state[i]);
                Set(Zero, ciphertext[i]); 
            }
            for (i in 0..127) 
            {
                Set(Zero, tweakey_1[i]);
                Set(Zero, tweakey_2[i]);
            }
        }
        return res; 
    } 

    operation Skinny_128_384(_message: Result[], _key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[128]; 

        using ((state, tweakey_1, tweakey_2, tweakey_3, ciphertext) = ( Qubit[128], Qubit[128], Qubit[128], Qubit[128], Qubit[128])) 
        {
            for (i in 0..127) 
            {
                Set(_message[i], state[i]); 
            }
            for (i in 0..127)
            {
                Set(_key[i], tweakey_1[i]);
                Set(_key[128+i], tweakey_2[i]);
                Set(_key[256+i], tweakey_3[i]); 
            }

            QSKINNY_128_384.Skinny(tweakey_1, tweakey_2, tweakey_3, state, ciphertext, round, costing);
 
            for (i in 0..127)
            {
                set res w/= i <- M(ciphertext[i]); 
            }

            // cleanup
            for (i in 0..127)
            {
                Set(Zero, state[i]);
                Set(Zero, ciphertext[i]); 
            }
            for (i in 0..127) 
            {
                Set(Zero, tweakey_1[i]);
                Set(Zero, tweakey_2[i]);
                Set(Zero, tweakey_3[i]);
            }
        }
        return res; 
    } 

    operation GroverOracle_128_128 (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((tweakey, success, plaintext) = (Qubit[128], Qubit(), Qubit[128*pairs]))
        {
            for (i in 0..127) 
            {
                Set(_key[i], tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..127)
                {
                    Set(_plaintexts[128*j + i], plaintext[128*j + i]);
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QSKINNY_128_128.GroverOracle(tweakey, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success);

            Set(Zero, success);
            for (i in 0..127)
            {
                Set(Zero, tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..127)
                {
                    Set(Zero, plaintext[128*j + i]); 
                }
            }
        }
        return res;
    }

    operation GroverOracle_128_256 (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((tweakey, success, plaintext) = (Qubit[256], Qubit(), Qubit[128*pairs]))
        {
            for (i in 0..255) 
            {
                Set(_key[i], tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..127)
                {
                    Set(_plaintexts[128*j + i], plaintext[128*j + i]);
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QSKINNY_128_256.GroverOracle(tweakey, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success);

            Set(Zero, success);
            for (i in 0..255)
            {
                Set(Zero, tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..127)
                {
                    Set(Zero, plaintext[128*j + i]); 
                }
            }
        }
        return res;
    }

    operation GroverOracle_128_384 (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((tweakey, success, plaintext) = (Qubit[384], Qubit(), Qubit[128*pairs]))
        {
            for (i in 0..383) 
            {
                Set(_key[i], tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..127)
                {
                    Set(_plaintexts[128*j + i], plaintext[128*j + i]);
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QSKINNY_128_384.GroverOracle(tweakey, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success);

            Set(Zero, success);
            for (i in 0..383)
            {
                Set(Zero, tweakey[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..127)
                {
                    Set(Zero, plaintext[128*j + i]); 
                }
            }
        }
        return res;
    }
}

