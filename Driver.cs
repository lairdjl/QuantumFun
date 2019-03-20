using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Bell
{
    class Driver
    {
        enum TEST_TO_RUN {
            BELLTEST_SINGLE,
            BELLTEST_DOUBLE
        } 
        static void Main(string[] args)
        {
                TEST_TO_RUN testToRun = TEST_TO_RUN.BELLTEST_DOUBLE;

                switch(testToRun){
                    case TEST_TO_RUN.BELLTEST_SINGLE:
                        _bellTestSingleQubit();
                        break;
                    case TEST_TO_RUN.BELLTEST_DOUBLE:
                        _bellTestDoubleQubit();
                        break;
                    default:

                    break;

            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }

        static void _bellTestSingleQubit(){
             using (var qsim = new QuantumSimulator()){

                var estimator = new ResourcesEstimator();
                BellTestSingleQubit.Run(estimator, 1000, Result.Zero).Wait();

                System.Console.WriteLine(estimator.ToTSV());
            
                System.Console.WriteLine("Press any key to continue...");
                Console.ReadKey();

                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };
                System.Console.WriteLine("** BELL TEST SINGLE QUBIT **");
                    foreach (Result initial in initials)
                {
                    var res = BellTestSingleQubit.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes) = res;
                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
                }
        }
        }

                static void _bellTestDoubleQubit(){
             using (var qsim = new QuantumSimulator()){

                var estimator = new ResourcesEstimator();
                BellTestTwoQubits.Run(estimator, 1000, Result.Zero).Wait();

                System.Console.WriteLine(estimator.ToTSV());
            
                System.Console.WriteLine("Press any key to continue...");
                Console.ReadKey();

                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };

                System.Console.WriteLine("** BELL TEST TWO QUBITS **");

                foreach (Result initial in initials)
                {
                    var res = BellTestTwoQubits.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes, agree) = res;
                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4} agree={agree, -4}");
                }
        }
        }
    }
}