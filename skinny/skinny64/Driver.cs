// Copyright (c) 2020 IIT Ropar.
// Licensed under MIT license.

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

            
            // SKINNY-64 
            Estimates.SkinnySBox<QSKINNY.InPlace.SkinnySbox>("tower_field = false", free_swaps); 
            Estimates.SubCells<QSKINNY.InPlace.SubCells>("state size is the same for all", free_swaps); 
            Estimates.AddConstants<QSKINNY.InPlace.AddConstants>("in_place = true - state size is the same for all", 40, free_swaps);
            Estimates.AddRoundTweakey<QSKINNY.InPlace.AddRoundTweakey>("widest = true - state size is the same for all", free_swaps);
            Estimates.AddRoundTweakey_z2<QSKINNY.InPlace.AddRoundTweakey_z2>("widest = true - state size is the same for all", free_swaps);
            Estimates.AddRoundTweakey_z3<QSKINNY.InPlace.AddRoundTweakey_z3>("widest = true - state size is the same for all", free_swaps);
            
            
            Estimates.TweakeyUpdate<QSKINNY.InPlace.TweakeyUpdate>("in_place = true - round = 32", 32, free_swaps); 
            Estimates.TweakeyUpdate_z2<QSKINNY.InPlace.TweakeyUpdate_2>("in_place = true - round = 36", 36, free_swaps); 
            Estimates.TweakeyUpdate_z3<QSKINNY.InPlace.TweakeyUpdate_3>("in_place = true - round = 40", 40, free_swaps); 
            

            Estimates.ShiftRows<QSKINNY.InPlace.ShiftRows>("widest = true - state size is the same for all", free_swaps); 
            Estimates.MixHalfWord<QSKINNY.InPlace.MixHalfWord>("widest = true - state size is the same for all", true, free_swaps); 
            Estimates.MixColumns<QSKINNY.InPlace.MixColumns>("widest = true - state size is the same for all", true, free_swaps); 


            // SKINNY-64 
            Estimates.Round<QSKINNY_64_64.Round>("state size is the same for all", 0, free_swaps);
            for (int round = 1; round <= 32; round++) 
            {
                Estimates.Round<QSKINNY_64_64.Round>($"round = {round}", round, free_swaps); 
            }

            Estimates.Round<QSKINNY_64_128.Round>("state size is the same for all", 0, free_swaps);
            for (int round = 1; round <= 36; round++)
            {
                Estimates.Round_z2<QSKINNY_64_128.Round>($"round = {round}", round, free_swaps); 
            }

            Estimates.Round<QSKINNY_64_192.Round>("state size is the same for all", 0, free_swaps);
            for (int round = 1; round <= 40; round++)
            {
                Estimates.Round_z3<QSKINNY_64_192.Round>($"round = {round}", round, free_swaps); 
            }
            
            Estimates.Skinny_64_64<QSKINNY_64_64.Skinny>("in_place", 32, free_swaps, "_128_in-place"); 
            Estimates.Skinny_64_128<QSKINNY_64_128.Skinny>("in_place", 36, free_swaps, "_128_in-place"); 
            Estimates.Skinny_64_192<QSKINNY_64_192.Skinny>("in_place", 40, free_swaps, "_128_in-place"); 

            Estimates.GroverOracle_64_64<QSKINNY_64_64.GroverOracle>("in_place mixcolumn - r = 1", 1, 32, free_swaps, "_128_in-place-MC_r1");
            Estimates.GroverOracle_64_64<QSKINNY_64_64.GroverOracle>("in_place mixcolumn - r = 2", 2, 32, free_swaps, "_128_in-place-MC_r2");
            Estimates.GroverOracle_64_64<QSKINNY_64_64.GroverOracle>("in_place mixcolumn - r = 3", 3, 32, free_swaps, "_128_in-place-MC_r3"); 
            
            Estimates.GroverOracle_64_128<QSKINNY_64_128.GroverOracle>("in_place mixcolumn - r = 1", 1, 36, free_swaps, "_128_in-place-MC_r1");
            Estimates.GroverOracle_64_128<QSKINNY_64_128.GroverOracle>("in_place mixcolumn - r = 2", 2, 36, free_swaps, "_128_in-place-MC_r2");
            Estimates.GroverOracle_64_128<QSKINNY_64_128.GroverOracle>("in_place mixcolumn - r = 3", 3, 36, free_swaps, "_128_in-place-MC_r3"); 
            
            Estimates.GroverOracle_64_192<QSKINNY_64_192.GroverOracle>("in_place mixcolumn - r = 1", 1, 40, free_swaps, "_128_in-place-MC_r1");
            Estimates.GroverOracle_64_192<QSKINNY_64_192.GroverOracle>("in_place mixcolumn - r = 2", 2, 40, free_swaps, "_128_in-place-MC_r2");
            Estimates.GroverOracle_64_192<QSKINNY_64_192.GroverOracle>("in_place mixcolumn - r = 3", 3, 40, free_swaps, "_128_in-place-MC_r3"); 
            

            Console.WriteLine();
        }
    }
}
