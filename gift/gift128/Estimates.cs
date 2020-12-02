// Copyright (c) 2020 Amit Kumar Chauhan, IIT Ropar.
// Licensed under MIT license.

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

        public static void GiftSBox<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.GiftSBox.Run(sim, QBits(0), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.GiftSBox.Run(sim, QBits(0), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }
        
        public static void SubCells<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.SubCells.Run(sim, nQBits(128, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.SubCells.Run(sim, nQBits(128, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void PermBits<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.PermBits.Run(sim, nQBits(128, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.PermBits.Run(sim, nQBits(128, false), free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void AddRoundKey<Qop>(string comment = "", bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.AddRoundKey.Run(sim, nQBits(128, false), nQBits(128, false)).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.AddRoundKey.Run(sim, nQBits(128, false), nQBits(128, false)).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void KeySchedule<Qop>(string comment = "", int round = 40, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.KeySchedule.Run(sim, nQBits(128, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.KeySchedule.Run(sim, nQBits(128, false), round, free_swaps).Result; 
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void AddConstants<Qop>(string comment = "", int round = 40, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.AddConstants.Run(sim, nQBits(128, false), round, true).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.AddConstants.Run(sim, nQBits(128, false), round, true).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void Round<Qop>(string comment = "", int round = 0, bool free_swaps = true)
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.Round.Run(sim, nQBits(128, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.Round.Run(sim, nQBits(128, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }

        public static void Gift<Qop>(string comment = "", int round = 40, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.Gift.Run(sim, nQBits(128, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.Gift.Run(sim, nQBits(128, false), nQBits(128, false), round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true);
        }

        public static void GroverOracle<Qop>(string comment = "", int pairs = 1, int round = 40, bool free_swaps = true, string suffix = "")
        {
            var sim = getTraceSimulator(false);
            var res = QTests.GIFT.GroverOracle.Run(sim, nQBits(128, false), nQBits(128*pairs, false), nBits(128*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, false, suffix);
            sim = getTraceSimulator(true);
            res = QTests.GIFT.GroverOracle.Run(sim, nQBits(128, false), nQBits(128*pairs, false), nBits(128*pairs, false), pairs, round, free_swaps).Result;
            ProcessSim<Qop>(sim, comment, true); 
        }
    }
}
