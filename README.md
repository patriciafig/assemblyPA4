# assemblyPA4

Filename: RString.asm

Write a program that uses both procedures (as described below), so that the input from the
user determines how many times to generate a random string. Do not generate 1 string and
display it over and over. Each string generated should be unique.
Create a procedure (UserInt) that asks for an unsigned integer input (N) from a user. The
procedure must pass this integer back to the calling procedure as an argument (this means in a
register).
Create a procedure (RandStr) that generates a string of length L, where L is between 5 and 25,
containing random CAPITAL letters. When calling the RandStr procedure, pass the value of N
(from UserInt) in ECX, and pass the offset of an array of bytes in EAX. This array will hold the
randomly generated string. You may declare an array of the maximum size since you don’t
know what the random string length will be.
Use an appropriate Irvine library procedure to print each randomly generated string.
Use the appropriate Irvine library procedure to require a key press before exiting the program.
1. The output will be shown in the console window with one string per line.
2. You may use any command Chapter 5 and below.
3. Your procedures must be called from main proc.
4. Data local to a procedure must be declared in that procedure, i.e. prompts. If you use local
data, you must have a .data and a .code in your procedure.
5. Part of the program will be graded on the basis of program style. I reserve the right to
judge style as I deem fit for the assignment. The use of comments is required and not
optional.
6. Upload to Canvas prior to the due date.
Extra Credit: Create a procedure (extracredit) which prints each string in a random foreground
color (exclude black on black).
