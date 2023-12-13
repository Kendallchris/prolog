[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Lw1frA55)
# Prolog Programming Assignment

## Motivation
Artificial Intelligence has gotten more attention in recent years. There are more AI tools available to the public than ever before: Alexa, Siri, Ericka, etc. not to mention services like Google Cloud Machine Learning, Deep Learning on AWS, IBM Cognitive, Microsoft Azure Machine Learning, etc. Furthermore, generative AI is coming to the picture with services like ChatGPT, Bard, etc. One of the early attempts to deal with AI was the development of “AI specific” languages. This is the case of Prolog, a declarative language that stores facts and rules (and other constructs as well), and has an interface where the user can query and make questions that Prolog’s engine will answer inferring from the facts and rules that where stored.
Another motivation for this assignment is to expose students to a completely different paradigm of programming. Three hundred and fifty eight, I will ask this number in the final. Up to this moment, most of the students have been working and coding with imperative and object-oriented languages, and a declarative language should pose a new challenge, as it requires a different way to think.

## Description
Write a Prolog program for the calculation of simple statistical values. The operations you are going to code are:
- Calculate the Mean of a series of numbers
- Calculate the Standard Deviation of a series of numbers
- Calculate the $\alpha$ and $\beta$ parameters of $y = \alpha x + \beta$ using linear regression for two series of numbers
- Calculate the Pearson Coefficient using two series of numbers
- Load a list of numbers from a CSV file

The Prolog rules are listed below:

| Rule | Description |
| ---- | ----------- |
|`load_data_column('file.csv', Header, C, List)` |Loads the column `C` from a CSV file `file.csv`. `Header`: (`true` or `false`) indicates whether the file has headers or not. The values of the column are placed on list `List`. |
|`regressiona(X, Y, A)` | Calculates the $\alpha$ parameter of the linear regression using list `X` and list `Y`. Places the $\alpha$ parameter in variable `A`. |
|`regressionb(X, Y, B)` | Calculates the $\beta$ parameter of the linear regression using list `X` and list `Y`. Places the $\beta$ parameter in variable `B`.|
|`correlation(X, Y, R)` | Calculates the Pearson Correlation Coefficient of the linear regression using lists `X` and `Y`. Places the value of coefficient r in variable `R`. |
|`mean(L, M)` | Calculates the mean of the values in list `L`. Places the mean in variable `M`  |
|`stddev(L, S)` | Calculates the standard deviation of the values in list `L`. Places the standard deviation in variable `S`|

## Assignment Requirements
-	Good programming practices
- Meaningful atoms and rules naming
-	This is a strictly individual assignment
-	A query file will be provided for you to test your program, this test (and additional ones) will be used for grading.
-	Use the rules names given in the table above.

## Delivery Method
You will push your final version to the repository of the assignment before the deadline, your program must be in a file named `stats.pl`  **[You MUST name your program this, failure will result in zero grade]**

## Assessment and Grading
Assessment will consider the following factors in the grading of the project:
-	Adherence to instructions
-	Correct function of the program
-	No runtime errors and no warnings
-	Late deliveries will have a zero mark
-	Plagiarism will have a double zero mark (in addition to losing 10% of your final grade, you will lose an additional 10% of their final grade), besides there will be a report filed in the students’ academic record. Make sure to read the ECS Department Academic Integrity Guidelines in the Course Syllabus
-	Each program will be loaded in Prolog and tested to check if the functions are in working order.
-	The programs will be “automatically” run using a bash shell script, it is important that you follow the instructions, so the script runs smoothly.


## Instructions for Testing
A file named `test.pl` is provided. You will need to concatenate your code with this file and create a new file called `full.pl` that contains your code and then the code from `test.pl`, and then run Prolog from the command line:  

`swipl -q -f full.pl -t main > your-output.txt`

The command tells prolog to run quietly (`-q`) using the file `full.pl` and to execute target `-t main`. The query main will then run each of the calculation rules. Once the process is finished, there will be a file named `your-output.txt` you can then compare this file with another file that is provided: `expected-output.txt` to check if your results are correct. 
> Before turning in your assignment make sure that your file `stats.pl` does not have test code.

### Steps
1. Copy your `stats.pl` file into a new empty file called `full.pl`
2. Append the file `test.pl` at the end of your code of `full.pl`
   1. Optionally, if you are comfortable using command line: `cat stats.pl test.pl > full.pl`. This will concatenate your file with the test file and create a new file called `full.pl`.
3. Run the following command:
    `swipl -q -f full.pl -t main > your-output.txt`
4. Compare the file `your-ouput.txt` with the provided `expected-output.txt`, you may use `diff` or `fc` to compare the files. However, it is possible that the files don't match exactly, so you may need to compare them visually or use the provided C++ program to check.
5. If your output matches, then you are ready to push the final version of your work
6. Push the repository  

### Auto Grading your Program
This repository comes with a file `grade-prolog.cpp` this file is a C++ program that opens your output file, and it will compare your answers with the correct answers for each of the rules computations. To run the program:
```shell
prompt$ cat stats.pl test.pl > full.pl
prompt$ g++ -std=c++14 main.cpp -o grade
prompt$ swipl -q -t main full.pl > your-output.txt
prompt$ ./grade your-output.txt
10
prompt$ 
```

The result of running the program should be:
```shell
10
```

This program will tell you the number of tests you passed out of a total of 10. We may use a different test set for this. Your code will be reviewed for the assessment and grading criteria.

## Recommendation

### Windows and Mac ...
It is recommended that you use a Docker container for your assignment, this will guarantee that you have the same version of Prolog than the one you will be graded with. If you decide to use the native Windows or Mac Prolog, make sure that your program can be run from command line.

### GUI Versions
There are GUI versions for the Prolog Interpreter, but they might not help you with the assignment goals. Use them at your own risk.

