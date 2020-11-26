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

        public static void SaturninSboxZero<Qop>(string comment = "", bool free_swaps = true) 
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.SaturninSboxZero.Run(sim, QBits(0), free_swaps).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.SaturninSboxZero.Run(sim, QBits(0), free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void SaturninSBoxOne<Qop>(string comment = "", bool free_swaps = true) 
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.SaturninSboxOne.Run(sim, QBits(0), free_swaps).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.SaturninSboxOne.Run(sim, QBits(0), free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        }
        
        public static void SubCells<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.SubCells.Run(sim, nQBits(256, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.SubCells.Run(sim, nQBits(256, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void NibblePermutation<Qop>(string comment = "", int round = 20, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.NibblePermutation.Run(sim, nQBits(256, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.NibblePermutation.Run(sim, nQBits(256, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void MixHalfWord<Qop>(string comment = "", bool in_place = true, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.MixHalfWord.Run(sim, nQBits(16, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.MixHalfWord.Run(sim, nQBits(16, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void MixColumns<Qop>(string comment = "", bool in_place = true, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.MixColumns.Run(sim, nQBits(256, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.MixColumns.Run(sim, nQBits(256, false), free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        } 
        
        public static void InverseNibblePermutation<Qop>(string comment = "", int round = 20, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.InverseNibblePermutation.Run(sim, nQBits(256, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.InverseNibblePermutation.Run(sim, nQBits(256, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void AddRoundKey<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.AddRoundKey.Run(sim, nQBits(256, false), nQBits(256, false)).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.AddRoundKey.Run(sim, nQBits(256, false), nQBits(256, false)).Result;
            ProcessSim<Qop>(sim, comment, true); 
        } 
 

        public static void AddRoundConstants<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.AddRoundConstants.Run(sim, nQBits(256, false), true).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.AddRoundConstants.Run(sim, nQBits(256, false), true).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void RotateKey<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.RotateKey.Run(sim, nQBits(256, false), true).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.RotateKey.Run(sim, nQBits(256, false), true).Result;  
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void SubKeyGeneration<Qop>(string comment = "", int round = 20, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.SubKeyGeneration.Run(sim, nQBits(256, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.SubKeyGeneration.Run(sim, nQBits(256, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true); 
        }


        public static void Round<Qop>(string comment = "", int round = 0, bool free_swaps = true) 
        { 
            var sim = getTraceSimulator(false); 
            var res = QTests.SATURNIN.Round.Run(sim, nQBits(256, false), nQBits(256, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment); 
            sim = getTraceSimulator(true); 
            res = QTests.SATURNIN.Round.Run(sim, nQBits(256, false), nQBits(256, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void SATURNIN<Qop>(string comment = "", int round = 20, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.SATURNIN.SATURNIN.Run(sim, nQBits(256, false), nQBits(256, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix); 
            sim = getTraceSimulator(true);
            res = QTests.SATURNIN.SATURNIN.Run(sim, nQBits(256, false), nQBits(256, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void GroverOracle<Qop>(string comment = "", int pairs = 1, int round = 20, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false); 
            var res = QTests.SATURNIN.GroverOracle.Run(sim, nQBits(256, false), nQBits(256*pairs, false), nBits(256*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);  
            sim = getTraceSimulator(true);  
            res = QTests.SATURNIN.GroverOracle.Run(sim, nQBits(256, false), nQBits(256*pairs, false), nBits(256*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);   
        }
    }
}
