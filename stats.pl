/* 
 * stats.pl - this program implements functions to read from a CSV file and to calculate linear regression, Pearson Correlation Coefficient, mean, and standard deviation
 * Chris Kendall
 * 20 November, 2023
 */

/*
 * Loads the column C from a CSV file file.csv. Header: (true or false) indicates whether the file has headers or not. 
 * The values of the column are placed on list List.
 * Parameters:
 *  FileName: the name of the CSV file.
 *  Header: true if the CSV file has a header row, false otherwise.
 *  C: the 0-based index of the column to load.
 *  List: the list where the column's values will be stored.
 */
load_data_column(FileName, Header, C, List) :-
    ColumnIndex is C + 1,                                   % Prolog lists are 1-indexed
    open(FileName, read, Stream),                           % Prolog native 'open' predicate: open(+FileName, +Mode, -Stream)
    ( Header -> read_line_to_string(Stream, _); true ),     % Skip the header line if Header is true.
    read_data(Stream, ColumnIndex, List),                   % Read data from the stream and store it in List.
    close(Stream).

% helper function for 'load_data_column'
% Parameters:
%   Stream: the input stream from which to read.
%   ColumnIndex: the 1-based index of the column to extract values from.
%   List: the list where the columns values will be stored.
read_data(Stream, ColumnIndex, List) :-
    read_line_to_string(Stream, Line),                      % Prolog native 'read_line_to_string' predicate: read_line_to_string(+Stream, -Line)
    (Line \= end_of_file ->                                 % if end of file has not been reached continue
        split_string(Line, ",", "", Columns),               % Split the line into columns based on commas; split_string(+String, +Delimiters, +Pad, -SubStrings)
        nth1(ColumnIndex, Columns, StringValue),            % Extract the value at ColumnIndex from the split line; nth1(+Index, ?List, ?Element)
        number_string(Value, StringValue),                  % Convert string to number
        read_data(Stream, ColumnIndex, Rest),               % recurse
        List = [Value|Rest];
      List = []                                             % Once end is reached return an empty list
    ).

% helper to recursively count the sum of each squared value in a list
sum_Square([], 0).                          % base case
sum_Square([Head|Tail], Sum) :-             % recursive case
    sum_Square(Tail, TailSum),
    Squared is Head * Head,
    Sum is Squared + TailSum.

% helper to recursively sum the products of 2 lists
sum_Products([], [], 0).
sum_Products([H1|T1], [H2|T2], Sum) :-
    sum_Products(T1, T2, TailSum),
    Product is H1 * H2,
    Sum is Product + TailSum.

% helper to recursively sum a list, also counting the number of items in the list
sum_List([], 0, 0).
sum_List([Head|Tail], Sum, Num) :-
    sum_List(Tail, TailSum, TailNum),
    Sum is Head + TailSum,
    Num is 1 + TailNum.

/*********************************** MIGHT NEED TO FLIP THE LIST PARAMETERS ON REGA AND REGB **********************************************/

/*
 * Calculates the alpha parameter of the linear regression using list X and list Y. Places the alpha parameter in variable A.
 * Parameters:
 *  X: List 1
 *  Y: List 2
 *  A: the alpha value to be calculated
 */
 regressiona(X, Y, A) :-
    mean(X, MeanX),
    mean(Y, MeanY),
    regressionb(X, Y, B),
    A is MeanY - B * MeanX.
    

/*
 * Calculates the beta parameter of the linear regression using list X and list Y. Places the beta parameter in variable B.
* Parameters:
 *  X: List 1
 *  Y: List 2
 *  A: the beta value to be calculated
 */
regressionb(X, Y, B) :-
    sum_Products(X, Y, SumXY),
    sum_List(X, SumX, N),
    sum_List(Y, SumY, _),
    sum_Square(X, SumX2),
    B is (N * SumXY - SumX * SumY) / (N * SumX2 - SumX * SumX).


/*
 * Calculates the Pearson Correlation Coefficient of the linear regression using lists X and Y. Places the value of coefficient r in variable R.
* Parameters:
 *  X: List 1
 *  Y: List 2
 *  A: the coefficient r value to be calculated
 */
correlation(X, Y, R) :-
    sum_Products(X, Y, SumXY),
    sum_List(X, SumX, N),
    sum_List(Y, SumY, _),
    sum_Square(X, SumX2),
    sum_Square(Y, SumY2),
    Numerator is (N * SumXY - SumX * SumY),
    DenominatorX is (N * SumX2 - SumX * SumX),
    DenominatorY is (N * SumY2 - SumY * SumY),
    Denominator is sqrt(DenominatorX * DenominatorY),
    R is Numerator / Denominator.

/*
 * Calculates the mean of the values in list L. Places the mean in variable M
 * Parameters:
 *  L: List of values
 *  M: the mean to be calculated
 */
mean(L, M) :-
    count_Sum(L, Sum, Num),
    ( Num > 0 -> M is Sum / Num ; M is 0).

% helpers to recursively travers the list, summing it and counting it.
count_Sum([], 0, 0).                            % base case
count_Sum([Head|Tail], Sum, Num) :-             % recursive case
    count_Sum(Tail, TailSum, TailNum),
    Sum is Head + TailSum,
    Num is 1 + TailNum.

/*
 * Calculates the standard deviation of the values in list L. Places the standard deviation in variable S
 * Parameters:
 *  L: List of values
 *  S: the standard deviation value to be calculated
 */
stddev(L, S) :-
    mean(L, M),
    count_Dev(L, SumDev, Num, M),                               % call helper function to get the number in list as well as the sum of their squared deviations
    (Num > 1 -> Variance is SumDev / (Num) ; Variance is 0),    % if more than 1 element in 'L' calculate standard deviation (before taking square root), else 'Variance' is 0
    S is sqrt(Variance).                                        % finish calculating 'S'

% Helpers to recursively traverse the list, summing the square of deviations from the mean and counting elements.
count_Dev([], 0, 0, _).                                 % Base case
count_Dev([Head|Tail], SumDev, Num, Mean) :-            % Recursive case
    count_Dev(Tail, TailSumDev, TailNum, Mean),
    Deviation is Head - Mean,
    SquaredDeviation is Deviation * Deviation,
    SumDev is SquaredDeviation + TailSumDev,
    Num is 1 + TailNum.