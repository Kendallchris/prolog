/*
    Test File for Prolog Assignment
    
*/

/* Data Definitions */

sat([1714,1664,1760,1685,1693,1764,1764,1792,1850,1735]).
gpa([2.4,2.52,2.54,2.74,2.83,3,3,3.01,3.01,3.02]).
/*
{{2.4,1714},{2.52,1664},{2.54,1760},{2.74,1685},{2.83,1693},{3,1764},{3,1764},{3.01,1792},{3.01,1850},{3.02,1735}}
data1([10,11,12,14,9]).
*/

writeln(T) :- write(T), nl.

main :-
        gpa(Gpa), /* Get GPA List */
        sat(Sat), /* Get SAT List */
        mean(Gpa, MeanG), /* Get Mean GPA */
        mean(Sat, MeanS), /* Get Mean SAT */
        stddev(Gpa, SDG), /* Get Standard Deviation of GPA */
        stddev(Sat, SDS), /* Get Standard Deviation of SAT */
        regressiona(Sat, Gpa, A), /* Get Regression alpha parameter */
        regressionb(Sat, Gpa, B), /* Get Regression beta parameter */
        correlation(Gpa, Sat, R), /* Get Pearson Correlation Coefficient */
        /* [10,11,12,14,9] */
        load_data_column('data1.csv', false, 0, ListOne), /* Load Data from CSV */
        /* [10,11,12,14,9] */
        load_data_column('data2.csv', true, 0, ListTwo), /* Load Data from CSV */
        /* [1714,1664,1760,1685,1693,1764,1764,1792,1850,1735] */
        load_data_column('sat-gpa.csv', true, 1, ListThree), /* Load Data from CSV */

        /* 2.8070 */
        writeln(MeanG),     
        /* 1742.1 */
        writeln(MeanS),
        /* 0.2295 */     
        writeln(SDG),       
        /* 52.9367 */
        writeln(SDS),       
        /* 0.0025 Wolfram Alpha: 0.00252447 */
        writeln(A),         
        /* -1.5909 Wolrfram Alpha: -1.59088*/
        writeln(B),         
        /* 0.5823 Wolfram Alpha: 0.582348 */
        writeln(R),        
        /* [10,11,12,14,9] */ 
        writeln(ListOne),   
        /* [10,11,12,14,9] */
        writeln(ListTwo),   
        /* [1714,1664,1760,1685,1693,1764,1764,1792,1850,1735] */
        writeln(ListThree). 
