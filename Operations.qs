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

     operation BellTest (count : Int, initial: Result) : (Int, Int)
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
}
