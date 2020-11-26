// Copyright (c) IIT Ropar.
// Licensed under the free license.

using System;
using System.Collections.Generic;
using Microsoft.Quantum.Simulation.Simulators.QCTraceSimulators;
using Microsoft.Quantum.Simulation.Core;
using static Utilities;
using FileHelpers; // csv parsing

namespace cs
{ 
    class Estimates  
    {
        static QCTraceSimulator getTraceSimulator(bool full_depth)
        {
            var config = new QCTraceSimulatorConfiguration();
            config.useDepthCounter = true;
            config.useWidthCounter = true;
            config.usePrimitiveOperationsCounter = true;
            config.throwOnUnconstraintMeasurement = false;

            if (full_depth)
            {
                config.gateTimes[PrimitiveOperationsGroups.CNOT] = 1;
                config.gateTimes[PrimitiveOperationsGroups.Measure] = 1; // count all one and 2 qubit measurements as depth 1
                config.gateTimes[PrimitiveOperationsGroups.QubitClifford] = 1; // qubit Clifford depth 1
            }
            return new QCTraceSimulator(config);
        }

        public static void ProcessSim<Qop>(QCTraceSimulator sim, string comment = "", bool full_depth = false, string suffix="")
        {
            if (!full_depth)
            {
                DisplayCSV.CSV(sim.ToCSV(), typeof(Qop).FullName, false, comment, false, suffix);
            }
            else
            {
                // full depth only
                var depthEngine = new FileHelperAsyncEngine<DepthCounterCSV>();
                using (depthEngine.BeginReadString(sim.ToCSV()[MetricsCountersNames.depthCounter]))
                {
                    // The engine is IEnumerable
                    foreach (DepthCounterCSV cust in depthEngine)
                    {
                        if (cust.Name == typeof(Qop).FullName)
                        {
                            Console.Write($"{cust.DepthAverage}");
                        }
                    }
                }
            }
        }

        public static void SkinnySBox<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.SkinnySBox.Run(sim, QBits(0), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.SkinnySBox.Run(sim, QBits(0), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }
        
        public static void SubCells<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.SubCells.Run(sim, nQBits(64, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.SubCells.Run(sim, nQBits(64, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }
        
        public static void AddConstants<Qop>(string comment = "", int round = 40, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.AddConstants.Run(sim, nQBits(64, false), round, true).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.AddConstants.Run(sim, nQBits(64, false), round, true).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void AddRoundTweakey<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.AddRoundTweakey.Run(sim, nQBits(64, false), nQBits(64, false)).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.AddRoundTweakey.Run(sim, nQBits(64, false), nQBits(64, false)).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void AddRoundTweakey_z2<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.AddRoundTweakey_z2.Run(sim, nQBits(64, false), nQBits(128, false)).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.AddRoundTweakey_z2.Run(sim, nQBits(64, false), nQBits(128, false)).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void AddRoundTweakey_z3<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.AddRoundTweakey_z3.Run(sim, nQBits(64, false), nQBits(192, false)).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.AddRoundTweakey_z3.Run(sim, nQBits(64, false), nQBits(192, false)).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void TweakeyUpdate<Qop>(string comment = "", int round = 40, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.TweakeyUpdate.Run(sim, nQBits(64, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.TweakeyUpdate.Run(sim, nQBits(64, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void TweakeyUpdate_z2<Qop>(string comment = "", int round = 40, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.TweakeyUpdate_2.Run(sim, nQBits(64, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.TweakeyUpdate_2.Run(sim, nQBits(64, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void TweakeyUpdate_z3<Qop>(string comment = "", int round = 40, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.TweakeyUpdate_3.Run(sim, nQBits(64, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.TweakeyUpdate_3.Run(sim, nQBits(64, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void ShiftRows<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.ShiftRows.Run(sim, nQBits(64, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.ShiftRows.Run(sim, nQBits(64, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void MixHalfWord<Qop>(string comment = "", bool in_place = true, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.MixHalfWord.Run(sim, nQBits(16, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.MixHalfWord.Run(sim, nQBits(16, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void MixColumns<Qop>(string comment = "", bool in_place = true, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.MixColumns.Run(sim, nQBits(64, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.MixColumns.Run(sim, nQBits(64, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void Round<Qop>(string comment = "", int round = 0, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.Round.Run(sim, nQBits(64, false), nQBits(64, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.Round.Run(sim, nQBits(64, false), nQBits(64, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }
        public static void Round_z2<Qop>(string comment = "", int round = 0, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.Round_z2.Run(sim, nQBits(64, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.Round_z2.Run(sim, nQBits(64, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }
        public static void Round_z3<Qop>(string comment = "", int round = 0, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.Round_z3.Run(sim, nQBits(128, false), nQBits(192, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.Round_z3.Run(sim, nQBits(128, false), nQBits(192, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void Skinny_64_64<Qop>(string comment = "", int round = 40, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.Skinny_64_64.Run(sim, nQBits(64, false), nQBits(64, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.Skinny_64_64.Run(sim, nQBits(64, false), nQBits(64, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void Skinny_64_128<Qop>(string comment = "", int round = 48, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.Skinny_64_128.Run(sim, nQBits(64, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.Skinny_64_128.Run(sim, nQBits(64, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void Skinny_64_192<Qop>(string comment = "", int round = 56, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.Skinny_64_192.Run(sim, nQBits(64, false), nQBits(192, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.Skinny_64_192.Run(sim, nQBits(64, false), nQBits(192, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void GroverOracle_64_64<Qop>(string comment = "", int pairs = 1, int round = 40, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.GroverOracle_64_64.Run(sim, nQBits(64, false), nQBits(64*pairs, false), nBits(64*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.GroverOracle_64_64.Run(sim, nQBits(64, false), nQBits(64*pairs, false), nBits(64*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }
        
        public static void GroverOracle_64_128<Qop>(string comment = "", int pairs = 1, int round = 40, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.GroverOracle_64_128.Run(sim, nQBits(128, false), nQBits(64*pairs, false), nBits(64*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.GroverOracle_64_128.Run(sim, nQBits(128, false), nQBits(64*pairs, false), nBits(64*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }
        
        public static void GroverOracle_64_192<Qop>(string comment = "", int pairs = 1, int round = 40, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SKINNY.GroverOracle_64_192.Run(sim, nQBits(192, false), nQBits(64*pairs, false), nBits(64*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.SKINNY.GroverOracle_64_192.Run(sim, nQBits(192, false), nQBits(64*pairs, false), nBits(64*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);  
        } 
    }
}
