// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

namespace QTests.SATURNIN
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open QUtilities;

    operation SaturninSboxZero(_a: Result[], costing: Bool) : Result[]
    {
        mutable res = new Result[4];
        using (a = Qubit[4])
        {
            for (i in 1..4)
            {
                Set(_a[i-1], a[i-1]);
            }
            
            QSATURNIN.InPlace.SaturninSboxZero(a, costing);
            
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

    operation SaturninSboxOne(_a: Result[], costing: Bool) : Result[]
    {
        mutable res = new Result[4];
        using (a = Qubit[4])
        {
            for (i in 1..4)
            {
                Set(_a[i-1], a[i-1]);
            }
            
            QSATURNIN.InPlace.SaturninSboxOne(a, costing);
            
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
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];

        //mutable res = new Result[4][4][4][4];

        using (
                (
                    is_1,  is_2,  is_3,  is_4,  is_5,  is_6,  is_7,  is_8,  is_9,  is_10, is_11, is_12, is_13, is_14, is_15, is_16,
                    is_17, is_18, is_19, is_20, is_21, is_22, is_23, is_24, is_25, is_26, is_27, is_28, is_29, is_30, is_31, is_32,
                    is_33, is_34, is_35, is_36, is_37, is_38, is_39, is_40, is_41, is_42, is_43, is_44, is_45, is_46, is_47, is_48,
                    is_49, is_50, is_51, is_52, is_53, is_54, is_55, is_56, is_57, is_58, is_59, is_60, is_61, is_62, is_63, is_64
                ) 
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let input_state_1 = [ is_1,  is_2,  is_3,  is_4];
            let input_state_2 = [ is_5,  is_6,  is_7,  is_8];
            let input_state_3 = [ is_9,  is_10, is_11, is_12];
            let input_state_4 = [ is_13, is_14, is_15, is_16];
            let input_state_5 = [ is_17, is_18, is_19, is_20];
            let input_state_6 = [ is_21, is_22, is_23, is_24];
            let input_state_7 = [ is_25, is_26, is_27, is_28];
            let input_state_8 = [ is_29, is_30, is_31, is_32];
            let input_state_9 = [ is_33, is_34, is_35, is_36];
            let input_state_10 = [is_37, is_38, is_39, is_40];
            let input_state_11 = [is_41, is_42, is_43, is_44];
            let input_state_12 = [is_45, is_46, is_47, is_48];
            let input_state_13 = [is_49, is_50, is_51, is_52];
            let input_state_14 = [is_53, is_54, is_55, is_56];
            let input_state_15 = [is_57, is_58, is_59, is_60];
            let input_state_16 = [is_61, is_62, is_63, is_64];
        

            let input_state = [
                                [input_state_1, input_state_2, input_state_3, input_state_4],
                                [input_state_5, input_state_6, input_state_7, input_state_8],
                                [input_state_9, input_state_10, input_state_11, input_state_12],
                                [input_state_13, input_state_14, input_state_15, input_state_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_input_state[4*4*4*k + 4*4*j + 4*i + l], input_state[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.SubCells(input_state, costing);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, input_state[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }

    operation NibblePermutation(_input_state: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];

        using (
                (
                    is_1,  is_2,  is_3,  is_4,  is_5,  is_6,  is_7,  is_8,  is_9,  is_10, is_11, is_12, is_13, is_14, is_15, is_16,
                    is_17, is_18, is_19, is_20, is_21, is_22, is_23, is_24, is_25, is_26, is_27, is_28, is_29, is_30, is_31, is_32,
                    is_33, is_34, is_35, is_36, is_37, is_38, is_39, is_40, is_41, is_42, is_43, is_44, is_45, is_46, is_47, is_48,
                    is_49, is_50, is_51, is_52, is_53, is_54, is_55, is_56, is_57, is_58, is_59, is_60, is_61, is_62, is_63, is_64
                ) 
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let input_state_1 = [ is_1,  is_2,  is_3,  is_4];
            let input_state_2 = [ is_5,  is_6,  is_7,  is_8];
            let input_state_3 = [ is_9,  is_10, is_11, is_12];
            let input_state_4 = [ is_13, is_14, is_15, is_16];
            let input_state_5 = [ is_17, is_18, is_19, is_20];
            let input_state_6 = [ is_21, is_22, is_23, is_24];
            let input_state_7 = [ is_25, is_26, is_27, is_28];
            let input_state_8 = [ is_29, is_30, is_31, is_32];
            let input_state_9 = [ is_33, is_34, is_35, is_36];
            let input_state_10 = [is_37, is_38, is_39, is_40];
            let input_state_11 = [is_41, is_42, is_43, is_44];
            let input_state_12 = [is_45, is_46, is_47, is_48];
            let input_state_13 = [is_49, is_50, is_51, is_52];
            let input_state_14 = [is_53, is_54, is_55, is_56];
            let input_state_15 = [is_57, is_58, is_59, is_60];
            let input_state_16 = [is_61, is_62, is_63, is_64];
        

            let input_state = [
                                [input_state_1, input_state_2, input_state_3, input_state_4],
                                [input_state_5, input_state_6, input_state_7, input_state_8],
                                [input_state_9, input_state_10, input_state_11, input_state_12],
                                [input_state_13, input_state_14, input_state_15, input_state_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_input_state[4*4*4*k + 4*4*j + 4*i + l], input_state[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.NibblePermutation(input_state, round, costing);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, input_state[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation MixHalfWord(_input_state: Result[], costing: Bool) : Result []
    {
        mutable res_1 = new Result[16];

        using((is_1, is_2, is_3, is_4) = (Qubit[4],Qubit[4],Qubit[4],Qubit[4]))
        {
            let input_state = [is_1, is_2, is_3, is_4];

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    Set(_input_state[4*i + j], input_state[i][j]);
                }
            }

            QSATURNIN.InPlace.MixHalfWord(input_state, costing);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    set res_1 w/= i <- M(input_state[i][j]);
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    Set(Zero, input_state[i][j]);
                }
            }
        }

        return res_1;
    }

    operation MixColumns(_input_state: Result[], costing: Bool) : Result[][] 
    {
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];

        //mutable res = new Result[4][4][4][4];

        using (
                (
                    is_1,  is_2,  is_3,  is_4,  is_5,  is_6,  is_7,  is_8,  is_9,  is_10, is_11, is_12, is_13, is_14, is_15, is_16,
                    is_17, is_18, is_19, is_20, is_21, is_22, is_23, is_24, is_25, is_26, is_27, is_28, is_29, is_30, is_31, is_32,
                    is_33, is_34, is_35, is_36, is_37, is_38, is_39, is_40, is_41, is_42, is_43, is_44, is_45, is_46, is_47, is_48,
                    is_49, is_50, is_51, is_52, is_53, is_54, is_55, is_56, is_57, is_58, is_59, is_60, is_61, is_62, is_63, is_64
                ) 
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let input_state_1 = [ is_1,  is_2,  is_3,  is_4];
            let input_state_2 = [ is_5,  is_6,  is_7,  is_8];
            let input_state_3 = [ is_9,  is_10, is_11, is_12];
            let input_state_4 = [ is_13, is_14, is_15, is_16];
            let input_state_5 = [ is_17, is_18, is_19, is_20];
            let input_state_6 = [ is_21, is_22, is_23, is_24];
            let input_state_7 = [ is_25, is_26, is_27, is_28];
            let input_state_8 = [ is_29, is_30, is_31, is_32];
            let input_state_9 = [ is_33, is_34, is_35, is_36];
            let input_state_10 = [is_37, is_38, is_39, is_40];
            let input_state_11 = [is_41, is_42, is_43, is_44];
            let input_state_12 = [is_45, is_46, is_47, is_48];
            let input_state_13 = [is_49, is_50, is_51, is_52];
            let input_state_14 = [is_53, is_54, is_55, is_56];
            let input_state_15 = [is_57, is_58, is_59, is_60];
            let input_state_16 = [is_61, is_62, is_63, is_64];
        

            let input_state = [
                                [input_state_1, input_state_2, input_state_3, input_state_4],
                                [input_state_5, input_state_6, input_state_7, input_state_8],
                                [input_state_9, input_state_10, input_state_11, input_state_12],
                                [input_state_13, input_state_14, input_state_15, input_state_16] 
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_input_state[4*4*4*k + 4*4*j + 4*i + l], input_state[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.MixColumns(input_state, costing); 

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][0][l]); 
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, input_state[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4]; 
    }

    operation InverseNibblePermutation(_input_state: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];

        using (
                (
                    is_1,  is_2,  is_3,  is_4,  is_5,  is_6,  is_7,  is_8,  is_9,  is_10, is_11, is_12, is_13, is_14, is_15, is_16,
                    is_17, is_18, is_19, is_20, is_21, is_22, is_23, is_24, is_25, is_26, is_27, is_28, is_29, is_30, is_31, is_32,
                    is_33, is_34, is_35, is_36, is_37, is_38, is_39, is_40, is_41, is_42, is_43, is_44, is_45, is_46, is_47, is_48,
                    is_49, is_50, is_51, is_52, is_53, is_54, is_55, is_56, is_57, is_58, is_59, is_60, is_61, is_62, is_63, is_64
                ) 
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let input_state_1 = [ is_1,  is_2,  is_3,  is_4];
            let input_state_2 = [ is_5,  is_6,  is_7,  is_8];
            let input_state_3 = [ is_9,  is_10, is_11, is_12];
            let input_state_4 = [ is_13, is_14, is_15, is_16];
            let input_state_5 = [ is_17, is_18, is_19, is_20];
            let input_state_6 = [ is_21, is_22, is_23, is_24];
            let input_state_7 = [ is_25, is_26, is_27, is_28];
            let input_state_8 = [ is_29, is_30, is_31, is_32];
            let input_state_9 = [ is_33, is_34, is_35, is_36];
            let input_state_10 = [is_37, is_38, is_39, is_40];
            let input_state_11 = [is_41, is_42, is_43, is_44];
            let input_state_12 = [is_45, is_46, is_47, is_48];
            let input_state_13 = [is_49, is_50, is_51, is_52];
            let input_state_14 = [is_53, is_54, is_55, is_56];
            let input_state_15 = [is_57, is_58, is_59, is_60];
            let input_state_16 = [is_61, is_62, is_63, is_64];
        

            let input_state = [
                                [input_state_1, input_state_2, input_state_3, input_state_4],
                                [input_state_5, input_state_6, input_state_7, input_state_8],
                                [input_state_9, input_state_10, input_state_11, input_state_12],
                                [input_state_13, input_state_14, input_state_15, input_state_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_input_state[4*4*4*k + 4*4*j + 4*i + l], input_state[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.InverseNibblePermutation(input_state, round, costing);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, input_state[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation AddRoundConstants(_key: Result[], costing: Bool) : Result[][] 
    {
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];
        using (
                (
                    is_1,  is_2,  is_3,  is_4,  is_5,  is_6,  is_7,  is_8,  is_9,  is_10, is_11, is_12, is_13, is_14, is_15, is_16,
                    is_17, is_18, is_19, is_20, is_21, is_22, is_23, is_24, is_25, is_26, is_27, is_28, is_29, is_30, is_31, is_32,
                    is_33, is_34, is_35, is_36, is_37, is_38, is_39, is_40, is_41, is_42, is_43, is_44, is_45, is_46, is_47, is_48,
                    is_49, is_50, is_51, is_52, is_53, is_54, is_55, is_56, is_57, is_58, is_59, is_60, is_61, is_62, is_63, is_64
                ) 
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let key_1 = [ is_1,  is_2,  is_3,  is_4];
            let key_2 = [ is_5,  is_6,  is_7,  is_8];
            let key_3 = [ is_9,  is_10, is_11, is_12];
            let key_4 = [ is_13, is_14, is_15, is_16];
            let key_5 = [ is_17, is_18, is_19, is_20];
            let key_6 = [ is_21, is_22, is_23, is_24];
            let key_7 = [ is_25, is_26, is_27, is_28];
            let key_8 = [ is_29, is_30, is_31, is_32];
            let key_9 = [ is_33, is_34, is_35, is_36];
            let key_10 = [is_37, is_38, is_39, is_40];
            let key_11 = [is_41, is_42, is_43, is_44];
            let key_12 = [is_45, is_46, is_47, is_48];
            let key_13 = [is_49, is_50, is_51, is_52];
            let key_14 = [is_53, is_54, is_55, is_56];
            let key_15 = [is_57, is_58, is_59, is_60];
            let key_16 = [is_61, is_62, is_63, is_64];
        

            let key = [
                                [key_1, key_2, key_3, key_4],
                                [key_5, key_6, key_7, key_8],
                                [key_9, key_10, key_11, key_12],
                                [key_13, key_14, key_15, key_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_key[4*4*4*k + 4*4*j + 4*i + l], key[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.AddRoundConstants(key, costing);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(key[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(key[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(key[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(key[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, key[i][j][k][l]);
                        }
                    }
                }
            }

        }        
        return [res_1, res_2, res_3, res_4]; 
    } 

    operation RotateKey (_round_key: Result[], costing: Bool) : Result[][] 
    {
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];

        using (
                (
                    key_1,  key_2,  key_3,  key_4,  key_5,  key_6,  key_7,  key_8,  key_9,  key_10, key_11, key_12, key_13, key_14, key_15, key_16,
                    key_17, key_18, key_19, key_20, key_21, key_22, key_23, key_24, key_25, key_26, key_27, key_28, key_29, key_30, key_31, key_32,
                    key_33, key_34, key_35, key_36, key_37, key_38, key_39, key_40, key_41, key_42, key_43, key_44, key_45, key_46, key_47, key_48,
                    key_49, key_50, key_51, key_52, key_53, key_54, key_55, key_56, key_57, key_58, key_59, key_60, key_61, key_62, key_63, key_64
                )  
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let round_key_1 = [ key_1,  key_2,  key_3,  key_4];
            let round_key_2 = [ key_5,  key_6,  key_7,  key_8];
            let round_key_3 = [ key_9,  key_10, key_11, key_12];
            let round_key_4 = [ key_13, key_14, key_15, key_16];
            let round_key_5 = [ key_17, key_18, key_19, key_20];
            let round_key_6 = [ key_21, key_22, key_23, key_24];
            let round_key_7 = [ key_25, key_26, key_27, key_28];
            let round_key_8 = [ key_29, key_30, key_31, key_32];
            let round_key_9 = [ key_33, key_34, key_35, key_36];
            let round_key_10 = [key_37, key_38, key_39, key_40];
            let round_key_11 = [key_41, key_42, key_43, key_44];
            let round_key_12 = [key_45, key_46, key_47, key_48];
            let round_key_13 = [key_49, key_50, key_51, key_52];
            let round_key_14 = [key_53, key_54, key_55, key_56];
            let round_key_15 = [key_57, key_58, key_59, key_60];
            let round_key_16 = [key_61, key_62, key_63, key_64];
    
            let round_key = [
                                [round_key_1, round_key_2, round_key_3, round_key_4],
                                [round_key_5, round_key_6, round_key_7, round_key_8],
                                [round_key_9, round_key_10, round_key_11, round_key_12],
                                [round_key_13, round_key_14, round_key_15, round_key_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_round_key[4*4*4*k + 4*4*j + 4*i + l], round_key[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.RotateKey(round_key, costing);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, round_key[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation SubKeyGeneration(_key: Result[], round : Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[64]; 
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];

        using (
                (
                    key_1,  key_2,  key_3,  key_4,  key_5,  key_6,  key_7,  key_8,  key_9,  key_10, key_11, key_12, key_13, key_14, key_15, key_16,
                    key_17, key_18, key_19, key_20, key_21, key_22, key_23, key_24, key_25, key_26, key_27, key_28, key_29, key_30, key_31, key_32,
                    key_33, key_34, key_35, key_36, key_37, key_38, key_39, key_40, key_41, key_42, key_43, key_44, key_45, key_46, key_47, key_48,
                    key_49, key_50, key_51, key_52, key_53, key_54, key_55, key_56, key_57, key_58, key_59, key_60, key_61, key_62, key_63, key_64
                )  
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let round_key_1 = [ key_1,  key_2,  key_3,  key_4];
            let round_key_2 = [ key_5,  key_6,  key_7,  key_8];
            let round_key_3 = [ key_9,  key_10, key_11, key_12];
            let round_key_4 = [ key_13, key_14, key_15, key_16];
            let round_key_5 = [ key_17, key_18, key_19, key_20];
            let round_key_6 = [ key_21, key_22, key_23, key_24];
            let round_key_7 = [ key_25, key_26, key_27, key_28];
            let round_key_8 = [ key_29, key_30, key_31, key_32];
            let round_key_9 = [ key_33, key_34, key_35, key_36];
            let round_key_10 = [key_37, key_38, key_39, key_40];
            let round_key_11 = [key_41, key_42, key_43, key_44];
            let round_key_12 = [key_45, key_46, key_47, key_48];
            let round_key_13 = [key_49, key_50, key_51, key_52];
            let round_key_14 = [key_53, key_54, key_55, key_56];
            let round_key_15 = [key_57, key_58, key_59, key_60];
            let round_key_16 = [key_61, key_62, key_63, key_64];
    
            let round_key = [
                                [round_key_1, round_key_2, round_key_3, round_key_4],
                                [round_key_5, round_key_6, round_key_7, round_key_8],
                                [round_key_9, round_key_10, round_key_11, round_key_12],
                                [round_key_13, round_key_14, round_key_15, round_key_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_key[4*4*4*k + 4*4*j + 4*i + l], round_key[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.SubKeyGeneration(round_key, round, costing); 

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(round_key[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, round_key[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4];
    }

    operation AddRoundKey(_state: Result[], _round_key: Result[]) : Result[][] 
    {
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];

        using (
                (
                    is_1,  is_2,  is_3,  is_4,  is_5,  is_6,  is_7,  is_8,  is_9,  is_10, is_11, is_12, is_13, is_14, is_15, is_16,
                    is_17, is_18, is_19, is_20, is_21, is_22, is_23, is_24, is_25, is_26, is_27, is_28, is_29, is_30, is_31, is_32,
                    is_33, is_34, is_35, is_36, is_37, is_38, is_39, is_40, is_41, is_42, is_43, is_44, is_45, is_46, is_47, is_48,
                    is_49, is_50, is_51, is_52, is_53, is_54, is_55, is_56, is_57, is_58, is_59, is_60, is_61, is_62, is_63, is_64,
                
                    key_1,  key_2,  key_3,  key_4,  key_5,  key_6,  key_7,  key_8,  key_9,  key_10, key_11, key_12, key_13, key_14, key_15, key_16,
                    key_17, key_18, key_19, key_20, key_21, key_22, key_23, key_24, key_25, key_26, key_27, key_28, key_29, key_30, key_31, key_32,
                    key_33, key_34, key_35, key_36, key_37, key_38, key_39, key_40, key_41, key_42, key_43, key_44, key_45, key_46, key_47, key_48,
                    key_49, key_50, key_51, key_52, key_53, key_54, key_55, key_56, key_57, key_58, key_59, key_60, key_61, key_62, key_63, key_64
                )  
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],

                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let input_state_1 = [ is_1,  is_2,  is_3,  is_4];
            let input_state_2 = [ is_5,  is_6,  is_7,  is_8];
            let input_state_3 = [ is_9,  is_10, is_11, is_12];
            let input_state_4 = [ is_13, is_14, is_15, is_16];
            let input_state_5 = [ is_17, is_18, is_19, is_20];
            let input_state_6 = [ is_21, is_22, is_23, is_24];
            let input_state_7 = [ is_25, is_26, is_27, is_28];
            let input_state_8 = [ is_29, is_30, is_31, is_32];
            let input_state_9 = [ is_33, is_34, is_35, is_36];
            let input_state_10 = [is_37, is_38, is_39, is_40];
            let input_state_11 = [is_41, is_42, is_43, is_44];
            let input_state_12 = [is_45, is_46, is_47, is_48];
            let input_state_13 = [is_49, is_50, is_51, is_52];
            let input_state_14 = [is_53, is_54, is_55, is_56];
            let input_state_15 = [is_57, is_58, is_59, is_60];
            let input_state_16 = [is_61, is_62, is_63, is_64];
        
            let round_key_1 = [ key_1,  key_2,  key_3,  key_4];
            let round_key_2 = [ key_5,  key_6,  key_7,  key_8];
            let round_key_3 = [ key_9,  key_10, key_11, key_12];
            let round_key_4 = [ key_13, key_14, key_15, key_16];
            let round_key_5 = [ key_17, key_18, key_19, key_20];
            let round_key_6 = [ key_21, key_22, key_23, key_24];
            let round_key_7 = [ key_25, key_26, key_27, key_28];
            let round_key_8 = [ key_29, key_30, key_31, key_32];
            let round_key_9 = [ key_33, key_34, key_35, key_36];
            let round_key_10 = [key_37, key_38, key_39, key_40];
            let round_key_11 = [key_41, key_42, key_43, key_44];
            let round_key_12 = [key_45, key_46, key_47, key_48];
            let round_key_13 = [key_49, key_50, key_51, key_52];
            let round_key_14 = [key_53, key_54, key_55, key_56];
            let round_key_15 = [key_57, key_58, key_59, key_60];
            let round_key_16 = [key_61, key_62, key_63, key_64];
        
            let input_state = [
                                [input_state_1, input_state_2, input_state_3, input_state_4],
                                [input_state_5, input_state_6, input_state_7, input_state_8],
                                [input_state_9, input_state_10, input_state_11, input_state_12],
                                [input_state_13, input_state_14, input_state_15, input_state_16]
                            ];

            let round_key = [
                                [round_key_1, round_key_2, round_key_3, round_key_4],
                                [round_key_5, round_key_6, round_key_7, round_key_8],
                                [round_key_9, round_key_10, round_key_11, round_key_12],
                                [round_key_13, round_key_14, round_key_15, round_key_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_state[4*4*4*k + 4*4*j + 4*i + l], input_state[i][j][k][l]);
                            Set(_round_key[4*4*4*k + 4*4*j + 4*i + l], round_key[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.InPlace.AddRoundKey(input_state, round_key);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, input_state[i][j][k][l]);
                            Set(Zero, round_key[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4];
    } 

    operation Round(_state: Result[], _key: Result[], round: Int, costing: Bool) : Result[][]
    {
        mutable res_1 = new Result[64];
        mutable res_2 = new Result[64];
        mutable res_3 = new Result[64];
        mutable res_4 = new Result[64];
        using (
                (
                    is_1,  is_2,  is_3,  is_4,  is_5,  is_6,  is_7,  is_8,  is_9,  is_10, is_11, is_12, is_13, is_14, is_15, is_16,
                    is_17, is_18, is_19, is_20, is_21, is_22, is_23, is_24, is_25, is_26, is_27, is_28, is_29, is_30, is_31, is_32,
                    is_33, is_34, is_35, is_36, is_37, is_38, is_39, is_40, is_41, is_42, is_43, is_44, is_45, is_46, is_47, is_48,
                    is_49, is_50, is_51, is_52, is_53, is_54, is_55, is_56, is_57, is_58, is_59, is_60, is_61, is_62, is_63, is_64,
                
                    key_1,  key_2,  key_3,  key_4,  key_5,  key_6,  key_7,  key_8,  key_9,  key_10, key_11, key_12, key_13, key_14, key_15, key_16,
                    key_17, key_18, key_19, key_20, key_21, key_22, key_23, key_24, key_25, key_26, key_27, key_28, key_29, key_30, key_31, key_32,
                    key_33, key_34, key_35, key_36, key_37, key_38, key_39, key_40, key_41, key_42, key_43, key_44, key_45, key_46, key_47, key_48,
                    key_49, key_50, key_51, key_52, key_53, key_54, key_55, key_56, key_57, key_58, key_59, key_60, key_61, key_62, key_63, key_64
                )  
                = 
                (   
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],

                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4],                    
                    Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4], Qubit[4],Qubit[4],Qubit[4],Qubit[4]
                )
            )
        {
            let input_state_1 = [ is_1,  is_2,  is_3,  is_4];
            let input_state_2 = [ is_5,  is_6,  is_7,  is_8];
            let input_state_3 = [ is_9,  is_10, is_11, is_12];
            let input_state_4 = [ is_13, is_14, is_15, is_16];
            let input_state_5 = [ is_17, is_18, is_19, is_20];
            let input_state_6 = [ is_21, is_22, is_23, is_24];
            let input_state_7 = [ is_25, is_26, is_27, is_28];
            let input_state_8 = [ is_29, is_30, is_31, is_32];
            let input_state_9 = [ is_33, is_34, is_35, is_36];
            let input_state_10 = [is_37, is_38, is_39, is_40];
            let input_state_11 = [is_41, is_42, is_43, is_44];
            let input_state_12 = [is_45, is_46, is_47, is_48];
            let input_state_13 = [is_49, is_50, is_51, is_52];
            let input_state_14 = [is_53, is_54, is_55, is_56];
            let input_state_15 = [is_57, is_58, is_59, is_60];
            let input_state_16 = [is_61, is_62, is_63, is_64];
        
            let round_key_1 = [ key_1,  key_2,  key_3,  key_4];
            let round_key_2 = [ key_5,  key_6,  key_7,  key_8];
            let round_key_3 = [ key_9,  key_10, key_11, key_12];
            let round_key_4 = [ key_13, key_14, key_15, key_16];
            let round_key_5 = [ key_17, key_18, key_19, key_20];
            let round_key_6 = [ key_21, key_22, key_23, key_24];
            let round_key_7 = [ key_25, key_26, key_27, key_28];
            let round_key_8 = [ key_29, key_30, key_31, key_32];
            let round_key_9 = [ key_33, key_34, key_35, key_36];
            let round_key_10 = [key_37, key_38, key_39, key_40];
            let round_key_11 = [key_41, key_42, key_43, key_44];
            let round_key_12 = [key_45, key_46, key_47, key_48];
            let round_key_13 = [key_49, key_50, key_51, key_52];
            let round_key_14 = [key_53, key_54, key_55, key_56];
            let round_key_15 = [key_57, key_58, key_59, key_60];
            let round_key_16 = [key_61, key_62, key_63, key_64];
        
            let input_state = [
                                [input_state_1, input_state_2, input_state_3, input_state_4],
                                [input_state_5, input_state_6, input_state_7, input_state_8],
                                [input_state_9, input_state_10, input_state_11, input_state_12],
                                [input_state_13, input_state_14, input_state_15, input_state_16]
                            ];

            let round_key = [
                                [round_key_1, round_key_2, round_key_3, round_key_4],
                                [round_key_5, round_key_6, round_key_7, round_key_8],
                                [round_key_9, round_key_10, round_key_11, round_key_12],
                                [round_key_13, round_key_14, round_key_15, round_key_16]
                            ];
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(_state[4*4*4*k + 4*4*j + 4*i + l], input_state[i][j][k][l]);
                            Set(_key[4*4*4*k + 4*4*j + 4*i + l], round_key[i][j][k][l]);
                        }
                    }
                }
            }

            QSATURNIN.Round(input_state, round_key, round, costing);

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][0][l]);
                    }
                }
            }
        
            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][1][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][2][l]);
                    }
                }
            }

            for (j in 0..3)
            {
                for (i in 0..3)
                {
                    for (l in 0..3)
                    {
                        set res_1 w/= i <- M(input_state[i][j][3][l]);
                    }
                }
            }

            // cleanup
            for (k in 0..3)
            {
                for (j in 0..3)
                {
                    for (i in 0..3)
                    {
                        for (l in 0..3)
                        {
                            Set(Zero, input_state[i][j][k][l]);
                            Set(Zero, round_key[i][j][k][l]);
                        }
                    }
                }
            }
        }
        return [res_1, res_2, res_3, res_4];
    } 

    operation ForwardSATURNIN(_key : Result[], _state: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[256];
        using ((input_state, round_key)=(Qubit[256], Qubit[256]))
        {
            for (i in 0..255)
            {
                Set(_state[i], input_state[i]);
                Set(_key[i], round_key[i]);
            }

            QSATURNIN.ForwardSATURNIN(round_key, input_state, round, costing);

            for (i in 0..255)
            {
                set res w/= i <- M(input_state[i]);
            }
        

            // cleanup
            for (i in 0..255)
            {
                Set(Zero, input_state[i]);
                Set(Zero, round_key[i]);
            }
        }
        return res;
    }

    //     operation SATURNIN(key: Qubit[], state: Qubit[], ciphertext: Qubit[], round: Int, costing: Bool) : Unit
    operation SATURNIN(_key: Result[], _state: Result[], round: Int, costing: Bool) : Result[]
    {
        mutable res = new Result[256];
        using ((input_state, round_key, ciphertext)=(Qubit[256], Qubit[256], Qubit[256]))
        {
            for (i in 0..255)
            {
                Set(_state[i], input_state[i]);
                Set(_key[i], round_key[i]);
            }

            QSATURNIN.SATURNIN(round_key, input_state, ciphertext, round, costing);

            for (i in 0..255)
            {
                set res w/= i <- M(ciphertext[i]);
            }

            // cleanup
            for (i in 0..255)
            {
                Set(Zero, input_state[i]);
                Set(Zero, round_key[i]);
            }
        }
        return res;
    
    }
    // operation GroverOracle(key_superposition: Qubit[], success: Qubit, plaintext: Qubit[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Unit
    
    operation GroverOracle (_key: Result[], _plaintexts: Result[], target_ciphertext: Bool[], pairs: Int, round: Int, costing: Bool) : Result
    {
        mutable res = Zero;

        using ((key, success, plaintext) = (Qubit[256], Qubit(), Qubit[256*pairs]))
        {
            for (i in 0..255) 
            {
                Set(_key[i], key[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..255)
                {
                    Set(_plaintexts[256*j + i], plaintext[256*j + i]); 
                }
            }

            // in actual use, we'd initialise set Success to |-), but not in this case
            QSATURNIN.GroverOracle(key, success, plaintext, target_ciphertext, pairs, round, costing);

            set res = M(success);

            Set(Zero, success);
            for (i in 0..255) 
            {
                Set(Zero, key[i]);
            }
            for (j in 0..(pairs-1))
            {
                for (i in 0..255) 
                {
                    Set(Zero, plaintext[256*j + i]); 
                }
            }
        }
        return res;
    }
}

