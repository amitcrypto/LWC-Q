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

            
            // GIFT-64
            Estimates.GiftSBox<QGIFT.InPlace.GiftSbox>("tower_field = false", free_swaps); 
            Estimates.SubCells<QGIFT.InPlace.SubCells>("state size is the same for all", free_swaps); 
            Estimates.PermBits<QGIFT.InPlace.PermBits>("in_place = true - state size is the same for all", free_swaps);
            Estimates.AddRoundKey<QGIFT.InPlace.AddRoundKey>("widest = true - state size is the same for all", free_swaps);
            Estimates.KeySchedule<QGIFT.InPlace.KeySchedule>("in_place = true - round = 28", 28, free_swaps); 
            Estimates.AddConstants<QGIFT.InPlace.AddConstants>("widest = true - state size is the same for all", 28, free_swaps); 

            // GIFT-64
            Estimates.Round<QGIFT.Round>("state size is the same for all", 0, free_swaps);
            for (int round = 1; round <= 28; round++)
            {
                Estimates.Round<QGIFT.Round>($"round = {round}", round, free_swaps); 
            }
            
            Estimates.Gift<QGIFT.Gift>("in_place", 28, free_swaps, "_128_in-place"); 

            Estimates.GroverOracle<QGIFT.GroverOracle>("in_place mixcolumn - r = 1", 1, 28, free_swaps, "_128_in-place-MC_r1");
            Estimates.GroverOracle<QGIFT.GroverOracle>("in_place mixcolumn - r = 2", 2, 28, free_swaps, "_128_in-place-MC_r2");
            Estimates.GroverOracle<QGIFT.GroverOracle>("in_place mixcolumn - r = 3", 3, 28, free_swaps, "_128_in-place-MC_r3"); 
            
            Console.WriteLine();
        }
    }
}
