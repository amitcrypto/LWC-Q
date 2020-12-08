// Copyright (c) 2020 IIT Ropar.
// Licensed under MIT license.

namespace QTests.GIFT
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open QUtilities;

    operation GiftSBox(_a: Result[], costing: Bool) : Result[]
    {
        mutable res = new Result[4];
        using (a = Qubit[4])
        {
            for (i in 1..4)
            {
                Set(_a[i-1], a[i-1]);
            }
            
            QGIFT.InPlace.GiftSbox(a, costing);
            
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

    operation SubCells(_input_state: Result[], costing: Bool) : Result[]
    {
        mutable res = new Result[128]; 

        using (input_state = Qubit[128]) 
        {
            for (i in 0..127)
            { 
                Set(_input_state[i], input_state[i]);   
            }

            QGIFT.InPlace.SubCells(input_state, costing);  

            for (i in 0..127)
            {
                set res w/= i <- M(input_state[i]); 
            } 

            // cleanup 
            for (i in 0..127)   
            { 
                Set(Zero, input_state[i]);  
            } 
        }
        return res; 
    }

    operation PermBits(_state: Result[], costing: Bool) : Result[]
    {
        mutable res = new Result[128]; 

        using (state = Qubit[128]) 
        { 
            for (i in 0..127)     
            {    
                Set(_state[i], state[i]);   
            }  
 
            QGIFT.InPlace.PermBits(state, costing); 

            for (i in 0..127)
            {
                set res w/= i <- M(state[i]); 
            } 

            // cleanup
            for (i in 0..127)   
            {
                Set(Zero, state[i]); 
            }
        }
        return res; 
    }

    operation AddRoundKey(_state: Result[], _round_key: Result[]) : Result[] 
    {
        mutable res = new Result[128]; 

        using ((state, round_key) = (Qubit[128], Qubit[128])
            )
        {
            for (i in 0..127) 
            {
                Set(_state[i], state[i]);
                Set(_round_key[i], round_key[i]); 
            }

            QGIFT.InPlace.AddRoundKey(state, round_key); 

            for (i in 0..127)
            {
                set res w/= i <- M(state[i]);
            }

            // cleanup
            for (i in 0..127) 
            {
                Set(Zero, state[i]);
                Set(Zero, round_key[i]);
            } 
        }
        return res; 
    } 

    operation KeySchedule(_key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[128]; 

        using (key = Qubit[128])
        {
            for (i in 0..127) 
            {
                Set(_key[i], key[i]);
            }

            QGIFT.InPlace.KeySchedule(key, round, costing); 

            for (i in 0..127) 
            {
                set res w/= i <- M(key[i]);
            }

            // cleanup
            for (i in 0..127) 
            {
                Set(Zero, key[i]);
            }
        }
        return res;
    }

    operation AddConstants(_state: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[128]; 

        using (state = Qubit[128]) 
        {
            for (i in 0..127) 
            {
                Set(_state[i], state[i]);
            }

            QGIFT.InPlace.AddConstants(state, round, costing); 

            for (i in 0..127)
            {
                set res w/= i <- M(state[i]);
            }

            // cleanup
            for (i in 0..127) 
            {
                Set(Zero, state[i]); 
            } 
        }
        return res; 
    } 

    operation Round(_state: Result[], _round_key: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[128];

        using ((in_state, round_key) = (Qubit[128], Qubit[128])) 
        {
            for (i in 0..127)
            {
                Set(_state[i], in_state[i]);
                Set(_round_key[i], round_key[i]); 
            }

            QGIFT.Round(in_state, round_key, round, costing); 

            for (i in 0..127)
            {
                set res w/= i <- M(in_state[i]); 
            }

            // cleanup
            for (i in 0..127) 
            {
                Set(Zero, in_state[i]);
                Set(Zero, round_key[i]); 
            }
        }
        return res; 
    } 

    operation Gift(_message: Result[], _key: Result[], round: Int, costing: Bool) : Result[] 
    {
        mutable res = new Result[128]; 

        using ((state, expanded_key, ciphertext) = ( Qubit[128], Qubit[128], Qubit[128])) 
        {
            for (i in 0..127) 
            {
                Set(_message[i], state[i]); 
            }
            for (i in 0..127)
            {
                Set(_key[i], expanded_key[i]); 
            }


            QGIFT.Gift(expanded_key, state, ciphertext, round, costing);
 
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
                Set(Zero, expanded_key[i]);
            }
        }
        return res; 
    } 

    operation GroverOracle (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((key, success, plaintext) = (Qubit[128], Qubit(), Qubit[128*pairs]))
        {
            for (i in 0..127) 
            {
                Set(_key[i], key[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..127)
                {
                    Set(_plaintexts[128*j + i], plaintext[128*j + i]);
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QGIFT.GroverOracle(key, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success);

            Set(Zero, success);
            for (i in 0..127)
            {
                Set(Zero, key[i]);
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

