// Copyright (c) IIT Ropar.
// Licensed under the free license.

using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace cs
{
    class Driver
    {
        static void Main(string[] args) 
        {
            // estimating costs

            bool free_swaps = true;

            Console.Write("operation, CNOT count, 1-qubit Clifford count, T count, R count, M count, T depth, initial width, extra width, comment, full depth");

            
            // SATURNIN 
            Estimates.SaturninSboxZero<QSATURNIN.InPlace.SaturninSboxZero>("in_place = true", free_swaps); 
            Estimates.SaturninSBoxOne<QSATURNIN.InPlace.SaturninSboxOne>("in_place = true", free_swaps);  
            Estimates.SubCells<QSATURNIN.InPlace.SubCells>("in_place = true", free_swaps);   
            Estimates.NibblePermutation<QSATURNIN.InPlace.NibblePermutation>("in_place = true", 20, free_swaps);   
            Estimates.MixHalfWord<QSATURNIN.InPlace.MixHalfWord>("in_place = true", true, free_swaps);   
            Estimates.MixColumns<QSATURNIN.InPlace.MixColumns>("in_place = true", true, free_swaps);   
            Estimates.InverseNibblePermutation<QSATURNIN.InPlace.InverseNibblePermutation>("in_place = true", 20, free_swaps);   
            Estimates.AddRoundKey<QSATURNIN.InPlace.AddRoundKey>("in_place = true", free_swaps); 
            Estimates.AddRoundConstants<QSATURNIN.InPlace.AddRoundConstants>("in_place = true", free_swaps); 
            Estimates.RotateKey<QSATURNIN.InPlace.RotateKey>("in_place = true", free_swaps);
            Estimates.SubKeyGeneration<QSATURNIN.InPlace.SubKeyGeneration>("in_place = true, super-round = 10, ", 20, free_swaps); 


            // SATURNIN 256 
            Estimates.Round<QSATURNIN.Round>("state size is the same for all", 0, free_swaps);
            for (int round = 1; round <= 20; round++)
            {
                Estimates.Round<QSATURNIN.Round>($"round = {round}", round, free_swaps); 
            }
            
            Estimates.SATURNIN<QSATURNIN.SATURNIN>("in_place", 20, free_swaps, "_256_in-place");  

            Estimates.GroverOracle<QSATURNIN.GroverOracle>("in_place mixcolumn - r = 1", 1, 20, free_swaps, "_256_in-place-MC_r1");
            Estimates.GroverOracle<QSATURNIN.GroverOracle>("in_place mixcolumn - r = 2", 2, 20, free_swaps, "_256_in-place-MC_r2");
            Estimates.GroverOracle<QSATURNIN.GroverOracle>("in_place mixcolumn - r = 3", 3, 20, free_swaps, "_256_in-place-MC_r3"); 
            
            Console.WriteLine();
        }
    }
}
