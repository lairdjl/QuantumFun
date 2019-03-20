namespace Bell
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation Set (desired: Result, q1: Qubit) : Unit {
        // Message("Hello quantum world!");
        let current = M(q1);

        if(desired != current){
            X(q1);
        }
    }

     operation BellTestSingleQubit (count : Int, initial: Result) : (Int, Int)
    {
        mutable numOnes = 0;
        using (qubit = Qubit())
        {
            for (test in 1..count)
            {
                Set (initial, qubit);

                //Performing an X gate fully flips the qubit
                //X(qubit);

                //Performing an  H (Hadarmard) gate half flips the qubit
                H(qubit);

                //Measures the qubit
                let res = M (qubit);

                // Count the number of ones we saw:
                if (res == One)
                {
                    set numOnes = numOnes + 1;
                }
            }
            Set(Zero, qubit);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    }

    operation BellTestTwoQubits(count : Int, initial: Result): (Int, Int, Int)
    {
        mutable numOnes = 0;
        mutable agree = 0;
        using (qubits = Qubit[2])
        {
            for(test in 1..count)
            {
                Set (initial, qubits[0]);
                Set (Zero, qubits[1]);

                H(qubits[0]);

                //CNOT Entangles the qubits, so that whatever happens to one of them, happens to the other.
                CNOT(qubits[0], qubits[1]);
                let res = M (qubits[0]);

                //see how the second qubit reacts to the first being measured
                if(M (qubits[1]) == res)
                {
                    set agree = agree + 1;
                }

                //count the number of ones we saw:
                if(res == One){
                    set numOnes = numOnes + 1;
                }
            }
            
            Set(Zero, qubits[0]);
            Set(Zero, qubits[1]);
        }


        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes, agree);
    }
}
